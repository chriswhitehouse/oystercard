class Oystercard

  attr_reader :balance, :entry_station, :trips
  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
    @trips = {}
  end

  def top_up(amount)
    fail "Can't exceed the limit of £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance on card" if @balance < MINIMUM_AMOUNT
    @trips[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_AMOUNT)
    @trips[:exit_station] = station
  end

  def in_journey?
    @trips.count.odd? == true
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
