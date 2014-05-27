require 'spec_helper.rb'

describe GPTP::OrganizationGivesPenny do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  it 'exists' do
    expect(GPTP::OrganizationGivesPenny).to be_a(Class)
  end

  it "returns a success message if given number of pennies is created" do
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    result = GPTP::OrganizationGivesPenny.new.run(penny: {name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, location: "dog park"}, number: 2)
    p result
    expect(result[:success?]).to eq(true)
    expect(result[:pennies][0]).to be_a(GPTP::Penny)
    expect(result[:message]).to eq("1 just created 2 pennies!")
  end

  it "returns an error message if the pennies are unable to be created" do
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    result = GPTP::OrganizationGivesPenny.new.run(penny: {description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, location: "dog park"}, number: 2)
    p result
    expect(result[:success?]).to eq(false)
    # expect(result[:error]).to eq("Sorry, this penny has already been taken.")
  end

end
