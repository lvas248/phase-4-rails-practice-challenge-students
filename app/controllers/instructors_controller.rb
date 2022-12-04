class InstructorsController < ApplicationController

    wrap_parameters format: []

rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found


    def index
        render json: Instructor.all, status: :ok
    end

    def show
        instructor = find_instructor
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor, status: :ok
    end

    def destroy
        instructor = find_instructor
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name, :id)
    end

    def find_instructor
        Instructor.find(params[:id])
    end

    def render_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: 'Instructor not found'}, status: :not_found
    end

end
