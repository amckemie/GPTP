require 'spec_helper.rb'

describe GPTP::VolunteerTakesPenny do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  let(:user1) {GPTP.db.create_volunteer(name: "Susie", password: "123abc", age: 21, email: "susie@gmail.com")}
  it 'exists' do
    expect(GPTP::VolunteerTakesPenny).to be_a(Class)
  end

  it "returns a success message if the user exists and enters the correct password" do
    user1
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    penny = GPTP.db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, location: "dog park")
    result = GPTP::VolunteerTakesPenny.new.run(volunteer_email: user1.email, penny_id: penny.id)
    p result
    expect(result[:success?]).to eq(true)
    expect(result[:volunteer]).to be_a(GPTP::Volunteer)
    expect(result[:message]).to eq("Susie successfully took the penny!")
  end

  it "returns an error message if the penny is taken" do
    user1
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    penny = GPTP.db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, vol_id: 1, location: "dog park")
    result = GPTP::VolunteerTakesPenny.new.run(volunteer_email: user1.email, penny_id: penny.id)
    expect(result[:success?]).to eq(false)
    expect(result[:error]).to eq("Sorry, this penny has already been taken.")
  end

end
