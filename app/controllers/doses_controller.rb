class DosesController < ApplicationController
  def new
    # we need @restaurant in our `simple_form_for`
    @cocktail = set_doses
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    # we need `restaurant_id` to asssociate review with corresponding restaurant
    @dose.cocktail = set_doses
    if @dose.save
      redirect_to cocktail_path(set_doses)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Dose.find(params[:id]).cocktail
    Dose.find(params[:id]).destroy

    redirect_to cocktail_path(@cocktail)
  end

  private

  def set_doses
    Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
