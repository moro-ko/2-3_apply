class FavoritesController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # 非同期通信：リダイレクト先の削除「リダイレクト先がない かつ JavaScriptリクエスト」→create.js.erbを探しにいく
    # redirect_back(fallback_location: root_path)
    # redirect_to book_path(book)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # 非同期通信：リダイレクト先の削除「リダイレクト先がない かつ JavaScriptリクエスト」→destroy.js.erbを探しにいく
    # redirect_back(fallback_location: root_path)
    # redirect_to book_path(book)
  end
    
end
