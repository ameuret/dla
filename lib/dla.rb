# frozen_string_literal: true

require_relative "dla/version"

module DLA
  class Error < StandardError; end
  class Node
    attr_accessor :maxX
    attr_accessor :maxY

    def initialize(maxX = 1280, maxY = 720)
      @maxX = maxX
      @maxY = maxY
    end
  end
end
