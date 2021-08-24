class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :avatar_url, :null => false
      t.string :occupation, :null => true

      t.timestamps
    end
  end
end
