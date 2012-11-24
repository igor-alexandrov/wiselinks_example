class Filters::Builder
  def initialize(filter, &block)
    @filter = filter
    self.instance_eval(&block)
  end
  
  def method(*args)
    options = args.extract_options!
    
    args.each do |argument|
      unless options[:attribute] == false
        self.add_filter_attribute(argument)
        if options[:type].present?
          @filter.send(:column, argument, options[:type]) 
        else  
          @filter.send(:attr_accessor, argument) 
        end
        
        self.add_json_attribute(argument) unless options[:json] == false
      end
      
      self.add_filter_method(argument)      
    end
  end
  
  def attribute(*args)
    options = args.extract_options!
    
    args.each do |argument|          
      self.add_filter_attribute(argument)
      if options[:type].present?
        @filter.send(:column, argument, options[:type]) 
      else  
        @filter.send(:attr_accessor, argument) 
      end
            
      self.add_json_attribute(argument) unless options[:json] == false
    end    
  end
  
  def lien_methods
    self.method(:lien_holder_id, :state_id, :county_id, :city_id, :property_class_id, :type => :integer)

    @filter.send :define_method, 'formatted_param_lien_holder_id' do
      id = self.lien_holder_id
      id.blank? ? nil : LienHolder.accessible_by(self.user.ability).where(:id => id).first.try(:display_name)
    end

    [:state, :county, :city, :property_class].each do |field|
      @filter.send :define_method, "formatted_param_#{field}_id" do
        id = self.send("#{field}_id")
        id.blank? ? nil : field.to_s.camelize.constantize.where(:id => id).first.try(:name)
      end
    end
  end
  
  def lien_status_methods
    @filter.send :define_method, 'filter_investment_status' do
      { :investment_status => Lien::Active::SELECTABLE_INVESTMENT_STATUSES[self.investment_status] } if self.investment_status.present?
    end

    self.method(:investment_status, :redemption_status, :bankruptcy_status, :foreclosure_status, :type => :string)

    [:investment_status, :redemption_status, :bankruptcy_status, :foreclosure_status].each do |field|
      @filter.send :define_method, "formatted_param_#{field}" do
        code = self.send(field)
        code.blank? ? nil : Lien.const_get(field.to_s.pluralize.upcase)[code]
      end
    end
  end  
    
protected
  def add_filter_method(argument)
    method = "filter_#{argument.to_s}"
    @filter.filter_methods << method
    
    # Define method only if it does not already exist
    unless @filter.method_defined?(method)
      @filter.send :define_method, method do
        value = send(argument)
        value.present? ? { argument.to_sym => value } : nil
      end
      @filter.send(:protected, method)    
    end
  end
  
  def add_filter_attribute(argument)
    @filter.filter_attributes << argument
  end
  
  def add_json_attribute(argument)
    @filter.json_attributes << argument
  end
end