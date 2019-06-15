module DRINK_TYPE
  extend self
  def drink_selector(number)
    case(number) 
    when  0 then Drink.new("cola",1000)
    when  1 then Drink.new("poka",1100)
    else -1
    end
  end
end