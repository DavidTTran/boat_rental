class Dock
  attr_reader :name, :max_rental_time, :revenue

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rented_boats = {}
    @revenue = 0
  end

  def rent(boat, renter)
    @rented_boats[boat] = renter
  end

  def rental_log
    @rented_boats
  end

  def charge(boat)
    charge = Hash.new
    renter_card = @rented_boats[boat].credit_card_number

    if boat.hours_rented <= @max_rental_time
      cost_by_hour = boat.hours_rented * boat.price_per_hour
    else
      cost_by_hour = @max_rental_time * boat.price_per_hour
    end

    charge[:card_number] = "#{renter_card}"
    charge[:amount] = cost_by_hour
    @revenue += cost_by_hour
    charge
  end

  def log_hour
    @rented_boats.each_key { |boat| boat.add_hour }
  end

  def return(boat)
    charge(boat)
    @revenue
  end
end
