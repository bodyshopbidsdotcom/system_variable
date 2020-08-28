require 'system_variable/engine'
require 'system_variable/config'

module SystemVariable
  class << self
    def configure
      yield(self.config) if block_given?
    end

    def config
      @_config ||= Config.new
    end

    def fetch(key, default: nil)
      value = nil

      config.sources.each do |source|
        value = source.fetch(key, nil)
        break unless value.nil?
      end

      if value.nil?
        default
      else
        value
      end
    end

    def exists?(key)
      config.sources.any? { |source| source.key? key }
    end
  end
end
