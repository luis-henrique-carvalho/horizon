FactoryBot.define do
  factory :milestone do
    title { "Milestone 1" }
    order { 0 }
    goal

    trait :with_subtask do
      after(:build) do |milestone|
        milestone.subtasks << build(:subtask, milestone: milestone) if milestone.subtasks.empty?
      end
    end

    # Por padrão, vamos garantir que tenha uma subtask para passar na validação,
    # mas permitiremos sobrescrever.
    after(:build) do |milestone|
      if milestone.subtasks.empty?
        milestone.subtasks << build(:subtask, milestone: milestone, title: "Default Subtask")
      end
    end
  end
end
