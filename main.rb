require './app'

def main
  app = App.new

  def options(option, app)
    case option
    when '1' then app.book.list
    when '2' then app.people.list
    when '3' then app.person_create
    when '4' then app.new_book
    when '5' then app.new_rental
    when '6' then app.rental_list
    else
      pust 'This is not a valid option'
    end
  end
end
