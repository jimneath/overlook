module Admin::ApplicationHelper 
  def flash_messages
    classes = { notice: 'success', warning: 'warning', error: 'error' }
    
    output = flash.map do |name, message|
      if message.present?
        class_name = ['alert', "alert-#{classes[name]}"].join(' ')
        message << '<a class="close" data-dismiss="alert">&times;</a>'
        
        content_tag(:div, class: 'span12') do
          content_tag(:div, raw(message), class: class_name)
        end
      end
    end
    
    raw(output.join)
  end
  
  def nav(name)
    class_name = params[:controller].eql?("admin/#{name}") ? 'active' : nil
    
    content_tag(:li, class: class_name) do
      link_to(name.to_s.titleize, "/admin/#{name}")
    end
  end
end
