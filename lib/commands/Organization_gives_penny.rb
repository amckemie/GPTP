require 'pry'
class GPTP::OrganizationGivesPenny
  def run(input)
    # Takes input of a hash including hash to create penny and the number of times to create the penny
    # Returns array with given number of the same pennies
    input[:penny].each do |key, value|
      if value == ""
        return {
        success?: false,
        message: "Please make sure you have provided all the necessary information to give a penny."
        }
      end
    end

    penny_array = []
    number = input[:number].to_i
    input[:penny]
    number.times do |x|
      penny_array<<GPTP.db.create_penny(input[:penny])
      # binding.pry
    end
    if penny_array.length == input[:number]
      return {
        :success? => true,
        pennies: penny_array,
        message: "#{penny_array[0].org_id} just created #{input[:number]} pennies!"
      }
    end
  end
end
