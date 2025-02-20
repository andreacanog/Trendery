# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  status     :string           default("pending"), not null
#  total      :decimal(10, 2)   default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # to ensure that an order cannot be created or saved in the database unless it has at least one associated OrderItem
  validates :order_items, presence: true

  validates :status, presence: true, inclusion: { in: %w[pending completed canceled] }
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total
    order_items.sum { |item| item.price * item.quantity }
  end

end
