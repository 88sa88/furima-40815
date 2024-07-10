# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


#テーブル設計
#users
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|email               | string          |null:false, unique: true            |
|encrypted_password  | string          |null:false,                         |
|nickname            | string          |null:false,                         |
|name                | string          |null:false,                         |
|name_kana           | string          |null:false,                         |
|birthday            | date            |null:false,                         |

#itemsテーブル
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|item_name           | text            |null:false,                         |
|explanation         | text            |null:false,                         |
|category            | string          |null:false,                         |
|situation           | string          |null:false,                         |
|postage             | string          |null:false,                         |
|region              | string          |null:false,                         |
|shipping_day        | string          |null:false,                         |
|price               | string          |null:false,                         |
|user                | reference       |null:false, foreign_key: true       |

#purchasesテーブル
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|user                | reference       |null:false, foreign_key: true       |
|item                | reference       |null:false, foreign_key: true       |
|shipping_address    | reference       |null:false, foreign_key: true       |

#shipping_addressテーブル
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|post_code           | integer         |null:false,                         |
|prefectures         | string          |null:false,                         |
|municipality        | string          |null:false,                         |
|street_address      | string          |null:false,                         |
|building            | string          |                                    |
|telephone_number    | integer         |null:false,                         |
|purchase            | reference       |null:false, foreign_key: true       |
