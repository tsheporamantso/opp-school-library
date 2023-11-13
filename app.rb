require './book'
require './student'
require './teacher'
require './rental'

class App
  attr_accessor :people, :rentals, :books

  def initialize
    @people = []
    @rentals = []
    @books = []
  end

  def run
    loop do
      display_menu
      option = gets.chomp

      break if option == '7'

      process_options(option)
    end

    puts 'Thank you for using this app!'
  end

  def process_options(option)
    case option
    when '1' then book_list
    when '2' then people_list
    when '3' then person_create
    when '4' then new_book
    when '5' then new_rental
    when '6' then rental_list
    else
      puts 'This is not a valid option'
    end
  end

  def book_list
    if @books.empty?
      puts 'There is no book in the list'
    else
      @books.each_with_index do |book, index|
        puts "#{index} - Title: #{book.title.capitalize}, Author: #{book.author.capitalize}"
      end
    end
  end

  def people_list
    if people.empty?
      puts 'There is no person in the list'
    else
      @people.each_with_index do |person, index|
        if person.instance_of?(Teacher)
          puts "#{index} [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        elsif person.instance_of?(Student)
          puts "#{index} [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        end
      end
    end
  end

  def person_create
    puts 'Do you want to create a student (1) or a teacher (2)? [input the number]:'
    type = gets.chomp
    case type
    when '1'
      student_create
    when '2'
      teacher_create
    else
      puts 'Invalid selection'
    end
  end

  def teacher_create
    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Specialization:'
    specialization = gets.chomp
    parent_permission = true
    @people.push Teacher.new(age: age, name: name, specialization: specialization, parent_permission: parent_permission)
    puts 'Person created successfully'
  end

  def student_create
    puts 'Name:'
    name = gets.chomp
    puts 'Age:'
    age = gets.chomp
    puts 'Has parent permission? [y/n]:'
    permission = gets.chomp.downcase
    parent_permission = permission == 'y'
    puts 'Classroom:'
    classroom = gets.chomp
    @people.push Student.new(age: age, name: name, parent_permission: parent_permission, classroom: classroom)
    puts 'Person created successfully'
  end

  def new_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully'
  end

  def new_rental
    puts 'select a book from the following list by number:'
    book_list
    bk_index = gets.chomp.to_i
    rented_book = @books[bk_index]
    puts 'select a person from the following list by number (not id)'
    people_list
    person_index = gets.chomp.to_i
    renter = @people[person_index]
    puts 'Date (YYYY-MM-DD):'
    date = gets.chomp
    if renter.can_use_services?
      @rentals.push Rental.new(date, rented_book, renter)
      puts 'Rental created successfully'
    else
      puts 'person lacks borrow permissions'
    end
  end

  def rental_list
    puts 'ID of person:'
    renter_id = gets.chomp
    renter = @people.select { |person| person.id == renter_id.to_i }
    if renter.empty?
      puts 'No rentals found'
    else
      renter.first.rentals.map do |rental|
        puts "#{rental.date}, Book: #{rental.book.title}, by #{rental.book.author}"
      end
    end
  end

  def display_menu
    puts ''
    puts 'Please choose an option by entering a number'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    puts ''
    print 'Enter number: '
  end
end
