#!/usr/bin/env ruby
# encoding: UTF-8

################################################################################
# Generate png files to test the font.
################################################################################

require_relative 'pixel_font.rb'
require_relative 'num_to_pic.rb'
require_relative 'valid_filename.rb'

################################################################################

# Create png file for each character in the font.
def save_each_character(pixel_size=2)
	font = PixelFont.new
	failed_filenames = 0
	font.chars.each do |i|
		
		# Don't need to do the space character.
		if i[0] != ' '
		
			# Make sure it's a valid filename.
			filename = "#{i[0]}.png"
			if !ValidFilename::valid?(filename)
				filename = "char_#{failed_filenames}.png"
				failed_filenames += 1
			end
			
			# Save as a png file.
			pic = PicFromNumbers.new i[1].map!{ |i| i.gsub(' ','0') }
			pic.image_file = 'img/' + filename
			pic.set_colour(255,255,255)
			pic.colour_invert = true
			pic.pixel_size = pixel_size
			pic.generate_image
		end
	end
end

########################################

# Save all characters as one big png.
def save_all_characters(pixel_size=2)
	font = PixelFont.new
	font.text = font.chars.keys.join(' ') + ' '
	font.to_paragraph(79)
	font.to_pixels
	font.border
	pic = PicFromNumbers.new(font.pixel_map)
	pic.image_file = 'img/all_chars.png'
	pic.set_colour(255,255,255)
	pic.colour_invert = true
	pic.pixel_size = pixel_size
	pic.generate_image
end

################################################################################

#	save_each_character(2)
	save_all_characters(2)

################################################################################
