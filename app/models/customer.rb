# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :payments
  has_many :profits
  has_many :customer_products, dependent: :destroy
  has_many :products, through: :customer_products
  belongs_to :user
  has_many :children, class_name: 'Customer', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Customer', optional: true

  has_closure_tree

  MEMBERSHIP_TARGET = 5000

  def handle_payment(params)
    product = Product.find(params[:product_id])
    to_spend = product.price.to_f * params[:qty].to_f
    new_payment = payments.new(name: "Payment of #{name}", expenditure: to_spend,
                               product_id: params[:product_id], retailer_id: params[:retailer_id])
    new_payment.save && (
      update(expenditure: expenditure.to_f + new_payment.expenditure.to_f)
      !is_agent && expenditure_this_month(params[:id] || id) >= MEMBERSHIP_TARGET &&
        update(
          is_agent: true,
          membership_date: Time.zone.now.to_date,
          refer_code: refer_code_gen(self)
        )
      new_payment.distribute_profit(self, params, product)
    )
  end

  def expenditure_this_month(customer_id)
    Payment.where('customer_id = ? and created_at between ? and ?', customer_id, Time.zone.now - 1.month, Time.zone.now)
           .sum(:expenditure)
  end

  def refer_code_gen(customer)
    "#{customer.name.split(' ').first.downcase}_#{customer.id + 100}"
  end
end
