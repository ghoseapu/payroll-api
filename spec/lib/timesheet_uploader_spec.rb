require 'rails_helper'

RSpec.describe "Timesheet Uploader" do
  describe "#run" do
    it "should create RawEmployeeTimes" do
      file_path = Rails.root.to_s + "/test/fixtures/files/time-report-1.csv"
      TimesheetUploader.new.import(file_path)

      expect(EmployeeTimesheet.count).to eq(3)

      first_employee_time = EmployeeTimesheet.first
      expect(first_employee_time.date).to eq(Date.parse('14/11/2016'))
      expect(first_employee_time.hours_worked).to eq(7.5)
      expect(first_employee_time.employee_id).to eq(1)
      expect(first_employee_time.job_group).to eq('A')
    end

    it 'should set the correct biweekly_start_date and biweekly_end_date in the first half of the month' do
      file_path = Rails.root.to_s + "/test/fixtures/files/time-report-2.csv"
      TimesheetUploader.new.import(file_path)

      expect(EmployeeTimesheet.count).to eq(1)

      first_employee_time = EmployeeTimesheet.first
      expect(first_employee_time.biweekly_start_date).to eq(Date.parse('1/11/2016'))
      expect(first_employee_time.biweekly_end_date).to eq(Date.parse('15/11/2016'))
    end

    it 'should set the correct biweekly_start_date and biweekly_end_date in the last half of the month' do
      file_path = Rails.root.to_s + "/test/fixtures/files/time-report-3.csv"
      TimesheetUploader.new.import(file_path)

      expect(EmployeeTimesheet.count).to eq(1)

      first_employee_time = EmployeeTimesheet.first
      expect(first_employee_time.biweekly_start_date).to eq(Date.parse('16/11/2016'))
      expect(first_employee_time.biweekly_end_date).to eq(Date.parse('30/11/2016'))
    end
  end
end