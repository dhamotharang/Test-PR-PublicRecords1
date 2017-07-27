export MatchCodes := MODULE
	export string1 name		:= 'N'; 	/*	Name/AKA/Business/DBA 			*/
	export string1 ssn_full := 'S'; 	/*	Full SSN						*/
	export string1 ssn_red  := 'R';		/*	Redacted SSN					*/
	export string1 ssn_prob := 'P'; 	/*	Probable SSN					*/
	export string1 addr		:= 'A';		/* 	Street Address/Address History	*/
	export string1 city		:= 'C';		/* 	City+State/Address History		*/
	export string1 zip		:= 'Z';		/* 	Zip Code/Address History		*/
	export string1 did		:= 'L';		/*  ADL 							*/
	
  // SSN + partial name match codes
	export string1 last_fi   := 'V';	/* full last name + first initial */
	export string1 lastname  := 'W';	/* full last name */
	export string1 first_li  := 'X';	/* full first name + last initial */
	export string1 firstname := 'Y';	/* full first name */
	export string mc_include_partial_name := 'SV,SVC,SVZ,SVZC,SVA,SVAC,SVAZ,SVAZC,SW,SWC,SWZ,SWZC,SWA,SWAC,SWAZ,SWAZC,SX,SXC,SXZ,SXZC,SXA,SXAC,SXAZ,SXAZC,SY,SYC,SYZ,SYZC,SYA,SYAC,SYAZ,SYAZC';
	
	 /* list of matchcodes to return 	*/
	//export string default_mcs := 'ANSZC,ANSC,ANSZ,ANS,ANZC,ANC,ANZ,SAZC,ANZC,SNC,SNZ,SAZ,SZC,SN,SA,SC,SZ,S,ANPZC,ANPC,ANPZ,ANP,PAZC,PNZC,PNC,PNZ,PAZ,PZC,PN,PZ,ANRZC,ANRC,ANRZ,ANR,RAZC,RNZC,RNC,RNZ,RAZ,RN,L';
	export string default_includes := '';
	
	export stripN_list_mname := ['RNZC','PN','PNC','PNZ','ANR','ANRC','ANRZ'];
	
	export stripN_list_sffix := ['N','NC','NZ','NZC','SN','SNC','SNZ','SNZC',
										'AN','ANC','ANZ','ANZC','ANS','ANSC','ANSZ','ANSZC',
										'RN','RNZC','PN','PNC','PNZ','PNZC',
										'ANR','ANRC','ANRZ','ANRZC','ANP','ANPC','ANPZ','ANPZC'];
										
	export filt_list_inits 	:= ['PZ','PZC','RAZ','PAZ'];
	
	export STRING1 DEBTOR_BUSINESS_FLAG := 'B';
	
	export string1 delim := ',';		/* delimiter used in match code list */
END;

