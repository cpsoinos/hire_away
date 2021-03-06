require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:first_name) { |n| "User#{n}" }
    sequence(:last_name) { |n| "Mc#{n}son" }
    street_address Faker::Address.street_address
    street_address_2 Faker::Address.secondary_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip_code Faker::Address.zip
    phone Faker::PhoneNumber.cell_phone
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    street_address Faker::Address.street_address
    street_address_2 Faker::Address.secondary_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip_code Faker::Address.zip
    phone Faker::PhoneNumber.cell_phone
    role "admin"
  end

  factory :event do
    sequence(:name) { |n| "#{Faker::Company.name} #{Faker::Company.suffix}#{n}" }
    description Faker::Lorem.sentence
    start_time Faker::Time.forward(23, :morning)
    end_time Faker::Time.forward(25, :evening)
    venue
  end

  factory :venue do
    sequence(:name) { |n| "Venue#{n}" }
    street_address "1 Kendall Square"
    city "Cambridge"
    state "Massachusetts"
  end

  factory :position do
    sequence(:name) { |n| "Position#{n}" }
    pay_rate_cents 1500
  end

  factory :offer do
    user
    event
  end

  factory :call do
    start_time Faker::Time.forward(23, :morning)
    end_time Faker::Time.forward(25, :evening)
    event
    position
    user
  end

end
