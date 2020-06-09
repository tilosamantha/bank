class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  
  def index
    @accounts = current_user.accounts       #dont actually want to see everyones account, only the user logged in
  end

  def show
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = "Account created"
      redirect_to root_path
    else
      flash[:error] = "Error #{@account.errors.full_messages.join("\n")}"
      render :new
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to root_path
  end

  private
    def account_params
      params.require(:account).permit(:balance, :name)
    end

    def set_account
      @account = Account.find(params[:id])
    end
end
