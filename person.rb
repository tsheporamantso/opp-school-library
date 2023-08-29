class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name: 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  private

  def of_age?
    return true if age >= 18

    false
  end

  def can_use_services?
    return true if is_of_age? || @parent_permission

    false
  end
end