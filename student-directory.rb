@students = [] # array accessible in all methods
require 'csv'

def ask_load # ask the user to load a file
  loop do
    puts "Do you want to load an existing list of students?\n1. Yes\n2. No\n9. Exit"
    case gets.chomp
      when "1" then select_load_file(0) # in this case 0 is useless, but we need to pass it
      when "2" then interactive_menu
      when "9" then puts "Bye bye!".center(100, "-"); exit # this will cause the program to terminate
      else
      puts "I don't know what you meant, try again".center(100, "-")
    end
  end
end

def select_load_file(selection) # selection is 0, 4 or 5
  puts "Please write the name of the file you want to load or press return to go to the menu"
  @filename = gets.chomp
  return interactive_menu if @filename.empty?
  @filename += ".csv" unless @filename.end_with?(".csv") # add .csv if not given by user
  check_file_exist(@filename, selection)
  interactive_menu
end

def select_save_file
  puts "What name would you like to save the list to?"
  @filename = gets.chomp
  @filename += ".csv" if !@filename.end_with?(".csv")
  save_students(@filename)
  interactive_menu
end

def check_file_exist(filename, selection) # try to load students.csv when running or save an empty file if it doesn't exist
  if File.exist?(filename) # if it exists
    load_students(filename, selection)
    puts "Loaded #{@students.count} from #{filename}".center(100, "-")
  else # if it doesn't exist
    puts "#{filename} not found, choose another file or press return to go to the menu".center(100, "-")
    select_load_file(selection) # selection is 0, 4 or 5
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
  puts "1. Input the students\n2. Show the students\n3. Export the list to a file\n4. Load a list from a file\n5. Add more students from a file\n9. Exit"
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
    select_load_file(4) # 4 is useless, 5 is important
  when "5"
    select_load_file(5) # we need to pass 5 to not overwrite the array @students
  when "9"
    puts "Bye bye!".center(100, "-")
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again".center(100, "-")
  end
end

def titleize(string) # Capitalize every word of a string
  string.split(" ").map {|word| word.capitalize}.join(" ")
end

def input_students
  puts "Please enter the name of the student"
  puts "To finish, just hit return"
  loop do  # get the first name, age and country
    check_name
    check_age
    check_country
    check_cohort
    @students << {name: @name, age: @age, country: @country, cohort: @cohort.to_sym}
    puts "Now we have #{@students.count} student#{'s' if @students.count != 1}, add another one or return to end".center(100, "-")
  end
  @students
end

def check_name
  loop do
    @name = titleize(gets.chomp)
    if @name.match(/^[[:alpha:][:blank:]]+$/)
      break
    elsif @name.empty?
      interactive_menu
    else
      puts "Please, enter a valid name".center(100, "-")
    end
  end
end

def check_age
  puts "Please enter the age of this student"
  loop do
    @age = gets.chomp
    if @age.match(/\D/) || @age.empty?
      puts "Please, enter a valid number".center(100, "-")
    else
      break
    end
  end
end

def check_country
  puts "Please enter the country of this student"
  loop do
    @country = titleize(gets.chomp)
    if @country.match(/^[[:alpha:][:blank:]]+$/)
      break
    else
      puts "Please, enter a valid country".center(100, "-")
    end
  end
end

def show_students
  if @students.empty?
    puts "There are no students in this school".center(100, "-")
  else
    print_header; print_student_list; print_footer
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

def load_students(filename, selection) # selection is 0, 4 or 5
  @students = [] if selection != 5 # if selection is 5 we don't overwrite the array @students
  CSV.foreach("/Users/andyruggieri/Projects/student-directory/#{filename}") do |row|
    name = row[0]
    age = row[1]
    country = row[2]
    cohort = row[3]
    @students << {name: name, age: age, country: country, cohort: cohort}
  end
end

def check_cohort # type court and check typos
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
  loop do
    puts "Please, enter the cohort of this student (eg. january, february, march, etc)"
    @cohort = gets.chomp.downcase
    break if @cohort.empty? || months.include?(@cohort)
    puts "Invalid month, try again (eg. january, february, march, etc)".center(100, "-")
  end
  @cohort = "2023" if @cohort.empty?
end

def print_header
  puts "The students of Fantasy Academy".center(100, "-")
  puts "-------------------------------".center(100)
end

def print_student_list
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} - Age: #{student[:age]} - Country: #{student[:country]} (#{student[:cohort].capitalize} cohort)".center(100)
  end
end

def print_footer
  puts "-------------------------------".center(100)
  puts "Overall, we have #{@students.count} great student#{'s' if @students.count != 1}".center(100, "-")
end

ask_load
