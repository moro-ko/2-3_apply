class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    @search = params[:search]
    if @model == "User"
      @users = User.looks(@word, @search)
    else
      @books = Book.looks(@word, @search)
    end
  end
  # 定義の仕方の違い
  # def search
  #   @model = params[:model]
  #   if @model == "User"
  #     @users = User.looks(params[:word], params[:search])
  #   else
  #     @books = Book.looks(params[:word], params[:search])
  #   end
  # end
  
end
