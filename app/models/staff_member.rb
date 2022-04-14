class StaffMember < ApplicationRecord
  def password=(raw_passowrd)
    if raw_passowrd.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_passowrd)
    elsif raw_passowrd.nil?
      self.hashed_password = nil
    end
  end
end
