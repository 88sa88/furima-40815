class PurchaseShippingAddress
  include ActiveModel::Model

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code,      format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id   numericality: {other_than: 0, message: "can't be blank"}
    validates :municipality
    validates :street_address
    validates :telephone_number        format: {with:  format: { with: /\A0\d{9,10}\z/ } ,message: "is invalid. number digits"}
    validates :purchase
  end
end