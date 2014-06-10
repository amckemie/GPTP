class GPTP::Penny

  attr_accessor :name, :description, :time_requirement, :time, :date, :location, :status, :vol_id
  attr_reader :id, :org_id

  def initialize(id, name, description, org_id, time_requirement, time, date, location, status, vol_id)
    @id = id
    @name = name
    @description = description
    @org_id = org_id
    @time_requirement = time_requirement
    @time = time
    @date = date
    @location = location
    @status = status
    @vol_id = vol_id
  end
end

