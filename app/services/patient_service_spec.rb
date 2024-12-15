require 'rails_helper'

RSpec.describe PatientService, type: :service do
  let(:api_client) { double('HTTParty') }
  let(:service) { described_class.new(api_client: api_client) }

  it 'returns :not_found for invalid NHS number' do
    allow(api_client).to receive(:get).and_return(double(code: 404))
    expect(service.validate_patient('000000000', 'Doe', Date.today)).to eq(:not_found)
  end
end
