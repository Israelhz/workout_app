class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]
  before_action :set_current_room, only: [:index]

  def index
    @exercises = current_user.exercises.in_last_seven_days
    @friends = current_user.friends
    @message = Message.new
    @messages = current_room.messages if current_room
    @followers = Friendship.where(friend_id: current_user.id)
  end

  def show
  end

  def new
    @exercise = current_user.exercises.new
  end

  def edit
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)
    
    if @exercise.save
      flash[:notice] = 'Exercise has been created'
      redirect_to [current_user, @exercise]
    else
      flash.now[:alert] = 'Exercise has not been created'
      render :new
    end
  end

  def update
    if @exercise.update(exercise_params)
      flash[:notice] = 'Exercise has been updated'
      redirect_to [current_user, @exercise]
    else
      flash.now[:alert] = 'Exercise has not been updated'
      render :edit
    end
  end

  def destroy
    if @exercise.delete
      flash[:notice] = 'Exercise has been deleted'
    else
      flash[:alert] = 'Exercise has not been deleted'
    end

    redirect_to user_exercises_path(current_user)
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date)
  end

  def set_current_room
    if params[:room_id]
      @room = Room.find_by(id: params[:room_id])
    else
      @room = current_user.room
    end
    session[:current_room] = @room.id if @room
  end
end
