#!/usr/bin/env ruby

require './lib/atm'
require './lib/prompter'
require './lib/exceptions'
require './lib/customer'

atm = Atm.new(Prompter.new)

atm.start