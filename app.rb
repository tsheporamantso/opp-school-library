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
end
