IMPORT PRTE2_Email_Data, email_data;

EXPORT Layouts := MODULE

		EXPORT incoming_boca := record
				Email_Data.Layout_Email.Scrubs_bits_base - [scrubsbits1];
				string9 ssn;				//*future use for did process
				string8 dob;				//*future use for did process
				string 	cust_name;
				string 	bug_name;
		END;		
		   
		EXPORT incoming_alpha := record
			 Email_Data.Layout_Email.Scrubs_bits_base - [scrubsbits1];
		END;
		
		EXPORT base := record
				Email_Data.Layout_Email.Scrubs_bits_base;
				string9 	ssn;				//*future use for did process
				string8 	dob;				//*future use for did process
				string 		cust_name;
				string 		bug_name;
				string10	date_aging_ind;
		END;
		
		// The build process uses this layout in preparation
		EXPORT keyRec := record
	    Email_Data.Layout_Email.Keys;
		END;

		// The build process uses this layout in preparation
		EXPORT Autokey_layout := RECORD
			Email_Data.Layout_email.Autokey_layout;
		END;
END;