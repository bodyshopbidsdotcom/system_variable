require 'faker'

FactoryBot.define do
  factory :system_variables_category, class: 'SystemVariable::Category' do
    name { Faker::String.random(length: 16) }
  end
end
