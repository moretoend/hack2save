class CreateComplaints < ActiveRecord::Migration[5.1]
  def change
    create_table :complaints do |t|
      t.references :denouncer, polymorphic: true
      t.references :denounced, polymorphic: true
      t.text :reason

      t.timestamps
    end
  end
end
