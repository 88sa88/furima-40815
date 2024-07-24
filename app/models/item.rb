class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :situation
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :Shipping_day

  has_one_attached :image

  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :situation_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_name, presence: true
  validates :explanation, presence: true
  validates :image, presence: true
  validates :price, presence: true , format: { with: /\A\d+\z/}, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  #学習メモ実装して確認する※バリテーションで空だとエラーとしているが上記で1を選ぶとメッセージが出るようにしている。上記がエラーになる
  
end
