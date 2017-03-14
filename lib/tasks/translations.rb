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
    config = YAML.load_file(Rails.root.join('config/locales/uk.yml'))
    I18n.locale = :uk
    flatten_hash(config['uk']).each do |key, val|
      if Translation.where(key: key).count == 0
        p key
        Translation.create(key: key, value: val)
      end
    end
  end

  def flatten_hash(hash)
    hash.each_with_object({}) do |(k, v), h|
      if v.is_a?(Hash)
        flatten_hash(v).map do |h_k, h_v|
          h["#{k}.#{h_k}".to_s] = h_v
        end
      else
        h[k] = v
      end
    end
  end
end
