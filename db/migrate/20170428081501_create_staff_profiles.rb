class CreateStaffProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :staff_profiles do |t|
      t.integer :authcons_id
      t.string :image
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.string :birthdate
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :occupation
      t.string :detail

      t.timestamps
    end
  end
end
