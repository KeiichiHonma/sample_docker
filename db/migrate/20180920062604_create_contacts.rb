class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :company_name
      t.string :email
      t.string :telephone
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
