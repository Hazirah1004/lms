class PostMailer < ActionMailer::Base

	def reg_user(user)
		mail(to: user.email,
			from: "admin@restu-lms.com",
			subject: "Succesful Register"
			)
	end

		def apprv_user(user)
		mail(to: user.email,
			from: "admin@restu-lms.com",
			subject: "Leave Approval"
			)
	end
end