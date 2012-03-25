require 'csv'

class Admin::UsersController < Admin::ApplicationController
  # filters
  before_filter :load_user, only: [:edit, :update, :destroy]
  
  # index
  def index
    @users = User.search(params[:q]).sorty(params)
    
    respond_to do |format|
      format.html do
        @users = @users.page(params[:page])
      end
      format.csv do
        data = CSV.generate do |csv|
          columns = User.columns.map(&:name)
          csv << columns.map(&:titleize)
          
          @users.map do |user|
            csv << columns.map{|c| user.send(c)}
          end
        end
        
        filename = "users-#{Time.now.strftime('%d-%m-%Y')}.csv"
        send_data(data, filename: filename, type: 'text/csv')
      end
    end
  end
  
  # new
  def new
    @user = User.new
  end
  
  # create
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to admin_users_url, notice: "User has been created"
    else
      render :new
    end
  end
  
  # edit
  def edit
    
  end
  
  # update
  def update
    if @user.update_attributes(params[:user])
      redirect_to admin_users_url, notice: "User has been updated"
    else
      render :edit
    end
  end
  
  # destroy
  def destroy
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to :back, notice: "User has been deleted" }
      format.js
    end
  end
  
  protected
  
  def load_user
    @user = User.find(params[:id])
  end
end