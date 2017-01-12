class Oystercard
MAX_BALANCE = 90
MIN_BALANCE = 1
attr_reader :balance, :in_journey

  def initialize(balance = 0)
    @in_journey = false
    @balance = balance
  end

  def top_up(amount)
    error_message = "Exceeds max balance of #{ MAX_BALANCE }."
    raise error_message if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    sufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(1)
  end

  def in_journey?
    @in_journey
  end


  private

  def sufficient_funds?
    raise "Not enough money." if balance < MIN_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
