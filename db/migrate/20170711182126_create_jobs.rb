class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :requirements, default: false
      t.text :requirements_description
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
