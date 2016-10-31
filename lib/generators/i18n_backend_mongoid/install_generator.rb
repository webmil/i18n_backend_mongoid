require 'rails/generators/base'
require 'generators/utils'

module I18nBackendMongoid
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include I18nBackendMongoid::Generators::Utils::InstanceMethods
      source_root File.expand_path('../../templates', __FILE__)

      argument :translation_table_name, type: :string

      def copy_initializer
        if libraries_available?('mongoid', 'rails-i18n')
          template 'translation.rb.erb', "app/models/#{table_name.downcase}.rb"
          template 'locale.rb.erb', 'config/initializers/locale.rb'
        else
          say('Mongoid or rails-i18n aren\'t installed!', :yellow)
        end
      end

      private

      def table_name
        translation_table_name.downcase.capitalize
      end
    end
  end
end
