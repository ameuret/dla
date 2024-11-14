#!/usr/bin/env ruby

require 'dla'
require 'duration'
require 'tty-cursor'
require 'tty-box'
require 'tty-reader'
require 'tty-screen'

curs = TTY::Cursor

out = nil
out = File.open('out.txt', 'w+')

at_exit {
  print curs.show
  out.close if out
}

print curs.hide
print curs.clear_screen

start = Time.now
keyb = TTY::Reader.new
# sw = TTY::Screen.width
# sh = TTY::Screen.height

sw = 512
sh = 512
scale = 0.1

x = y = 0
single = false

keyb.on(:keyctrl_x, :keyescape) do
  puts 'Exiting...'
  exit
end

root = DLA::Node.root(xBound: sw - 3, yBound: sh - 3)

n = DLA::Node.new root: root, xBound: sw - 3, yBound: sh - 3
frameIdx = 0
cellCreated = 0

print curs.move_to((root.x * scale * 2.5).floor + 1, (root.y * scale).floor + 1), '🟠'

loop do
  d = Duration.new(Time.now - start)
  keyb.read_keypress(nonblock: true)
  print TTY::Box.frame(format('%05d moves - %d cells/%d - %ds', frameIdx, root.nodes.count, cellCreated, d.to_i).to_s,
                       top: 0,
                       left: 0,
                       width: (sw * scale * 2.5).floor,
                       height: (sh * scale).floor,
                       padding: 0,
                       align: :center,
                       border: :round,
                       title: {top_left: 'DLA',
                               bottom_right: 'ESC: Quit',
                               bottom_left: format('[%dx%d]', sw, sh)})
  loop do
    n.move
    x = n.x + 1
    y = n.y + 1
    frameIdx += 1
    # print curs.move_to(x, y), '*' #✴🔶🟤
    if n.parent || x < 0 || x > sw - 2 || y < 0 || y > sh - 2
      if n.parent #✴🔶🟤
        if out
          out << n.to_s
          out << "\n"
        end
        print curs.move_to((x * scale * 2.5).floor, (y * scale).floor), '🟠'
        # print curs.clear_screen
      end
      n = DLA::Node.new root:, xBound: sw - 2, yBound: sh - 2
      cellCreated += 1
      break
    end
  end
end
