FactoryGirl.define do
  sequence :body do |n|
    "GreatAnswer # #{n}"
  end

  factory :answer do
    body
    question
    user
    best false
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
    user
    best false
  end
end
