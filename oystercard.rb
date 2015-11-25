class Oystercard

  attr_reader :balance, :in_journey

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIMIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Max limit is £#{MAX_LIMIT}" if amount + balance > MAX_LIMIT
    @balance += amount
  end

  def touch_in_out
    fail "Please top up. Current balance is £#{balance}" if balance < MIN_LIMIT
    deduct(MIMIMUM_CHARGE)
    @in_journey = !@in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
