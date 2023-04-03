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
# now we print the names of the students
puts "The students of Villains Academy"
puts "-------------"
students.each do |student|
  puts student
end
# then we print the total
puts "Overall, we have #{students.count} great students"