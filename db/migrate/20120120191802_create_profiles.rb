class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :url
      t.text :bio
      t.string :email
      t.string :username
      t.integer :user_id

      t.timestamps
    end
  end
end
