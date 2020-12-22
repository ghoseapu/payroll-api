# Payroll API

## Project Description

Imagine that we are prototyping a new payroll system API. A front end (that hasn't been developed yet, but will likely be a single page application) is going to use our API to achieve two goals:

1. Upload a CSV file containing data on the number of hours worked per day per employee
1. Retrieve a report detailing how much each employee should be paid in each _pay period_

All employees are paid by the hour (there are no salaried employees.) Employees belong to one of two _job groups_ which determine their wages; job group A is paid $20/hr, and job group B is paid $30/hr. Each employee is identified by a string called an "employee id" that is globally unique in our system.

Hours are tracked per employee, per day in comma-separated value files (CSV).
Each individual CSV file is known as a "time report", and will contain:

1. A header, denoting the columns in the sheet (`date`, `hours worked`, `employee id`, `job group`)
1. 0 or more data rows

In addition, the file name should be of the format `time-report-x.csv`,
where `x` is the ID of the time report represented as an integer. For example, `time-report-42.csv` would represent a report with an ID of `42`.

Assumption:

1. Columns will always be in that order.
1. There will always be data in each column and the number of hours worked will always be greater than 0.
1. There will always be a well-formed header line.
1. There will always be a well-formed file name.

Sample input file name: `time-report-42.csv` 

### What this API does:

We've agreed to build an API with the following endpoints to serve HTTP requests:

1. An endpoint for uploading a file.

   - This file will conform to the CSV specifications outlined in the previous section.
   - Upon upload, the timekeeping information within the file must be stored to a database for archival purposes.
   - If an attempt is made to upload a file with the same report ID as a previously uploaded file, this upload should fail with an error message indicating that this is not allowed.

1. An endpoint for retrieving a payroll report structured in the following way:

   _NOTE:_ It is not the responsibility of the API to return HTML, as we will delegate the visual layout and redering to the front end. The expectation is that this API will only return JSON data.

   - Return a JSON object `payrollReport`.
   - `payrollReport` will have a single field, `employeeReports`, containing a list of objects with fields `employeeId`, `payPeriod`, and `amountPaid`.
   - The `payPeriod` field is an object containing a date interval that is roughly biweekly. Each month has two pay periods; the _first half_ is from the 1st to the 15th inclusive, and the _second half_ is from the 16th to the end of the month, inclusive. `payPeriod` will have two fields to represent this interval: `startDate` and `endDate`.
   - Each employee should have a single object in `employeeReports` for each pay period that they have recorded hours worked. The `amountPaid` field should contain the sum of the hours worked in that pay period multiplied by the hourly rate for their job group.
   - If an employee was not paid in a specific pay period, there should not be an object in `employeeReports` for that employee + pay period combination.
   - The report should be sorted in some sensical order (e.g. sorted by employee id and then pay period start.)
   - The report should be based on all _of the data_ across _all of the uploaded time reports_, for all time.

   As an example, given the upload of a sample file with the following data:

    <table>
    <tr>
      <th>
        date
      </th>
      <th>
        hours worked
      </th>
      <th>
        employee id
      </th>
      <th>
        job group
      </th>
    </tr>
    <tr>
      <td>
        2020-01-04
      </td>
      <td>
        10
      </td>
      <td>
        1
      </td>
      <td>
        A
      </td>
    </tr>
    <tr>
      <td>
        2020-01-14
      </td>
      <td>
        5
      </td>
      <td>
        1
      </td>
      <td>
        A
      </td>
    </tr>
    <tr>
      <td>
        2020-01-20
      </td>
      <td>
        3
      </td>
      <td>
        2
      </td>
      <td>
        B
      </td>
    </tr>
    <tr>
      <td>
        2020-01-20
      </td>
      <td>
        4
      </td>
      <td>
        1
      </td>
      <td>
        A
      </td>
    </tr>
    </table>

   A request to the report endpoint should return the following JSON response:

   ```javascript
   {
     payrollReport: {
       employeeReports: [
         {
           employeeId: 1,
           payPeriod: {
             startDate: "2020-01-01",
             endDate: "2020-01-15"
           },
           amountPaid: "$300.00"
         },
         {
           employeeId: 1,
           payPeriod: {
             startDate: "2020-01-16",
             endDate: "2020-01-31"
           },
           amountPaid: "$80.00"
         },
         {
           employeeId: 2,
           payPeriod: {
             startDate: "2020-01-16",
             endDate: "2020-01-31"
           },
           amountPaid: "$90.00"
         }
       ];
     }
   }
   ```

We consider ourselves to be language agnostic here at Wave, so feel free to use any combination of technologies you see fit to both meet the requirements and showcase your skills. We only ask that your submission:

- Is easy to set up
- Can run on either a Linux or Mac OS X developer machine
- Does not require any non open-source software

### Documentation:

1. Instructions on how to build/run this application

ruby 2.7.2 has been used to develop this application. sqlite has been ussed for relational database prerequisites

To run this project one should have Ruby on Rails setup in his/her machine.

Use Git Bash or cmd to run this application:

Step 1: Go to project location using Git Bash
Example: cd /f/myrails/payroll-report
Step 2: run "bundle install"
Example: bundle install
Step 3: run "rails db:setup"
Example: rails db:setup
Step 4: run "RAILS_ENV=test rails db:setup" (Ref. https://github.com/rspec/rspec-rails)
Example: RAILS_ENV=test rails db:setup
Step 5: run "rspec" (for unit test)
Example: rspec
Step 6: run "rails s"
Example: rails s
Step 7: Visit "http://localhost:3000/payroll_report" in your browser to get json object
Step 8: Open another Git Bash window and go to project location
Example: cd /f/myrails/payroll-report
Step 9: Place your csv file in the root folder
Example: Copy your csv file from your drive to the project root folder (In my case, I placed it inside "F:/myrails/payroll-report" folder)
Step 10: run curl -F "file=@time-report-x.csv" localhost:3000/timesheet to upload file, where x is a number
Example: curl -F "file=@time-report-43.csv" localhost:3000/timesheet
Step 11: Refresh your browser (http://localhost:3000/payroll_report) to get updated json object


2. Questions/Answers:
   - How did I test that my implementation was correct?
   1. used a testing framework named "rspec-rails"
   2. tested manually by uploading different valid and invalid csv files and visiting http://localhost:3000/payroll_report
   - If this application was destined for a production environment, what would I add or change?
   1. use PostgreSQL or MySQL
   2. use primary key in the table
   3. check additional use cases while uploading file (incorrect names and order of headers, invalid column values, absence of headers, blank csv file, blank columns in between, duplicate data, etc.)
   4. use CICD pipeline for running unit tests while committing
   - What compromises did I have to make as a result of the time constraints of this challenge?
   1. did not give extra effort on additinal use cases while uploading file (incorrect names and order of headers, invalid column values, absence of headers, blank csv file, blank columns in between, duplicate data, etc.)
   2. did not work on handling large csv file import