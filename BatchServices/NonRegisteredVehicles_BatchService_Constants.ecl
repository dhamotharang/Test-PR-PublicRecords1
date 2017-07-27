EXPORT NonRegisteredVehicles_BatchService_Constants := MODULE

  // SearchTimeInMonths input option values
  export unsigned1 SIXMONTHS        := 6;
  export unsigned1 TWELVEMONTHS     := 12;   // default
  export unsigned1 TWENTYFOURMONTHS := 24;
	
  // SearchMVR input option values
  export string2 INHOUSE_FIRST        := 'IF';  // default
	export string2 INHOUSE_AND_REALTIME := 'IR';
	export string2 INHOUSE_ONLY         := 'IH';
  export string2 REALTIME_ONLY        := 'RT';

  // "Early_date" calculation related values
	export unsigned2 DAYSIN_6MONTHS  := 183; // rounded up from 365/2 = 182.5
	export unsigned2 DAYSIN_12MONTHS := 365;
	export unsigned2 DAYSIN_24MONTHS := 730;

  // Output hit_flag values
	export string7 NO_HIT         := 'NO';
	export string7 OUTOFSTATE_REG := 'NON-REG';
	export string7 INSTATE_REG    := 'REG';
	export string7 REJECTED_REC   := 'REJ';

  // Join related limits
	export unsigned2 JOIN_LIMIT        := 10000; 
  export unsigned2 JOIN_LIMIT_UNLMTD := 0;
  export unsigned2 KEEP_LIMIT_HDR    := 10000;

  // RT MVR gateway input transform values
  export unsigned1 USE_BEST := 1;
  export unsigned1 USE_PREV := 2;

END; // END of the MODULE