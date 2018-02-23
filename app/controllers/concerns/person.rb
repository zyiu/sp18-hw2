class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def nickname
    # YOUR IMPLEMENTATION HERE
    @nickname
  end

  def birth_year
    # YOUR IMPLEMENTATION HERE
    Time.now.year- @age.to_i
  end

  def introduction
    # YOUR IMPLEMENTATION HERE
    "Hi I'm " + @name + ", and I'm " + @age + " years old."
  end

end
