require 'rspec'
require_relative '../lib/person'
require_relative '../lib/craft'

RSpec.describe Person do

  xit 'initializes' do
    person = Person.new({
      name: 'Hector',
      interests: ['sewing', 'millinery', 'drawing']
      })

    expect(person.class).to eq(Person)
    expect(person.name).to eq('Hector')
    expect(person.interests).to eq(["sewing", "millinery", "drawing"])
    expect(person.supplies).to eq({})
  end

  xit 'can add supplies' do
    person = Person.new({
      name: 'Hector',
      interests: ['sewing', 'millinery', 'drawing']
      })

    person.add_supply('fabric', 4)
    person.add_supply('scissors', 1)

    expect(person.supplies).to eq({"fabric"=>4, "scissors"=>1})

    person.add_supply('fabric', 3)

    expect(person.supplies).to eq({"fabric"=>7, "scissors"=>1})
  end

end
