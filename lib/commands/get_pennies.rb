require 'time'
class GPTP::GetPennies
  def run(data)
    if data.keys[0] == :vol
      vol = GPTP.db.get_volunteer(data[:vol])
      pennies = GPTP.db.vol_pennies(vol.id)
    else
      org = GPTP.db.get_organization(data[:org])
      pennies = GPTP.db.org_pennies(org.id)
    end
    return {success?: false, error: "You have no pennies."} if pennies.length == 0
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    past_pennies = []
    upcoming_pennies = []
    pennies.each do |penny|
      past_pennies << penny if penny.date < today
      upcoming_pennies << penny if penny.date >= today
    end
    if past_pennies.length == 0
      upcoming_pennies.sort_by! {|x,y| x.date<=>y}
      return {success?: true, error: "You have no past pennies.", upcoming_pennies: upcoming_pennies}
    elsif upcoming_pennies.length == 0
      past_pennies.sort_by! {|x,y| x.date<=>y}
      return {success?: true, error: "You have no upcoming pennies.", past_pennies: past_pennies}
    else
      past_pennies.sort_by! {|x,y| x.date<=>y}
      upcoming_pennies.sort_by! {|x,y| x.date<=>y}
      return {success?: true, past_pennies: past_pennies, upcoming_pennies: upcoming_pennies}
    end
  end
end
