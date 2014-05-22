class GPTP::Volunteer
  attr_reader :name, :password, :age, :id
  def initialize(id, name, password, age)
    @id = id
    @name = name
    @password = password
    @age = age
  end
end
