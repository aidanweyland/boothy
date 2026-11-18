
class Booth < ApplicationRecord
  belongs_to :business, optional: true

  validates :number, presence: true
  validates :number, uniqueness: { scope: :business_id }

  validates :monthly_fee,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true

  validates :vendor_name, presence: true, if: :occupied?

  def occupied?
    occupied == true
  end
end
