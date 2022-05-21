class Phone < ApplicationRecord
  include StringNormalizer

  belongs_to :customer, optional: true
  belongs_to :address, optional: true

  before_validation do
    self.number = normalize_as_phone_number(number)
    # \D 数字以外の文字
    self.number_for_index = number.gsub(/\D/, "") if number
  end

  before_create do
    self.customer = address.customer if address
  end

  validates :number, presence: true,
            format:  { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }
end
