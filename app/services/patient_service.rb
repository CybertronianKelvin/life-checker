require 'httparty'
require 'json'
require 'date'

class PatientService
  BASE_URL = 'https://al-tech-test-apim.azure-api.net/tech-test/t2/patients'
  attr_reader :api_client

  # @todo move key into a .env file
  def initialize(api_client: HTTParty, subscription_key: '6041fa5a085c4882ada2c38ffd5b149b')
    raise ArgumentError, 'Subscription key is missing' unless subscription_key

    @api_client = api_client
    @subscription_key = subscription_key
  end

  def fetch_patient(nhs_number)
    @api_client.get("#{BASE_URL}/#{nhs_number}", headers: {
                      'Ocp-Apim-Subscription-Key' => @subscription_key
                    })
  end

  def calculate_patient_age(dob)
    calculate_age(dob)
  end

  def validate_patient(nhs_number, surname, dob)
    response = fetch_patient(nhs_number)

    return :error unless response.success?
    return :not_found if response.code == 404

    patient_data = begin
      JSON.parse(response.body)
    rescue StandardError
      {}
    end
    # @todo uncomment this and get them to work
    return :error if patient_data.empty?

    # patient_born_date = valid_date?(patient_data['born']) ? Date.parse(patient_data['born']) : nil
    # return :error unless patient_born_date

    # return :mismatch if patient_data['name'] != surname.upcase || patient_born_date != dob
    return :underage if calculate_age(patient_born_date) < 16

    :valid
  rescue StandardError => e
    Rails.logger.error("Error fetching patient: #{e.message}") if defined?(Rails)
    :error
  end

  private

  def calculate_age(dob)
    now = Time.zone ? Time.zone.now : Time.now
    ((now - dob.to_time) / 1.year.seconds).floor
  end

  def valid_date?(date_string)
    Date.parse(date_string)
    true
  rescue ArgumentError
    false
  end
end
