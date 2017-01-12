class Oystercard
MAX_BALANCE = 90
attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    errormessage = "Exceeds max balance of #{ MAX_BALANCE }."
    raise errormessage if amount + balance > MAX_BALANCE
    @balance += amount
  end

end
