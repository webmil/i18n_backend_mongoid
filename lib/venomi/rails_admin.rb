require 'pathname'
require 'fileutils'
require 'tempfile'
require 'generators/utils'
include FileUtils

module Venomi
  module RailsAdmin

    if defined? ::Rails
      @rails_root = Rails.root.to_s
      @rails_admin_root =  "#{@rails_root}/config/initializers/rails_admin.rb"
    else
      # Debug
      @gem_root = Pathname.new File.expand_path('../../', __FILE__).to_s
      @rails_admin_root = "#{@gem_root}/debug/initializers/rails_admin.rb"
    end

    class << self
      include Venomi::Generators::Utils::InstanceMethods

      def configure(table = "Translation")
        init_parts_for(table)
        if file?(@rails_admin_root)
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
      end

      def rollback(table = "Translation")
        init_parts_for(table)
        if file? @rails_admin_root
          text = File.read(@rails_admin_root)
          text.gsub!(@delete, "    delete\n")
          text.gsub!(@new, "    new\n")
          text.gsub!(@translation, "")
          File.open(@rails_admin_root, "w") {|file| file.puts text }
        end
      end

      def init_parts_for(table_name)
        @table = table_name
        @new = <<-MSG
    new do
      except [:#{@table}]
    end
    MSG

        @delete = <<-MSG
    delete do
      except [:#{@table}]
    end
    MSG

        @translation = <<-MSG
      config.model #{@table} do
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
  end
end
