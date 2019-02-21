EXPORT File_OTP := MODULE

	//Base File	
	EXPORT Main 	:= dataset('~thor_data400::base::phones::otp_main', PhonesInfo.Layout_Common.Phones_Transaction_Main, flat);

END;