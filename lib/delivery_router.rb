# frozen_string_literal: true

Dir["#{__dir__}/models/**/*.rb"].sort.each { |f| require f }

class DeliveryRouter
  attr_reader :restaurants, :customers, :riders

  def initialize(restaurants, customers, riders)
    @restaurants  = restaurants
    @customers    = customers
    @riders       = riders
  end

  def add_order(customer: nil, restaurant: nil)
    valid_customer    = customer_from_params!(customer)
    valid_restaurant  = restaurant_from_params!(restaurant)

    order = Order.new(customer: valid_customer, restaurant: valid_restaurant)
    rider = find_best_rider(order)

    order.start_delivery!(rider)
    valid_customer.add_order(order)
  end

  def clear_orders(customer: nil)
    valid_customer = customer_from_params!(customer)
    valid_customer.clear_orders!
  end

  def route(rider: nil)
    valid_rider = rider_from_params!(rider)

    valid_rider.routes.map(&:customer)
  end

  def delivery_time(customer: nil)
    valid_customer = customer_from_params!(customer)
    order = valid_customer.orders.find { |o| !o.start_at.nil? }
    raise 'Customer has not order' if order.nil?

    order.rider.delivery_time_for(valid_customer.orders.first)
  end

  private

  def customer_from_params!(customer_id)
    customer = @customers.find { |cust| cust.id == customer_id }
    raise "Customer not found with id #{customer_id}" if customer.nil?

    customer
  end

  def rider_from_params!(rider_id)
    rider = @riders.find { |cust| cust.id == rider_id }
    raise "Rider not found with id #{rider_id}" if rider.nil?

    rider
  end

  def restaurant_from_params!(restaurant_id)
    restaurant = @restaurants.find { |cust| cust.id == restaurant_id }
    raise "Restaurant not found with id #{restaurant_id}" if restaurant.nil?

    restaurant
  end

  def find_best_rider(order)
    @riders.min { |a, b| a.delivery_time_for(order) <=> b.delivery_time_for(order) }
  end
end
