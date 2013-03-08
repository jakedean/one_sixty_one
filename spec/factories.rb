FactoryGirl.define do 
  factory :user do
  	sequence(:name) { |n| "Person #{n}" }
  	sequence(:email) { |n| "Person#{n}@example.com" }
  	password "foobar"
  	password_confirmation "foobar"

  factory :admin do
  	admin true
  end
 end

 factory :school do
 	sequence(:name) { |n| "#{n} University" }
 end

 factory :item do
 	content 'You should go shag in the stacks'
 end

 factory :reaction do
 	comment 'Yes it is the best thing to do'
 end
 
end