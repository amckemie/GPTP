class GPTP::SignIn
  # volunteer is a boolean variable that states whether the user is a volunteer (true) or an organization (false)
  def run(email, password, volunteer)
    if volunteer
      user = GPTP.db.get_volunteer(email)
    else
      user = GPTP.db.get_organization(email)
    end
    if user.name && user.password == password
      return {
        success?: true,
        user: user,
        message: "User successfully signed in."
      }
    elsif user.name == nil
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
