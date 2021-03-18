# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  due_date    :date
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  validates :name, :description, presence: true
  validates :name, uniqueness: {case_sensitive: false}
  validate :due_date_validity
  validates :participating_users, presence: true

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
      return if due_date.blank?
      return if due_date > Date.today
      errors.add :due_date, 'La fecha no puede estar en el pasado'
  end
end
