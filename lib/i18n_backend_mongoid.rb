require 'i18n_backend_mongoid/i18n/backend/mongoid'
require 'i18n_backend_mongoid/translateble'

module I18nBackendMongoid
end

begin
  require 'rails'
rescue LoadError
  #do nothing
end

require 'i18n_backend_mongoid/version'
require 'i18n_backend_mongoid/railtie' if defined?(Rails)
