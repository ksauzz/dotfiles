#!/bin/env ruby
require 'rubygems'
require 'irb/completion'

begin
  # load wirble
  require 'wirble'

  # start wirble(with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

IRB.conf[:SAVE_HISTORY] = 30
IRB.conf[:AUTO_INDENT] = true
