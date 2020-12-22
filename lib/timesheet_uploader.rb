require 'csv'

class TimesheetUploader
  def import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      date = Date.parse(row["date"])
      if date.day <= 15
        biweekly_start_date = Date.new(date.year, date.month, 1)
        biweekly_end_date = Date.new(date.year, date.month, 15)
      else
        biweekly_start_date = Date.new(date.year, date.month, 16)
        biweekly_end_date = Date.new(date.year, date.month, -1)  
      end  

      employee_timesheet = EmployeeTimesheet.new(
        date: date,
        biweekly_start_date: biweekly_start_date,
        biweekly_end_date: biweekly_end_date,
        hours_worked: row["hours worked"],
        employee_id: row["employee id"],
        job_group: row["job group"] 
      )

      employee_timesheet.save!
    end
  end  
end  