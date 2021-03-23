# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_notes_on_task_id  (task_id)
#  index_notes_on_user_id  (user_id)
#
# Foreign Keys
#
#  task_id  (task_id => tasks.id)
#  user_id  (user_id => users.id)
#
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :body, presence: true
end