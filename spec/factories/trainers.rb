FactoryBot.define do
  factory :trainer do
    name { 'Ash Ketchum' }
    sequence(:email) { |n| "ash_ketchum_#{n}@localhost" }
    password { 'pikachu' }
  end
end
