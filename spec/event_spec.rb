require 'rspec'
require_relative '../lib/person'
require_relative '../lib/craft'
require_relative '../lib/event'

RSpec.describe Event do

  xit 'initializes' do
    person = Person.new({
      name: 'Hector',
      interests: ['sewing', 'millinery', 'drawing']
      })
    craft = Craft.new('knitting',
      {yarn: 20, scissors: 1, knitting_needles: 2})
    event = Event.new("Carla's Craft Connection", [craft], [person])

    expect(event.class).to eq(Event)
    expect(event.name).to eq("Carla's Craft Connection")

    expect(event.crafts.class).to eq(Array)
    expect(event.crafts.length).to eq(1)
    expect(event.crafts.first.name).to eq('knitting')

    expect(event.attendees.class).to eq(Array)
    expect(event.attendees.length).to eq(1)
    expect(event.attendees.first.name).to eq('Hector')
  end

  xit 'can return statistics' do
    hector = Person.new({
      name: 'Hector',
      interests: ['sewing', 'millinery', 'drawing']
      })
    toni = Person.new({
      name: 'Toni',
      interests: ['sewing', 'knitting']
      })
    sewing = Craft.new('sewing',
      {fabric: 5, scissors: 1, thread: 1, sewing_needles: 1})
    knitting = Craft.new('knitting',
      {yarn: 20, scissors: 1, knitting_needles: 2})
    event = Event.new("Carla's Craft Connection", [sewing, knitting], [hector, toni])

    expect(event.attendee_names).to eq(['Hector', 'Toni'])
    expect(event.craft_with_most_supplies).to eq('sewing')
    expect(event.supply_list).to eq(['fabric', 'scissors', 'thread', 'sewing_needles', 'yarn', 'knitting_needles'])

    expect(hector.can_build?(sewing)).to be false

    hector.add_supply('fabric', 7)
    hector.add_supply('thread', 1)

    expect(hector.can_build?(sewing)).to be false

    hector.add_supply('scissors', 1)
    hector.add_supply('sewing_needles', 1)

    expect(hector.can_build?(sewing)).to be true
  end

end
