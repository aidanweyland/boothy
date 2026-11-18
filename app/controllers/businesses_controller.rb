
class BusinessesController < ApplicationController
  def index
    @businesses = Business.order(:name)
  end

  def new
    @business = Business.new(
      monthly_expenses: 0,
      default_monthly_fee: 800
    )
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      redirect_to owner_path(business_id: @business.id),
                  notice: "Business created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])

    if @business.update(business_params)
      redirect_to owner_path(business_id: @business.id),
                  notice: "Business settings updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def resize
    @business = Business.find(params[:id])
    new_count = Integer(params[:booth_count], exception: false)

    unless new_count && new_count.between?(1, 100)
      return redirect_to(
        owner_path(business_id: @business.id),
        alert: "Booth capacity must be between 1 and 100."
      )
    end

    error = nil

    @business.with_lock do
      current_count = @business.booths.count

      if new_count > current_count
        next_number = @business.booths.maximum(:number).to_i + 1

        (new_count - current_count).times do |index|
          @business.booths.create!(
            number: next_number + index,
            monthly_fee: @business.default_monthly_fee,
            occupied: false
          )
        end
      elsif new_count < current_count
        removal_count = current_count - new_count

        removable = @business.booths
          .where(occupied: false)
          .order(number: :desc)
          .limit(removal_count)
          .to_a

        if removable.length < removal_count
          error = "Remove vendors before reducing capacity further."
        else
          removable.each(&:destroy!)
        end
      end
    end

    if error
      redirect_to owner_path(business_id: @business.id),
                  alert: error
    else
      redirect_to owner_path(business_id: @business.id),
                  notice: "Booth capacity updated."
    end
  end

  private

  def business_params
    params.require(:business).permit(
      :name,
      :business_type,
      :monthly_expenses,
      :default_monthly_fee
    )
  end
end
