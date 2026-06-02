class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.string :website
      t.string :logo_url

      t.timestamps
    end
  end
end
