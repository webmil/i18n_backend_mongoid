require 'rails/generators/base'
require 'venomi/rails_admin'
require 'generators/utils'

module Venomi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Venomi::Generators::Utils::InstanceMethods
      source_root File.expand_path("../../templates", __FILE__)

      def copy_initializer
        if libraries_available?("mongoid", "rails-i18n")
          template "mongoid.rb", "lib/i18n/backend/mongoid.rb"
          template "translation.rb", "app/models/translation.rb"
          template "locale.rb", "config/initializers/locale.rb"
        else
          say("Mongoid or rails-i18n aren't installed!", :yellow)
        end
      end

      def install
        case self.behavior
          when :invoke
            if libraries_available?("mongoid","rails_admin")
              Venomi::RailsAdmin.configure
            else
              say("Rails-admin isn`t required or installed!", :yellow)
            end
          when :revoke
            Venomi::RailsAdmin.rollback
          end
      end

    end
  end
end
