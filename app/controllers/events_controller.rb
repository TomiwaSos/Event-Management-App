class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @events = Event.search(params[:q])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event was successfully created"
      redirect_to events_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @event.destroy
    redirect_to root_path, :notice => "Successfully destroyed event."
  end

  def update
    if @event.update(event_params)
      redirect_to root_path, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :status_id, :active_from,
                                  :active_to, :created_by)
  end

  def require_same_user
    if current_user != @event.user
     flash[:alert] = 'you can only edit or delete your own events'
     redirect_to @event
    end
  end
end
