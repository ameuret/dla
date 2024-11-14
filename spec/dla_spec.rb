# frozen_string_literal: true

RSpec.describe DLA::Node do
  before :example do
    @root = DLA::Node.root
  end

  describe '.root' do
    it 'creates a new root' do
      r = DLA::Node.root
      expect(r.root).to be r
    end

    it 'can be created at a specific point' do
      r = DLA::Node.root(x: 42, y: 84)
      expect(r.x).to eq(42)
      expect(r.y).to eq(84)
    end

    it 'is centered in the bounds by default' do
      r = DLA::Node.root
      expect(r.x).to eq(640)
      expect(r.y).to eq(360)
      r = DLA::Node.root(xBound: 420, yBound: 840)
      expect(r.x).to eq(210)
      expect(r.y).to eq(420)
    end
  end

  describe '#allTreeNodes' do
    it 'lists _all_ nodes of the tree' do
      n1 = DLA::Node.new root: @root
      n2 = DLA::Node.new root: @root
      n3 = DLA::Node.new root: @root
      n4 = DLA::Node.new root: @root
      n5 = DLA::Node.new root: @root
      @root.attach n1, :north
      @root.attach n2, :south
      @root.attach n3, :east
      n3.attach n4, :south
      n2.attach n5, :south

      allNodes = n3.allTreeNodes
      [n1, n2, n3, n4, n5].each do
        |n|
        expect(allNodes.include?(n)).to be true
      end
    end
  end

  describe '#free?' do
    it 'is true if the given position is unoccupied' do
      @root.free? 10, 10
    end
  end

  describe '#attach' do
    it 'artificially grafts a node to an anchor point (:north, :south, :east, :west)' do
      n = DLA::Node.new root: @root
      @root.attach n, :south
      expect(@root.south).to be(n)
      expect(n.parent).to be(@root)
    end
  end

  describe '.new' do
    it 'takes bounds as optional arguments' do
      DLA::Node.new root: @root, xBound: 42, yBound: 43
    end

    it 'creates a node in a random location' do
      n = DLA::Node.new root: @root
      expect(n.x).to be_an Integer
      expect(n.y).to be_an Integer
    end
  end

  it 'keeps its bounds within xBound and yBound' do
    n = DLA::Node.new root: @root, xBound: 42, yBound: 43
    expect(n.xBound).to eq(42)
    expect(n.yBound).to eq(43)
  end

  describe '#move' do
    it 'moves to a random neighboring location' do
      n = DLA::Node.new root: @root
      prevX, prevY = n.x, n.y
      n.move
      expect(n.x == prevX + 1 ||
             n.x == prevX - 1 ||
             n.y == prevY + 1 ||
             n.y == prevY - 1).to be true
    end

    it 'raises an exception if asked to moved when already attached' do
      n = DLA::Node.new root: @root
      @root.attach n, :south
      expect {n.move}.to raise_exception RuntimeError
    end
  end

  describe '#to_s' do
    it 'dumps the node state into a string like 727,187(726,187)wsenwnnew' do
      n = DLA::Node.new root: @root
      42.times{n.move}
      expect(n.to_s).to match /\d+,\d+\(\d+,\d+\)[nsew]+/
    end
  end
end
