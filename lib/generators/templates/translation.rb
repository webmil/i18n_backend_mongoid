class Translation
  include Mongoid::Document

  after_save do
    I18n.backend.reload!
  end

  store_in collection: "i18n"
  # scope :default, ->{ order_by(locale: :asc, key: :asc) }

  field :key, type: String
  field :value, type: String, localize: true

  validates :key, presence: true, uniqueness: true
end
