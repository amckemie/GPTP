require 'spec_helper.rb'

describe GPTP::SignIn do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  let(:user1) {GPTP.db.create_volunteer(name: "Susie", password: "123abc", age: 21, email: "susie@gmail.com")}
  let(:organization1) {GPTP.db.create_organization(name: "Doing Good", password: "dgdg", description: "doing good stuff", phone_num: "512-123-4567", address: "123 road drive", email: "org@gmail.com")}
  it 'exists' do
    expect(GPTP::SignIn).to be_a(Class)
  end

  it "returns a success message if the user (vol and org) exists and enters the correct password" do
    user1
    organization1
    result = GPTP::SignIn.new.run("susie@gmail.com", "123abc", true)
    expect(result[:success?]).to eq(true)
    expect(result[:user]).to be_a(GPTP::Volunteer)
    expect(result[:message]).to eq("User successfully signed in.")
    result2 = GPTP::SignIn.new.run("org@gmail.com", "dgdg", false)
    expect(result2[:success?]).to eq(true)
    expect(result2[:user]).to be_a(GPTP::Organization)
    expect(result2[:message]).to eq("User successfully signed in.")
  end

  it "returns an error message if the user (vol or org) doesn't exist" do
    result = GPTP::SignIn.new.run("user@gmail.com", "1234", true)
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("There is no user with that email.")
    result2 = GPTP::SignIn.new.run("org2@gmail.com", "1234", false)
    expect(result2[:success?]).to eq(false)
    expect(result2[:error]).to eq("There is no user with that email.")
  end

  it "returns an error message if the user (vol or org) enters the wrong password" do
    user1
    organization1
    result = GPTP::SignIn.new.run("susie@gmail.com", "wrong", true)
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("Incorrect password.")
    result2 = GPTP::SignIn.new.run("org@gmail.com", "wrongpw", false)
    expect(result2[:success?]).to eq(false)
    expect(result2[:error]).to eq("Incorrect password.")
  end
end
