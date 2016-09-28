require 'i18n/backend/base'

module I18n
  module Backend
    class Mongoid
      module Implementation
        attr_accessor :model
        include Base, Flatten

        def initialize(model)
          @model = model
          init_translations
        end

        def initialized?
          @initialized ||= false
        end

        # Stores translations for the given locale in memory.
        # This uses a deep merge for the translations hash, so existing
        # translations will be overwritten by new ones only at the deepest
        # level of the hash.
        def store_translations(locale, data, options = {})
          locale = locale.to_sym
          translations[locale] ||= {}
          data = data.deep_symbolize_keys
          translations[locale].deep_merge!(data)
        end

        # Get available locales from the translations hash
        def available_locales
          init_translations unless initialized?
          translations.inject([]) do |locales, (locale, data)|
            locales << locale unless (data.keys - [:i18n]).empty?
            locales
          end
        end

        # Clean up translations hash and set initialized to false on reload!
        def reload!
          @initialized = false
          @translations = nil
          init_translations
        end

        protected

          def init_translations
            load_translations
            @initialized = true
          end

          def load_translations
            @translations = {}
            @model.all.each{ |t| @lookuptranslations[t.key] = t.value_translations }
          end

          def translations
            @translations ||= {}
          end

          def lookup(locale, key, scope = [], options = {})
            init_translations unless initialized?
            #translations.dig(key,value)
             translations[key].blank? ? nil : translations[key][locale]
          end
      end

      include Implementation
    end
  end
end
