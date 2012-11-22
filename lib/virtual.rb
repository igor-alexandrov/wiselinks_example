class Virtual < ActiveRecord::Base
  def self.columns() 
    @columns ||= [] 
  end  

  def self.columns_hash()
    @columns_hash ||= {}
  end


  def self.column(name, sql_type = :string, default = nil, null = true)  
    column = ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)  

    columns << column
    columns_hash[name.to_s] = column   
  end  

  self.abstract_class = true

  def self.table_name
    to_s.underscore.pluralize
  end
  
  def readonly?
    true
  end
  
protected
  def assign_attributes(attrs, options = {})
    return unless attrs

    attrs = attrs.stringify_keys
    attrs.each do |k, v|
      send("#{k}=", v) rescue nil
    end
  end
end