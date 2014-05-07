class CreateContactos < ActiveRecord::Migration
  def change
    create_table :contactos do |t|
      t.string :name
      t.string :email
      t.text :mensaje

      t.timestamps
    end
  end
end
