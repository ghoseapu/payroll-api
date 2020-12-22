class TimesheetController < ApplicationController
  def create
    file = params[:file]

    unless /time-report-\d+.csv/.match file.original_filename
      render json: {error: 'Invalid filename pattern. Example of correct file name: time-report-x.csv, where x is a number representing time report ID'}, status: 400 and return
    end  

    report_id = file.original_filename.split('-').last

    if TimeReport.exists?(time_report_id: report_id)
      render json: {error: "Not permitted: #{file.original_filename} has already been uploaded."}, status: 400 and return
    end  

    file_path = Rails.root.to_s + "/#{file.original_filename}"
    
    TimesheetUploader.new.import(file_path)

    time_report = TimeReport.create(
      time_report_upload_status: TimeReport.upload_statuses[:success],
      time_report_id: report_id,
      time_report_name: file.original_filename  
    )
    
    render json: { time_reports_id: time_report.id}
  end  
end  