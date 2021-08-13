FactoryBot.define do
  factory :participant do
    association :user
  end

  trait :responsible do
    role { Participant::ROLES[:responsible] }
  end

  trait :follower do # rasgos
    role { Participant::ROLES[:follower] }
  end

  after(:build) do |participant, _|
    participant.save
  end
end