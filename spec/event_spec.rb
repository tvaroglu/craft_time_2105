require 'simplecov'
SimpleCov.start

require 'rspec'
require_relative '../lib/person'
require_relative '../lib/craft'
require_relative '../lib/event'

RSpec.describe Event do

  it 'initializes' do
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

  it 'can return statistics' do
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

  it 'can return attendees interested in each craft and assess craft requirements' do
    hector = Person.new({
      name: 'Hector',
      interests: ['sewing', 'millinery', 'drawing']
      })
    toni = Person.new({
      name: 'Toni',
      interests: ['sewing', 'knitting']
      })
    brian = Person.new({
      name: 'Brian',
      interests: ['drawing', 'knitting']
      })
    knitting = Craft.new('knitting',
      {yarn: 20, scissors: 1, knitting_needles: 2})
    sewing = Craft.new('sewing',
      {fabric: 5, scissors: 1, thread: 1})
    painting = Craft.new('painting',
      {canvas: 1, paint_brush: 2, paints: 5})
    event = Event.new("Carla's Craft Connection", [knitting, painting, sewing], [hector, toni, brian])

    expected = event.attendees_by_craft_interest
    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(3)
    expect(expected.values.length).to eq(3)

    data_validation = expected.values.all? { |value| value.class == Array }
    expect(data_validation).to be true

    expect(expected['knitting'].length).to eq(2)
    expect(expected['knitting'].first.name).to eq('Toni')
    expect(expected['knitting'].last.name).to eq('Brian')

    expect(expected['painting'].length).to eq(0)

    expect(expected['sewing'].length).to eq(2)
    expect(expected['sewing'].first.name).to eq('Hector')
    expect(expected['sewing'].last.name).to eq('Toni')


    expected = event.crafts_that_use('scissors')

    expect(expected.class).to eq(Array)
    expect(expected.length).to eq(2)
    expect(expected.first.name).to eq('knitting')
    expect(expected.last.name).to eq('sewing')

    expected = event.crafts_that_use('fire')

    expect(expected.class).to eq(Array)
    expect(expected.length).to eq(0)
  end

  it 'can return attendees interested in each craft and assess craft requirements' do
    hector = Person.new({
      name: 'Hector',
      interests: ['sewing', 'millinery', 'drawing']
      })
    toni = Person.new({
      name: 'Toni',
      interests: ['sewing', 'knitting']
      })
    brian = Person.new({
      name: 'Brian',
      interests: ['drawing', 'knitting', 'painting']
      })
    knitting = Craft.new('knitting',
      {yarn: 20, scissors: 1, knitting_needles: 2})
    sewing = Craft.new('sewing',
      {fabric: 5, scissors: 1, thread: 1})
    painting = Craft.new('painting',
      {canvas: 1, paint_brush: 2, paints: 5})

    toni.add_supply('yarn', 30)
    toni.add_supply('scissors', 2)
    toni.add_supply('knitting_needles', 5)
    toni.add_supply('fabric', 10)
    toni.add_supply('scissors', 1)
    toni.add_supply('thread', 2)
    toni.add_supply('paint_brush', 10)
    toni.add_supply('paints', 20)

    brian.add_supply('yarn', 20)
    brian.add_supply('scissors', 2)
    brian.add_supply('knitting_needles', 2)

    hector.add_supply('fabric', 5)
    hector.add_supply('scissors', 1)
    hector.add_supply('thread', 1)
    hector.add_supply('canvas', 5)
    hector.add_supply('paint_brush', 10)
    hector.add_supply('paints', 20)

    event = Event.new("Carla's Craft Connection", [knitting, sewing, painting], [hector, toni, brian])

    expected = event.assign_attendees_to_crafts

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(3)
    expect(expected.values.length).to eq(3)

    data_validation = expected.values.all? { |value| value.class == Array }

    expect(data_validation).to be true

    expect(expected.keys[0].name).to eq('knitting')
    expect(expected.values[0].length).to eq(2)
    expect(expected.values[0].first.name).to eq('Toni')
    expect(expected.values[0].last.name).to eq('Brian')

    expect(expected.keys[1].name).to eq('sewing')
    expect(expected.values[1].length).to eq(2)
    expect(expected.values[1].first.name).to eq('Hector')
    expect(expected.values[1].last.name).to eq('Toni')

    expect(expected.keys[2].name).to eq('painting')
    expect(expected.values[2].length).to eq(0)
  end
end
