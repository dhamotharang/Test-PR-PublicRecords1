EXPORT Layout_american_student_suppression := MODULE

	// EXPORT raw := RECORD			//layout of initial file
		// STRING         FULL_NAME;
		// STRING         ADDRESS_1;
		// STRING         CITY;
		// STRING         STATE;
		// STRING         Z5;
		// STRING         ZIP_4;
		// STRING         CRRT_CODE;
		// STRING         FIRST_NAME;
		// STRING         LAST_NAME;
	// END;

	EXPORT raw := RECORD
		STRING24         FULL_NAME;
		STRING24         ADDRESS_2;
		STRING24         ADDRESS_1;
		STRING16         CITY;
		STRING2	         STATE;
		STRING5	         Z5;
		STRING4	         ZIP_4;
		STRING1	         LF;
	END;
	
	// EXPORT base := RECORD
		// UNSIGNED4      DATE_FIRST_SEEN;
		// UNSIGNED4      DATE_LAST_SEEN;
		// UNSIGNED4      DATE_VENDOR_FIRST_REPORTED;
		// UNSIGNED4      DATE_VENDOR_LAST_REPORTED;
		// STRING5	       Z5;
		// STRING24       NAME;
		// STRING50       ADDRESS_1;											//The initial suppression file has only address_1 and no address_2
		// STRING24       ADDRESS_2;
		// STRING16       CITY;
		// STRING2	       STATE;
		// STRING4	       ZIP_4;
	// END;
	
	EXPORT base := RECORD
		UNSIGNED4      DATE_FIRST_SEEN;
		UNSIGNED4      DATE_LAST_SEEN;
		UNSIGNED4      DATE_VENDOR_FIRST_REPORTED;
		UNSIGNED4      DATE_VENDOR_LAST_REPORTED;
		UNSIGNED6      RCID;
		STRING24       FULL_NAME;
		STRING50       ADDRESS_1;											//The initial suppression file has only address_1 and no address_2
		STRING24       ADDRESS_2;
		STRING16       CITY;
		STRING2	       STATE;
		STRING5	       Z5;
		STRING4	       ZIP_4;
	END;
	
END;