class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :requirements
      t.datetime :start_date
      t.datetime :end_date
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
