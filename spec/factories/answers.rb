FactoryGirl.define do
  sequence :body do |n|
    "GreatAnswer # #{n}"
  end

  factory :answer do
    body
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
    user
  end
end
