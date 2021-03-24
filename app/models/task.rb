# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  code        :string
#  description :string
#  due_date    :date
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  owner_id    :integer          not null
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#  index_tasks_on_owner_id     (owner_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  owner_id     (owner_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant', dependent: :destroy
  has_many :participants, through: :participating_users, source: :user
  has_many :notes, dependent: :destroy

  validates :name, :description, presence: true
  validates :name, uniqueness: {case_sensitive: false}
  validate :due_date_validity
  validates :participating_users, presence: true

  before_create :create_code
  after_create :send_email

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
      return if due_date.blank?
      return if due_date > Date.today
      errors.add :due_date, 'La fecha no puede estar en el pasado'
  end

  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_email
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_mailer.deliver!
    end
  end
end
