# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_participants_on_task_id  (task_id)
#  index_participants_on_user_id  (user_id)
#
# Foreign Keys
#
#  task_id  (task_id => tasks.id)
#  user_id  (user_id => users.id)
#
require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
