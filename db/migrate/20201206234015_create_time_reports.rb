class CreateTimeReports < ActiveRecord::Migration[6.0]
  def change
    create_table :time_reports do |t|
      t.string :time_report_name
      t.integer :time_report_id
      t.string :time_report_upload_status

      t.timestamps
    end
  end
end
