class CreateAdminSpecialists < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_specialists do |t|
      t.integer :staff_profile_id
      t.string :title
      t.text :description
      t.text :detail
      t.string :image

      t.timestamps
    end
  end
end
