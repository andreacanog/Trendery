# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  name        :string           not null
#  price       :decimal(10, 2)   not null
#  stock       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    has_many :order_items, dependent: :destroy
  
    has_one_attached :photo
  
    validates :name, presence: true, uniqueness: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validate :ensure_photo
  
    private
  
    def ensure_photo
      unless self.photo.attached?
        errors.add(:photo, "must be attached")
      end
    end
end
  