class Oystercard

  attr_reader :balance, :entry_station
  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Can't exceed the limit of £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance on card" if @balance < MINIMUM_AMOUNT
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_AMOUNT)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
