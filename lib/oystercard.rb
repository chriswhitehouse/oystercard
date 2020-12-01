class Oystercard

  attr_reader :balance
  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Can't exceed the limit of £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in
    fail "Insufficient balance on card" if @balance < MINIMUM_AMOUNT
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_AMOUNT)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
