module AppLocales

  def get_flatten_hash_for(lang)
    locale = {}
    app_locales_paths.each do |files_path|
      hash = YAML.load_file(files_path)
      if hash.key?(lang)
        flatten = flatten_hash(hash[lang])
        locale.merge!(flatten)
      end
    end
    locale
  end

  def app_locales_paths
    I18n.load_path.select do |path|
      path.include?(Rails.root.to_s)
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

  def translation_model
    if I18n.backend.class == I18n::Backend::Mongoid
      I18n.backend.model
    elsif I18n.backend.class == I18n::Backend::Chain
      I18n.backend.backends.find {|b| b.class == I18n::Backend::Mongoid }.model
    end
  end
end