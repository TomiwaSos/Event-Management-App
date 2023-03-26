class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :require_user
  before_action :require_same_user, only: %i[edit update destroy]

  def new
    @event = Event.find(params[:event_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @comment.event.update(status_id: @comment.status_id, resolved: @comment.resolved)
      if @comment.resolved == true
        @comment.event.update(resolved_at: Date.today,
                              resolved_by: comment_params[:author_id])
      end
      redirect_to event_path(params[:event_id]), notice: 'Comment was successfully created'
    else
      render 'new'
    end
  end

  def edit; end

  def destroy
    @comment.destroy
    redirect_to event_path(params[:event_id]), notice: 'Successfully destroyed comment.'
  end

  def update
    if @comment.update(comment_params)
      redirect_to event_path(params[:event_id]), notice: 'Successfully updated user.'
    else
      render action: 'edit'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:event_id, :author_id, :description, :status_id, :resolved)
  end

  def require_same_user
    return unless current_user != @comment.user

    flash.alert = 'you can only edit or delete your own comments'
    redirect_to @event
  end
end
