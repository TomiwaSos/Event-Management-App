class EventsController < ApplicationController
  def index
    @events = Event.all
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
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, :notice => "Successfully destroyed user."
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to root_path, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description,:status_id, :active_from,
                                  :active_to, :created_by)
  end
end
