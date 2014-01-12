
FactoryGirl.define do
  factory :user do
    name "John Appleseed"
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "secret"
  end

  factory :song do
    name "Radioactive"
    sequence(:artist) { |a| "Imaging #{a} Dragons" }
  end
end
