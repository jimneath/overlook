module Overlook
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
  
    def install_files
      source = self.class.source_root
    
      Dir["#{source}/**/*"].each do |file|
        next if File.directory?(file)
        path = file.gsub(source, '').gsub(/^\//, '')
        copy_file path, "app/#{path}"
      end
    end
  end
end
