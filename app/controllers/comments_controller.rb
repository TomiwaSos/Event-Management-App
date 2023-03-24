class CommentsController < ApplicationController
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
    @event = Event.find(params[:event_id])
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to event_path(params[:event_id]), :notice => "Successfully destroyed comment."
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to event_path(params[:event_id]), :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:event_id, :author_id, :description, :status_id)
  end
end
