module Overlook
  class AdminGenerator < Rails::Generators::NamedBase
    # source
    source_root File.expand_path('../templates', __FILE__)
  
    def add_route
      inject_into_file 'config/routes.rb', "\n    resources :#{table_name}", {
        after: /namespace :admin do$/
      }
    end
  
    def add_navigation
      inject_into_file 'app/views/layouts/admin.html.erb', "\n            <%= nav(:#{table_name}) %>", {
        after: /<ul class="nav">/
      }
    end
  
    def copy_controller_file
      template "controller.rb", "app/controllers/admin/#{plural_file_name}_controller.rb"
    end
  
    def copy_view_files
      template "index.html.erb", "app/views/admin/#{plural_file_name}/index.html.erb"
      template "show.html.erb", "app/views/admin/#{plural_file_name}/show.html.erb"
      template "new.html.erb", "app/views/admin/#{plural_file_name}/new.html.erb"
      template "edit.html.erb", "app/views/admin/#{plural_file_name}/edit.html.erb"
      template "form.html.erb", "app/views/admin/#{plural_file_name}/_form.html.erb"
      template "partial.html.erb", "app/views/admin/#{plural_file_name}/_#{file_name}.html.erb"
      template "sidebar.html.erb", "app/views/admin/#{plural_file_name}/_sidebar.html.erb"
      template "breadcrumb.html.erb", "app/views/admin/#{plural_file_name}/_breadcrumb.html.erb"
      template "destroy.js.erb", "app/views/admin/#{plural_file_name}/destroy.js.erb"
    end
  
    protected
  
    def name_attribute(klass)
      klass = klass.new
  
      methods = %w[title name subject login user_name screen_name first_name id].map do |attribute|
        klass.respond_to?(attribute) ? attribute : nil
      end
    
      methods.compact.first
    end
  
    def listing_columns
      self.columns.select do |column|
        ![:text].include?(column.type)
      end
    end
  
    def columns
      columns = class_name.constantize.columns
    
      columns.select do |column|
        !column.name[/^id$/]
      end
    end
  end
end