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
    if @supplies.keys.length < craft.supplies_required.keys.length
      result = false
    else
      supplies_required = craft.supplies_required.sort_by { |supply, quantity_required| supply }.to_h
      current_supplies = @supplies.sort_by { |item, quantity| item }.to_h
      current_supplies.each do |item, quantity|
        if quantity < supplies_required[item.to_sym]
          result = false
          break
        end
      end
    end
    result
  end

end
