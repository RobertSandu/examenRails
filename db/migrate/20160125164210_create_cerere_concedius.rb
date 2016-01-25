class CreateCerereConcedius < ActiveRecord::Migration
  def change
    create_table :cerere_concedius do |t|
      t.date :data_inceput
      t.date :data_sfarsit
      t.integer :user_id
      t.integer :aprobata

      t.timestamps null: false
    end
  end
end
