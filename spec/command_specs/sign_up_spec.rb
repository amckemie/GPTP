require 'spec_helper.rb'

describe GPTP::SignIn do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  it 'exists' do
    expect(GPTP::SignUp).to be_a(Class)
  end

  it "returns a success message if the user is able to successfully sign up by entering a unique email" do
    result = GPTP::SignUp.new.run(name: "Ashley", password: "ghfj", age: 25, email: "ashley@gmail.com")
    expect(result[:success?]).to eq(true)
    expect(result[:volunteer]).to be_a(GPTP::Volunteer)
    volunteer = GPTP.get_volunteer(result[:volunteer].email)
    expect(volunteer.name).to eq("Ashley")
    expect(result[:message]).to eq("User successfully signed up.")
  end

  xit "returns an error message if the user doesn't exist" do
    result = GPTP::SignIn.new.run("user@gmail.com", "1234")
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("There is no user with that email.")
  end

  xit "returns an error message if the user enters the wrong password" do
    result = GPTP::SignIn.new.run("susie@gmail.com", "wrong")
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("Incorrect password.")
  end
end
