module Users

    class WorkoutsController < ApplicationController

        # READ
        def index
            @user = User.find(params[:user_id])
            
            @workouts = @user.workouts.order(name: :asc).paginate(page: params[:page], :per_page => 10)
        end

        def show
            @workout = Workout.find(params[:id])
        end
        # CREATE
        def create
            @workout = Workout.find(params[:workout][:id])
            new_workout = current_user.workouts.create!(name: @workout.name)
            @workout.regiments.each do |regiment|
                new_workout.regiments.create!(exercise: regiment.exercise, sets: regiment.sets, reps: regiment.reps)
            end
            redirect_to user_workouts_path(current_user)
        end

        def new
            @user = User.new if @user == nil
        end

        # UPDATE
        def edit
            @workout = Workout.find(params[:id])
        end

        def update
            @user = User.find(params[:id])
            if @user.update_attributes(user_params)
                redirect_to @user
            else
                render 'edit'
            end
        end

        # DESTROY
        def destroy
            @workout = Workout.find(params[:id])
            @workout.destroy
            redirect_to user_workouts_path
        end

        private
        def user_params
            params.require(:user).permit(:username, :email, :password)
        end

    end
end