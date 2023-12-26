using Luxor
using Glob

t = Turtle()

"""
Description:
------------
Function that produces a canvas and draws using a turtle.
This is just a test function

Parameters:
-----------
A Luxor.Turtle object

Returns:
--------
None
"""
function test_turtle(t::Luxor.Turtle)
    @svg begin
        Forward(t,100)
        Pencolor(t, 1, 0, 0)
        Forward(t,100)
    end
end

# API for shapes
# 1. Create a square
"""
Description:
------------
	Makes a square using the turtle from Luxor

Parameters:
-----------
	side_length
		Length of the side of the square.

"""
function make_square(t::Luxor.Turtle, side_length::Number)
    @svg begin
        for i in 1:4
            Forward(t , side_length)
            Turn(t ,90)
        end
	end
end

# 4.3 
"""
draw the koch curve
Algorithm:
- draw koch curve _||_ with length x/3
- turn 60
- draw koch
- turn 120
- draw koch
- turn 60
- draw koch
"""
function koch(t::Luxor.Turtle,length::Number)
	Forward(t, length/3)
	Turn(t,-60)
	Forward(t, length/3)
	Turn(t,120)
	Forward(t, length/3)
	Turn(t,-60)
	Forward(t, length/3)
end

function koch_fractal(t::Luxor.Turtle,depth::Int, length::Number)
	if depth == 1
		koch(t,length)
	else
		koch_fractal(t,depth-1, length/3)
		Turn(t,-60)
		koch_fractal(t,depth-1, length/3)
		Turn(t,120)
		koch_fractal(t,depth-1, length/3)
		Turn(t,-60)
		koch_fractal(t,depth-1, length/3)
	end
end


# deletes svgs
function delete_svg()
	pdf_files = glob("*.pdf")
	svg_files = glob("*.svg")
	for file in vcat(pdf_files,svg_files)
		rm(file)
	end
end

test_turtle(t)
delete_svg()
make_square(t, 100)

@pdf begin
    koch_fractal(t,6,500)
end 2_000 500

