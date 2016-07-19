FactoryGirl.define do
  sequence :title do |n|
    "GreatTitle№#{n}"
  end

  factory :question do
    title
    body 'MyText'
    user
  end

  factory :invalid_question, class: 'Question' do
    title
    body nil
    user
  end
end
