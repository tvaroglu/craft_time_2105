require 'simplecov'
SimpleCov.start

require 'rspec'
require_relative '../lib/craft'

RSpec.describe Craft do

  it 'initializes' do
    craft = Craft.new('knitting',
      {yarn: 20, scissors: 1, knitting_needles: 2})

    expect(craft.class).to eq(Craft)
    expect(craft.name).to eq('knitting')
    expect(craft.supplies_required).to eq(
      {:yarn=>20, :scissors=>1, :knitting_needles=>2})
  end

end
