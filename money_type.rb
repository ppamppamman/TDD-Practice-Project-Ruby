module MONEY_TYPE
  extend self
  
  
  def money_list
    [:_5000, :_1000, :_500, :_100, :_50]
  end

  def money_selector(sym)
    case(sym) 
      when :_50 then 50
      when :_100 then 100
      when :_500 then 500
      when :_1000 then 1000
      when :_5000 then 5000
      else puts "error!"
    end
  end

  def money_selector_string(sym)
    case(sym) 
      when :_50 then "50원"
      when :_100 then "100원"
      when :_500 then "500원"
      when :_1000 then "1000원"
      when :_5000 then "5000원"
      else puts "error!"
    end
  end
end