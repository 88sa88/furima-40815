FactoryBot.define do
  factory :purchase_shipping_address do
    post_code {'123-4567'}
    prefecture_id { 2 }
    municipality { 'test' }
    street_address { 'test' }
    telephone_number { '09011111111'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
