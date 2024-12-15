class PatientsController < ApplicationController
  def new
    # render Patient
  end

  def validate
    service = PatientService.new
    result = service.validate_patient(params[:nhs_number], params[:surname], Date.parse(params[:dob]))

    case result
    when :valid
      redirect_to questions_path(age: service.calculate_patient_age(Date.parse(params[:dob])))
    when :underage
      flash[:error] = 'You are not eligible for this service.'
    when :not_found, :mismatch
      flash[:error] = 'Your details could not be found.'
    else
      flash[:error] = 'An unexpected error occurred. Please try again.'
    end

    render :new unless result == :valid
  end
end
