# frozen_string_literal: true

class ModelBase
  ATTRIBUTES = %i[id x y].freeze

  def initialize(attributes = {})
    accepted_attributes = ATTRIBUTES + self.class::ATTRIBUTES

    accepted_attributes.each do |attribute|
      self.class.send(:define_method, "#{attribute}=") do |value|
        instance_variable_set "@#{attribute}", value
      end

      instance_variable_set "@#{attribute}", attributes[attribute]

      self.class.send(:define_method, attribute) do
        instance_variable_get "@#{attribute}"
      end
    end
  end

  def distance_to(model)
    raise 'Invalid model type' unless model.class.superclass == ModelBase

    from  = [x, y]
    to    = [model.x, model.y]

    Math.sqrt(from.zip(to).reduce(0) { |sum, p| sum + (p[0] - p[1])**2 })
  end
end
