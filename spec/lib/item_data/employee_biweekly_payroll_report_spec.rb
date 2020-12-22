require 'rails_helper'

RSpec.describe ItemData::EmployeeBiweeklyPayrollReport do
  describe '#to_json' do
    it 'should return a camelcase representation of employee biweekly payroll report' do
      report = ItemData::EmployeeBiweeklyPayrollReport.new(
        employee_id: 1,
        biweekly_start_date: Date.new(2020, 1, 1),
        biweekly_end_date: Date.new(2020, 1, 15),
        amount_paid: Money.new(30000, 'USD')
      )

      json = report.to_json
       
      expect(json).to eq({
        employeeId: 1,
        payPeriod: {
          startDate: "2020-01-01",
          endDate: "2020-01-15"
        },
        amountPaid: "$300.00"
      })
    end
  end
end