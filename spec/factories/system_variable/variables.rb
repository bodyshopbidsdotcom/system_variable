require 'faker'

FactoryBot.define do
  factory :system_variable_variable, class: 'SystemVariable::Variable' do
    key { Faker::String.random(length: 16) }
    value { Faker::String.random(length: 16) }
    category { FactoryBot.build(:system_variables_category) }
  end
end
