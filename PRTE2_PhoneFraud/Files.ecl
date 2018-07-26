EXPORT Files := module

			//infiles are the base files that are currently in production at the time of the build
			EXPORT phonefraud_otp_base_in							:= dataset(Constants.in_phonefraud_otp, Layouts.layout_phonefraud_otp_base_in, flat);
			EXPORT phonefraud_spoofing_base_in 	:= dataset(Constants.in_phonefraud_spoofing, Layouts.layout_phonefraud_spoofing_base_in, flat);
			
			EXPORT phonefraud_otp_base 			 	:= dataset(Constants.base_phonefraud_otp, Layouts.layout_phonefraud_otp_base_ext,flat);
			EXPORT phonefraud_spoofing_base	:= dataset(Constants.base_phonefraud_spoofing, Layouts.layout_phonefraud_spoofing_base_ext,flat);
	
END;