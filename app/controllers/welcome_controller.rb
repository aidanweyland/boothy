
class WelcomeController < ApplicationController
  def index
  end

  def owner
    @business =
      if params[:business_id].present?
        Business.find(params[:business_id])
      else
        Business.order(:id).first
      end

    return redirect_to new_business_path if @business.nil?

    @booths = @business.booths.order(:number)

    @total_booths = @booths.count
    @occupied_booths = @booths.count(&:occupied?)
    @available_booths = @total_booths - @occupied_booths

    @monthly_expenses = @business.monthly_expenses
    @monthly_income = @business.monthly_income
    @potential_income = @business.potential_income

    @coverage_percentage = @business.coverage_percentage
    @potential_coverage_percentage =
      @business.potential_coverage_percentage

    @additional_potential_income =
      @potential_income - @monthly_income

    @selected_booth =
      @booths.find { |booth| booth.number == params[:booth].to_i } ||
      @booths.first
  end

  def vendor
    @business =
      if params[:business_id].present?
        Business.find(params[:business_id])
      else
        Business.order(:id).first
      end

    @booth =
      if @business
        @business.booths
          .where(occupied: true)
          .order(:number)
          .first
      end
  end
end
