class GPTP::OrganizationSignUp
  def run(data)
    organization = GPTP.db.get_organization(data[:email])
    if organization.name
      return {
        success?: false,
        error: "An organization with that email already exists."
      }
    else
      organization = GPTP.db.create_organization(name: data[:name], password: data[:password], age: data[:age], email: data[:email])
      return {
        success?: true,
        organization: organization,
        message: "Organization successfully signed up."
      }
    end
  end
end
