class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @event = Event.find(params[:event_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Comment was successfully created"
      redirect_to event_path(params[:event_id])
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @comment.destroy
    redirect_to event_path(params[:event_id]), :notice => "Successfully destroyed comment."
  end

  def update
    if @comment.update(comment_params)
      redirect_to event_path(params[:event_id]), :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:event_id, :author_id, :description, :status_id)
  end

  def require_same_user
    byebug
    if current_user != @comment.user
     flash[:alert] = 'you can only edit or delete your own comments'
     redirect_to @event
    end
  end
end
