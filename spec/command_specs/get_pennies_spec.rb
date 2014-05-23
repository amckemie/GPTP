require 'spec_helper.rb'
require 'time'

describe GPTP::GetPennies do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
    @t = Time.now
    @cd = GPTP::GetPennies.new
  end

  let(:today) {"#{@t.year} #{@t.month} #{@t.day}"}
  let(:org1) {GPTP.db.create_organization(name: "Doing Good", password: "dgdg", description: "doing good stuff", phone_num: "512-123-4567", address: "123 road drive", email: "org@gmail.com")}
  let(:user1) {GPTP.db.create_volunteer(name: "Susie", password: "123abc", age: 21, email: "susie@gmail.com")}
  let(:penny1) {GPTP.db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, location: "dog park")}
  let(:penny2) {GPTP.db.create_penny(name: "test2", description: "do stuff", org_id: 1, time_requirement: 4, time: 'noon', date: "2014 2 6", status: 0, location: "dog park")}
  let(:takepenny1) {GPTP::VolunteerTakesPenny.new.run(volunteer_email: user1.email, penny_id: penny1.id)}
  let(:takepenny2) {GPTP::VolunteerTakesPenny.new.run(volunteer_email: user1.email, penny_id: penny2.id)}
  let(:org_test) {@cd.run(org: org1.email)}
  let(:vol_test) {@cd.run(vol: user1.email)}

  it 'exists' do
    expect(GPTP::GetPennies).to be_a(Class)
  end

  describe '#run' do
    it 'should return an error if the user does not have any pennies' do
      org1
      expect(org_test[:error]).to eq("You have no pennies.")
      user1
      expect(vol_test[:error]).to eq("You have no pennies.")
    end

    it 'should return an error with upcoming pennies if the user does not have any past pennies' do
      org1
      user1
      penny1
      takepenny1
      expect(org_test[:error]).to eq("You have no past pennies.")
      expect(org_test[:upcoming_pennies].length).to eq(1)
      expect(vol_test[:error]).to eq("You have no past pennies.")
      expect(vol_test[:upcoming_pennies].length).to eq(1)
    end

    xit 'should return an error with past pennies if the user does not have any upcoming pennies' do
    end

    xit 'should return true with array of the users past and present pennies' do
    end
  end

end
