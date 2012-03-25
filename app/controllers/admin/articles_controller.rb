require 'csv'

class Admin::ArticlesController < Admin::ApplicationController
  # filters
  before_filter :load_article, only: [:show, :edit, :update, :destroy]
  
  # index
  def index
    @articles = Article.search(params[:q]).sorty(params)
    
    respond_to do |format|
      format.html do
        @articles = @articles.page(params[:page])
      end
      
      format.csv do
        data = CSV.generate do |csv|
          columns = Article.columns.map(&:name)
          csv << columns.map(&:titleize)
          
          @articles.map do |article|
            csv << columns.map{|c| article.send(c)}
          end
        end
        
        filename = "articles-#{Time.now.strftime('%d-%m-%Y')}.csv"
        send_data(data, filename: filename, type: 'text/csv')
      end
    end
  end
  
  # show
  def show
    
  end
  
  # new
  def new
    @article = Article.new
  end
  
  # create
  def create
    @article = Article.new(params[:article])
    
    if @article.save
      redirect_to admin_articles_url, notice: "Article has been created"
    else
      render :new
    end
  end
  
  # edit
  def edit
    
  end
  
  # update
  def update
    if @article.update_attributes(params[:article])
      redirect_to admin_articles_url, notice: "Article has been updated"
    else
      render :edit
    end
  end
  
  # destroy
  def destroy
    @article.destroy
    
    respond_to do |format|
      format.html { redirect_to :back, notice: "Article has been deleted" }
      format.js
    end
  end
  
  protected
  
  def load_article
    @article = Article.find(params[:id])
  end
end