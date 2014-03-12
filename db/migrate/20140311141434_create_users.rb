class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :admin
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
