# frozen_string_literal: true

class ArticlesController < ApplicationController
  #you have call the authenticate user funtion before any action excepte the action of show
  before_action :authenticate_user!, except: [:show]
  #you will call the set_article function to find out the id of user who clicked to destroy , update, edit
  before_action :set_article, only: %i[edit update destroy]
  before_action :authorize_article, only: %i[edit update destroy]
#new user who login will store in current_user ,user-articles show the current_user articles, current_user is built-in functionality of devise
  def index
    @user_articles = current_user.articles
  end

  def show
    @article = Article.includes(comments: :replies).find(params[:id])
  end
# if article can't save due to error this method will run
  def new
    @article = Article.new
  end
#fetch the param from article_params and pass it to create method 
  def create
    @article = Article.create(article_params)
    authorize @article
    #if article saved
    if @article.save
      flash[:notice] = t(:article_success)
      #built-in
      redirect_to root_path
    #if article don't save
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:alert] = t(:article_fail)
      redirect_to @article
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    flash[:notice] = t(:article_deleted) if @article.destroy
    redirect_to root_path
  end

  private
#when user create ,edit , udate , delete the article 
#we pick just ID from params , params contains the hashes array , params passed from frontend when any edit, delete button clicked for article
  def set_article
    @article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
  end
#contain method which contain the authentication to accept the only permit params fron frontend in the case if user send more parameters by inspecting the webpage
#merge : param from frontend will be merged with the foreign key from user:: user_id is field name and current_user.id is data which we want to insert
  def article_params
    params.require(:article).permit(:title, :description, :image).merge(user_id: current_user.id)
  end
end
