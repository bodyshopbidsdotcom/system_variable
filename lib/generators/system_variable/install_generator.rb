require 'rails/generators'

module SystemVariable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.next_migration_number(dirname) #:nodoc:
        # Implement the required interface for Rails::Generators::Migration.
        next_migration_number = current_migration_number(dirname) + 1
        if ::ActiveRecord::Base.timestamped_migrations
          [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
        else
          "%.3d" % next_migration_number
        end
      end

      def self.migration_parent
        # TODO: is this necessary? try removing it and putting the logic in the instance method
        Rails::VERSION::MAJOR == 4 ? 'ActiveRecord::Migration' : "ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]"
      end

      source_root File.expand_path("../templates", __FILE__)

      def copy_migration
        migration_template 'install_migration.rb', 'db/migrate/install_system_variable.rb'
      end

      private

      def migration_parent
        self.class.migration_parent
      end

      def table_name
        SystemVariable::Helper.table_name
      end
    end
  end
end
