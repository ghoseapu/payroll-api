require 'rails_helper'

RSpec.describe PayrollGenerator do
  describe '#report' do
    it 'should return a list of employee reports base on EmployeeTimesheet records' do
      EmployeeTimesheet.create(date: Date.new(2020, 1, 4), biweekly_start_date: Date.new(2020, 1, 1), biweekly_end_date: Date.new(2020, 1, 15), hours_worked: 10, employee_id: '1', job_group: 'A')
      EmployeeTimesheet.create(date: Date.new(2020, 1, 14), biweekly_start_date: Date.new(2020, 1, 1), biweekly_end_date: Date.new(2020, 1, 15), hours_worked: 5, employee_id: '1', job_group: 'A')
      EmployeeTimesheet.create(date: Date.new(2020, 1, 4), biweekly_start_date: Date.new(2020, 1, 1), biweekly_end_date: Date.new(2020, 1, 15), hours_worked: 3, employee_id: '2', job_group: 'B')
      EmployeeTimesheet.create(date: Date.new(2020, 1, 20), biweekly_start_date: Date.new(2020, 1, 16), biweekly_end_date: Date.new(2020, 1, 31), hours_worked: 4, employee_id: '1', job_group: 'A')

      report_list = PayrollGenerator.new.report

      expect(report_list.size).to eq(3)

      first_report = report_list.first
      expect(first_report.employee_id).to eq(1)
      expect(first_report.biweekly_start_date).to eq(Date.new(2020, 1, 1))
      expect(first_report.biweekly_end_date).to eq(Date.new(2020, 1, 15))
      expect(first_report.amount_paid).to eq(Money.new(30000, 'USD'))

      second_report = report_list[1]
      expect(second_report.employee_id).to eq(1)
      expect(second_report.biweekly_start_date).to eq(Date.new(2020, 1, 16))
      expect(second_report.biweekly_end_date).to eq(Date.new(2020, 1, 31))
      expect(second_report.amount_paid).to eq(Money.new(8000, 'USD'))

      third_report = report_list.last
      expect(third_report.employee_id).to eq(2)
      expect(third_report.biweekly_start_date).to eq(Date.new(2020, 1, 1))
      expect(third_report.biweekly_end_date).to eq(Date.new(2020, 1, 15))
      expect(third_report.amount_paid).to eq(Money.new(9000, 'USD'))
    end

    it 'should return a list of employee reports ordered by employee id, and then by biweekly_start_date' do
      EmployeeTimesheet.create(date: Date.new(2020, 1, 4), biweekly_start_date: Date.new(2020, 1, 1), biweekly_end_date: Date.new(2020, 1, 15), hours_worked: 3, employee_id: '3', job_group: 'B')
      EmployeeTimesheet.create(date: Date.new(2020, 1, 17), biweekly_start_date: Date.new(2020, 1, 16), biweekly_end_date: Date.new(2020, 1, 31), hours_worked: 10, employee_id: '1', job_group: 'A')
      EmployeeTimesheet.create(date: Date.new(2020, 1, 14), biweekly_start_date: Date.new(2020, 1, 1), biweekly_end_date: Date.new(2020, 1, 15), hours_worked: 5, employee_id: '1', job_group: 'A')

      report_list = PayrollGenerator.new.report

      expect(report_list.size).to eq(3)
      expect(report_list[0].employee_id).to eq(1)
      expect(report_list[0].biweekly_start_date).to eq(Date.new(2020, 1, 1))
      
      expect(report_list[1].employee_id).to eq(1)
      expect(report_list[1].biweekly_start_date).to eq(Date.new(2020, 1, 16))

      expect(report_list[2].employee_id).to eq(3)
      expect(report_list[2].biweekly_start_date).to eq(Date.new(2020, 1, 1))
    end
  end
end