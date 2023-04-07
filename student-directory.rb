@students = [] # array accessible in all methods
require 'csv'

def ask_load # ask the user to load a file
  puts "Do you want to load an existing list of students?\n1. Yes\n2. No\n9. Exit"
  process_load(gets.chomp)
end

def process_load(selection)
  case selection
    when "1"
      select_load_file
    when "2"
      interactive_menu
    when "9"
      puts "Bye bye!".center(100, "-")
      exit # this will cause the program to terminate
  end
end

def select_load_file # the user can choose the name of a file to be loaded
  puts "Please write the name of the file you want to load or press return to go to the menu"
  @filename = gets.chomp
  unless @filename.empty? # if empty goes to the menu
    if !@filename.include?(".csv") # if it doesn't have a .csv extension
      @filename = @filename + ".csv" # add the extension
    end
    try_load_students(@filename) # send the filename to the method
    interactive_menu
  else
    interactive_menu
  end
end

def select_save_file
  puts "What name would you like to save the list to?"
  @filename = gets.chomp
  if !@filename.include?(".csv")
    @filename = @filename + ".csv"
  end
  save_students(@filename)
  interactive_menu
end

# try to load students.csv when running or save an empty file if it doesn't exist
def try_load_students(filename)
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
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Export the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit" # 9 because we'll be adding more items
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
      puts "Now we have #{@students.count} student, add another one or return to end".center(100, "-")
    else
      puts "Now we have #{@students.count} students, add another one or return to end".center(100, "-")
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