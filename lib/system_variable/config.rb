module SystemVariable
  class Config
    attr_accessor :external_sources,
                  :cache_key,
                  :caching_enabled,
                  :cache_expiration

    def initialize
      @external_sources = [ENV]
      @cache_key = 'system_variable'
      @caching_enabled = true
      @cache_expiration = 24.hours
    end
  end
end
