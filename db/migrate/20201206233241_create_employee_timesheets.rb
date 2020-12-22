class CreateEmployeeTimesheets < ActiveRecord::Migration[6.0]
  def change
    create_table :employee_timesheets do |t|
      t.date :date
      t.date :biweekly_start_date
      t.date :biweekly_end_date
      t.float :hours_worked
      t.integer :employee_id
      t.string :job_group

      t.timestamps
    end
  end
end
