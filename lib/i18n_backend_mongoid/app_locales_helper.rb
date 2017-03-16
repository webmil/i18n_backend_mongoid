module AppLocalesHelper

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
    model = nil
    exeption_msg = 'Something went wrong. Cant find I18n mongoid backend'

    if I18n.backend.is_a? I18n::Backend::Mongoid
      model = I18n.backend.model
    elsif I18n.backend.is_a? I18n::Backend::Chain
      model = I18n.backend.backends.find{ |b| b.is_a? I18n::Backend::Mongoid }.model
    end
    raise exeption_msg if model.nil?
    model
  end

  def confirm(msg)
    print msg
    print 'Are you sure? (yes or no) '
    confirm = STDIN.gets.chomp
    if confirm.present? && confirm == 'yes'
      true
    else
      puts 'You canceled this action'
    end
  end

  def valid_locale?(locale)
    if I18n.available_locales.include?(locale.to_sym)
      true
    else
      puts %Q[ "#{locale}" is not valid locale. ]
    end
  end
end