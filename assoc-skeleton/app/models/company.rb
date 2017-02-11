# == Schema Information
#
# Table name: companies
#
#  id            :integer          not null, primary key
#  name          :string
#  website       :string
#  market_cap    :float
#  ticker_symbol :string
#  created_at    :datetime
#  updated_at    :datetime
#  exchange_id   :integer
#

class Company < ActiveRecord::Base

  has_many :boards,
    primary_key: :id,
    foreign_key: :company_id,
    class_name: :Board

  belongs_to :exchange,
    primary_key: :id,
    foreign_key: :exchange_id,
    class_name: :Exchange
end
