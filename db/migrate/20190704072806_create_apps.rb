class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :access_list_type
      t.string :app_key
      t.string :contact_email
      t.string :icon
      t.string :name
      t.string :privacy_policy
      t.string :status
      t.text :user_access_list
      t.string :website
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
