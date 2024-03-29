class Task
  # module for mondoid
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM

  field :name, type: String
  field :description, type: String
  field :due_date, type: Date
  field :code, type: String
  field :status, type: String
  field :transitions, type: Array, default: []

  belongs_to :category
  belongs_to :owner, class_name: 'User'

  has_many :participating_users, class_name: 'Participant', dependent: :destroy
  # has_many :participants, through: :participating_users, source: :user

  has_many :notes, dependent: :destroy

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :due_date_validity

  before_create :create_code
  after_create :send_email

  
  accepts_nested_attributes_for :participating_users, allow_destroy: true
  
  # status machine
  
  aasm column: :status do
    state :pending, initial: true
    state :in_process, :finished
    
    after_all_transitions :audit_status_change
    event :start do
      transitions from: :pending, to: :in_process
    end

    event :finish do
      transitions from: :in_process, to: :finished
    end
  end

  def audit_status_change
    set transitions: transitions.push(
      {
        from_state: aasm.from_state,
        to_state: aasm.to_state,
        current_event: aasm.current_event,
        timestamp: Time.zone.now
      }
    )
  end

  def participants
    participating_users.includes(:user).map(&:user)
  end

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today

    errors.add :due_date, 'La fecha no puede estar en el pasado'
  end

  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_email
    return unless Rails.env.development?

    Tasks::SendEmailJob.perform_async id.to_s
  end
end
