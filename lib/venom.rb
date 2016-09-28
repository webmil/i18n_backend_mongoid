module Venom
end

begin
  require 'rails'
rescue LoadError
  #do nothing
end

require "venom/version"
