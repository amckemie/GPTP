class GPTP::Volunteer
  attr_reader :name, :password, :age, :id, :email
  def initialize(id, name, password, age, email)
    @id = id
    @name = name
    @password = password
    @age = age
    @email = email
  end
end
