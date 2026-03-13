FactoryBot.define do
  factory :goal do
    title { "Launch new feature" }
    description { "Important details about the feature" }
    category { :product }
    status { :on_track }
    progress { 0 }
    deadline { 1.month.from_now }
    user
  end
end
