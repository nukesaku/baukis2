class StaffMember < ApplicationRecord
  has_many :events, class_name: 'StaffEvent', dependent: :destroy
  
  def password=(raw_passowrd)
    if raw_passowrd.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_passowrd)
    elsif raw_passowrd.nil?
      self.hashed_password = nil
    end
  end
  
  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end
end
