class ExpendituresController < ApplicationController
	def index
		@user = current_user
		@expenditures = current_user.expenditures.all
	end

	def create
		@expenditure = Expenditure.new(expenditure_params)
		
		if @expenditure.save
			current_user.expenditures << @expenditure
			current_user.save
			redirect_to expenditures_path
		else
			render 'new'
		end
	end

	def new
		@expenditure = Expenditure.new
	end

	def destroy
		@expenditure = Expenditure.find params[:id]
		@expenditure.destroy

		redirect_to expenditures_path
	end

	private
	def expenditure_params
		params.require(:expenditure).permit(:name, :price)
	end

end
