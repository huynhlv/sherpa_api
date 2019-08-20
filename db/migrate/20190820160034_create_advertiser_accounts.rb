class CreateAdvertiserAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :advertiser_accounts do |t|
      t.string :email
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
