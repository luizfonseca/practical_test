FactoryBot.define do
  factory :user do
    name "Joao"
      sequence :email do |n|
        "person#{n}@example.com"
      end

    password 123456
    password_confirmation 123456
  end
end
