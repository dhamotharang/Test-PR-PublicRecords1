EXPORT Layout_Keys_PR  := MODULE
  
	EXPORT DID := RECORD
    UNSIGNED6 l_did;
		STRING40 accident_nbr;
		STRING30 vin;
		STRING40 orig_accnbr;
    STRING4 report_code;
    STRING100 jurisdiction;
    STRING2 jurisdiction_state;
    STRING11 jurisdiction_nbr;
		STRING2 vehicle_incident_st;
  END;
  
	EXPORT VIN := RECORD
    STRING30 l_vin;
		STRING40 accident_nbr;
		STRING40 orig_accnbr;
    STRING4 report_code;
    STRING100 jurisdiction;
    STRING2 jurisdiction_state;
    STRING11 jurisdiction_nbr;
		STRING2 vehicle_incident_st;
  END;	
END;