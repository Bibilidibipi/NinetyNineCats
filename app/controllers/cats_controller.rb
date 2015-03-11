class CatsController < ApplicationController
  before_action :check_owner, only: [:edit, :update]
  before_action :logged_in, only: [:new, :create]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      flash[:notice] = "Successfully created cat!"
      redirect_to cats_url
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update(cat_params)
      flash[:notice] = "Successfully updated cat!"
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  private

  def check_owner
    @cat = Cat.find(params[:id])
    redirect_to cats_url unless current_user.id == @cat.user_id
  end

  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end
end
