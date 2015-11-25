class Oystercard

  attr_reader :balance, :in_journey
  MAX_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Max limit is £#{MAX_LIMIT}" if amount + balance > MAX_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in_out
    @in_journey = !@in_journey
  end

end
