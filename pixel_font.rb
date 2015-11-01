#!/usr/bin/env ruby
# encoding: UTF-8

################################################################################
# Array representation of the Silkscreen font.
# Includes all the characters in the font, plus some additional ones.
# http://kottke.org/plus/type/silkscreen/
# 
# If this file is called from the command line, create a png image for each
#   character using the file 'num_to_pic.rb'
################################################################################

require_relative 'valid_filename.rb'

################################################################################

class PixelFont
	attr_reader :chars
	attr_reader :leading, :tracking, :space_width
	
	# Cache of the most recent string and array representations.
	attr_accessor :text, :pixel_map
	
	##############################################################################
	
	# Validate integer and make absolute.
	def abs_integer(input,error_msg)
		if input.is_a? Integer
			input.abs
		else
			raise error_msg
		end
	end
	
	# Needs to be an integer >= 0
	def tracking=(input)
		msg = 'PixelFont.tracking needs to be a positive integer'
		@tracking = abs_integer(input, msg)
	end
	def leading=(input)
		msg = 'PixelFont.leading needs to be a positive integer'
		@leading = abs_integer(input, msg)
	end
	
	# Needs to be an integer >= 0
	# Also need to reset the value of @chars[' '] 
	def space_width=(input)
		msg = 'PixelFont.space_width needs to be a positive integer'
		@space_width = abs_integer(input, msg)
		@chars[' '] = 7.times.map { ' ' * @space_width }
		@space_width
	end
	
  ##############################################################################
	
	def initialize
		
		# Array representations of characters in the Silkscreen font.
		# All character maps are arrays containing 7 strings of the same length.
		@chars = {}
		
		# Simple initialise variables.
		@text = nil
		self.leading = 1
		self.tracking = 2
		self.space_width = 2
		
		############################################################################
		
		# Default Silkscreen characters.
		@chars['a'] = [
			'    ',
			' 11 ',
			'1  1',
			'1111',
			'1  1',
			'1  1',
			'    '
		]
		@chars['b'] = [
			'    ',
			'111 ',
			'1  1',
			'1111',
			'1  1',
			'111 ',
			'    '
		]
		@chars['c'] = [
			'    ',
			' 11 ',
			'1  1',
			'1   ',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['d'] = [
			'    ',
			'111 ',
			'1  1',
			'1  1',
			'1  1',
			'111 ',
			'    '
		]
		@chars['e'] = [
			'   ',
			'111',
			'1  ',
			'111',
			'1  ',
			'111',
			'   '
		]
		@chars['f'] = [
			'   ',
			'111',
			'1  ',
			'111',
			'1  ',
			'1  ',
			'   '
		]
		@chars['g'] = [
			'    ',
			' 111',
			'1   ',
			'1 11',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['h'] = [
			'    ',
			'1  1',
			'1  1',
			'1111',
			'1  1',
			'1  1',
			'    '
		]
		@chars['i'] = [
			' ',
			'1',
			'1',
			'1',
			'1',
			'1',
			' '
		]
		@chars['j'] = [
			'    ',
			'   1',
			'   1',
			'   1',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['k'] = [
			'    ',
			'1  1',
			'1 1 ',
			'11  ',
			'1 1 ',
			'1  1',
			'    '
		]
		@chars['l'] = [
			'   ',
			'1  ',
			'1  ',
			'1  ',
			'1  ',
			'111',
			'   '
		]
		@chars['m'] = [
			'     ',
			'1   1',
			'11 11',
			'1 1 1',
			'1   1',
			'1   1',
			'     '
		]
		@chars['n'] = [
			'     ',
			'1   1',
			'11  1',
			'1 1 1',
			'1  11',
			'1   1',
			'     '
		]
		@chars['o'] = [
			'    ',
			' 11 ',
			'1  1',
			'1  1',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['p'] = [
			'    ',
			'111 ',
			'1  1',
			'111 ',
			'1   ',
			'1   ',
			'    '
		]
		@chars['q'] = [
			'    ',
			' 11 ',
			'1  1',
			'1  1',
			'1  1',
			' 11 ',
			'   1'
		]
		@chars['r'] = [
			'    ',
			'111 ',
			'1  1',
			'111 ',
			'1 1 ',
			'1  1',
			'    '
		]
		@chars['s'] = [
			'    ',
			' 111',
			'1   ',
			' 11 ',
			'   1',
			'111 ',
			'    '
		]
		@chars['t'] = [
			'   ',
			'111',
			' 1 ',
			' 1 ',
			' 1 ',
			' 1 ',
			'   '
		]
		@chars['u'] = [
			'    ',
			'1  1',
			'1  1',
			'1  1',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['v'] = [
			'     ',
			'1   1',
			'1   1',
			' 1 1 ',
			' 1 1 ',
			'  1  ',
			'     '
		]
		@chars['w'] = [
			'     ',
			'1   1',
			'1 1 1',
			'1 1 1',
			'1 1 1',
			' 1 1 ',
			'     '
		]
		@chars['x'] = [
			'     ',
			'1   1',
			' 1 1 ',
			'  1  ',
			' 1 1 ',
			'1   1',
			'     '
		]
		@chars['y'] = [
			'     ',
			'1   1',
			' 1 1 ',
			'  1  ',
			'  1  ',
			'  1  ',
			'     '
		]
		@chars['z'] = [
			'   ',
			'111',
			'  1',
			' 1 ',
			'1  ',
			'111',
			'   '
		]
		
		
		@chars['1'] = [
			'   ',
			'11 ',
			' 1 ',
			' 1 ',
			' 1 ',
			'111',
			'   '
		]
		@chars['2'] = [
			'    ',
			'111 ',
			'   1',
			' 11 ',
			'1   ',
			'1111',
			'    '
		]
		@chars['3'] = [
			'    ',
			'111 ',
			'   1',
			' 11 ',
			'   1',
			'111 ',
			'    '
		]
		@chars['4'] = [
			'    ',
			'1 1 ',
			'1 1 ',
			'1111',
			'  1 ',
			'  1 ',
			'    '
		]
		@chars['5'] = [
			'    ',
			'1111',
			'1   ',
			'111 ',
			'   1',
			'111 ',
			'    '
		]
		@chars['6'] = [
			'    ',
			' 11 ',
			'1   ',
			'111 ',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['7'] = [
			'    ',
			'1111',
			'   1',
			'  1 ',
			' 1  ',
			' 1  ',
			'    '
		]
		@chars['8'] = [
			'    ',
			' 11 ',
			'1  1',
			' 11 ',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['9'] = [
			'    ',
			' 11 ',
			'1  1',
			' 111',
			'   1',
			' 11 ',
			'    '
		]
		@chars['0'] = [
			'    ',
			' 11 ',
			'1  1',
			'1  1',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['.'] = [
			' ',
			' ',
			' ',
			' ',
			' ',
			'1',
			' '
		]
		@chars[','] = [
			'  ',
			'  ',
			'  ',
			'  ',
			'  ',
			' 1',
			'1 '
		]
		@chars[':'] = [
			' ',
			' ',
			'1',
			' ',
			'1',
			' ',
			' '
		]
		@chars[';'] = [
			'  ',
			'  ',
			' 1',
			'  ',
			' 1',
			'1 ',
			'  '
		]
		@chars['!'] = [
			' ',
			'1',
			'1',
			'1',
			' ',
			'1',
			' '
		]
		@chars['?'] = [
			'    ',
			'111 ',
			'   1',
			' 11 ',
			'    ',
			' 1  ',
			'    '
		]
		@chars['@'] = [
			'     ',
			' 111 ',
			'1 1 1',
			'1 11 ',
			'1    ',
			' 111 ',
			'     '
		]
		@chars['#'] = [
			'     ',
			' 1 1 ',
			'11111',
			' 1 1 ',
			'11111',
			' 1 1 ',
			'     '
		]
		@chars['$'] = [
			'  1 ',
			' 111',
			'1   ',
			' 11 ',
			'   1',
			'111 ',
			' 1  '	
		]
		@chars['%'] = [
			'     ',
			'11 1 ',
			'11 1 ',
			'  1  ',
			' 1 11',
			' 1 11',
			'     '
		]
		@chars['&'] = [
			'  1 ',
			' 111',
			'1   ',
			' 11 ',
			'1   ',
			' 111',
			'  1 '
		]
		@chars["'"] = [
			' ',
			'1',
			'1',
			' ',
			' ',
			' ',
			' '
		]
		@chars['"'] = [
			'   ',
			'1 1',
			'1 1',
			'   ',
			'   ',
			'   ',
			'   '
		]
		@chars['`'] = [
			'1 ',
			' 1',
			'  ',
			'  ',
			'  ',
			'  ',
			'  '
		]
		@chars['^'] = [
			' 1 ',
			'1 1',
			'   ',
			'   ',
			'   ',
			'   ',
			'   '
		]
		@chars['~'] = [
			' 1 1',
			'1 1 ',
			'    ',
			'    ',
			'    ',
			'    ',
			'    '
		]
		@chars['_'] = [
			'    ',
			'    ',
			'    ',
			'    ',
			'    ',
			'    ',
			'1111'
		]
		@chars['+'] = [
			'     ',
			'  1  ',
			'  1  ',
			'11111',
			'  1  ',
			'  1  ',
			'     '
		]
		@chars['*'] = [
			'     ',
			'  1  ',
			'1 1 1',
			' 111 ',
			'1 1 1',
			'  1  ',
			'     '	
		]
		@chars['='] = [
			'   ',
			'   ',
			'111',
			'   ',
			'111',
			'   ',
			'   '
		]
		@chars['/'] = [
			'   ',
			'  1',
			'  1',
			' 1 ',
			'1  ',
			'1  ',
			'   '
		]
		@chars['\\'] = [
			'   ',
			'1  ',
			'1  ',
			' 1 ',
			'  1',
			'  1',
			'   '
		]
		@chars['('] = [
			'  ',
			' 1',
			'1 ',
			'1 ',
			'1 ',
			' 1',
			'  '
		]
		@chars[')'] = [
			'  ',
			'1 ',
			' 1',
			' 1',
			' 1',
			'1 ',
			'  '
		]
		@chars['['] = [
			'  ',
			'11',
			'1 ',
			'1 ',
			'1 ',
			'11',
			'  '
		]
		@chars[']'] = [
			'  ',
			'11',
			' 1',
			' 1',
			' 1',
			'11',
			'  '
		]
		@chars['{'] = [
			'   ',
			' 11',
			' 1 ',
			'1  ',
			' 1 ',
			' 11',
			'   '
		]
		@chars['}'] = [
			'   ',
			'11 ',
			' 1 ',
			'  1',
			' 1 ',
			'11 ',
			'   '
		]
		@chars['<'] = [
			'   ',
			'  1',
			' 1 ',
			'1  ',
			' 1 ',
			'  1',
			'   '
		]
		@chars['>'] = [
			'   ',
			'1  ',
			' 1 ',
			'  1',
			' 1 ',
			'1  ',
			'   '
		]
		@chars['|'] = [
			'1',
			'1',
			'1',
			'1',
			'1',
			'1',
			'1'
		]
		@chars['-'] = [
			'   ',
			'   ',
			'   ',
			'111',
			'   ',
			'   ',
			'   '
		]
		
		############################################################################
		
		# Non-default Silkscreen characters.
		@chars['–'] = [
			'     ',
			'     ',
			'     ',
			'11111',
			'     ',
			'     ',
			'     '
		]
		@chars['—'] = [
			'       ',
			'       ',
			'       ',
			'1111111',
			'       ',
			'       ',
			'       '
		]
		@chars['¡'] = [
			' ',
			'1',
			' ',
			'1',
			'1',
			'1',
			' '
		]
		@chars['¿'] = [
			'    ',
			'  1 ',
			'    ',
			' 11 ',
			'1   ',
			' 111',
			'    '
		]
		@chars['£'] = [
			'    ',
			'  11',
			' 1  ',
			'1111',
			' 1  ',
			'1 11',
			'    '
		]
		@chars['€'] = [
			'    ',
			'  11',
			' 1  ',
			'111 ',
			' 1  ',
			'  11',
			'    '
		]
		@chars['¥'] = [
			'1   1',
			' 1 1 ',
			'  1  ',
			'11111',
			'  1  ',
			'11111',
			'  1  '
		]
		@chars['ç'] = [
			'    ',
			' 11 ',
			'1  1',
			'1   ',
			'1  1',
			' 11 ',
			'11  '
		]
		@chars['¬'] = [
			'    ',
			'    ',
			'1111',
			'   1',
			'   1',
			'    ',
			'    '
		]
		@chars['†'] = [
			' 1 ',
			'111',
			' 1 ',
			' 1 ',
			' 1 ',
			'   ',
			'   '
		]
		@chars['π'] = [
			'     ',
			'11111',
			' 1 1 ',
			' 1 1 ',
			' 1 1 ',
			' 1 11',
			'     '	
		]
		@chars['¶'] = [
			' 1111',
			'111 1',
			' 11 1',
			'  1 1',
			'  1 1',
			'  1 1',
			'  1 1'	
		]
		@chars['☺'] = [
			'    ',
			'    ',
			'1  1',
			'    ',
			'1  1',
			' 11 ',
			'    '
		]
		@chars['☹'] = [
			'    ',
			'    ',
			'1  1',
			'    ',
			' 11 ',
			'1  1',
			'    '
		]
		@chars['☻'] = [
			'      ',
			' 1111 ',
			'1 11 1',
			'111111',
			'1 11 1',
			'11  11',
			' 1111 '
		]
		
	end
	
	################################################################################
	
	# Return nil if not in the @chars array.
	def map_char_to_array(input_char)
		input_char.downcase!
		
		# Need to handle diacritics better. This will do for now.
		input_char = 'a' if ['â','á','à','ä','å','ă'].include?(input_char)
		input_char = 'e' if ['ê','é','è','ë'].include?(input_char)
		input_char = 'i' if ['î','í','ì','ï'].include?(input_char)
		input_char = 'o' if ['ô','ó','ò','ö','ø'].include?(input_char)
		input_char = 'u' if ['û','ú','ù','ü','ů'].include?(input_char)
		input_char = 'y' if ['ÿ','ý'].include?(input_char)
		input_char = 'c' if ['č','ć'].include?(input_char)
		input_char = 'd' if ['đ'].include?(input_char)
		input_char = 'n' if ['ñ'].include?(input_char)
		input_char = 't' if ['ț'].include?(input_char)
		input_char = 's' if ['š','ș'].include?(input_char)
		input_char = 'z' if ['ž'].include?(input_char)
		
		# What to do about these multi-character ligatures?
		# æ Æ œ Œ ß
		
		begin
			output = @chars[input_char]
			
			# Written in code with spaces for readability, but now need to be zeros.
			output.map!{ |i| i.gsub(' ','0') }
		
		# Return nil if not in the @chars array.
		rescue
			output = nil
		end
	end
	
	##############################################################################
	
	# Add an array to the end of another.
	# Use this to add a Silkscreen char array to another.
	def add_to_char_line(original_array, char_array_to_add)
		output_array = []
		if original_array == [] or original_array == nil
			output_array = char_array_to_add
		else
			0.upto(6) do |line|
				output_array[line] = 
					original_array[line] + ('0'*@tracking) + char_array_to_add[line]
			end
		end
		output_array
	end
	
	##############################################################################
	
	# Convert a string into an array of strings of 0s and 1s using the font.
	def line(input_text=@text)
		output_font_array = []
		input_text.each_char do |c|
			
			# Pixel map of the char, or nil if the char is not in Silkscreen.
			char_array = map_char_to_array(c)
			if char_array
				output_font_array = add_to_char_line(output_font_array, char_array)
			end
			
		end
		@pixel_map = output_font_array
	end
	
	##############################################################################
	
	# Get the width of a line in Silkscreen pixels, including kerning.
	def length(input_text=@text)
		line(input_text).first.length
	end
	
	##############################################################################
	
	# Convert a string into a Silkscreen font array.
	# Respects newline chars and centres each line.
	def to_pixels(input_text=@text, leading=@leading)
		
		# Split by \n to get each line.
		input_lines = input_text.split("\n")
		
		# Append to a big array.
		lines = []
		input_lines.each_with_index do |i, index|
			lines += line(i)
			if index != input_lines.size - 1
				leading.times do
					lines += ['0']
				end
			end
		end
		
		# Search for the longest pixel length.
		max_len = lines.max{|a,b|a.length<=>b.length}.length
		
		# For the lines that are not max_len long, centre with spaces.
		output = []
		lines.each do |i|
			if i.length == max_len
				output << i
			else
				output << i.center(max_len,'0')
			end
		end
		
		@pixel_map = output
	end
	
	##############################################################################
	
	# Add newlines where the length is greater than a set len.
	#   text   = "This is just a stupid test sentence!"
	#   lines  = to_paragraph(text,80)
	# > lines == "This is just a\nstupid test\nsentence!"
	def to_paragraph(len=0, input_text=@text)
		
		# Split the input text by spaces.
		text_split = input_text.split(' ')
		
		# Build up a line until it is over the length limit.
		lines = []
		buffer = ''
		text_split.each do |i|
			new_buffer = (buffer + ' ' + i).strip
			
			# If we are over the length, write the previous buffer to the lines.
			if length(new_buffer) > len
				lines << buffer if not buffer.empty?
				buffer = i
			else
				buffer = new_buffer
			end
		end
		
		# If we've anything left over, add that too.
		lines << buffer if buffer
		
		@text = lines.join("\n")
	end
	
	##############################################################################
	
	# Draw a rounded rectangle around the Silkscreen array.
	# Separate padding arguments for all four sides.class << self
	def private_border(input_arr=@pixel_map, pad_n=3, pad_e=3, pad_s=3, pad_w=3)
		output = input_arr
		
		# Add padding '0's to start and end of each line.
		output = output.map { |i| ('0'*pad_w) + i + ('0'*pad_e) }
		
		# Add padding '0' rows to start and end of array.
		elem = '0' * output[0].length
		pad_n.times { output = output.unshift elem }
		pad_s.times { output = output.push    elem }
		
		# Draw solid line left and right border lines.
		output = output.map { |i| '1' + i + '1' }
		
		# Edit existing array to draw four inner corner pixels.
		output[ 0][ 0.. 1] = '01'
		output[-1][ 0.. 1] = '01'
		output[ 0][-2..-1] = '10'
		output[-1][-2..-1] = '10'
		
		# Draw solid line top and bottom border lines.
		elem = '00' + ('1' * (output[0].length-4) ) + '00'
		output = output.unshift elem
		output = output.push    elem
		
		@pixel_map = output
	end
	private :private_border
	
  ######################################
	
	# Public overloader method to handle args to the real, private method.
	def border(*args)
		
		# Default if no args specified.
		if args.size == 0
			private_border
			
		# String array must always be first argument.
		elsif args[0].is_a? Array
			
			case args.size
				when 1  # Just the string.
					private_border(args[0])
					
				when 2  # String, and same padding for all sides.
					private_border(args[0],args[1],args[1],args[1],args[1])
					
				when 3  # String, and separate padding for vertical and horizontal.
					private_border(args[0],args[1],args[2],args[1],args[2])
					
				when 4  # This makes no sense.
					raise "PixelFont#border has incorrect arguments"
					
				else    # This might make no sense, but let the method handle it.
					private_border(*args)
			end
		
		# Since text must always be first argument, this must all be Ints.
		elsif args[0].is_a? Integer
		
			case args.size
				when 1  # Same padding for all sides.
					private_border(@pixel_map,args[0],args[0],args[0],args[0])
					
				when 2  # Separate padding for vertical and horizontal.
					private_border(@pixel_map,args[0],args[1],args[0],args[1])
					
				when 3  # This makes no sense.
					raise "PixelFont#border has incorrect arguments"
					
				else    # This might make no sense, but let the method handle it.
					private_border(@pixel_map,*args)
			end
		end
	end
	
	##############################################################################
	
end

################################################################################
