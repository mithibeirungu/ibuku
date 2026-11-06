class CreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :name, default: "Registrar Officer"
      t.string :role, default: "registrar"
      t.string :otp_digest
      t.datetime :otp_sent_at

      t.timestamps
    end

    add_index :admins, :email, unique: true
  end
end

