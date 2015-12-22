class Manager < ActiveRecord::Base

	#before_save { |manager| manager.dept_id = (Employee.find(employee_id)).dept_id }
end
