class Students::OmniauthCallbacksController < ApplicationController
	def facebook
		#raise params.to_yaml
		#raise request.env["omniauth.auth"].to_yaml
		@student = Student.from_omniauth(request.env["omniauth.auth"])
		if @student.persisted?
			@student.remember_me = true
			sign_in_and_redirect @student, event: :authentication
			return
		end
		session["devise.auth"] = request.env["omniauth.auth"]
		render :edit
	end

	


	def custom_sign_up
		@student = Student.from_omniauth(session["devise.auth"])

		if @student.update(student_params)
			sign_in_and_redirect @student, event: :authentication
		else
			render :edit
		end
	end
	private
		def student_params
			params.require(:student).permit(:name,:apellido_pat,:apellido_mat,:curp,:no_control,:email)
		end
end