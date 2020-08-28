module SystemVariable
  class Config
    attr_accessor :cache_key,
                  :caching_enabled,
                  :cache_expiration,
                  :sources

    def initialize
      @sources = [SystemVariable::Variable, ENV]
      @cache_key = 'system_variable'
      @caching_enabled = true
      @cache_expiration = 24.hours
    end
  end
end
