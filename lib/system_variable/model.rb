# TODO remove these two by using a separate helper for L7
require 'generators/system_variable/install_generator'
require 'active_record'

module SystemVariable
  class Model < ::ActiveRecord::Base
    self.table_name = SystemVariable::Generators::InstallGenerator.table_name

    validates :name, :presence => true

    DEFAULT_SYSTEM_VARIABLE_CACHE_TIME_IN_SECONDS = 10

    # The format of this class variable is:
    # {
    #   'VARIABLE_NAME_1' => {
    #     :value => <string>,
    #     :refreshed_at => <datetime>
    #   },
    #   'VARIABLE_NAME_2' => {
    #     :value => <string>,
    #     :refreshed_at => <datetime>
    #   }
    # }
    @variables_cache = {}

    def self.[](name)
      return @variables_cache[name][:value] if @variables_cache.key?(name) && @variables_cache[name][:refreshed_at] > (Time.zone.now - cache_time_in_seconds)

      value = if ENV.key?(name)
                ENV[name]
              else
                # using `take` to support rails 3
                # https://github.com/bbatsov/rails-style-guide/issues/76#issuecomment-26249242
                self.where(:name => name).take.try(:value) # rubocop:disable Rails/FindBy
              end

      @variables_cache[name] = {
        :value => value,
        :refreshed_at => Time.zone.now
      }

      value
    end

    def self.cache_time_in_seconds
      # We can use system variables for this as well and cache it. Doing this for now.
      (ENV['SYSTEM_VARIABLE_CACHE_TIME_IN_SECONDS'] || DEFAULT_SYSTEM_VARIABLE_CACHE_TIME_IN_SECONDS).to_i.seconds
    end
  end
end
