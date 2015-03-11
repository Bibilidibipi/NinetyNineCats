class CatRentalRequestsController < ApplicationController
  def new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      flash[:success] = "Request submitted"
      redirect_to cat_url(@request.cat)
    else
      flash[:errors] = @request.errors.full_messages
      redirect_to :back
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    if @request.approve!
      flash[:success] = "Request approved :)"
    else
      flash[:errors] = @request.errors.full_messages
    end
    redirect_to :back
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    if @request.deny!
      flash[:success] = "Request denied :("
    else
      flash[:errors] = @request.errors.full_messages
    end
    redirect_to :back
  end

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
