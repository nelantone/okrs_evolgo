FactoryBot.define do
  factory :key_result do
    user { create(:user) }
    goal { create(:goal) }
    title { 'Test key-results' }
    status { 0 }
  end
end
