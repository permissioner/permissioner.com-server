class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :language_code
      t.string :verification_token
      t.boolean :verified
      t.references :app, foreign_key: true

      t.timestamps
    end
  end
end
