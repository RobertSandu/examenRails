class CerereConcediu < ActiveRecord::Base
	belongs_to :user

	validate :ver_data_inceput_data_sfarsit
	validate :ver_data_inceput_maine
	validate :ver_data_inceput_lucratoare
	validate :ver_data_sfarsit_lucratoare
	validate :ver_are_zile_concediu

	private

	def ver_data_inceput_data_sfarsit
    	errors.add(:data_inceput, "data inceput trebuie sa fie mai mare sau egala cu data de sfarsit") unless
        	data_inceput < data_sfarsit
	end 

	def ver_data_inceput_maine
		errors.add(:data_inceput, "data inceput trebuie sa fie cel putin ziua urmatoare") unless 
			not data_inceput < Date.tomorrow		
	end

	def ver_data_inceput_lucratoare
		errors.add(:data_inceput, "data inceput trebuie sa fie o zi lucratoare") unless 
			not data_inceput.saturday? or data_inceput.sunday?
	end

	def ver_data_sfarsit_lucratoare
		errors.add(:data_sfarsit, "data sfarsit  trebuie sa fie o zi lucratoare") unless 
			not data_sfarsit.saturday? or data_sfarsit.sunday?
	end

	def ver_are_zile_concediu

	    business_days = 0
	    date = data_sfarsit
	    while date > data_inceput
	     business_days = business_days + 1 unless date.saturday? or date.sunday?
	     date = date - 1.day
	    end

	    if business_days > 20
			errors.add(:data_sfarsit, "nu ai suficient zile de concediu disponibile")
	    end
	end
end
