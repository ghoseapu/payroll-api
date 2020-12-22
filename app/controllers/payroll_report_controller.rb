class PayrollReportController < ApplicationController
  def index
    reports = PayrollGenerator.new.report
    json_report = reports.map(&:to_json)
    render json: { 
      payrollReport: {
        employeeReports: json_report
      } 
    }
  end 
end  