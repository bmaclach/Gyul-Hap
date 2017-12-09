This program solves Gyul! Hap! puzzles as seen on the Korean game show The Genius.

You will need a text file containing information about the Gyul! Hap! board you want to solve. Each line of the text file should contain the colour, shape, and background colour, in that order and separated by spaces, for a picture on your board. The information for each picture on the board should be on a different line. 

You can see how your file should be formatted by looking at the "exampleInput.txt" file.

To run the program from a command prompt, navigate to your directory containing the "gyulhap.hs" file as well as your input file, and execute the following command:

cat exampleInput.txt | runhaskell gyulhap

Of course, you should replace "exampleInput.txt" with the name of your input file.

The program can also be run in GHCI. For that, the Gyul! Hap! boards must be user-defined and supplied to the findHaps function. The boards are defined as a list of tuples, where each tuple describes a picture on the board. For example, the tuple (Red, Circle, Black) describes a picture of a red circle on a black background.

## Input file short-forms

You can type up input files more quickly using short-forms! See "exampleShortInput.txt" for an example of how to format an input file with short-forms.

Here is a legend of the short-forms for each property:

### Colours

Red - R
Blue - B
Yellow - Y
Purple - P
Green - G
Orange - O

### Shapes

Circle - C
Square - Sq
Triangle - T
Sun - S
Moon - M
Star - St

### Backgrounds

Black - Bk
Grey - Gy
White - W