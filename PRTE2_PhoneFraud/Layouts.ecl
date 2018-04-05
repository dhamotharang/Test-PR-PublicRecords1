IMPORT PhoneFraud;

EXPORT Layouts := MODULE
 
	 EXPORT layout_phonefraud_otp_base_in := PhoneFraud.Layout_OTP.Base;
	 EXPORT layout_phonefraud_spoofing_base_in := PhoneFraud.Layout_Spoofing.Base;
	 
		//phonefraud otp base in plus additional fields to save off original values before the update
		EXPORT layout_phonefraud_otp_base_ext	:= RECORD	
			layout_phonefraud_otp_base_in;
			string8 	orig_event_date;
			string6 	orig_event_time;
		END;

		//phonefraud spoofing base in plus additional fields to save off original values before the update
		EXPORT layout_phonefraud_spoofing_base_ext	:= RECORD	
			layout_phonefraud_spoofing_base_in;
			string8 	orig_event_date;
			string6 	orig_event_time;
		END;

 END;