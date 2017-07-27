IMPORT AutoKeyI;
EXPORT Constants := MODULE
	EXPORT MAX_RECS_PERDID    := 100;
	EXPORT MAX_RECS_PERID     := 100;
	EXPORT MAX_DEEP_DIVE_DIDS := 100;
	EXPORT MAX_IDS_PER_ACCTNO := 2000;
	// Max number of records per acctno allowed
	// Same as iesp max number of records per search
	EXPORT MAX_RECORDS_PER_ACCTNO   := 60;
	// Max number of records per acctno allowed for match search by DID
	EXPORT MAX_DEEP_DIVE_PER_ACCTNO := 1;
	EXPORT MAX_RECS_EXCEPTIONS      := 1;
	// Max sort_rank allowed for match searches
	EXPORT MAX_SORT_RANK_MATCHES := 100;
	EXPORT MAX_AGE_ADL_BEST			 := 18;
	EXPORT MIN_ADL_SCORE				 := 75;

	// Matchcodes
	EXPORT STRING1 STR_MATCH_NAME                := 'N';
	EXPORT STRING1 STR_MATCH_SSN                 := 'S';
	EXPORT STRING1 STR_MATCH_PROB_SSN            := 'P';
	EXPORT STRING1 STR_MATCH_DOB                 := 'D';
	EXPORT STRING1 STR_MATCH_PROB_DOB            := 'B';
	EXPORT STRING1 STR_MATCH_ADDR                := 'A';
	EXPORT STRING1 STR_MATCH_CITY_STATE          := 'C';
	EXPORT STRING1 STR_MATCH_ZIP                 := 'Z';
	EXPORT STRING1 STR_MATCH_LNAME_PARTIAL_FNAME := 'V';
	EXPORT STRING1 STR_MATCH_LNAME               := 'W';

	// Program code constants
	EXPORT SET OF STRING1 SNAP_DSNAP_SET := ['S', 'D']; //nac1 & nac2 - S and D records should find/exclude each other
	EXPORT SET OF STRING1 PROGRAM_SET :=[  // NAC - National Accuracy Clearinghouse, LexisNexis Product
																				 // HHS - Health and Human Services programs
																		/*01*/ 'S' // 'S'NAP         - Supplemental Nutrition Assistance Program (food stamps)
																		/*02*/,'D' // 'D'-SNAP       - Disaster Supplemental Nutrition Assistance Program (food stamps)
																		/*03*/,'T' // 'T'ANF         - Temporary $ Assistance $ for Needy Families
																		/*04*/,'M' // 'M'edicaid     - Medical Aid based on income
																		/*05*/,'P' // CHI'P'         - Children's Health Insurance Program
																		/*06*/,'C' // 'C'C           - Child Care 
																		/*07*/,'I' // SSNP - W'I'C   - Special Supplemental Nutrition Program for Women, Infants, and Children
																		/*08*/,'N' // 'N'SLP         - National School Lunch Program (and all Child Nutrition programs (CACFP))
	                            			/*17*/,'U' // 'U'I           - Unemployment Insurance (DOL - department of labor)
																		/*18*/,'W' // 'W'C           - Workers Compensation & Disability
																		/*19*/,'H' // 'H'UD          - Housing & Urban Developement (Public Housing Assistance) 
																	  /*20*/,'V' // DM'V'          - Drivers License (Vehicles)
																			 ];													      
  // ProgramsAllowed   S  D  T  M  P  C  I  N  ....  U  W  H  V  ....	
	// String position  01 02 03 04 05 06 07 08  ....  17 18 19 20 ....32
	// Do NOT alter the ProgramsAllowed string below since it is used in NAC_V2_Services.IParams.dynamicSet
	EXPORT STRING32 ProgramsAllowed := 'SDTMPCIN        UWHV            ';
	// Input Examples - 
  // ProgramsAllowedSearch := '00000010000000000000000000000000';// Will mask all programs except I
  // ProgramsAllowedReturn := '00000000000000000001000000000000';//	Will mask all programs except V

	// Used for investigative only where we allow wild card searches for ALL programs when IsOnline=TRUE
	EXPORT STRING1 _ALL := '*';

	EXPORT STRING1 ELI_PERIOD_MONTH := 'M'; // Input dates formatted as - YYYYMM 
	       STRING1 ELI_PERIOD_DAY   := 'D'; // Input dates formatted as - YYYYMMDD
	EXPORT SET OF STRING1 ELI_PERIOD_SET := [ELI_PERIOD_MONTH, ELI_PERIOD_DAY]; 

	// Eligibility constants
	//'A' - Applicant
	//'D' - Disqualified
	//'E' - Eligible
	//'I' - Ineligible Alien
	//'N' - Not Eligible - the latest NAC2 keys should no longer contain N records
	EXPORT STRING1 NO_BENEFIT_RECEIVED := 'N'; //NAC2 data should no longer have N records but just in case
	EXPORT STRING1 ELIGIBLE := 'E';

	// Error codes used
	SHARED err := AutoKeyI.errorcodes._codes;//          301                   303              101    
	EXPORT SET OF UNSIGNED SET_Input_Errors	 := [err.INSUFFICIENT_INPUT, err.INVALID_INPUT, err.CONFIG_ERR];
																			     //          203                   10
	EXPORT SET OF UNSIGNED SET_Output_Errors := [err.TOO_MANY_SUBJECTS, err.NO_RECORDS];
	EXPORT SET OF UNSIGNED ERROR_CODES_SET   := SET_Input_Errors+SET_Output_Errors;

	// Debugging - this will display the output statements
	EXPORT Debug := FALSE;
END;