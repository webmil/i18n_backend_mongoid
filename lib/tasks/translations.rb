require 'i18n_backend_mongoid/app_locales'
include AppLocales
namespace :translations do
  desc "TODO"
  task :to_db, [:lang] => [:environment] do |t, args|
    model = translation_model
    I18n.locale = args[:lang].to_sym
    model.collection.drop

    get_flatten_hash_for(args[:lang]).each do |key, val|
      model.create(key: key, value: val)
    end
  end

  desc "merge task"
  task :merge, [:lang] => [:environment] do |t, args|

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
