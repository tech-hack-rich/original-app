class AccountsController < ApplicationController
  before_action 
  before_action :authenticate_user!, except: [:index]

  def index
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
end

private
  def account_params
    params.require(:account).permit(:name, :info).merge(user_id: current_user.id)
  end