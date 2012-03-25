require 'csv'

class Admin::<%= class_name.pluralize %>Controller < Admin::ApplicationController
  # filters
  before_filter :load_<%= file_name %>, only: [:show, :edit, :update, :destroy]
  
  # index
  def index
    @<%= table_name %> = <%= class_name %>.search(params[:q]).sorty(params)
    
    respond_to do |format|
      format.html do
        @<%= table_name %> = @<%= table_name %>.page(params[:page])
      end
      
      format.csv do
        data = CSV.generate do |csv|
          columns = <%= class_name %>.columns.map(&:name)
          csv << columns.map(&:titleize)
          
          @<%= table_name %>.map do |<%= file_name %>|
            csv << columns.map{|c| <%= file_name %>.send(c)}
          end
        end
        
        filename = "<%= table_name %>-#{Time.now.strftime('%d-%m-%Y')}.csv"
        send_data(data, filename: filename, type: 'text/csv')
      end
    end
  end
  
  # show
  def show
    
  end
  
  # new
  def new
    @<%= file_name %> = <%= class_name %>.new
  end
  
  # create
  def create
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
    
    if @<%= file_name %>.save
      redirect_to admin_<%= table_name %>_url, notice: "<%= human_name %> has been created"
    else
      render :new
    end
  end
  
  # edit
  def edit
    
  end
  
  # update
  def update
    if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
      redirect_to admin_<%= table_name %>_url, notice: "<%= human_name %> has been updated"
    else
      render :edit
    end
  end
  
  # destroy
  def destroy
    @<%= file_name %>.destroy
    
    respond_to do |format|
      format.html { redirect_to :back, notice: "<%= human_name %> has been deleted" }
      format.js
    end
  end
  
  protected
  
  def load_<%= file_name %>
    @<%= file_name %> = <%= class_name %>.find(params[:id])
  end
end