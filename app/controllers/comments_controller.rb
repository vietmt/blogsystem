class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :owner_user,   only: :destroy

  def create
    @comment = Comment.new comment_params
    @entry = Entry.find_by(id: @comment.entry_id)
    @user = current_user.following.find_by(id: @entry.user_id)
    if current_user.id == @entry.user_id || @user != nil
      if @comment.save
        flash[:success] = "Comment created!"
        redirect_to request.referrer || root_url
      else
        flash[:notice] = "Comment not is blank"
        redirect_to request.referrer || root_url
      end
    else
        flash[:alert] = "You must follow before comment"
        redirect_to request.referrer || root_url
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :entry_id, :user_id)
    end

    def owner_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

end
