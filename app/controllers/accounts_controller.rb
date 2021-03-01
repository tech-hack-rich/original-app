class AccountsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_account, only: [:show, :edit, :update, :destroy]
  before_action :user_match, only: [:show, :edit, :update, :destroy]
  
  def index
    if user_signed_in?
      @accounts = Account.where(user_id: current_user.id).includes(:user).order('created_at DESC')
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @asset = Asset.new  
    @assets = @account.assets.all
    @movement = Movement.new
    @movements = @account.movements.all
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to account_path(@account)
    else
      render :edit
    end
  end

  def destroy
    if @account.destroy
      redirect_to root_path
    end
  end

end

private
  def account_params
    params.require(:account).permit(:name, :info).merge(user_id: current_user.id)
  end

  def find_account
    @account = Account.find(params[:id])
  end

  def user_match
    redirect_to root_path unless current_user == @account.user
  end