require 'spec_helper.rb'

describe GPTP::SignIn do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  let(:user1) {GPTP.db.create_volunteer(name: "Susie", password: "123abc", age: 21, email: "susie@gmail.com")}
  it 'exists' do
    expect(GPTP::SignIn).to be_a(Class)
  end

  it "returns a success message if the user exists and enters the correct password" do
    user1
    result = GPTP::SignIn.new.run("susie@gmail.com", "123abc")
    expect(result[:success?]).to eq(true)
    expect(result[:volunteer]).to be_a(GPTP::Volunteer)
    expect(result[:message]).to eq("User successfully signed in.")
  end

  it "returns an error message if the user doesn't exist" do
    result = GPTP::SignIn.new.run("user@gmail.com", "1234")
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("There is no user with that email.")
  end

  it "returns an error message if the user enters the wrong password" do
    result = GPTP::SignIn.new.run("susie@gmail.com", "wrong")
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("Incorrect password.")
  end
end
