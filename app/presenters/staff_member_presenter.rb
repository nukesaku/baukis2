class StaffMemberPresenter < ModelPresenter
  delegate :suspended?, :family_name, :given_name, :family_name_kana, :given_name_kana, to: :object
  
  # 職員の停止フラグのOn/Offを表現する記号を返す。
  # On: BALLOT BOX WITH CHECK (U+2611)
  # Off: BALLOT BOX (U+2610)
  def suspended_mark
    suspended? ? raw("&#x2611;") : raw("&#x2610;")
  end
  
  def full_name
    markup do |m|
      m.text"#{family_name} #{given_name}"
    end
  end
  
  def full_name_kana
    markup do |m|
      m.text"#{family_name_kana} #{given_name_kana}"
    end
  end
end
