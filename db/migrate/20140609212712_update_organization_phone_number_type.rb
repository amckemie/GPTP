class UpdateOrganizationPhoneNumberType < ActiveRecord::Migration
  def change
    change_column(:organizations, :phone_num, :string)
  end
end
