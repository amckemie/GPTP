class GPTP::VolunteerSignUp
  def run(data)
    data.each do |key, value|
      if value == ""
        return {
        success?: false,
        error: "You did not enter the correct information."
        }
      end
    end

    volunteer = GPTP.db.get_volunteer(data[:email])
    if volunteer.name
      return {
        success?: false,
        error: "A volunteer with that email already exists."
      }
    else
      volunteer = GPTP.db.create_volunteer(name: data[:name], password: data[:password], age: data[:age], email: data[:email])
      return {
        success?: true,
        user: volunteer,
        message: "Volunteer successfully signed up."
      }
    end
  end
end
