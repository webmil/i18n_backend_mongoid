require 'i18n_backend_mongoid/app_locales_helper'
include AppLocalesHelper
namespace :translations do
  desc "TODO"
  task :to_db, [:lang] => [:environment] do |t, args|
    next unless valid_locale?(args[:lang])
    model = translation_model
    msg = "This action will drop collection from #{model.to_s}. "
    next unless confirm(msg)
    I18n.locale = args[:lang].to_sym
    model.collection.drop

    get_flatten_hash_for(args[:lang]).each do |key, val|
      model.create(key: key, value: val)
    end
  end

  desc "merge task"
  task :merge, [:lang] => [:environment] do |t, args|
    next unless valid_locale?(args[:lang])

    I18n.locale = args[:lang].to_sym
    model = translation_model

    get_flatten_hash_for(args[:lang]).each do |key, val|
      if model.where(key: key).count == 0
        p key
        model.create(key: key, value: val)
      end
    end
  end
end
