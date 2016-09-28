require_relative("../../lib/i18n/backend/mongoid")

I18n.backend = I18n::Backend::Chain.new( I18n::Backend::Simple.new, I18n::Backend::Mongoid.new(Translation) )
