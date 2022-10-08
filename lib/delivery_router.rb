# frozen_string_literal: true

class DeliveryRouter
  attr_reader :restaurants, :customers, :riders

  def initialize(restaurants, customers, riders)
    @restaurants  = restaurants
    @customers    = customers
    @riders       = riders
  end

  def add_order(customer: nil, restaurant: nil)
    raise "Can't add order if customer and/or restaurant is nil" if customer.nil? || restaurant.nil?

    valid_customer    = customer_from_params!(customer)
    valid_restaurant  = restaurant_from_params!(restaurant)

    valid_customer.add_order(valid_restaurant)
  end

  private

  def customer_from_params!(customer_id)
    customer = @customers.find { |cust| cust.id == customer_id }
    raise "Customer not found with id #{customer_id}" if customer.nil?

    customer
  end

  def restaurant_from_params!(restaurant_id)
    restaurant = @restaurants.find { |cust| cust.id == restaurant_id }
    raise "Restaurant not found with id #{restaurant_id}" if restaurant.nil?

    restaurant
  end
end
