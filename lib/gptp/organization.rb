class GPTP::Organization
  attr_reader :id, :name, :password, :description, :phone_num, :address, :email
  def initialize(id, name, password, description, phone_num, address, email)
    @id = id
    @name = name
    @password = password
    @description = description
    @phone_num = phone_num
    @address = address
    @email = email
  end
end
