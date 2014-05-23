require 'spec_helper.rb'

describe GPTP::SignIn do
  let(:organization1) {GPTP.db.create_organization(name: "Doing Good", password: "dgdg", description: "doing good stuff", phone_num: "512-123-4567", address: "123 road drive", email: "org@gmail.com")}

  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("organizations")
    GPTP.db.clear_table("organizations")
  end

  it 'exists' do
    expect(GPTP::OrganizationSignUp).to be_a(Class)
  end

  it "returns an error message if a volunteer with that email already exists" do
    organization1
    result = GPTP::OrganizationSignUp.new.run(name: "Company1", password: "pw", description: "stuff", phone_num: "111-111-1111", address: "123 drive", email: "org@gmail.com")
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("An organization with that email already exists.")
  end

  it "returns a success message if the user is able to successfully sign up by entering a unique email" do
    result = GPTP::OrganizationSignUp.new.run(name: "Company1", password: "pw", description: "stuff", phone_num: "111-111-1111", address: "123 drive", email: "different@gmail.com")
    expect(result[:success?]).to eq(true)
    expect(result[:organization]).to be_a(GPTP::Organization)
    organization = GPTP.db.get_organization(result[:organization].email)
    expect(organization.name).to eq("Company1")
    expect(organization.description).to eq("stuff")
    expect(organization.phone_num).to eq("111-111-1111")
    expect(organization.address).to eq("123 drive")
    expect(organization.email).to eq("different@gmail.com")
    expect(result[:message]).to eq("Organization successfully signed up.")
  end
end
