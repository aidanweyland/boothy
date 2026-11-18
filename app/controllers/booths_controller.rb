
class BoothsController < ApplicationController
  def update
    @booth = Booth.find(params[:id])
    @business = @booth.business

    if @business.nil?
      return redirect_to owner_path,
        alert: "This booth has no assigned business."
    end

    attributes = booth_params

    if attributes.key?(:vendor_name)
      vendor_name = attributes[:vendor_name].to_s.strip

      if vendor_name.blank?
        attributes[:vendor_name] = nil
        attributes[:occupied] = false
      else
        attributes[:vendor_name] = vendor_name
        attributes[:occupied] = true
      end
    end

    if @booth.update(attributes)
      redirect_to owner_path(
        business_id: @business.id,
        booth: @booth.number
      ), notice: "Booth updated successfully."
    else
      redirect_to owner_path(
        business_id: @business.id,
        booth: @booth.number
      ), alert: @booth.errors.full_messages.to_sentence
    end
  end

  private

  def booth_params
    params.require(:booth).permit(
      :vendor_name,
      :monthly_fee
    )
  end
end
