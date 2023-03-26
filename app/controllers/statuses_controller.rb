class StatusesController < ApplicationController
  before_action :require_user
  before_action :set_status, only: %i[show edit update destroy]

  def index
    @statuses = Status.all
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    if @status.save
      redirect_to statuses_path, notice: 'Successfully created status.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @status.update(status_params)
      redirect_to status_path, notice: 'Successfully updated status.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @status.destroy
      redirect_to statuses_url, notice: 'Successfully destroyed status.'
    else
      @statuses = Status.all
      render :index, status: :unprocessable_entity
    end
  end

  private

  def status_params
    params.require(:status).permit(:name, :colour)
  end

  def set_status
    @status = Status.find(params[:id])
  end
end
