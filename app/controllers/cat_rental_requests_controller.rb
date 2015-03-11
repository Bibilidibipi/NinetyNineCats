class CatRentalRequestsController < ApplicationController
  before_action :check_owner, only: [:approve, :deny]
  before_action :logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @request.user_id = current_user.id
    if @request.save
      flash[:notice] = "Request submitted"
      redirect_to cat_url(@request.cat)
    else
      flash[:errors] = @request.errors.full_messages
      redirect_to :back
    end
  end

  def approve
    if @request.approve!
      flash[:notice] = "Request approved :)"
    else
      flash[:errors] = @request.errors.full_messages
    end
    redirect_to :back
  end

  def deny
    if @request.deny!
      flash[:notice] = "Request denied :("
    else
      flash[:errors] = @request.errors.full_messages
    end
    redirect_to :back
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

  def check_owner
    @request = CatRentalRequest.find(params[:id])
    redirect_to cats_url unless current_user.id == @request.cat.user_id
  end
end
