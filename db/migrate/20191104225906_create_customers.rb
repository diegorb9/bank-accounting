# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :document, unique: true, null: false
      t.string :access_token, unique: true, null: false

      t.timestamps
    end
  end
end
