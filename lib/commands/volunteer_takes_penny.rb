require 'pry'
class GPTP::VolunteerTakesPenny
  def run(input)
    # Takes input of a hash including volunteer_email, penny_id
    # Returns a penny assigned to volunteer
    penny = GPTP.db.get_penny(input[:penny_id])
    volunteer = GPTP.db.get_volunteer(input[:volunteer_email])
    #game.winner
    #match.winner
    if penny.vol_id == nil
      penny = GPTP.db.update_penny(input[:penny_id], {vol_id: volunteer.id})
      return {
        :success? => true,
        volunteer: volunteer,
        penny: penny,
        message: "#{volunteer.name} successfully took the penny!"
      }
    else
      return{
        :success? => false,
        error: "Sorry, this penny has already been taken."
      }
    end
  end
end
