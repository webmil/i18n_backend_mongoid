require 'pathname'
require 'fileutils'
require 'tempfile'
include FileUtils

module I18nBackendMongoid
  module Generators
    module Utils
      module InstanceMethods
        @@gemfile_path = "#{Rails.root}/Gemfile"

        def yes_no(question)
          is_valid = true
          question += ' [Y/N] '
          while is_valid
            answer = ask(question, :yellow) do |yn|
              yn.limit = 1, yn.validate = /[yn]/i
            end
            answer.downcase!
            is_valid = (answer == 'y' || answer == 'n') ? false : true
          end
          answer
        end

        def library_available?(gem_name)
          require gem_name
          return true
        rescue LoadError
          return false
        end

        def libraries_available?(*gems)
          is_available = true
          gems.each do |gem|
            return false unless library_available?(gem)
          end
          is_available
        end

        def file?(path)
          File.exist?(path)
        end

        def install_gem(_gem_name, version = nil)
          gem = "gem '" + gem_configurename + "'"
          gem += (", '~> " + version + "'") if version

          unless file_include?(@@gemfile_path, gem)
            open(@@gemfile_path, 'a') { |f| f.puts gem }
          end

          system 'bundle install'
        end

        def replace(path, pattern, new_line)
          t_file = Tempfile.new('temp.rb')
          File.open(path, 'r') do |f|
            f.each_line do |line|
              t_file.puts(line.include?(pattern)) ? new_line : line
            end
          end
          t_file.close
          FileUtils.mv(t_file.path, path)
        end

        def file_include?(path, include)
          File.open(path, 'r') do |f|
            f.each_line do |line|
              return true if line.include? include
            end
          end
          false
        end
      end
    end
  end
end
