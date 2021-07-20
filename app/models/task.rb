class Task
  # module for mondoid
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :due_date, type: Date
  field :code, type: String

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
    return
    return unless Rails.env.development?
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_mailer.deliver!
    end
  end
end
