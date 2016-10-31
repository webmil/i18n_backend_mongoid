module I18nBackendMongoid
  module Translateble
    extend ActiveSupport::Concern
    included do
      after_save do
        I18n.backend.reload!
      end

      field :key, type: String
      field :value, type: String, localize: true

      validates :key, presence: true, uniqueness: true
    end
  end
end
