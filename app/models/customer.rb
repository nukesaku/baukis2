class Customer < ApplicationRecord
  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  def password=(raw_passowrd)
    if raw_passowrd.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_passowrd)
    elsif raw_passowrd.nil?
      self.hashed_password = nil
    end
  end
end
