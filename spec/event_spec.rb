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

  xit 'can add do more stuff' do
    # stuff
  end

end
