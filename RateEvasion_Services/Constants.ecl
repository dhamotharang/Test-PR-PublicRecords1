
export Constants := MODULE

	export MAX_RECS_ON_JOIN   := 1000;
	
	// Vehicle party file orig_name_type field codes
	export string1 OWNER      := '1';
	export string1 REGISTRANT := '4';
  export string1 LIENHOLDER := '7';
	
	// Vehicle party file history field codes
	export string1 EXPIRED    := 'E';
	export string1 HISTORY    := 'H';

  // Default scoring values
  export integer1 DEF_START_SCORE  := 00;
  export integer1 DEF_FN_MATCH     := 10; // per Seth Perlmutter, Aug 17, 2009
	export integer1 DEF_FN_NOMATCH   := 10; // per Seth Perlmutter, Aug 17, 2009
	export integer1 DEF_FN_MISSING   := 5;
  export integer1 DEF_LN_MATCH     := 30; // per Seth Perlmutter, Aug 17, 2009
	export integer1 DEF_LN_NOMATCH   := 30; // per Seth Perlmutter, Aug 17, 2009
	export integer1 DEF_LN_MISSING   := 10;
  export integer1 DEF_ADDR_MATCH   := 20;
	export integer1 DEF_ADDR_NOMATCH := 20;
	export integer1 DEF_ADDR_MISSING := 15;
  export integer1 DEF_CITY_MATCH   := 00;
	export integer1 DEF_CITY_NOMATCH := 00;
	export integer1 DEF_CITY_MISSING := 05;
  export integer1 DEF_ST_MATCH     := 00;
	export integer1 DEF_ST_NOMATCH   := 00;
	export integer1 DEF_ST_MISSING   := 20;
  export integer1 DEF_ZIP_MATCH    := 15;
	export integer1 DEF_ZIP_NOMATCH  := 10;
	export integer1 DEF_ZIP_MISSING  := 20;
  export integer1 DEF_SSN_MATCH    := 20;
	export integer1 DEF_SSN_NOMATCH  := 20;
	export integer1 DEF_SSN_MISSING  := 05;
  export integer1 DEF_DOB_MATCH    := 05;
	export integer1 DEF_DOB_NOMATCH  := 10;
	export integer1 DEF_DOB_MISSING  := 10;
  export integer1 DEF_PHN_MATCH    := 00; // per Seth Perlmutter, Aug 17, 2009
	export integer1 DEF_PHN_NOMATCH  := 00; // per Seth Perlmutter, Aug 17, 2009
	export integer1 DEF_PHN_MISSING  := 00; // per Seth Perlmutter, Aug 17, 2009
	
  // MAIF default scoring values.
	// May not be needed if scoring info can be passed-in to roxie, but Claudio Amaral still
	// needs to decide on the input scoring info xml structure.
	// These default values match the values in score_1031131.xml which Scott Schneck 
	// extracted from SYBASE on 09/22/2009 and emailed to me (Dave Wright).
	export string7  MAIF_COMPANY_ID   := '1031131';
  export integer1 MAIF_START_SCORE  := 00;
  export integer1 MAIF_FN_MATCH     := 05;
	export integer1 MAIF_FN_NOMATCH   := 00;
	export integer1 MAIF_FN_MISSING   := 00;
  export integer1 MAIF_LN_MATCH     := 15;
	export integer1 MAIF_LN_NOMATCH   := 00;
	export integer1 MAIF_LN_MISSING   := 00;
  export integer1 MAIF_ADDR_MATCH   := 20;
	export integer1 MAIF_ADDR_NOMATCH := 00;
	export integer1 MAIF_ADDR_MISSING := 00;
  export integer1 MAIF_CITY_MATCH   := 00;
	export integer1 MAIF_CITY_NOMATCH := 00;
	export integer1 MAIF_CITY_MISSING := 00;
  export integer1 MAIF_ST_MATCH     := 25;
	export integer1 MAIF_ST_NOMATCH   := 00;
	export integer1 MAIF_ST_MISSING   := 00;
  export integer1 MAIF_ZIP_MATCH    := 25;
	export integer1 MAIF_ZIP_NOMATCH  := 00;
	export integer1 MAIF_ZIP_MISSING  := 00;
  export integer1 MAIF_SSN_MATCH    := 00;
	export integer1 MAIF_SSN_NOMATCH  := 05;
	export integer1 MAIF_SSN_MISSING  := 05;
  export integer1 MAIF_DOB_MATCH    := 03;
	export integer1 MAIF_DOB_NOMATCH  := 05;
	export integer1 MAIF_DOB_MISSING  := 05;
  export integer1 MAIF_PHN_MATCH    := 07;
	export integer1 MAIF_PHN_NOMATCH  := 05;
	export integer1 MAIF_PHN_MISSING  := 05;
	
END;