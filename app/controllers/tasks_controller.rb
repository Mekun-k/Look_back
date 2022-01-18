class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[show new create edit update destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
