require './money_type'
class Money
  include MONEY_TYPE

  attr_accessor :value
 
  def initialize(money)
    money_valid("_"+money.to_s) ? @value = money : puts("잘못 된 화폐입니다!")
  end

  def money_valid(value)
    MONEY_TYPE.money_list.include?(value.to_sym)
  end
end