# frozen_string_literal: true

require_relative 'dla/version'

module DLA
  class Error < StandardError; end

  class Node
    attr_accessor :xBound, :yBound, :root, :x, :y, :parent, :nodes, :ix, :iy, :history

    def self.root(x: nil, y: nil, xBound: 1280, yBound: 720)
      r = Node.new root: nil
      r.x = r.ix = x || xBound / 2
      r.y = r.iy = y || yBound / 2
      r.nodes << r
      r
    end

    def initialize(root:, xBound: 1280, yBound: 720)
      @root = root || self
      @xBound = xBound
      @yBound = yBound
      @nodes = []
      @x, @y = randomFreePos
      @ix, @iy = @x, @y
      @children = {}
      @history = String.new
    end

    def at(x, y)
      allTreeNodes.find { |n| n.x == x && n.y == y }
    end

    def north
      @children[:north]
    end

    def south
      @children[:south]
    end

    def east
      @children[:east]
    end

    def west
      @children[:west]
    end

    def allTreeNodes
      @root.nodes
    end

    def attach(node, position)
      raise ArgumentError, 'position must be :north, :south, :east, :west' unless [:north, :south, :east, :west].include? position

      @children[position] = node
      node.parent = self
      raise ArgumentError, 'Node is already present' if allTreeNodes.include? node

      @root.nodes << node
    end

    def randomFreePos(forcedX: nil, forcedY: nil)
      x = y = 0
      loop do
        x = rand @xBound
        y = rand @yBound
        break unless @root.at x, y
      end
      [x, y]
    end

    def oppositeDirection(dir)
      {
        north: :south,
        south: :north,
        east: :west,
        west: :east
      }[dir]
    end

    def move
      raise RuntimeError if @parent

      dir = [:north, :south, :east, :west].sample
      destV = {
        north: [0, 1],
        south: [0, -1],
        east: [1, 0],
        west: [-1, 0]
      }[dir]
      @history << dir.to_s[0]
      if (contact = @root.at(@x + destV[0], @y + destV[1]))
        contact.attach(self, oppositeDirection(dir))
      else
        @x += destV[0]
        @y += destV[1]
      end
    end

    def to_s
      format('%d,%d(%d,%d)%s', @x, @y, @ix, @iy, @history)
    end
  end
end
