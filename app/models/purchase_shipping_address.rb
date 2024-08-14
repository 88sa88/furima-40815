class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipality, :street_address, :building, :telephone_number, :prefecture_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code,        format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id ,   numericality: {other_than: 1, message: "can't be blank"}
    validates :municipality
    validates :street_address
    validates :telephone_number, format: { with: /\A0\d{9,10}\z/, message: "is invalid. number digits"}
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, street_address: street_address, building: building, telephone_number: telephone_number, purchase_id: purchase.id)
  end
 end