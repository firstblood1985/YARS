module ApplicationHelper
	def clear_flash
		flash[:warning] = nil
		flash[:notice] = nil
	end
end
