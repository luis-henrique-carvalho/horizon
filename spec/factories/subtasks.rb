FactoryBot.define do
  factory :subtask do
    title { "Subtask 1" }
    completed { false }
    milestone
  end
end
