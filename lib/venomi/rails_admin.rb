require 'pathname'
require 'fileutils'
require 'tempfile'
include FileUtils

module Venomi
  module RailsAdmin

    if defined? ::Rails
      @rails_root = Rails.root.to_s
      @rails_admin_root = @rails_root + "/config/initializers/rails_admin.rb"
    else
      @gem_root = Pathname.new File.expand_path('../../', __FILE__)
      @rails_admin_root = @gem_root.to_s + "/debug/initializers/rails_admin.rb"
    end

    def self.configure
      unless file_include?(@rails_admin_root, "config.model Translation do")
        replace(@rails_admin_root, "RailsAdmin.config do |config|", ("RailsAdmin.config do |config|\n" + @translation))
      end

      unless file_include?(@rails_admin_root, " new do")
        replace(@rails_admin_root, " new", @new)
      end

      unless file_include?(@rails_admin_root, " delete do")
        replace(@rails_admin_root, " delete", @delete)
      end
    end

    def self.rollback
        text = File.read(@rails_admin_root)
        text.gsub!(@delete, "    delete\n")
        text.gsub!(@new, "    new\n")
        text.gsub!(@translation, "")
        File.open(@rails_admin_root, "w") {|file| file.puts text }
    end

    def self.replace(path, pattern, new_line)
      t_file = Tempfile.new('temp.rb')
      File.open(path, 'r') do |f|
        f.each_line do |line|
          t_file.puts (line.include? pattern)? new_line : line
        end
      end
      t_file.close
      FileUtils.mv(t_file.path, path)
    end

    def self.file_include?(path, include)
      File.open(path, 'r') do |f|
       f.each_line do |line|
         return true if line.include? include
        end
      end
      false
    end

    @new = <<-MSG
    new do
      except [:Translation]
    end
    MSG

    @delete = <<-MSG
    delete do
      except [:Translation]
    end
    MSG

    @translation = <<-MSG
    config.model Translation do
      list do
        field :key
        field :value
      end
      edit do
        field :key do
          read_only true
        end
        field :value
      end
    end
    MSG

  end
end
