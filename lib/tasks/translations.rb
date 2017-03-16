require 'i18n_backend_mongoid/app_locales_helper'
include AppLocalesHelper

namespace :translations do
  desc "TODO"
  task :to_db, [:lang] => [:environment] do |t, args|
    locale = get_locale(args)
    next unless valid_locale?(locale)
    begin
      model = translation_model
      msg = "This action will drop collection for #{model.to_s} model. "
      next unless confirm(msg)
      I18n.locale = locale
      model.collection.drop

      get_flatten_hash_for(locale).each do |key, val|
        model.create(key: key, value: val)
      end
    rescue TranslationClassLostError => e
      abort e.message
    end
  end

  desc "merge task"
  task :merge, [:lang] => [:environment] do |t, args|
    locale = get_locale(args)
    begin
      I18n.locale = locale
      model = translation_model
      get_flatten_hash_for(locale).each do |key, val|
        if model.where(key: key).count == 0
          p key
          model.create(key: key, value: val)
        end
      end
    rescue TranslationClassLostError => e
      abort e.message
    end
  end
end
