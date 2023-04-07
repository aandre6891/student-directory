# student-directory

The student-directory allows you to manage all the students of the Fantasy Academy. Please, ignore these files (they have been used for exercises):

- directory.rb
- directory_index.rb

The complete directory is in the file:

- student-directory.rb

# how to use it

Use the file "student-directory.rb". 

The program will ask you to load an existing list giving three options:

- Yes => You can write the name of a .csv file in the same folder of the program to load it.
- No => You go to the menu.
- Exit => You can exit the program.

# the menu

In the Menu you can choose between the following options:

- Input the students
- Show the list of students
- Export the current list to a new or existing file
- Load a list from a file
- Exit

## input the students

The program asks you to enter the name of a student. If you don't put any name you go back to the menu. If the name is valid, the program asks you to put the age of that student. If it's a valid number, the program asks you to insert the country of that student. If it's valid, you have to write the cohort of the student. It has to be a months, but if you leave it blank the program automatically puts the student in the 2023 cohort. The program keeps on asking for new students until you press enter instead of digit a new name.

## show the list of students

The program displays the list of students loaded and/or added with index and info.

## export the current list to a new or existing file

The program asks you the name you want to save the file. If the file already exists in the folder, the program overwrites it. If it doesn't exist, the program creates a new file with the name you put. No need to add the extension since the program saves the file as a ".csv" anyway.

## load a list from a file

You can upload a .csv file from the same folder of the program. If the file doesn't exists, the program keeps on asking you for a correct name. no need to write the extension of the file.

## exit

The program exits.