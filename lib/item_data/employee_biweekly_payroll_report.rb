module ItemData
  class EmployeeBiweeklyPayrollReport < Struct.new(:employee_id, :biweekly_start_date, :biweekly_end_date, :amount_paid, keyword_init: true)
      def to_json
        {
          "employeeId": employee_id,
          "payPeriod": {
            "startDate": biweekly_start_date.strftime('%F'),
            "endDate": biweekly_end_date.strftime('%F')
          },
          "amountPaid": amount_paid.format
        }
      end  
  end  
end  