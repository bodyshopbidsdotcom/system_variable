# == Schema Information
#
# Table name: system_variable_variables
#
#  id          :bigint(8)        not null, primary key
#  description :string(255)
#  key         :string(255)      not null
#  value       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#
# Indexes
#
#  index_system_variable_variables_on_category_id  (category_id)
#  index_system_variable_variables_on_key          (key) UNIQUE
#

module SystemVariable
  class Variable < ApplicationRecord
    belongs_to :category, optional: true

    validates_presence_of :key

    accepts_nested_attributes_for :category

    before_save :sanitize
    after_commit :clear_cache

    def sanitize
      self.key = self.class.sanitize_key(self.key)
      self.value = self.class.sanitize_value(self.value) || ''
    end

    class << self
      def all_values
        if SystemVariable.config.caching_enabled
          Rails.cache.fetch(SystemVariable.config.cache_key, expires_in: SystemVariable.config.cache_expiration) { self.hashify }
        else
          self.hashify
        end
      end

      def hashify
        self.all.map { |variable| [variable.key, variable.value] }.to_h
      end

      def fetch(key, default=nil)
        key = self.sanitize_key(key)
        self.all_values.dig(key) || default
      end

      def key?(key)
        key = self.sanitize_key(key)
        self.all_values.key?(key)
      end

      def sanitize_key(key)
        key.try(:upcase).try(:strip)
      end

      def sanitize_value(key)
        key.try(:strip)
      end
    end

    def clear_cache
      Rails.cache.delete(SystemVariable.config.cache_key) if SystemVariable.config.caching_enabled
    end
  end
end
