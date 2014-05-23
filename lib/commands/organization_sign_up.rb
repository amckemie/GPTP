class GPTP::OrganizationSignUp
  def run(data)
    organization = GPTP.db.get_organization(data[:email])
    if organization.name
      return {
        success?: false,
        error: "An organization with that email already exists."
      }
    else
      organization = GPTP.db.create_organization(name: data[:name], password: data[:password], description: data[:description], phone_num: data[:phone_num], address: data[:address], email: data[:email])
      return {
        success?: true,
        user: organization,
        message: "Organization successfully signed up."
      }
    end
  end
end
