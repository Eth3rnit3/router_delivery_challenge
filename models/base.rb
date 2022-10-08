require 'ostruct'

class ModelBase
  ATTRIBUTES = %i[].freeze

  def initialize(attributes = {})
    attributes.each_key do |attribute|
      next unless self.class::ATTRIBUTES.include? attribute

      self.class.send(:define_method, "#{attribute}=") do |value|
        instance_variable_set "@#{attribute}", value
      end

      instance_variable_set "@#{attribute}", attributes[attribute]

      self.class.send(:define_method, attribute) do
        instance_variable_get "@#{attribute}"
      end
    end
  end
end
