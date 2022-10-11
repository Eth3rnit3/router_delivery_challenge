# frozen_string_literal: true

require_relative './base'

class Order < ModelBase
  ATTRIBUTES = %i[customer restaurant].freeze

  attr_reader :start_at, :estimated_deliver_time, :estimated_deliver_at, :rider

  def initialize(attributes)
    super(attributes)

    @start_at = nil
    @estimated_deliver_time = nil
    @estimated_deliver_at = nil
    @rider = nil
  end

  def start_delivery!(rider)
    @start_at = Time.now
    @rider = rider
    @estimated_deliver_time = @rider.delivery_time_for(self)
    @estimated_deliver_at = @start_at + @estimated_deliver_time
    @rider.add_route(self)

    self
  end
end
