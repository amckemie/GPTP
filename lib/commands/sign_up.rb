class GPTP::VolunteerSignUp
  def run(data)
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
