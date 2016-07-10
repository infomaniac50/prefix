#!/usr/bin/env ruby

# == bin_gen: Generate a binary file based on provided requirements
#
# This tool was written to allow me to generate small amounts of binary
# data to test an app I was writing. My primary use was to generate
# a simple file with all bytes in order so I could spot those which
# were being affected during import and export.
#
# See www.digininja.org/projects/bin_gen.php for more information
#
# Author:: Robin Wood (robin@digininja.org)
# Copyright:: Copyright (c) Robin Wood 2013
# Licence:: license = "Creative Commons Attribution-Share Alike Licence"
#

require 'getoptlong'

opts = GetoptLong.new(
	[ '--help', '-h', GetoptLong::NO_ARGUMENT ],
	[ '--random', '-a', GetoptLong::NO_ARGUMENT ],
	[ '--reverse', '-r', GetoptLong::NO_ARGUMENT ],
	[ '--start', "-s" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--length', "-l" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--fixed-char', "-c" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--file', "-f" , GetoptLong::REQUIRED_ARGUMENT ],
)

# Display the usage
def usage
	puts"bin_gen v 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Usage: bin_gen [OPTIONS]
	--file x, -f x: output file, use - for stdout. Default is stdout
	--start x, -s x: the start character. Default 0
	--length x, -l x: the number of bytes to generate. Default 255
	--reverse, -r: reverse the order. Default false
	--fixed-char x, -c x: use a fixed byte. Default off
	--random, -a: use random bytes. Default off
	--help, -h: this help message

"
	exit
end

start = 0
length = 255
fixed_char = nil
reverse = false
random = false
output_file = STDOUT

begin
	opts.each do |opt, arg|
		case opt
			when '--file'
				output_file = arg
				if arg == "-"
					output_file = STDOUT
				else
					begin
						output_file = File.new(arg, "w")
					rescue => e
						puts "There was a problem creating the output file - " + e.message
						exit
					end
				end
			when '--help'
				usage
			when "--start"
				start = arg.to_i
			when "--fixed"
				fixed_char = arg.to_i
			when "--length"
				length = arg.to_i
			when "--reverse"
				reverse = true
			when "--random"
				random = true
		end
	end
rescue
	usage
end

#puts "Start #{start}, length #{length}, fixed char #{(fixed_char.nil?)? "off" : fixed_char}"

0.upto (length - 1) do |c|
	if !fixed_char.nil?
		char = fixed_char
	elsif random
		char = Random.rand(256)
	else
		if reverse
			d = c * -1
		else
			d = c
		end

		char = (start + d) % 256
	end
	output_file.print char.chr
end
