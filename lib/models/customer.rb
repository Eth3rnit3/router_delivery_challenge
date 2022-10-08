require_relative './base'

class Customer < ModelBase
  ATTRIBUTES = %i[].freeze
  attr_reader :orders

  def initialize(attributes)
    super(attributes)

    @orders = []
  end

  def add_order(order)
    @orders << order
  end

  def cancel_order(restaurant)
    @orders = @orders.reject { |order| order.restaurant.id == restaurant.id }
  end

  def clear_orders!
    @orders = []
  end
end
