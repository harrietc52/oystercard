class Oystercard

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journey

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIMIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Max limit is £#{MAX_LIMIT}" if amount + balance > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Please top up. Current balance is £#{balance}" if balance < MIN_LIMIT
    deduct(MIMIMUM_CHARGE)
    @journeys << station
    @in_journey = !@in_journey
    @entry_station = station
  end

  def touch_out(station)
    @in_journey = !@in_journey
    @journeys << station
    @exit_station = station
    @entry_station = nil
  end

  def journey
    @journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
