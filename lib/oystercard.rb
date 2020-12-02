class Oystercard

  attr_reader :balance, :entry_station, :journeys, :journey
  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1
  PENALTY_FAIR = 6

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Can't exceed the limit of £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance on card" if @balance < MINIMUM_AMOUNT
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.end_journey(station)
    deduct
    @journeys << @journey
  end

  private
  def deduct
    @balance -= @journey.calculate_fair
  end

end
