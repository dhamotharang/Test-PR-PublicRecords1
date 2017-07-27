EXPORT File_Spoofing := MODULE

	EXPORT Raw 			:= dataset('~thor_data400::in::phonefraud_spoofing_daily', 		PhoneFraud.Layout_Spoofing.Raw, csv(quote('|'),separator(['\t']), terminator(['\r\n', '\n'])));
	EXPORT History 	:= dataset('~thor_data400::in::phonefraud_spoofing_history', 	PhoneFraud.Layout_Spoofing.Raw, flat);
	EXPORT Base 		:= dataset('~thor_data400::base::phonefraud_spoofing', 				PhoneFraud.Layout_Spoofing.Base,flat);

END;
