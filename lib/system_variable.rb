require 'system_variable/engine'
require 'system_variable/config'
require 'pry'

module SystemVariable
  class << self
    def configure
      yield(self.config) if block_given?
    end

    def config
      @_config ||= Config.new
    end

    def fetch(key, default: nil)
      value = SystemVariable::Variable.get(key)
      if value.nil?
        config.external_sources.each do |source|
          value = source.fetch(key, nil)
          break unless value.nil?
        end
      end

      if value.nil?
        default
      else
        value
      end
    end

    def exists?(key)
      SystemVariable::Variable.exists?(key) || config.external_sources.any? { |source| source.key? key }
    end
  end
end
