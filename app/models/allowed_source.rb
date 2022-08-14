class AllowedSource < ApplicationRecord
  validates :octet1, :octet2, :octet3, :octet4, presence: true,
            numericality: { only_integer: true, allow_blank: true }, # numericalityタイプのバリデーションは、変換前の値に対して行われるので、正しくエラー判定される。
            inclusion: { in: 0..255, allow_blank: true } # inclusionタイプのバリデーションは、"XYZ"のような文字列がこれらの属性に代入されると、整数0に変換されてしまう。
  validates :octet4,
            uniqueness: {
              scope: [ :namespace, :octet1, :octet2, :octet3 ], allow_blank: true
            } # 5つの属性の組み合わせに関してuniquenessタイプのバリデーションが実施される。

  def ip_address=(ip_address)
    octets = ip_address.split(".")
    self.octet1 = octets[0]
    self.octet2 = octets[1]
    self.octet3 = octets[2]

    if octets[3] == "*"
      self.octet4 = 0
      self.wildcard = true
    else
      self.octet4 = octets[3]
    end
  end

  class << self
    def include?(namespace, ip_address)
      return true if !Rails.application.config.baukis2[:restrict_ip_addresses]

      octets = ip_address.split(".")

      condition = %Q{
        octet1 = ? AND octet2 = ? AND octet3 = ?
        AND ((octet4 = ? AND wildcard = ?) OR wildcard = ?)
      }.gsub(/\s+/, " ").strip

      opts = [ condition, *octets, false, true ]
      where(namespace: namespace).where(opts).exists?
    end
  end
end
