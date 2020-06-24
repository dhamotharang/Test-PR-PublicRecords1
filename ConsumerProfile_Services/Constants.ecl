IMPORT iesp;

EXPORT Constants := MODULE
	export MAX_SEEDS_REC 	:= 25;
	
// the Risk 5.0 reason codes 	
  export Reason_Codes := module
		export string S65 := 'S65';
		export string F04 := 'F04';
		export string F00 := 'F00';
		export string F03 := 'F03';
	end;
	
	export SSN_HRI := module
		export string DECEASED := '02';
		export string ISSUED_PRIOR_DOB := '03';
		export string INVALID := '06';
		export string RECENTLY_ISSUED := '39';
		export string MISSING := '79';
		export string NON_US := '85';
		export string ISSUED_AFTER_5 := '90';
	end;

	export Address_HRI := module
		export string UNABLE_TO_VERIFY := '25';
		export string VERIFIED_BUT_NOT_PRIMARY := '99';
	end;
	
	export SSN_INFO := module
		export VALID := 'true';
		export INVALID := 'false';
	end;
	
	export ADDRESS_VERIFICATION := module
		export set of unsigned1 NO_MATCH := [0, 1, 2, 4, 7, 9];
		export set of unsigned1 MATCH := [3, 5, 6, 8, 10, 11, 12];
		export string DESCRIPTION(unsigned1 c) := map(
						c in NO_MATCH => 	'Address not on file for the LexID',
						c in MATCH		=>	'Address is on file for the LexID',
						'');
	end;
	
	export DOB_VERIFICATION := module
  export set of string1 NO_DOB := ['0'];
		export set of string1 NO_MATCH := ['1'];
		export set of string1 PARTIAL_MATCH := ['2', '3', '4', '5', '6', '7'];
		export set of string1 MATCH := ['8'];
		export string DESCRIPTION(string1 c) := map(
      c in NO_DOB => 'No DOB input or No DOB found',
						c in NO_MATCH 			=> 	'No DOB Match',
						c in PARTIAL_MATCH	=>	'Partial DOB Match',
						c in MATCH					=>	'Full DOB Match',
						'');
	end;
	
	export PHONE_VERIFICATION := module
		export set of unsigned1 NO_ADDR_MATCH := [0, 2, 3, 5, 8]; //in NAP_Summary
		export set of unsigned1 ADDRESS_MATCH := [6, 10, 11, 12]; //in NAP_Summary
		export string DESCRIPTION(unsigned1 c) := map(
						c in NO_ADDR_MATCH 			=> 	'No Phone Matches Address',
						c in ADDRESS_MATCH			=>	'Phone Matches Address',
						'');
	end;
	
END;