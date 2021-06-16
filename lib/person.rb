class Person
  attr_reader :name, :interests, :supplies

  def initialize(attributes)
    @name = attributes[:name]
    @interests = attributes[:interests]
    @supplies = Hash.new(0)
  end

  def add_supply(item, quantity)
    @supplies[item] += quantity
  end

  def can_build?(craft)
    result = true
    craft.supplies_required.each do |item, quantity|
      if @supplies[item.to_s] < quantity
        result = false
        break
      end
    end
    result
  end

end
