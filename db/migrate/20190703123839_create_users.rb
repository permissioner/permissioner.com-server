class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :email_normalized
      t.string :username
      t.string :username_normalized
      t.references :apps, foreign_key: true

      t.timestamps
    end
  end
end
