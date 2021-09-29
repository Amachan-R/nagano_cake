class Address < ApplicationRecord

  belongs_to :customer

  def shipping_total_name
    "〒" + self.postal_code + ' ' + self.address + ' ' + self.name
  end

end
