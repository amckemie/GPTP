class GPTP::Penny

  attr_accessor :name, :description, :time_requirement, :time, :date, :location, :status, :vol_id
  attr_reader :id, :org_id

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @description =params[:description]
    @org_id = params[:org_id]
    @time_requirement = params[:time_requirement]
    @time =params[:time]
    @date = params[:date]
    @location = params[:location]
    @status = params[:status]
    @vol_id = params[:vol_id]
  end

end
