
class Business < ApplicationRecord
  has_many :booths, dependent: :destroy

  validates :name, presence: true
  validates :monthly_expenses,
            numericality: { greater_than_or_equal_to: 0 }

  validates :default_monthly_fee,
            numericality: { greater_than_or_equal_to: 0 }

  def occupied_booths
    booths.where(occupied: true)
  end

  def available_booths
    booths.where(occupied: false)
  end

  def monthly_income
    occupied_booths.sum(:monthly_fee)
  end

  def potential_income
    monthly_income +
      available_booths.count * default_monthly_fee
  end

  def coverage_percentage
    return 0 if monthly_expenses.zero?

    (monthly_income / monthly_expenses * 100).round
  end

  def potential_coverage_percentage
    return 0 if monthly_expenses.zero?

    (potential_income / monthly_expenses * 100).round
  end
end
