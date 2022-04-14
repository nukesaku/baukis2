class Admin::Base < ApplicationController
  private def current_administrator
    if session[:administrator_id]
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end
  
  helper_method :current_administrator
end