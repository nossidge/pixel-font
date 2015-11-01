#!/usr/bin/env ruby
# encoding: UTF-8

################################################################################
# Simple method to determine if a string is a valid filename.
# Windows only, for now.
################################################################################

module ValidFilename
	
	# Just Windows for now.
	def self.valid?(text)
		valid_in_windows?(text)
	end
	
	# Is the filename valid in Windows?
	def self.valid_in_windows?(text)
		invalid_chars = ['\\','/','?','<','>',':','*','|','"','^']
		invalid_strings = ['con','nul','prn',
			'com1','com2','com3','com4','com5','com6','com7','com8','com9',
			'lpt1','lpt2','lpt3','lpt4','lpt5','lpt6','lpt7','lpt8','lpt9']
		valid_c = !invalid_chars.any? { |c| text.include? c }
		valid_s = !invalid_strings.include?(text)
		(valid_c && valid_s && !text.empty?)
	end
	
	# Turn an invalid filename into a valid one.
	# Replace each dodgy character with a valid one.
	def self.make_valid(text,replace_char='_')
		invalid_regex = /[\\\/?<>:*|"^]/
		text.gsub(invalid_regex,replace_char)
	end
end

################################################################################

__END__

puts ValidFilename::valid_filename?('lpt5')
puts ValidFilename::valid_filename?('foo3')
puts ValidFilename::valid_filename?('foo:3')
puts ValidFilename::valid_filename?('|foo:3')
puts ValidFilename::valid_filename?('')
puts ValidFilename::valid_filename?(' ')
puts ValidFilename::make_valid('|foo:1\\2/3?4<5>6:7*8|9"0^')

