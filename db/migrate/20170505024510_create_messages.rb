class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :patient_profile_id
      t.integer :staff_profile_id
      t.string :content

      t.timestamps
    end
  end
end
