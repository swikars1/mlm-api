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
  
  has_many_attached :bills
  has_one_attached :id_front
  has_one_attached :id_back

  def handle_payment(params)
    payment_name = params[:name] || 'Product Payment'
    new_payment = payments.new(name: payment_name, expenditure: params[:expenditure],
                               retailer_id: params[:retailer_id], bill_no: params[:bill_no])
    new_payment.save && (
      update(expenditure: expenditure.to_f + new_payment.expenditure.to_f, last_active_at: Time.zone.now.to_date)
      new_payment.distribute_profit(self, params)
    )
  end

  def is_active
    !last_active_at.nil?
  end

  def expenditure_this_month(customer_id)
    Payment.where('customer_id = ? and created_at between ? and ?', customer_id, Time.zone.now - 1.month, Time.zone.now)
           .sum(:expenditure)
  end
end
