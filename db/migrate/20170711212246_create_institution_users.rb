class CreateInstitutionUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_users do |t|
      t.references :user, foreign_key: true
      t.references :institution, foreign_key: true
      t.integer :permission

      t.timestamps
    end
  end
end
