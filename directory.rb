# type court and check typos
def check_cohort
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
  # get the cohort
  puts "Please, enter the cohort of this student (eg. January)"
  @cohort = gets.chomp.downcase
  if @cohort.empty? 
    @cohort = "2023"
  elsif !@cohort.empty? && !months.include?(@cohort)
    loop do
      puts "Wrong month, write it better"
      @cohort = gets.chomp.downcase
      if months.include?(@cohort)
        break
      end
    end
  end
end

# Capitalize every word of a string
def titleize(string)
  string.split(" ").map {|word| word.capitalize}.join(" ")
end

def input_students
  puts "Please enter the name of the student"
  puts "To finish, just hit return twice"
  # empty array
  students = []
  # get the first name, age and country
  name = titleize(gets.chomp)
  while !name.empty? do
    # while the name is not empty, repeat this code
    puts "Please enter the age of this student"
    age = gets.chomp.to_i
    puts "Please enter the country of this student"
    country = titleize(gets.chomp)
    check_cohort
    # add the student hash to the array
    students << {name: name, age: age, country: country, cohort: @cohort.to_sym}
    if students.count == 1
      puts "Now we have #{students.count} student, add another one or return to end"
    else
      puts "Now we have #{students.count} students, add another one or return to end"
    end
    # get another name, age and country
    name = titleize(gets.chomp)
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(50, "-")
  puts "-------------------------------".center(50)
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} - Age: #{student[:age]} - Country: #{student[:country]} (#{student[:cohort].capitalize} cohort)".center(50)
  end
end

def print_footer(students)
  if students.count == 1
    puts "Overall, we have #{students.count} great student".center(50, "-")
  else
    puts "Overall, we have #{students.count} great students".center(50, "-")
  end
end

students = input_students
print_header
print(students)
print_footer(students)
