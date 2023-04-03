# header before list of students
def input_students
  puts "Please, enter the names of the students"
  puts "To finish, just hit return twice"
  # empty array
  students = []
  # gets the first name
  name = gets.chomp.capitalize
  students << name
  # repeat the code until the name is not empty
  while !name.empty? do
    # add the student hash to the array
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp.capitalize
    unless name == ""
      students << name
    end
  end
  # return the array of students
  students
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
  end
  
  def print(students)
    puts "Which initial do you want to check?"
    initial = gets.chomp.upcase
    students.each_with_index do |student, index|
      if student.chr[0] == initial
      puts "#{index+1}: #{student}"
      end
    end
  end
  
  def print_footer(students)
    puts "Overall, we have #{students.count} great students"
  end
  
  students = input_students
  # let's call the methods
  print_header
  print(students)
  print_footer(students)