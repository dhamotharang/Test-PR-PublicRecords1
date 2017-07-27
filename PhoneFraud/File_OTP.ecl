EXPORT File_OTP := MODULE

	EXPORT Raw 				:= dataset('~thor_data400::in::phonefraud_otp_daily', 		PhoneFraud.Layout_OTP.Raw, csv(quote('|'),separator(['\t']), terminator(['\r\n', '\n'])));
	EXPORT History 		:= dataset('~thor_data400::in::phonefraud_otp_history', 	PhoneFraud.Layout_OTP.Raw, flat);
	EXPORT Base 			:= dataset('~thor_data400::base::phonefraud_otp', 				PhoneFraud.Layout_OTP.Base,flat);
	
END;