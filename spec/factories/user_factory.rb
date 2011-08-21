FactoryGirl.define do
  factory :user do |f|
    f.sequence(:id) { |n| n}
    f.sequence(:username){ |n| "test#{n}"}
    f.password "testtt2"
    f.password_confirmation "testtt2"
    f.sequence(:email){ |n| "test#{n}@test2.com"}
  end

  factory :valid_user, :class => User do
    id 1
    username "test"
    password "test"
    password_confirmation "test"
    email "test@test.com"
    active true
  end
end