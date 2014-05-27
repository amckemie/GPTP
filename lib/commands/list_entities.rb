class GPTP::ListEntities
  def run(data)
    if data[:type] == "organization"
      result = GPTP.db.list_organizations
    elsif data[:type] == "volunteer"
      result = GPTP.db.list_volunteers
    else
      result = GPTP.db.list_pennies
    end

    if result.length == 0
      return {
        success?: false
      }
    else
      return {
        success?: true,
        result: result
      }
    end
  end
end
