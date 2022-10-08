require_relative './base'

class Rider < ModelBase
  ATTRIBUTES = %i[speed].freeze

  attr_reader :routes

  def initialize(attributes)
    super(attributes)

    @routes = []
    @speed = 10 if @speed.nil? # (km/h)
  end

  def add_route(order)
    @routes << order
  end

  def clear_routes!
    @routes = []
  end

  def delivery_time_for(order)
    distance1 = distance_to(order.restaurant)
    distance2 = order.restaurant.distance_to(order.customer)

    (distance1 + distance2) * speed
  end
end
