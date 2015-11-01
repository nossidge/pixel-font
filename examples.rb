#!/usr/bin/env ruby
# encoding: UTF-8

################################################################################
# Examples of Silkscreen pngs.
################################################################################

require_relative 'pixel_font.rb'
require_relative 'num_to_pic.rb'
require_relative 'valid_filename.rb'

################################################################################

# Basic function to save to a png image.
def save_to_png(pixel_map, filename)
	filename = ValidFilename::make_valid(filename)
	pic = PicFromNumbers.new(pixel_map)
	pic.image_file = 'img/' + filename
	pic.colour_invert = true
	pic.pixel_size = 2
	pic.generate_image
end

################################################################################

# We can reuse this object for multiple pictures.
font = PixelFont.new

# Basic output with no border or line breaks.
# After calling #to_pixels, font.pixel_map contains the string array of pixels.
font.text = 'Lorem ipsum dolor sit amet.'
font.to_pixels
save_to_png(font.pixel_map,'lorum_1.png')

# Handles line breaks as expected.
font.text = "Lorem\nipsum dolor sit\namet."
font.to_pixels
save_to_png(font.pixel_map,'lorum_2.png')

# Use #to_paragraph to break lines at a certain pixel length.
# Does not break lines mid-word, so beware of long words.
# Ignores existing line breaks.
font.text = "Lorem\nipsum\ndolor\nsit\namet."
font.to_paragraph(70)
font.to_pixels
save_to_png(font.pixel_map,'lorum_3.png')

# Borders can be added and added and added.
# But you need to have already called #to_pixels.
font.border           # Default padding is 2 pixels on all sides.
font.border(3)        # Pad all sides by 3 pixels.
font.border(10,20)    # Pad top and bottom by 10, and sides by 20.
font.border(2,4,6,8)  # Different padding for each side. Order is N,E,S,W.
font.border(0)        # No padding, just draw the border.
save_to_png(font.pixel_map,'lorum_4.png')

# Diacritics default to their base Latin character.
font.text = "Lørêm ìpšum đólòr șïț åmëț"
font.to_paragraph(80)
font.to_pixels
save_to_png(font.pixel_map,'lorum_5.png')

# Handle some really long text.
font.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
font.to_paragraph(170)
font.to_pixels
font.border(3,6)
font.border(1)
save_to_png(font.pixel_map,'lorum_6.png')

################################################################################
