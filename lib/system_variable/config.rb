module SystemVariable
  class Config
    attr_accessor :external_sources,
                  :cache_key,
                  :caching_enabled

    def initialize
      @external_sources = [ENV]
      @cache_key = 'system_variable'
      @caching_enabled = true
    end
  end
end
