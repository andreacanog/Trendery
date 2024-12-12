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

  validates :status, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }
end

