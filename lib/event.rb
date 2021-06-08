class Event
  attr_reader :name, :crafts, :attendees

  def initialize(name, crafts, attendees)
    @name = name
    @crafts = crafts
    @attendees = attendees
  end

  def attendee_names
    @attendees.map { |attendee| attendee.name }
  end

  def craft_with_most_supplies
    result = @crafts.max_by { |craft| craft.supplies_required.keys.length }
    result.name
  end

  def supply_list
    collection_arr = Array.new
    @crafts.each do |craft|
      craft.supplies_required.keys.each do |supply|
        collection_arr << supply.to_s
      end
    end
    collection_arr.uniq
  end

  def attendees_by_craft_interest
    grouping = @crafts.each_with_object({}) { |craft, hash| hash[craft.name] = Array.new }
    grouping.each do |craft, attendees_array|
      @attendees.each do |attendee|
        attendee.interests.each do |interest|
          attendees_array << attendee if (interest == craft && attendees_array.index(attendee) == nil)
        end
      end
    end
  end

  def crafts_that_use(supply)
    @crafts.select { |craft| craft.supplies_required.keys.index(supply.to_sym) != nil }
  end

  def assign_attendees_to_crafts
    grouping = @crafts.each_with_object({}) { |craft, hash| hash[craft] = Array.new }
    grouping = grouping.each do |craft, attendees_array|
      @attendees.each do |attendee|
        attendees_array << attendee if (attendee.can_build?(craft) && attendees_array.index(attendee) == nil)
      end
    end
  end

end
