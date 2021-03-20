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
require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
