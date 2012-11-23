class Filters::FormBuilder < ActionView::Helpers::FormBuilder
  def label(method, content_or_options = nil, options = {}, &block)    
    options ||= {}

    content_is_options = content_or_options.is_a?(Hash)
    if content_is_options || block_given?
      options.merge!(content_or_options) if content_is_options
      text = nil
    else
      text = content_or_options
    end

    if options.delete(:required)
      text = @template.content_tag(:span, "*", :class => "f__mandatory") + " " + text 
    end
    
    super(method, text, options, &block)    
  end
  
  def text_field(method, options = {})
    options.reverse_merge!({
      :name => sanitized_method_name(method)
    })
    super
  end
  
  def select(method, choices, options = {}, html_options = {})
    html_options.reverse_merge!({
      :name => sanitized_method_name(method)
    })
    
    super
  end
  
  def check_box(method, options = {}, checked_value = '1', unchecked_value = nil)
    options.reverse_merge!({
      :name => sanitized_method_name(method)
    })    
    super
  end
  
  def radio_button(method, tag_value, options = {})
    options.reverse_merge!({
      :name => sanitized_method_name(method)      
    })            
    
    super
  end
  
  def hidden_field(method, options = {})
    options.reverse_merge!({
      :name => sanitized_method_name(method)      
    })            
    
    super    
  end
  
  def date_field(method, options = {})
    options.reverse_merge!({
      :class => ''
    })
    options[:class] += ' date' 
    text_field(method, options)
  end
  
  def currency_field(method, options = {})
    options.reverse_merge!({
      :class => '',
      :size => 11
    })
    options[:class] += ' currency' 
    text_field(method, options)
  end  
  
protected
  def sanitized_method_name(method_name)
    method_name.to_s.sub(/\?$/,"")
  end
end