class AddDetailsToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :first_name, :string
    add_column :candidates, :last_name, :string
    add_column :candidates, :phone, :string
    add_column :candidates, :dob, :date
    add_column :candidates, :pan_number, :string
    add_column :candidates, :aadhaar_number, :string
    add_column :candidates, :address, :text
    add_column :candidates, :city, :string
    add_column :candidates, :state, :string
    add_column :candidates, :pincode, :string
  end
end
