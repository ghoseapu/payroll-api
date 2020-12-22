require 'rails_helper'

RSpec.describe TimesheetController do
  describe '#create' do
    it 'should create a time report record if the file is successfully uploaded' do
      file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/files/time-report-10.csv", 'text/csv')

      expect_any_instance_of(TimesheetUploader).to receive(:import)

      post :create, params: { file: file }

      expect(TimeReport.count).to eq(1)

      time_report = TimeReport.first
      expect(time_report.time_report_upload_status).to eq('success')
      expect(time_report.time_report_id).to eq(10)
      expect(time_report.time_report_name).to eq('time-report-10.csv')

      json = JSON.parse(response.body)
      expect(json["time_reports_id"]).to eq(time_report.id)
    end

    it 'should return an error message if the file has already been uploaded' do
      TimeReport.create(time_report_upload_status: 'success', time_report_id: 10, time_report_name: 'time-report-10.csv')
      file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/files/time-report-10.csv", 'text/csv')

      post :create, params: { file: file }

      json = JSON.parse(response.body)
      expect(json["error"]).to eq('Not permitted: time-report-10.csv has already been uploaded')
      expect(response.status).to eq(400)
    end

    it 'should return an error message if the file does not conform to the expected fileanem time-report-x.csv' do
      file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/files/wrong-pattern-report.csv", 'text/csv')

      post :create, params: { file: file }

      json = JSON.parse(response.body)
      expect(json["error"]).to eq('Invalid filename pattern. Example of correct file name: time-report-x.csv, where x is a number representing time report ID')
      expect(response.status).to eq(400)
    end
  end
end    