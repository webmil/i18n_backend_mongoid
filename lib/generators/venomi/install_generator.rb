require 'rails/generators/base'
require 'venomi/rails_admin'
require 'generators/utils'

module Venomi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Venomi::Generators::Utils::InstanceMethods
      source_root File.expand_path("../../templates", __FILE__)

      argument :translation_table_name, :type => :string

      def copy_initializer
        if libraries_available?("mongoid", "rails-i18n")
          template "mongoid.rb", "lib/i18n/backend/mongoid.rb"
          template "translation.rb.erb", "app/models/#{table_name.downcase}.rb"
          template "locale.rb.erb", "config/initializers/locale.rb"
        else
          say("Mongoid or rails-i18n aren't installed!", :yellow)
        end
      end

      def install
        case self.behavior
          when :invoke
            if libraries_available?("mongoid","rails_admin")
              Venomi::RailsAdmin.configure table_name
            else
              say("Rails-admin isn`t required or installed!", :yellow)
            end
          when :revoke
            Venomi::RailsAdmin.rollback table_name
          end
      end

      private
        def table_name
          translation_table_name.downcase.capitalize
        end

    end
  end
end
