# frozen_string_literal: true

customer1 = Customer.create!(name: 'Luke Skywalker', document: '001')
customer1.account.account_movements.create(operator: 'addition', amount: 100.0)

customer2 = Customer.create!(name: 'Anakin Skywalker', document: '002')
customer2.account.account_movements.create(operator: 'addition', amount: 1000.0)

customer3 = Customer.create!(name: 'Uncle Scrooge McDuck', document: '003')
customer3.account.account_movements.create(operator: 'addition', amount: 1_000_000.0)
