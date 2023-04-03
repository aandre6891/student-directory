#let's make an array of all the students
students = [
  "Dr. Hannibal Lecter", 
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
# header before list of students
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

# array iteration and print all the names
def print(names)
  names.each do |name|
    puts name
  end
end

# then we print the total
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# let's call the methods
print_header
print(students)
print_footer(students)