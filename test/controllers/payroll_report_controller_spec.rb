require 'rails_helper'

RSpec.describe PayrollReportController do
  describe '#index' do
    it 'should return the appropriate json from employee payroll table' do
      expect_any_instance_of(PayrollGenerator).to receive(:report).and_return(
        [
          ItemData::EmployeeBiweeklyPayrollReport.new(employee_id: 1, biweekly_start_date: Date.new(2020, 1, 1), biweekly_end_date: Date.new(2020, 1, 15), amount_paid: Money.new(30000, 'USD')),
          ItemData::EmployeeBiweeklyPayrollReport.new(employee_id: 2, biweekly_start_date: Date.new(2020, 1, 1), biweekly_end_date: Date.new(2020, 1, 15), amount_paid: Money.new(8000, 'USD'))
        ]
      )

      get :index

      json = JSON.parse(response.body)
      employee_reports = json['payrollReport']['employeeReports']

      expect(employee_reports[0]['employeeId']).to eq(1)
      expect(employee_reports[0]['payPeriod']['startDate']).to eq('2020-01-01')
      expect(employee_reports[0]['payPeriod']['endDate']).to eq('2020-01-15')
      expect(employee_reports[0]['amountPaid']).to eq('$300.00')
    end
  end
end