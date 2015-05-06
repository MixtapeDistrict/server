class AddPaymentEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :payment_email, :string
  end
end
