class QuestionsController < ApplicationController
  def index
    @age = params[:age].to_i
  end

  def submit
    age = params[:age].to_i
    answers = {
      drink: params[:drink],
      smoke: params[:smoke],
      exercise: params[:exercise]
    }

    score = ScoringService.new(age: age, answers: answers).calculate_score

    if score <= 3
      flash[:notice] = 'Thank you for answering our questions. Keep up the good work!'
    else
      flash[:notice] =
        'We think there are some simple things you could do to improve your quality of life. Please phone to book an appointment.'
    end

    # render :index
    redirect_to root_path
  end
end
