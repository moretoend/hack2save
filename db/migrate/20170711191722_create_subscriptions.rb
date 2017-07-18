class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :job, foreign_key: true
      t.integer :status
      t.text :cover_letter

      t.timestamps
    end
  end
end
