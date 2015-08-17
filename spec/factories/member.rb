require 'faker'

module DiabeticToolbox
  FactoryGirl.define do
    factory :members, class: DiabeticToolbox::Member do |member|
      password = Faker::Internet.password(8, 64)
      sequence(:email) { |n| Faker::Internet.email "#{Faker::Name.first_name}#{n}" }
      member.first_name Faker::Name.first_name
      member.last_name Faker::Name.last_name
      member.username Faker::Name.name
      member.password password
      member.password_confirmation password
    end

    factory :member, class: DiabeticToolbox::Member do |member|
      member.sequence(:email) { |n| "frodo.baggins#{n}@example.com" }
      member.first_name 'Frodo'
      member.last_name 'Baggins'
      member.sequence(:username) { |n| "Ring Bearer#{n}" }
      member.password 'password'
      member.password_confirmation 'password'
    end
  end
end