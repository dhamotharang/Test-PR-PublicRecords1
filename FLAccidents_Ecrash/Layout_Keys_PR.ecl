EXPORT Layout_Keys_PR  := MODULE
  
	EXPORT DID := RECORD
    UNSIGNED6 l_did;
		STRING40 accident_nbr;
		STRING30 vin;
		STRING40 orig_accnbr;
  END;
  
	EXPORT VIN := RECORD
    STRING30 l_vin;
		STRING40 accident_nbr;
		STRING40 orig_accnbr;
  END;	
END;