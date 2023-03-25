class EventsController < ApplicationController
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
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, :notice => "Successfully destroyed event."
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to root_path, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :status_id, :active_from,
                                  :active_to, :created_by)
  end

  # def event_search_params
  #   params.require(:q).permit(:title_cont)
  # end
end
