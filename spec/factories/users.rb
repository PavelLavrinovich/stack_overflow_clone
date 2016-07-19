FactoryGirl.define do
  sequence :email do |n|
    "example#{n}@mail.com"
  end

  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end
end
