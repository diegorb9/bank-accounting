# frozen_string_literal: true

class CreateAccountMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :account_movements do |t|
      t.decimal :amount, null: false, scale: 2, precision: 8
      t.references :account, null: false, foreign_key: true
      t.integer :operator, null: false

      t.timestamps
    end
  end
end
