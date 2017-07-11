class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :reviewable, foreign_key: { to_table: :users }
      t.integer :reviewable_type
      t.text :body

      t.timestamps
    end
  end
end
