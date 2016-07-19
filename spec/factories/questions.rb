FactoryGirl.define do
  sequence :title do |n|
    "GreatTitle№#{n}"
  end

  factory :question do
    title
    body 'MyText'
  end

  factory :invalid_question, class: 'Question' do
    title
    body nil
  end
end
