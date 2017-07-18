class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.references :user, foreign_key: true
      t.references :institution, foreign_key: true
      t.integer :profile

      t.timestamps
    end
  end
end
