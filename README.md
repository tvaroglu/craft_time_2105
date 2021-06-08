## Instructions

* Fork this Repository
* Clone your forked repo to your computer.
* Complete the activity below.
* Push your solution to your forked repo
* Submit a pull request from your repository to this repository
  * Put your name in your PR!

## Iteration 1 - Craft, Person, and Event

Use TDD to create classes that will respond to the interaction pattern below:

```ruby
pry(main)> require './lib/person'
#=> true

pry(main)> require './lib/craft'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> person = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
#=> #<Person:0x00007fd379b96028...>

pry(main)> person.name
#=> "Hector"

pry(main)> person.interests
#=> ["sewing", "millinery", "drawing"]

pry(main)> person.supplies
#=> {}

pry(main)> craft = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
#=> #<Craft:0x00007fd37b818318...>

pry(main)> craft.name
#=> "knitting"

pry(main)> craft.supplies_required
#=> {:yarn=>20, :scissors=>1, :knitting_needles=>2}

pry(main)> event = Event.new("Carla's Craft Connection", [craft], [person])
#=> #<Event:0x00007fd379af43e0...>

pry(main)> event.name
#=> "Carla's Craft Connection"

pry(main)> event.crafts
#=> [#<Craft:0x00007fd37b818318...>]

pry(main)> event.attendees
#=> [#<Person:0x00007fd379b96028...>]

pry(main)> person.add_supply('fabric', 4)

pry(main)> person.add_supply('scissors', 1)

pry(main)> person.supplies
#=> {"fabric"=>4, "scissors"=>1}

pry(main)> person.add_supply('fabric', 3)

pry(main)> person.supplies
#=> {"fabric"=>7, "scissors"=>1}
```

## Iteration 2
Use TDD to update your classes to respond to the following interaction pattern
* `craft_with_most_supplies` returns the name of the craft that requires the most supply types.

```ruby
pry(main)> require './lib/person'
#=> true

pry(main)> require './lib/craft'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
#=> #<Person:0x00007fc419b97910...>

pry(main)> toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
#=> #<Person:0x00007fc3fa01e558...>

pry(main)> sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1, sewing_needles: 1})
#=> #<Craft:0x00007fc40901d5b8...>
pry(main)> knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
#=> #<Craft:0x00007fc419b4c2f8...>

pry(main)> event = Event.new("Carla's Craft Connection", [sewing, knitting], [hector, toni])
#=> #<Event:0x00007fc3fa828780...>

pry(main)> event.attendee_names
#=> ["Hector", "Toni"]

pry(main)> event.craft_with_most_supplies
#=> "sewing"

pry(main)> event.supply_list
#=> ["fabric", "scissors", "thread", "sewing_needles", "yarn", "knitting_needles"]

pry(main)> hector.can_build?(sewing)
#=> false

pry(main)> hector.add_supply('fabric', 7)

pry(main)> hector.add_supply('thread', 1)

pry(main)> hector.can_build?(sewing)
#=> false

pry(main)> hector.add_supply('scissors', 1)

pry(main)> hector.add_supply('sewing_needles', 1)

pry(main)> hector.can_build?(sewing)
#=> true
```

## Iteration 3
Use TDD to update your classes to respond to the following interaction pattern
* `attendees_by_craft_interest` returns a hash where the keys are the names of all of the crafts in the event, and the values are arrays of attendees who are interested in that craft.

```ruby
pry(main)> require './lib/person'
#=> true

pry(main)> require './lib/craft'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
#=> #<Person:0x00007fe442377890...>

pry(main)> toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
#=> #<Person:0x00007fe44286a348...>

pry(main)> tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting']})
#=> #<Person:0x00007fe442335788...>

pry(main)> knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
#=> #<Craft:0x00007fe43381a640...>

pry(main)> sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
#=> #<Craft:0x00007fe4422e6610...>

pry(main)> painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})
#=> #<Craft:0x00007fe4330159e0...>

pry(main)> event = Event.new("Carla's Craft Connection", [knitting, painting, sewing], [hector, toni, tony])
#=> #<Event:0x00007fe442285ea0...>

pry(main)> event.attendees_by_craft_interest
#=> {
#    "knitting"=>[#<Person:0x00007fe44286a348...>,#<Person:0x00007fe442335788...>],
#    "painting"=>[],
#    "sewing"=>[#<Person:0x00007fe442377890...>,#<Person:0x00007fe44286a348...>]
#   }

pry(main)> event.crafts_that_use('scissors')
#=> [#<Craft:0x00007fe43381a640...>,#<Craft:0x00007fe4422e6610...>]

pry(main)> event.crafts_that_use('fire')
#=> []
```

## Iteration 4
Use TDD to update your classes to respond to the following interaction pattern
* `assign_attendees_to_crafts` returns a hash where the keys are each craft in the event, and the values are arrays of randomly chosen attendees who are interested in and can build that craft. Two possible return values are shown in the interaction pattern, but there could be other random assignments.

```ruby
pry(main)> require './lib/craft'
#=> true

pry(main)> require './lib/person'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing', 'painting']})
#=> #<Person:0x00007fae4d91ac00...>

pry(main)> toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
#=> #<Person:0x00007fae2f018490...>

pry(main)> tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting', 'painting']})
#=> #<Person:0x00007fae4d9526f0...>

pry(main)> knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
#=> #<Craft:0x00007fae4d2a6fb8...>

pry(main)> sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
#=> #<Craft:0x00007fae2f032930...>

pry(main)> painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})
#=> #<Craft:0x00007fae2f84b950...>

pry(main)> toni.add_supply('yarn', 30)

pry(main)> toni.add_supply('scissors', 2)

pry(main)> toni.add_supply('knitting_needles', 5)

pry(main)> toni.add_supply('fabric', 10)

pry(main)> toni.add_supply('scissors', 1)

pry(main)> toni.add_supply('thread', 2)

pry(main)> toni.add_supply('paint_brush', 10)

pry(main)> toni.add_supply('paints', 20)

pry(main)> tony.add_supply('yarn', 20)

pry(main)> tony.add_supply('scissors', 2)

pry(main)> tony.add_supply('knitting_needles', 2)

pry(main)> hector.add_supply('fabric', 5)

pry(main)> hector.add_supply('scissors', 1)

pry(main)> hector.add_supply('thread', 1)

pry(main)> hector.add_supply('canvas', 5)

pry(main)> hector.add_supply('paint_brush', 10)

pry(main)> hector.add_supply('paints', 20)

pry(main)> event = Event.new("Carla's Craft Connection", [knitting, painting, sewing], [hector, toni, tony])
#=> #<Event:0x00007fae4d23d8b0...>

pry(main)> event.assign_attendees_to_crafts
#=> {#<Craft:0x00007fae4d2a6fb8...>=>[#<Person:0x00007fae4d9526f0...>],
     #<Craft:0x00007fae2f84b950...>=>[#<Person:0x00007fae4d91ac00...>],
     #<Craft:0x00007fae2f032930...>=>[#<Person:0x00007fae2f018490...>]}

pry(main)> event.assign_attendees_to_crafts
#=> {#<Craft:0x00007fae4d2a6fb8...>=>[#<Person:0x00007fae4d9526f0...>],
     #<Craft:0x00007fae2f84b950...>=>[],
     #<Craft:0x00007fae2f032930...>=>[#<Person:0x00007fae4d91ac00...>,#<Person:0x00007fae2f018490...>]}
```
