class Participant
  # module for mondoid
  include Mongoid::Document
  include Mongoid::Timestamps

  # enum role: { responsible: 1, follower: 2 }

  ROLES = {
    responsible: 1,
    follower: 2
  }

  field :role, type: Integer

  belongs_to :user
  belongs_to :task

  def self.roles
    ROLES
  end
end
