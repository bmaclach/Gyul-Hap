This program solves Gyul! Hap! puzzles as seen on the Korean game show The Genius.

A Gyul! Hap! puzzle consists of a grid of pictures, where each picture is defined by a colour, shape, and background colour. A "Hap" is a set of 3 pictures where each property (colour, shape, background colour) is either all the same or all different between the three pictures. For example, a red circle on a white background, a blue circle on a white background, and a yellow circle on a white background form a "Hap" because the colours are all different, and the shapes and backgrounds are all the same. This program identifies all of the Haps on a grid, given descriptions of the pictures on the grid.

You will need a text file containing information about the Gyul! Hap! board you want to solve. Each line of the text file should contain the colour, shape, and background colour, in that order and separated by spaces, for a picture on your board. The information for each picture on the board should be on a different line. 

You can see how your file should be formatted by looking at the "exampleInput.txt" file.

To run the program from a command prompt, navigate to your directory containing the "GyulHap.hs" file, "solve.sh" file, and your input file, and execute the following command:

`./solve.sh exampleInput.txt`

Of course, you should replace "exampleInput.txt" with the name of your input file.

## Input file short-forms

You can type up input files more quickly using short-forms! See "exampleShortInput.txt" for an example of how to format an input file with short-forms.

Here is a legend of the short-forms for each property:

### Colours

- Red - R
- Blue - B
- Yellow - Y
- Purple - P
- Green - G
- Orange - O

### Shapes

- Circle - C
- Square - Sq
- Triangle - T
- Sun - S
- Moon - M
- Star - St

### Backgrounds

- Black - Bk
- Grey - Gy
- White - W