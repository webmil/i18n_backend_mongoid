require 'rails/generators/base'
require 'venom/rails_admin'

module Venom
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc 'Venom installation generator'

      def copy_initializer
        template "translation.rb", "app/models/translation.rb"
        template "locale.rb", "config/initializers/locale.rb"
        template "mongoid.rb", "lib/i18n/backend/mongoid.rb"
      end

      def install
        case self.behavior
          when :invoke
            Venom::RailsAdmin.configure
          when :revoke
            Venom::RailsAdmin.rollback
          end
      end

    end
  end
end
