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

        def available_locales
          Rails.application.config.i18n.available_locales
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
          @model.all.each do |record|
            I18n.config.available_locales.each do |loc|
              next unless record.value_translations.key?(loc)
              k = I18n.normalize_keys(loc, record.key, [])
              k.shift
              store_translations(loc, k.reverse.inject(record.value_translations[loc]) { |a, n| { n => a } })
            end
          end
        end

        def translations
          @translations ||= {}
        end

        # Looks up a translation from the translations hash. Returns nil if
        # eiher key is nil, or locale, scope or key do not exist as a key in the
        # nested translations hash. Splits keys or scopes containing dots
        # into multiple keys, i.e. <tt>currency.format</tt> is regarded the same as
        # <tt>%w(currency format)</tt>.
        def lookup(locale, key, scope = [], options = {})
          init_translations unless initialized?
          keys = I18n.normalize_keys(locale, key, scope, options[:separator])

          keys.inject(translations) do |result, k|
            k = k.to_sym
            return nil unless result.is_a?(Hash) && result.key?(k)
            result = result.is_a?(Symbol) ? resolve(locale, k, result, options.merge(scope: nil)) : result[k]

            result
          end
        end
      end

      include Implementation
    end
  end
end
