# class GPTP::GetPennies
#   def run(data)
#     pennies = GPTP.db.list_pennies
#     if data.keys[0] == :vol_id
#       pennies.select! {|penny| penny[:vol_id] == data[:vol_id]}
#     else
#       pennies.select! {|penny| penny[:org_id] == data[:org_id]}
#     end
#     t = Time.now
#     today = "#{t.year} #{t.month} #{t.day}"
#     past_pennies = upcoming_pennies = []
#     pennies.each do |penny|
#       past_pennies << penny if penny[:date] < today
#       upcoming_pennies << penny if penny[:date] > today
#     end
#     if past_pennies.length && upcoming_pennies.length == 0
#       return {success?: false, error: "You have no pennies."}
#     elsif past_pennies.length == 0
#       past_pennies.sort_by! {|x,y| x[:date]<=>y}
#       return {success?: false, error: "You have no past pennies.", past_pennies: past_pennies}
#     elsif upcoming_pennies.length == 0
#       upcoming_pennies.sort_by! {|x,y| x[:date]<=>y}
#       return {success?: false, error: "You have no upcoming pennies.", upcoming_pennies: upcoming_pennies}
#     else
#       pennies.sort_by! {|x,y| x[:date]<=>y}
#       return {success?: true, past_pennies: past_pennies, upcoming_pennies: upcoming_pennies}
#     end
#     end
#   end
# end
