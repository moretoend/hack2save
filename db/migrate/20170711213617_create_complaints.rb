class CreateComplaints < ActiveRecord::Migration[5.1]
  def change
    create_table :complaints do |t|
      t.references :denunciable, foreign_key: { to_table: :users }
      t.integer :denunciable_type
      t.string :reason
      t.text :body

      t.timestamps
    end
  end
end
