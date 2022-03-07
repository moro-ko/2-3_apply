class BookCommentsController < ApplicationController
    
    def create
        @book = Book.find(params[:book_id])
        @book_comment = BookComment.new(book_comment_params)
        @book_comment.book_id = @book.id
        @book_comment.user_id = current_user.id
        @book_comment.save
        # comment = current_user.book_comments.new(book_comment_params)
        # comment.book_id = book.id
        # comment.save
    # 非同期通信：リダイレクト先の削除「リダイレクト先がない かつ JavaScriptリクエスト」→create.js.erbを探しにいく
        # redirect_back(fallback_location: root_path)         
    end
    
    def destroy
        @book = Book.find(params[:book_id])
        book_comment = @book.book_comments.find(params[:id])
        book_comment.destroy
        # BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy :この行を省略せずに書いたものが上記３行
    # 非同期通信：リダイレクト先の削除「リダイレクト先がない かつ JavaScriptリクエスト」→destroy.js.erbを探しにいく
        # redirect_to request.referer
    end
    
    private

    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end

end
