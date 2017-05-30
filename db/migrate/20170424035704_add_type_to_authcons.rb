class AddTypeToAuthcons < ActiveRecord::Migration[5.0]
  def change
    add_column :authcons, :type, :string
  end
end
