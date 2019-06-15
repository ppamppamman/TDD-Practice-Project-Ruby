require './drink_type'
class User
  attr_accessor :amount

  def initialize(amount)
    @amount = amount.value
    @drinks = []
  end

  # 자판기에 돈을 투입한다.
  def input_amount_to_vm(money)
    @amount -= money.value
    money.value
  end

  # 자판기가 잔돈을 반환한다.
  def output_balance_from_vm(money)
    @amount += money
  end

  # 음료수를 선택한다.
  def select_drink(drink_number)
    drink_index = drink_number-1 
    drink_index #index.. 고민 잘한건지 모르겠음 사용자는 1 이지만, 이제부턴 기계에 들어가서 바꿨는데, 잘 모르겠당. 
  end

  # 음료수를 받는다.
  def pick_up_drink(drink)
    @drinks.push(drink)
  end
end