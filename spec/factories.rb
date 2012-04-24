#encoding:UTF-8
FactoryGirl.define do
  factory :user do
    first_name "youngsik"
    last_name "kim"
    email    "dean1@headflow.net"
    password "dudtlr"
    password_confirmation "dudtlr"
  end

  
  sequence :email do |n|
    "person-#{n}@example.com"
  end

  factory :team do
    name    "A"
  end

  factory :position do
    name    "공격수"
  end

  factory :ground do
    title "puchonsoccer"
    location "puchon city ground"
    datetime Time.now
    forwardcount 2
    midfieldcount 4
    backcount 4
    keepercount 1
    status "pending"
    limit 20
    limitday 2
    association :user
  end
end