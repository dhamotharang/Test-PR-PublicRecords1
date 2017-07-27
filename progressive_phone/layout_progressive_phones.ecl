IMPORT iesp;

EXPORT layout_progressive_phones := MODULE

	EXPORT Phone_Last3Digits := RECORD
	    STRING3 digits;
  END;

EXPORT layout_exp_multiple_phones := RECORD
		progressive_phone.layout_experian_phones;
		DATASET(Phone_Last3Digits) Phones_Last3Digits{maxcount(iesp.Constants.MaxCountLast3Digits)};	
	END;
	
END;