FactoryGirl.define do
  factory :user do |f|
    f.email "user@mail.com"
    f.password "foobar"
  end
end
