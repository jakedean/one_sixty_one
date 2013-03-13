FactoryGirl.define do 
  factory :user do
  	sequence(:name) { |n| "Person #{n}" }
  	sequence(:email) { |n| "Person#{n}@example.com" }
  	password "foobar"
  	password_confirmation "foobar"
 end

 factory :school do
 	sequence(:name) { |n| "#{n} University" }
 end

 factory :item do
 	content 'You should go to a hockey game'
 end

 factory :reaction do
 	comment 'Yes it is the best thing to do'
 end

 factory :want do 
 	status 0

 end

 factory :personal do
 end

 factory :vote do
 end
 
end


