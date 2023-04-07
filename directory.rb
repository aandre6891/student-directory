@students = [] # array accessible in all methods
filename = "students.csv"
require 'csv'

# try to load students.csv when running or save an empty file if it doesn't exist
def try_load_students(filename)
  if File.exist?(filename) # if it exists
    load_students
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    save_students
    puts "#{filename} didn't exist, we have created it"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

# Capitalize every word of a string
def titleize(string)
  string.split(" ").map {|word| word.capitalize}.join(" ")
end

def input_students
  puts "Please enter the name of the student"
  puts "To finish, just hit return twice"
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
    @students << {name: name, age: age, country: country, cohort: @cohort.to_sym}
    if @students.count == 1
      puts "Now we have #{@students.count} student, add another one or return to end"
    else
      puts "Now we have #{@students.count} students, add another one or return to end"
    end
    # get another name, age and country
    name = titleize(gets.chomp)
  end
  # return the array of students
  @students
end

def show_students
  if @students.count != 0
    print_header
    print_student_list
    print_footer
  else 
    puts "There are no students in this school"
  end
end

def save_students
  CSV.open("/Users/andyruggieri/Projects/student-directory/students.csv", "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:age], student[:country], student[:cohort]]
    end
  end
end

def load_students
  @students = []
  CSV.foreach("/Users/andyruggieri/Projects/student-directory/students.csv") do |row|
    name = row[0]
    age = row[1]
    country = row[2]
    cohort = row[3]
    @students << {name: name, age: age, country: country, cohort: cohort}
  end
end

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

def print_header
  puts "The students of Villains Academy".center(50, "-")
  puts "-------------------------------".center(50)
end

def print_student_list
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} - Age: #{student[:age]} - Country: #{student[:country]} (#{student[:cohort].capitalize} cohort)".center(50)
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student".center(50, "-")
  else
    puts "Overall, we have #{@students.count} great students".center(50, "-")
  end
end

try_load_students(filename)
interactive_menu
