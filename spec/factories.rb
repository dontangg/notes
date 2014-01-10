
FactoryGirl.define do
  factory :user do
    name "John Appleseed"
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "secret"
  end

  factory :submission do
    song "Radioactive"
    sequence(:artist) { |a| "Imaging #{a} Dragons" }
  end
end
