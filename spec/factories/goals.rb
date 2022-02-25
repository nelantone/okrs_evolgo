FactoryBot.define do
  factory :goal do
    title { 'Test my app' }
    user  { create(:user) }
    start_date { Time.zone.local(2022, 2, 2, 2, 22) }
    end_date   { Time.zone.local(2022, 2, 2, 2, 22) + 1.day }
    progress { '0 %' }
  end
end
