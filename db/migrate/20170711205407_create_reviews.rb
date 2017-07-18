class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :origin, polymorphic: true
      t.references :receiver, polymorphic: true
      t.integer :grade
      t.text :notes

      t.timestamps
    end
  end
end
