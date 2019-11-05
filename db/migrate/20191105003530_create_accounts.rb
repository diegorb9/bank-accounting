# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :customer, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
