# == Schema Information
#
# Table name: system_variable_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_system_variable_categories_on_name  (name) UNIQUE
#

module SystemVariable
  class Category < ApplicationRecord
    has_many :variables

    validates_presence_of :name
  end
end
