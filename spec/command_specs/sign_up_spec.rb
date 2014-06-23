require 'spec_helper.rb'

describe GPTP::SignUp do
  let(:volunteer1) {GPTP.db.create_volunteer(name: "Susie", password: "123abc", age: 21, email: "susie@gmail.com")}

  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  it 'exists' do
    expect(GPTP::VolunteerSignUp).to be_a(Class)
  end

  it "returns an error message if a volunteer with that email already exists" do
    volunteer1
    result = GPTP::VolunteerSignUp.new.run(name: "Ashley", password: "ghfj", age: 25, email: "susie@gmail.com")
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("A volunteer with that email already exists.")
  end

  it "returns a success message if the user is able to successfully sign up by entering a unique email" do
    result = GPTP::VolunteerSignUp.new.run(name: "Ashley", password: "ghfj", age: 25, email: "ashley@gmail.com")
    expect(result[:success?]).to eq(true)
    expect(result[:volunteer]).to be_a(GPTP::Volunteer)
    volunteer = GPTP.db.get_volunteer(result[:volunteer].email)
    expect(volunteer.name).to eq("Ashley")
    expect(result[:message]).to eq("Volunteer successfully signed up.")
  end
end
