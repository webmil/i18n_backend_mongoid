require 'i18n_backend_mongoid'
require 'rails'
module I18nBackendMongoid
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'tasks/translations.rb'
    end
  end
end