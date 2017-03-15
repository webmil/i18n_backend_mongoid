require 'i18n_backend_mongoid/app_locales'
include AppLocales
namespace :translations do
  desc "TODO"
  task to_db: :environment do

    Translation.collection.drop

    config = YAML.load_file(Rails.root.join('config/locales/uk.yml'))
    I18n.locale = :uk
    flatten_hash(config['uk']).each do |key, val|
      Translation.create(key: key, value: val)
    end
  end

  desc "merge task"
  task merge: :environment do
    I18n.locale = :uk
    model = translation_model
    byebug
    get_flatten_hash_for('uk').each do |key, val|
      if model.where(key: key).count == 0
        p key
        model.create(key: key, value: val)
      end
    end
  end
end
