class GPTP::SignIn
  def run(email, password)
    volunteer = GPTP.db.get_volunteer(email)
    if volunteer.name && volunteer.password == password
      return {
        success?: true,
        volunteer: volunteer,
        message: "User successfully signed in."
      }
    elsif volunteer.name == nil
      return {
        success?: false,
        error: "There is no user with that email."
      }
    else
      return {
        success?: false,
        error: "Incorrect password."
      }
    end
  end
end
