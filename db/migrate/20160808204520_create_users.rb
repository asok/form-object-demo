class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.boolean :terms_accepted
      t.date :date_of_birth

      t.timestamps
    end
  end
end
