class PayrollGenerator
  def report
    grouped_employee_timesheet = EmployeeTimesheet
    .select(:employee_id, :job_group, :biweekly_start_date, :biweekly_end_date, "SUM(hours_worked) as total_hours")
    .group(:employee_id, :job_group, :biweekly_start_date, :biweekly_end_date)
    .order(:employee_id, :biweekly_start_date)

    report_list = []
    grouped_employee_timesheet.each do |group_employee_timesheet|
      report_list << ItemData::EmployeeBiweeklyPayrollReport.new(
        employee_id: group_employee_timesheet.employee_id, 
        biweekly_start_date: group_employee_timesheet.biweekly_start_date, 
        biweekly_end_date: group_employee_timesheet.biweekly_end_date, 
        amount_paid: calculate_total_amount(group_employee_timesheet.job_group, group_employee_timesheet.total_hours)
      )
    end
    
    report_list
  end

  private

  def calculate_total_amount(job_group, hours_worked)
    if job_group == 'A'
      hours_worked * Money.new(2000, 'USD')
    elsif job_group == 'B'
      hours_worked * Money.new(3000, 'USD')
    end  
  end
end  