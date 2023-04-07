@students = [] # array accessible in all methods
require 'csv'

def ask_load # ask the user to load a file
  puts "Do you want to load an existing list of students?\n1. Yes\n2. No\n9. Exit"
  process_load(gets.chomp)
end

def process_load(selection)
  case selection
    when "1" then select_load_file
    when "2" then interactive_menu
    when "9" then puts "Bye bye!".center(100, "-"); exit # this will cause the program to terminate
  end
end

def select_load_file
  puts "Please write the name of the file you want to load or press return to go to the menu"
  @filename = gets.chomp
  return interactive_menu if @filename.empty?
  @filename += ".csv" unless @filename.end_with?(".csv")
  try_load_students(@filename)
  interactive_menu
end

def select_save_file
  puts "What name would you like to save the list to?"
  @filename = gets.chomp
  @filename += ".csv" if !@filename.end_with?(".csv")
  save_students(@filename)
  interactive_menu
end

def try_load_students(filename) # try to load students.csv when running or save an empty file if it doesn't exist
  if File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}".center(100, "-")
  else # if it doesn't exist
    puts "#{filename} not found, choose another file or press return to go to the menu".center(100, "-")
    select_load_file
  end
end

def interactive_menu
  loop do
    puts "* * * * Menu * * * *"
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students\n2. Show the students\n3. Export the list to a file\n4. Load a list from a file\n9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    select_save_file
  when "4"
    select_load_file
  when "9"
    puts "Bye bye!".center(100, "-")
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def titleize(string) # Capitalize every word of a string
  string.split(" ").map {|word| word.capitalize}.join(" ")
end

def input_students
  puts "Please enter the name of the student"
  puts "To finish, just hit return twice"
  # get the first name, age and country
  loop do
    name = titleize(gets.chomp)
    break if name.empty?
    puts "Please enter the age of this student"
    age = gets.chomp.to_i
    puts "Please enter the country of this student"
    country = titleize(gets.chomp)
    check_cohort
    @students << {name: name, age: age, country: country, cohort: @cohort.to_sym}
    puts "Now we have #{@students.count} student#{'s' if @students.count != 1}, add another one or return to end".center(100, "-")
  end
  @students
end

def show_students
  if @students.empty?
    puts "There are no students in this school"
  else
    print_header
    print_student_list
    print_footer
  end
end

def save_students(filename)
  CSV.open("/Users/andyruggieri/Projects/student-directory/#{filename}", "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:age], student[:country], student[:cohort]]
    end
  puts "List saved in #{filename}".center(100, "-")
  end
end

def load_students(filename)
  @students = []
  CSV.foreach("/Users/andyruggieri/Projects/student-directory/#{filename}") do |row|
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
  puts "The students of Villains Academy".center(100, "-")
  puts "-------------------------------".center(100)
end

def print_student_list
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} - Age: #{student[:age]} - Country: #{student[:country]} (#{student[:cohort].capitalize} cohort)".center(100)
  end
end

def print_footer
  if @students.count == 1
    puts "-------------------------------".center(100)
    puts "Overall, we have #{@students.count} great student".center(100, "-")
  else
    puts "-------------------------------".center(100)
    puts "Overall, we have #{@students.count} great students".center(100, "-")
  end
end

ask_load
