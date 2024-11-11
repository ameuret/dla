# frozen_string_literal: true

RSpec.describe DLA::Node, '#initialize' do
  it 'takes bounds as optional arguments' do
    expect {DLA::Node.new 42, 43}.not_to raise_error
    # expect(n.maxX).to eq(42)
    # expect(n.maxY).to eq(43)
  end
end

RSpec.describe DLA::Node do
  it 'keeps its bounds within maxX and maxY' do
    n = DLA::Node.new 42, 43
    expect(n.maxX).to eq(42)
    expect(n.maxY).to eq(43)
  end
end
