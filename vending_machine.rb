require './money_type'
class VendingMachine
  include MONEY_TYPE
  attr_accessor :deposit
  @drinks = {}

  def initialize()
    @drinks = [
      {name: "cola", price: 1000, qty: 0},
      {name: "poka", price: 1200, qty: 10},
    ]
    @deposit = 0
  end
  def input_deposit(money)
    @deposit += money
    puts "투입 금액 #{@deposit} 원"
    drink_list()
  end

  def return_drink(drink)
    check_qty_zero(@drinks[drink][:qty])
    calculator_balance(@drinks[drink][:price])
    @drinks[drink][:qty] -= 1
    DRINK_TYPE.drink_selector(drink)
  end

  def check_qty_zero(qty)
    qty.to_i.zero?
    puts "품절된 상품입니다. 다른 버튼을 눌러주세요"
    false
  end
  def drink_list
    puts "---- 무엇을 마시겠습니까 숫자를 입력해 주세요 ----"
    @drinks.each_with_index do |drink,index|
      is_drink = (drink[:qty] > 0) ? "O" : "X"
      puts "#{index+1}. #{drink[:name]} #{drink[:price]}원 #{is_drink}" if drink[:price] <= @deposit
    end
    puts "-----------------------------"
  end

  def calculator_balance(price)
    if @deposit < price
      puts "ERROR! 잔액이 부족합니다. 다시 입력해 주세요"
    else 
      @deposit -= price
    end
  end

  def return_balance
    puts "balance:#{@deposit}"
    @deposit
  end

  def balance_calculate
    result = {}
    MONEY_TYPE.money_list.each do |money|
      result[MONEY_TYPE.money_selector_string(money)] =  @deposit / MONEY_TYPE.money_selector(money)
      @deposit %= MONEY_TYPE.money_selector(money)
    end

    message_title = "반환 금액: "
    message_content = ""
    result.each do |money, qty| 
      message_content += "#{money}:#{qty}" unless qty.zero?
    end
    puts message_title + message_content unless message_content.empty?
  end
end