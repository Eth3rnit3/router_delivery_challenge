require 'byebug'
require_relative './base'

class Rider < ModelBase
  ATTRIBUTES = %i[speed].freeze

  attr_reader :routes

  def initialize(attributes)
    super(attributes)

    @routes = []
    @speed = 0 if @speed.nil? # (km/h)
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
    time_to_restaurant = (distance1 * 60) / speed
    time_to_customer = (distance2 * 60) / speed

    time_to_restaurant -= order.restaurant.cooking_time if order.restaurant.cooking_time > time_to_restaurant

    time_to_restaurant + time_to_customer
  end
end
