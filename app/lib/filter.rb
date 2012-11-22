# requires the squeel gem
#
# https://github.com/ernie/squeel
require "#{::Rails.root.to_s}/lib/virtual"

class Filter < Virtual
  attr_accessor :scope, :permit_action, :user, :page

  class << self
    attr_accessor :filter_methods, :filter_attributes, :json_attributes

    def define_filter(&block)
      @filter_methods     ||= []
      @filter_attributes  ||= []
      @json_attributes    ||= []

      Filters::Builder.new(self, &block)
    end
  end

  validates :user, :presence => true

  def initialize(attributes = {})
    super

    self.page = 1 if self.page.blank?
    self.permit_action = :update if self.permit_action.blank?
  end

  def per_page
    250
  end

  def results
    s = self.scope.where(self.find_criteria)  
    s = s.accessible_by(self.user.ability, self.permit_action) if self.user.present?
    s
  end

  def to_json
    JSON.generate(Hash[self.class.json_attributes.map { |a| value = send(a); [a, send(a)] unless value.nil? }])
  end

  def self.from_json(json)
    attributes = (JSON.parse(json)).symbolize_keys!.slice(*self.json_attributes) rescue {}
    self.new(attributes)
  end

  def store_to(destination)
    destination[self.key] = self.to_json
    return self
  end

  def self.restore_from(source)
    self.from_json(source[self.key])
  end

  def update(attributes = {}, options = {})
    options.reverse_merge!({
      :nullify => false
    })

    if !!options[:nullify]
      nullifying = self.class.filter_attributes - attributes.keys
      nullifying.each{ |attr| self.send("#{attr}=", nil) }
    end

    self.attributes = attributes
    return self
  end

  def self.key
    "f.#{self.to_s.underscore.gsub('/', '-')}"
  end

  def key
    self.class.key
  end

  # The filter parameters in a human-readable format:
  # { "Start Date" => "01/01/2012", "End Date" => "12/31/2012", ... }
  # Parameter names should be defined in models.en.yml
  def formatted_params
    @formatted_params ||= self.class.filter_attributes.inject([]) do |list,field|
      value = self.send field
      data_type = self.class.columns.find { |c| c.name.to_s == field.to_s }.try(:type)

      if value.blank?
        nil
      elsif self.respond_to?("formatted_param_#{field}")
        text = self.send("formatted_param_#{field}")
      elsif data_type == :date || data_type == :datetime
        text = value.present? ? I18n.l(value) : nil
      elsif data_type == :boolean
        text = { true => 'Yes', false => 'No' }[value]
        if value == true
          text = 'Yes'
        elsif value == false
          text = 'No'
        else
          text = nil
        end
      else
        text = value
      end

      list << [ self.class.human_attribute_name(field), text ] if text.present?
      list
    end
  end

protected
  def add_condition(query, condition)
    query.nil? ? condition : query & condition
  end

  def find_criteria
    conditions = nil

    self.class.filter_methods.each do |m|
      begin
        value = self.send(m)
        conditions = self.add_condition(conditions, value) unless value.nil?
      rescue
      end
    end
    conditions
  end

  def order_criteria
    :id
  end
end
