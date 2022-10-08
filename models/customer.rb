require_relative './base'

class Customer < ModelBase
  ATTRIBUTES = %i[].freeze

  def initialize(attributes)
    super(attributes)

    @orders = []
  end

  def add_order(restaurant)
    @orders << { restaurant: restaurant, order_at: Time.now }
  end

  def cancel_order(restaurant)
    @orders = @orders.reject { |order| order[:restaurant].id == restaurant.id }
  end
end
