class TimeReport < ActiveRecord::Base
  enum upload_status: { success: 'success' }
end  
