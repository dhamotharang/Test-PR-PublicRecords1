export consts := MODULE
	// LAYOUT ROLLUP CONSTANTS
	export NAMES_PER_PARTY := 5;
	export ADDRESSES_PER_PARTY := 5;
	export PHONES_PER_PARTY := 5;
	export EMAILS_PER_PARTY := 5;
	export PARTIES_PER_ROLLUP := 10;
	export STATUSES_PER_ROLLUP := 20;
	export COMMENTS_PER_ROLLUP := 20;
	export DOCKETS_PER_ROLLUP	:= 10000;
	// last 4 digits of SSN search
	export MAX_SSN4 := 3000;
  export MAX_PER_COURT_CASE_LOOKUP := 1;  // There should only be 1 record per court ID / case number lookup
  export KEEP_LIMIT := 1000;
  export string2 CASETYPE_BANKRUPTCY := 'BK';
  
  /*  From Data Fab: T - represents Trustee A1 - attorney1, 
      A2 - attorney2, T1 - trustee1, D - Debtor.  
      The code is usually uses name_type[1] to look for A,T,D.  */
  export NAME_TYPES := 
      module
        export string1	ATTORNEY := 'A';
        export string1	DEBTOR   := 'D';
        export string1	TRUSTEE  := 'T';
		  end;
			
  export SET of STRING2 DEBTOR_TYPES := ['P','S','PA','SA'];
END;  