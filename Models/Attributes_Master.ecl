import risk_indicators, ut, mdr, easi, riskwise, aml, riskview, std; 

blankEasi := row( [], EASI.Layout_Easi_Census );
blankBTST := row( [], Risk_Indicators.Layout_BocaShell_BtSt_Out );
blankIP2O := row( [], riskwise.Layout_IP2O );
blankAML  := row( [], AML.Layouts.LayoutAMLShell );

export Attributes_Master(
	risk_indicators.layout_boca_shell clam,
	boolean isFCRA,
	EASI.Layout_Easi_Census inEasi = blankEasi,
	EASI.Layout_Easi_Census Easi1 = blankEasi,
	EASI.Layout_Easi_Census Easi2 = blankEasi,
	Risk_Indicators.Layout_BocaShell_BtSt_Out BillToShipTo = blankBTST,
	riskwise.Layout_IP2O ip2o = blankIP2O,
	AML.Layouts.LayoutAMLShell AMLin = blankAML
	) := MODULE

/* ***********************************************************************/
// constants
shared	capZero := '0';
shared	capOfOne := '1';
shared 	cap84 := '84';  // 7 year cap
shared	cap150 := '150';
shared	cap255 := '255';
shared	cap960 := '960';
shared	cap9999 := '9999';
shared	capMax := '9999999999';
shared  negativeCapMax := -9999999999;
shared cap7Byte := '9999999';
shared cap10Byte := '9999999999';


// common functions
// ==============================================================================================================
shared	getPreviousMonth(unsigned histdate) := FUNCTION
			rollBack := trim(((string)histdate)[5..6]) in ['00','01'];
			histYear := if(rollBack, (unsigned)((trim((string)histdate)[1..4]))-1, (unsigned)(trim((string)histdate)[1..4]));
			histMonth := if(rollBack, 12, (unsigned)((trim((string)histdate)[5..6]))-1);
			return (unsigned)(intformat(histYear,4,1) + intformat(histMonth,2,1));
	END;

shared	checkDate6(unsigned3 foundDate) := FUNCTION
			outDate := if(foundDate >= clam.historyDate, getPreviousMonth(clam.historyDate), foundDate);
			return outDate;
	END;
	
shared	checkBoolean(boolean x) := if(x, '1', '0');
shared	capR(REAL input, REAL lower, REAL upper) := IF(input <= lower, lower, IF(input >= upper, upper, input));
shared	capS(string input, string lowerBound, string upperBound) := trim(IF((unsigned)input < (unsigned)upperBound, 
										IF((UNSIGNED)input < (UNSIGNED)lowerBound, lowerBound, input), 
										upperBound));	// get smaller number and make sure the lower bounds is not exceeded

// this function is for correcting months of 00 in header dates.  
// header dates are unsigned3 values, even though layout_address_informationv3 allows unsigned4, the values are still YYYYMM 										
shared unsigned3 fixYYYY00( unsigned YYYYMM ) := if( YYYYMM > 0 and YYYYMM % 100 = 0, YYYYMM + 1, YYYYMM );


// for a few attributes (notably: AddrMostRecentTaxDiff, AddrMostRecentIncomeDiff, AddrMostRecentValueDiff, AddrMostRecentCrimeDiff),
// a -1 value is legitimate (not null), so we'll change legitimate -1 values to -2 in order to preserve the exceptionality of -1
shared preserveNull( integer val ) := if( val=-1, -2, val );

// shared intermediate variables
// ===================================================================================================================
export boolean noAddrinput    := not clam.input_validation.Address;
shared 	noPhoneinput   := not clam.input_validation.homephone;
shared	noSSNinput     := not clam.input_validation.ssn;
shared	noDOBinput     := not clam.input_validation.dateofbirth;
shared	noNAMEinput     := not (clam.input_validation.firstname and clam.input_validation.lastname);
shared	noLASTNAMEinput     := not clam.input_validation.lastname;

shared	sysdate := if(clam.historydate <> 999999, (integer)(((string)clam.historydate)[1..6]), (integer)(((STRING)Std.Date.Today())[1..6]));
shared 	ageDate := (unsigned4)Risk_Indicators.iid_constants.myGetDate(clam.historydate);  
shared 	under21 := clam.inferred_age < 21 OR (ut.Age(clam.reported_dob, (unsigned)ageDate)) < 21;	
shared	subjectFirstSeen := fixYYYY00(ut.Min2(clam.ssn_verification.header_first_seen, clam.ssn_verification.credit_first_seen));
shared	subjectLastSeen := fixYYYY00(checkDate6(max(clam.ssn_verification.header_last_seen, clam.ssn_verification.credit_last_seen)));

shared	IAdateFirstSeen := fixYYYY00(clam.address_verification.input_address_information.date_first_seen);
shared	AH1dateFirstSeen := fixYYYY00(clam.address_verification.address_history_1.date_first_seen);
shared	AH2dateFirstSeen := fixYYYY00(clam.address_verification.address_history_2.date_first_seen);
shared 	noPrimaryRes := ~clam.address_verification.input_address_information.isbestmatch and ~clam.address_verification.address_history_1.isbestmatch and ~clam.address_verification.address_history_2.isbestmatch;

// current address pick for matching isbestmatch, assuming 1 of the 3 addresses are best
shared	CAaddrChooser := map(clam.address_verification.input_address_information.isbestmatch => 1, // input is current
											 clam.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
											 clam.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
											 4);	// don't know what the current address is	

shared	CADateFirstReported := map(CAaddrChooser=1 => IAdateFirstSeen,
														 CAaddrChooser=2 =>	AH1dateFirstSeen,
														 CAaddrChooser=3 => AH2dateFirstSeen,
														 0);	
shared	CADateLastReported := fixYYYY00(checkDate6(map(CAaddrChooser=1 => clam.address_verification.input_address_information.date_last_seen,
																			CAaddrChooser=2 => clam.address_verification.address_history_1.date_last_seen,
																			CAaddrChooser=3 => clam.address_verification.address_history_2.date_last_seen,
																			0)));
shared	CALastSaleDate := map(CAaddrChooser=1 => clam.address_verification.input_address_information.purchase_date,
												CAaddrChooser=2 => clam.address_verification.address_history_1.purchase_date,
												CAaddrChooser=3 => clam.address_verification.address_history_2.purchase_date,
												0);

	// Previous address picker assumes that either the input or Address history 1 is current
shared	PAaddrChooser_temp := map(CAaddrChooser=1 => 2, // if input is current, then pick history 1 as previous
											 CAaddrChooser=2 and clam.address_verification.input_address_information.date_last_seen > clam.address_verification.address_history_2.date_last_seen => 1,	// if hist 1 is current and input date last seen > hist 2 date last seen then input is previous
											 CAaddrChooser=2 and clam.address_verification.input_address_information.date_last_seen = clam.address_verification.address_history_2.date_last_seen and
													clam.address_verification.input_address_information.date_first_seen >= clam.address_verification.address_history_2.date_first_seen => 1,	// if hist 1 is current and input date last seen = hist 2 date last seen and input date first seen >= hist 2 date first seen then input is previous
											 CAaddrChooser=3 and clam.address_verification.input_address_information.date_last_seen > clam.address_verification.address_history_1.date_last_seen => 1, // if hist 2 is current and input date last seen > hist 1 date last seen then input is previous
											 CAaddrChooser=3 and clam.address_verification.input_address_information.date_last_seen = clam.address_verification.address_history_1.date_last_seen and
													clam.address_verification.input_address_information.date_first_seen >= clam.address_verification.address_history_1.date_first_seen => 1,	// if hist 2 is current and input date last seen = hist 1 date last seen and input date first seen >= hist 1 date first seen then input is previous
											 CAaddrChooser=2 => 3,	// if none of the above and hist 1 is current, then hist 2 is previous
											 CAaddrChooser=4 => 4,	// no Current address chosen
											 2);	// if none of the above and hist 2 is current, then hist 1 is previous
	
	// override the previous address chooser to 4 if the address selected as previous doesn't actually exist
shared	PAaddrChooser := if( (PAaddrChooser_temp=1 and clam.address_verification.input_address_information.prim_name='') or
											 (PAaddrChooser_temp=2 and clam.address_verification.address_history_1.prim_name='') or
											 (PAaddrChooser_temp=3 and clam.address_verification.address_history_2.prim_name=''), 
											 4,
											 PAaddrChooser_temp);

// determine we use hist1 or hist2 to compare to input											 
shared  MostRecentAddrChooser := map(noAddrInput => 0,
																		 CAaddrChooser=1 and PAaddrChooser=2  => 1,  // use addr history 1
																		 CAaddrChooser=2 and PAaddrChooser=3  => 2,  // use addr history 2
																		 0);

shared	MostRecentDateFirstReported := map(MostRecentAddrChooser=1 => AH1dateFirstSeen,
														 MostRecentAddrChooser=2 =>	AH2dateFirstSeen,
														 0);
														 
shared	PADateFirstReported := map(PAaddrChooser=1 => IAdateFirstSeen,
														 PAaddrChooser=2 =>	AH1dateFirstSeen,
														 PAaddrChooser=3 => AH2dateFirstSeen,
														 0);
														 
shared	PADateLastReported := fixYYYY00(checkDate6(map(PAaddrChooser=1 => clam.address_verification.input_address_information.date_last_seen,
																			PAaddrChooser=2 => clam.address_verification.address_history_1.date_last_seen,
																			PAaddrChooser=3 => clam.address_verification.address_history_2.date_last_seen,
																			0)));
																			
shared	PALastSaleDate := map(PAaddrChooser=1 => clam.address_verification.input_address_information.purchase_date,
												PAaddrChooser=2 => clam.address_verification.address_history_1.purchase_date,
												PAaddrChooser=3 => clam.address_verification.address_history_2.purchase_date,
												0);//just guessing here
												
shared 	firstVerified := clam.iid.nap_summary in [3, 4, 8, 9, 10, 12] or clam.iid.nas_summary in [3, 4, 8, 9, 10, 12];
shared 	lastVerified := clam.iid.nap_summary in [5, 7, 8, 9, 11, 12] or clam.iid.nas_summary in [5, 7, 8, 9, 11, 12];
																																		
shared	inputEcon := EconCode(clam.iid.dwelltype, clam.address_verification.input_address_information.assessed_amount, 
												clam.avm.input_address_information, (unsigned)clam.address_verification.input_address_information.census_home_value);
shared	hist1Econ := EconCode(clam.address_verification.addr_type2, clam.address_verification.address_history_1.assessed_amount, 
												clam.avm.address_history_1, (unsigned)clam.address_verification.address_history_1.census_home_value);											
shared	hist2Econ := EconCode(clam.address_verification.addr_type3, clam.address_verification.address_history_2.assessed_amount, 
												clam.avm.address_history_2, (unsigned)clam.address_verification.address_history_2.census_home_value);		

shared	input_tax_value := clam.address_verification.input_address_information.assessed_total_value;
shared	ah1_tax_value := clam.address_verification.address_history_1.assessed_total_value;
shared	ah2_tax_value := clam.address_verification.address_history_2.assessed_total_value;
shared	in_ah1_diff_raw := input_tax_value - ah1_tax_value;
shared	in_ah2_diff_raw := input_tax_value - ah2_tax_value;	

shared	in_ah1_diff := if(in_ah1_diff_raw < negativeCapMax, negativeCapMax, 
													if(in_ah1_diff_raw > (unsigned)CapMax, (unsigned)CapMax, in_ah1_diff_raw));
shared	in_ah2_diff := if(in_ah2_diff_raw < negativeCapMax, negativeCapMax, 
													if(in_ah2_diff_raw > (unsigned)CapMax, (unsigned)CapMax, in_ah2_diff_raw));
	

shared	statusAddr1 := map(clam.address_verification.input_address_information.applicant_owned or 
														clam.address_verification.input_address_information.applicant_sold or
														clam.address_verification.input_address_information.family_owned or 
														clam.address_verification.input_address_information.family_sold => 'O',// owned
										 ~clam.address_verification.input_address_information.occupant_owned and
														clam.iid.dwelltype not in ['','S'] => 'R',// rent,
										 'U');// unknown
shared	statusAddr2 := map(clam.address_verification.address_history_1.applicant_owned or 
														clam.address_verification.address_history_1.applicant_sold or
														clam.address_verification.address_history_1.family_owned or 
														clam.address_verification.address_history_1.family_sold => 'O',// owned
										 ~clam.address_verification.address_history_1.occupant_owned and 
														clam.address_verification.addr_type2 not in ['','S'] => 'R',// rent,
										 'U');// unknown;
shared	statusAddr3 := map(clam.address_verification.address_history_2.applicant_owned or 
														clam.address_verification.address_history_2.applicant_sold or
														clam.address_verification.address_history_2.family_owned or 
														clam.address_verification.address_history_2.family_sold => 'O',// owned
										 ~clam.address_verification.address_history_2.occupant_owned and 
														clam.address_verification.addr_type3 not in ['','S'] => 'R',// rent,
										 'U');// unknown;

								

/* **********************************************************************************************
			BEGINNING OF ATTRIBUTES LOGIC
*************************************************************************************************/
	
		shared Age_Oldest_Record := capS((string)round((ut.DaysApart((string)subjectFirstSeen, (string)sysdate)) / 30), capZero, cap960);
		
export	string3	AgeOldestRecord	:= if(subjectFirstSeen=0, '-1', Age_Oldest_Record );		
	
export	string3	AgeNewestRecord := if(subjectLastSeen=0, '-1', capS((string)round((ut.DaysApart((string)subjectLastSeen, (string)sysdate)) / 30), capZero, cap960) );

export	string1	RecentUpdate	:= if((integer)agenewestrecord between 0 and 11, '1', '0');

export	string3	SrcsConfirmIDAddrCount	:= capS((string)map(CAaddrChooser=1 => clam.address_verification.input_address_information.source_count,
																	CAaddrChooser=2 => clam.address_verification.address_history_1.source_count,
																	CAaddrChooser=3 => clam.address_verification.address_history_2.source_count,
																	0), capZero, cap255);
																	
export string1 SubjectOnFile := if(clam.did > 0, '1', '0');																	
	
export	string2	InvalidDL	:= map(clam.shell_input.dl_Number='' or clam.shell_input.dl_state='' => '-1',
																 clam.iid.drlcvalflag in ['1','3'] => '1',
																 '0');
																 
export	string1	VerificationFailure	:= 
  if(clam.iid.nas_summary <= 4 and clam.iid.nap_summary <= 4 and clam.address_verification.input_address_information.naprop <= 2, '1','0');

export	string1	FCRAVerificationFailure	:= 
if(riskview.constants.noscore(clam.iid.nas_summary,clam.iid.nap_summary, clam.address_verification.input_address_information.naprop, clam.truedid), '1', '0');
	
  
export	string2	SSNNotFound	:= map(noSSNinput => '-1',
																	clam.iid.ssnexists => '0',
																	'1');	
																	
export	string1	VerifiedName	:= 	map(firstVerified and lastVerified => '3',
																			lastVerified => '2',
																			firstVerified => '1',
																			'0');
																		
export	string2	VerifiedSSN	:= map(noSSNinput or not clam.iid.ssnexists => '-1',  
																	 clam.iid.nas_summary in [7, 9, 10, 11, 12] => '2', 
																	 clam.iid.nas_summary = 1 => '1',
																	 '0');
																	 
export	string2	VerifiedPhone	:= map(noPhoneInput => '-1',
																		clam.iid.nap_summary in [6, 7, 9, 10, 11, 12] => '2',
																		clam.iid.nap_summary = 1 => '1',	
																		'0');
																		
export	string2	VerifiedAddress	:= map(noAddrInput => '-1',
																			 clam.iid.nap_summary in [5, 8, 10, 11, 12] or 
																			 clam.iid.nas_summary in [5, 8, 10, 11, 12] => '1', 
																			 '0');
																			 
export	string2	VerifiedDOB	:= map(noDobInput => '-1',
																	 clam.dobmatchlevel='8' => '7', // Full Date of Birth verified
																	 clam.dobmatchlevel='5' => '6', // Day and year verified
																	 clam.dobmatchlevel='4' => '5', // Month and day verified
																	 clam.dobmatchlevel='7' => '4', // Month and year verified
																	 clam.dobmatchlevel='6' => '3', // Year only verified
																	 clam.dobmatchlevel='3' => '2', // Month only verified
																	 clam.dobmatchlevel='2' => '1', // Day only verified
																	 '0');
																 
export	string3	InferredMinimumAge(boolean isPrescreen)	:= if(clam.inferred_age=0 OR (isPrescreen AND under21), '-1', 
																															capS((string)clam.inferred_age, capZero, cap150) );

export	string3	BestReportedAge(boolean isPrescreen)	:= if(clam.reported_dob=0 OR (isPrescreen AND under21), '-1', 
																															capS((string)ut.Age(clam.reported_dob, ageDate), capZero, cap150) );

export string3 SubjectSSNCount               := capS((string)clam.velocity_counters.ssns_per_adl, capZero, cap255);
export string3 SubjectAddrCount              := capS((string)clam.velocity_counters.addrs_per_adl, capZero, cap255);
export string3 SubjectPhoneCount             := capS((string)clam.velocity_counters.phones_per_adl, capZero, cap255);
export string3 SubjectSSNRecentCount         := capS((string)clam.velocity_counters.ssns_per_adl_created_6months, capZero, cap255);
export string3 SubjectAddrRecentCount        := capS((string)clam.velocity_counters.addrs_per_adl_created_6months, capZero, cap255);
export string3 SubjectPhoneRecentCount       := capS((string)clam.velocity_counters.phones_per_adl_created_6months, capZero, cap255);
export string3 SSNIdentitiesCount            := capS((string)clam.SSN_Verification.adlPerSSN_count, capZero, cap255);
export string3 SSNAddrCount                  := capS((string)if(clam.velocity_counters.addrs_per_ssn<clam.velocity_counters.addrs_per_ssn_created_6months, 255, clam.velocity_counters.addrs_per_ssn), capZero, cap255); // if total count < recent count, that means recent > 255, so set it to 255
export string3 SSNIdentitiesRecentCount      := capS((string)clam.velocity_counters.adls_per_ssn_created_6months, capZero, cap255);
export string3 SSNAddrRecentCount            := capS((string)clam.velocity_counters.addrs_per_ssn_created_6months, capZero, cap255);
export string3 InputAddrPhoneCount           := capS((string)clam.velocity_counters.phones_per_addr, capZero, cap255);
export string3 InputAddrPhoneRecentCount     := capS((string)clam.velocity_counters.phones_per_addr_created_6months, capZero, cap255);
export string3 AddrIdentitiesCount           := capS((string)clam.velocity_counters.adls_per_addr, capZero, cap255);
export string3 PhoneIdentitiesCount          := capS((string)clam.velocity_counters.adls_per_phone, capZero, cap255);
export string3 AddrIdentitiesRecentCount     := capS((string)clam.velocity_counters.adls_per_addr_created_6months, capZero, cap255);
export string3 PhoneIdentitiesRecentCount    := capS((string)clam.velocity_counters.adls_per_phone_created_6months, capZero, cap255);

export string2 PhoneListedDifferent := map(
	noPhoneInput => '-1',
	clam.iid.nap_summary=1 => '1',
	'0'
);	

export	string3	SSNAgeDeceased	:= if(clam.ssn_verification.Validation.deceasedDate=0 or clam.ssn_verification.Validation.deceasedDate>agedate, '-1', 
																			capS((string)ut.Age(clam.ssn_verification.Validation.deceasedDate, ageDate), capZero, cap960) );

// this one will only be a valid attribute until June 2012, after that we won't be able to tell anymore.																
export	string2	SSNRecent	:= map(noSSNInput => '-1',
																(sysdate - (INTEGER)(clam.iid.soclhighissue[1..6]) < 100) AND sysdate <= Risk_Indicators.iid_constants.randomSSN1Year => '1',
																'0');
																
export	string3	SSNLowIssueAge	:= if((unsigned)clam.iid.socllowissue=0 or (unsigned)clam.iid.socllowissue > ageDate, '-1', 
									capS((string)round((ut.DaysApart(clam.iid.socllowissue, (string)ageDate)) / 30), capZero, cap960) );

export	string3	SSNHighIssueAge	:= if((unsigned)clam.iid.soclhighissue=0 or (unsigned)clam.iid.soclhighissue > ageDate, '-1', 
									capS((string)round((ut.DaysApart(clam.iid.soclhighissue, (string)ageDate)) / 30), capZero, cap960) );
									
export	string2	SSNIssueState	:= if(clam.iid.soclstate='', '-1', clam.iid.soclstate);

export	string2	SSNNonUS	:= map(noSSNInput => '-1', 
																clam.iid.non_us_ssn => '1',
																'0');

export	string2	SSN3Years	:= map(noSSNInput => '-1',
																// If it is not a randomized social and only issued within the last 36 months
																(~Risk_Indicators.rcSet.isCodeRS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag) AND (sysdate - (INTEGER)(clam.iid.socllowissue[1..6])) < 300) OR 
																// Or it was possibly randomized and the date is prior to June 25th, 2014
																(Risk_Indicators.rcSet.isCodeRS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag) AND sysdate <= Risk_Indicators.iid_constants.randomSSN3Years) => '1',
																'0');
																
export	string2	SSNAfter5 	:= map(noSSNInput => '-1',
															((INTEGER)(clam.iid.socllowissue[1..6]) - (INTEGER)(clam.shell_input.Dob[1..6])) > 500 AND 
															(INTEGER)(clam.shell_input.Dob[1..4]) > 1990 AND (INTEGER)(clam.shell_input.Dob[1..6]) < 200606 => '1',
															'0');
																														
export	string2	SSNProblems	:= map(noSSNInput 								=> '-1',  // not input
								clam.iid.decsflag='1' 		=> '5',   // deceased SSN
								clam.iid.socsdobflag='1'	=> '4',  	// issued prior to DOB
								Risk_Indicators.rcSet.isCodeIS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag)  => '3',  	// verified and valid, but was invalid prior to June 25th (reason code IS flag)
								not clam.SSN_Verification.Validation.valid => '2',  // invalid ssn
								Risk_Indicators.rcSet.isCodeRS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag)	=> '1', // randomized ssn (RS)
								'0');  // valid
	// if input address isn't one of your last 3 addresses, yet we have it in the address history, use the dates from the address history summary
	shared	InputAddrDateFirstSeen := fixYYYY00(if(IAdateFirstSeen=0 and clam.address_history_summary.hist_addr_match > 0, 
																			 clam.address_history_summary.input_addr_first_seen,
																			 IAdateFirstSeen));
	shared	InputAddrDateLastSeen := fixYYYY00(if(clam.address_verification.input_address_information.date_last_seen=0 and clam.address_history_summary.hist_addr_match > 0, 
																			 clam.address_history_summary.input_addr_last_seen,
																			 clam.address_verification.input_address_information.date_last_seen));
															
export	string3	InputAddrAgeOldestRecord	:= if(noaddrInput or InputAddrDateFirstSeen=0, '-1', 
																				capS((string)round((ut.DaysApart((string)InputAddrDateFirstSeen,	(string)sysdate)) / 30), capZero, cap960) );
																				
export	string3	InputAddrAgeNewestRecord	:= if(noaddrInput or InputAddrDateLastSeen=0, '-1', 
																				capS((string)round((ut.DaysApart((string)checkDate6(InputAddrDateLastSeen),	(string)sysdate)) / 30), capZero, cap960) );
																				
export	string2	InputAddrHistoricalMatch	:= map(CAaddrChooser=1 => '2', // input address is the current address 
																								clam.address_history_summary.hist_addr_match > 0 => '1',  // input address exists is in your address history according to Pete's logic
																								InputAddrDateFirstSeen <> 0 or InputAddrDateLastSeen <> 0 => '1',  // input address exists in your chronology
																								'-1');

export	string3	InputAddrLenOfRes 	:= if(noaddrInput or InputAddrDateFirstSeen=0 or InputAddrDateLastSeen=0, '-1',

																		capS((string)((INTEGER)InputAddrAgeOldestRecord - (INTEGER)InputAddrAgeNewestRecord), capZero, cap960) );

// *********	BEGINNING OF BUILD DATE VARIABLES *********************	
// only use this variable in realtime mode to simulate the header build date rather than todays date

	shared checkHdrBldDate(unsigned FoundDate, unsigned HdrBldDate) := FUNCTION
			outDate := if(foundDate >= HdrBldDate, HdrBldDate, foundDate);
			return outDate;
	END;
	
	shared InputAddrDateFirstSeenChk := checkHdrBldDate(InputAddrDateFirstSeen, clam.header_summary.header_build_date);
	shared InputAddrDateLastSeenChk := checkHdrBldDate(InputAddrDateLastSeen, clam.header_summary.header_build_date);
	shared subjectFirstSeenChk := checkHdrBldDate(subjectFirstSeen, clam.header_summary.header_build_date);
	shared subjectLastSeenChk := checkHdrBldDate(subjectLastSeen, clam.header_summary.header_build_date);
	shared CADateFirstReportedChk := checkHdrBldDate(CADateFirstReported, clam.header_summary.header_build_date);
	shared CADateLastReportedChk := checkHdrBldDate(CADateLastReported, clam.header_summary.header_build_date);
	shared PADateFirstReportedChk := checkHdrBldDate(PADateFirstReported, clam.header_summary.header_build_date);
	shared PADateLastReportedChk := checkHdrBldDate(PADateLastReported, clam.header_summary.header_build_date);
	shared MostRecentDateFirstReportedChk := checkHdrBldDate(MostRecentDateFirstReported, clam.header_summary.header_build_date);
  shared system_YYYYMM_v4 := if(clam.historydate = risk_indicators.iid_constants.default_history_date, clam.header_summary.header_build_date, clam.historydate);
	
	
export	string3	InputAddrAgeOldestRecord_buildDate	:= if(noaddrInput or InputAddrDateFirstSeen=0, '-1', 
																				capS((string)round((ut.DaysApart((string)InputAddrDateFirstSeenChk,	(string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );
																				
export	string3	InputAddrAgeNewestRecord_buildDate	:= if(noaddrInput or InputAddrDateLastSeen=0, '-1', 
																				capS((string)round((ut.DaysApart((string)checkDate6(InputAddrDateLastSeenChk),	(string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );

export	string3	InputAddrLenOfRes_buildDate 	:= if(noaddrInput or InputAddrDateFirstSeenChk=0 or InputAddrDateLastSeenChk=0, '-1',
																		capS((string)((INTEGER)InputAddrAgeOldestRecord_buildDate - (INTEGER)InputAddrAgeNewestRecord_buildDate), capOfOne, cap960) );

shared Age_Oldest_Record_buildDate := capS((string)round((ut.DaysApart((string)subjectFirstSeenChk, (string)system_YYYYMM_v4)) / 30), capOfOne, cap960);																		

export	string3	AgeOldestRecord_buildDate	:= if(subjectFirstSeen=0, '-1', Age_Oldest_Record_buildDate );		
	
export	string3	AgeNewestRecord_buildDate := if(subjectLastSeen=0, '-1', capS((string)round((ut.DaysApart((string)subjectLastSeenChk, (string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );

export	string1	RecentUpdate_buildDate	:= if((integer)agenewestrecord between 0 and 11, '1', '0');

export	string3	CurrAddrAgeOldestRecord_buildDate	:= if(CAaddrChooser=4 or CADateFirstReportedChk=0, '-1', capS((string)round((ut.DaysApart((string)CADateFirstReportedChk,	(string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );
	
export	string3	CurrAddrAgeNewestRecord_buildDate	:= if(CAaddrChooser=4 or CADateLastReportedChk=0, '-1', capS((string)round((ut.DaysApart((string)CADateLastReportedChk,	(string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );

export	string3	CurrAddrLenOfRes_buildDate 	:= if(CAaddrChooser=4 or CADateFirstReportedChk=0 or CADateLastReportedChk=0, '-1',
																capS((string)((INTEGER)CurrAddrAgeOldestRecord_buildDate - (INTEGER)CurrAddrAgeNewestRecord_buildDate), capOfOne, cap960) );

export	string3	PrevAddrAgeOldestRecord_buildDate	:= if(PAaddrChooser=4 or PADateFirstReportedChk=0, '-1', 
																						capS((string)round((ut.DaysApart((string)PADateFirstReportedChk,	(string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );

export	string3	PrevAddrAgeNewestRecord_buildDate	:= if(PAaddrChooser=4 or PADateLastReportedChk=0, '-1', 
																						capS((string)round((ut.DaysApart((string)PADateLastReportedChk,	(string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );
																						
export	string3	PrevAddrLenOfRes_buildDate 	:= if(PAaddrChooser=4 or PADateFirstReportedChk=0 or PADateLastReportedChk=0, '-1',
																capS( (string)((INTEGER)PrevAddrAgeOldestRecord_buildDate - (INTEGER)PrevAddrAgeNewestRecord_buildDate), capOfOne, cap960) );	
																
export	string3	AddrMostRecentMoveAge_buildDate	:= if(MostRecentAddrChooser=0, '-1',
	capS((string)round((ut.DaysApart((string)MostRecentDateFirstReportedChk,	(string)system_YYYYMM_v4)) / 30), capOfOne, cap960) );	
																
// *********	END OF BUILD DATE VARIABLES *********************																


	shared IADwellType := if(clam.shell_input.addr_type='S' and clam.iid.addrvalflag='N', '', clam.shell_input.addr_type);
export	string2	InputAddrDwellType 	:= if(noAddrInput or IADwellType='', '-1', IADwellType);

export	string2	InputAddrDelivery	:= map(clam.advo_input_addr.address_vacancy_indicator='Y' => '4',  // vacant address
								clam.advo_input_addr.seasonal_delivery_indicator='Y' and clam.advo_input_addr.residential_or_business_ind in ['A','C'] => '3',  // seasonal residential
								clam.advo_input_addr.seasonal_delivery_indicator='E' => '2',  // educational institution
								clam.advo_input_addr.throw_back_indicator='Y' => '1',  // mail is sent to PO box instead of the home address
								'-1');
																																							 
export	string2	InputAddrApplicantOwned	:= map(noaddrinput or clam.address_verification.input_address_information.naprop=0 => '-1',
																							clam.address_verification.input_address_information.applicant_owned => '1',
																							'0');
																					
export	string2	InputAddrFamilyOwned	:= map(noaddrinput or clam.address_verification.input_address_information.naprop=0 => '-1',
																							clam.address_verification.input_address_information.family_owned and 
																								~clam.address_verification.input_address_information.applicant_owned => '1',
																							'0');
																							
export	string2	InputAddrOccupantOwned 	:=  map(noaddrinput or clam.address_verification.input_address_information.naprop=0 => '-1',
																							clam.address_verification.input_address_information.occupant_owned and 
																								~clam.address_verification.input_address_information.applicant_owned and
																								~clam.address_verification.input_address_information.family_owned => '1',
																							'0');
																							
export	string3	InputAddrAgeLastSale	:= if(noaddrinput or clam.address_verification.input_address_information.purchase_date=0 or 
																						clam.address_verification.input_address_information.purchase_date>ageDate, '-1', 
																		capS((string)round((ut.DaysApart((string)clam.address_verification.input_address_information.purchase_date, (string)sysdate)) / 30), capZero, cap960) );	
																		
export	string10	InputAddrLastSalesPrice	:= if(noaddrinput or clam.address_verification.input_address_information.purchase_amount=0 or
																								clam.address_verification.input_address_information.purchase_date>ageDate, '-1', 
																								capS((string)clam.address_verification.input_address_information.purchase_amount, capZero, capMax));

export	string2	InputAddrMortgageType	:= map(InputAddrApplicantOwned<>'1' => '-1',		
																								clam.address_verification.input_address_information.type_financing='ADJ' => '1',
																								clam.address_verification.input_address_information.type_financing='CNV' => '2',
																								clam.address_verification.input_address_information.type_financing='OTH' => '3',
																								clam.address_verification.input_address_information.type_financing='' and
																									clam.address_verification.input_address_information.mortgage_type<>'' => '3',
																								'-1');
	
export	string2	InputAddrNotPrimaryRes 	:= map(noaddrinput or noPrimaryRes => '-1', 
																				~clam.address_verification.input_address_information.isbestmatch => '1',
																				'0');
																				
export	string2	InputAddrActivePhoneList 	:= map(noaddrinput => '-1',
																								 clam.address_verification.activePhone<>0 => '1',
																								 '0');
																								 
export	string10	InputAddrTaxValue 	:= if(noaddrinput, '-1', 
																								capS((string)clam.address_verification.input_address_information.assessed_total_value, capZero, capMax));

shared string4  AvyValueChk  := if(clam.address_verification.input_address_information.assessed_value_year='','-1',clam.address_verification.input_address_information.assessed_value_year);
shared string4  Hist1AvyValueChk	:=	if(clam.address_verification.address_history_1.assessed_value_year='','-1',clam.address_verification.address_history_1.assessed_value_year);
shared string4  Hist2AvyValueChk  :=	if(clam.address_verification.address_history_2.assessed_value_year='','-1',clam.address_verification.address_history_2.assessed_value_year);
																			
export	string4	InputAddrTaxYr	:= if(noaddrinput or clam.address_verification.input_address_information.assessed_value_year='' , '-1', 
																			clam.address_verification.input_address_information.assessed_value_year);	

export	string10	InputAddrTaxMarketValue	:= if(noaddrinput, '-1', 
																								capS((string)clam.address_verification.input_address_information.assessed_amount, capZero, capMax));
																								
export	string10	InputAddrAVMValue	:= if(noaddrinput, '-1', 
																				  capS((string)clam.avm.input_address_information.avm_automated_valuation, capZero, capMax));
																					
export	string10	InputAddrAVMValue12	:= if(noaddrinput, '-1', 
																				  capS((string)clam.avm.input_address_information.avm_automated_valuation2, capZero, capMax));  // valuation2 = 1 year prior
																					
export	string10	InputAddrAVMValue60	:= if(noaddrinput, '-1', 
																				  capS((string)clam.avm.input_address_information.avm_automated_valuation6, capZero, capMax));  // valuation6 = 5 years prior
																					
export	string5	InputAddrCountyIndex	:= if(noaddrinput, '-1', 
																					trim((string)(decimal4_2)(capR(clam.avm.input_address_information.avm_automated_valuation / clam.avm.input_address_information.avm_median_fips_level, 0, 99.0))) );
																					
export	string5	InputAddrTractIndex	:= if(noaddrinput, '-1', 
																					trim((string)(decimal4_2)(capR(clam.avm.input_address_information.avm_automated_valuation / clam.avm.input_address_information.avm_median_geo12_level, 0, 99.0))) );
																					
export	string5	InputAddrBlockIndex	:= if(noaddrinput, '-1', 
																					trim((string)(decimal4_2)(capR(clam.avm.input_address_information.avm_automated_valuation / clam.avm.input_address_information.avm_median_geo11_level, 0, 99.0))) );
	
export	string3	CurrAddrAgeOldestRecord	:= if(CAaddrChooser=4 or CADateFirstReported=0, '-1', capS((string)round((ut.DaysApart((string)CADateFirstReported,	(string)sysdate)) / 30), capZero, cap960) );
	
export	string3	CurrAddrAgeNewestRecord	:= if(CAaddrChooser=4 or CADateLastReported=0, '-1', capS((string)round((ut.DaysApart((string)CADateLastReported,	(string)sysdate)) / 30), capZero, cap960) );

export	string3	CurrAddrLenOfRes 	:= if(CAaddrChooser=4 or CADateFirstReported=0 or CADateLastReported=0, '-1',
																capS((string)((INTEGER)CurrAddrAgeOldestRecord - (INTEGER)CurrAddrAgeNewestRecord), capZero, cap960) );

				CAdwelltype := map(CAaddrChooser=1 => if(clam.shell_input.addr_type='S' and clam.iid.addrvalflag='N', '', clam.shell_input.addr_type),
													 CAaddrChooser=2 => clam.address_verification.addr_type2,
													 CAaddrChooser=3 => clam.address_verification.addr_type3,
													 '');																
export	string2	CurrAddrDwellType 	:= if(CAaddrChooser=4 or CAdwelltype='', '-1', CAdwelltype);
													 
export	string2	CurrAddrApplicantOwned 	:= map(CAaddrChooser=1 => checkboolean(clam.address_verification.input_address_information.applicant_owned),
																					CAaddrChooser=2 => checkBoolean(clam.address_verification.address_history_1.applicant_owned),
																					CAaddrChooser=3 => checkBoolean(clam.address_verification.address_history_2.applicant_owned),
																					'-1');	
																					
export	string2	CurrAddrFamilyOwned 	:= map(CAaddrChooser=1 => checkBoolean(clam.address_verification.input_address_information.family_owned and ~clam.address_verification.input_address_information.applicant_owned),
																			 CAaddrChooser=2 => checkBoolean(clam.address_verification.address_history_1.family_owned and ~clam.address_verification.address_history_1.applicant_owned),
																			 CAaddrChooser=3 => checkBoolean(clam.address_verification.address_history_2.family_owned and ~clam.address_verification.address_history_2.applicant_owned),
																			 '-1');
																			 
export	string2	CurrAddrOccupantOwned 	:= map(CAaddrChooser=1 => checkBoolean(clam.address_verification.input_address_information.occupant_owned and ~clam.address_verification.input_address_information.applicant_owned and
														~clam.address_verification.input_address_information.family_owned),
				 CAaddrChooser=2 => checkBoolean(clam.address_verification.address_history_1.occupant_owned and ~clam.address_verification.address_history_1.applicant_owned and
														~clam.address_verification.address_history_1.family_owned),
				 CAaddrChooser=3 => checkBoolean(clam.address_verification.address_history_2.occupant_owned and ~clam.address_verification.address_history_2.applicant_owned and
														~clam.address_verification.address_history_2.family_owned),
				 '-1');
				 
export	string3	CurrAddrAgeLastSale	:= if(CAaddrChooser=4 or CALastSaleDate=0 or CALastSaleDate>ageDate, '-1', capS((string)round((ut.DaysApart((string)CALastSaleDate, (string)sysdate)) / 30), capZero, cap960) );

export	string10	CurrAddrLastSalesPrice	:= map(CALastSaleDate=0 or CALastSaleDate>ageDate => '-1',
																						CAaddrChooser=1 => capS((string)clam.address_verification.input_address_information.purchase_amount, capZero, capMax),
																						CAaddrChooser=2 => capS((string)clam.address_verification.address_history_1.purchase_amount, capZero, capMax),
																						CAaddrChooser=3 => capS((string)clam.address_verification.address_history_2.purchase_amount, capZero, capMax),
																						'-1');

	shared curr_addr_financing_type := map(CAaddrChooser=1 => clam.address_verification.input_address_information.type_financing,
																					CAaddrChooser=2 => clam.address_verification.address_history_1.type_financing,
																					CAaddrChooser=3 => clam.address_verification.address_history_2.type_financing,
																					'');
																		
	shared curr_addr_mtg_type := map(CAaddrChooser=1 => clam.address_verification.input_address_information.mortgage_type,
																					CAaddrChooser=2 => clam.address_verification.address_history_1.mortgage_type,
																					CAaddrChooser=3 => clam.address_verification.address_history_2.mortgage_type,
																					'');
																					
export	string2	CurrAddrMortgageType	:= map(CurrAddrApplicantOwned<>'1' => '-1',		
																								curr_addr_financing_type='ADJ' => '1',
																								curr_addr_financing_type='CNV' => '2',
																								curr_addr_financing_type='OTH' => '3',
																								curr_addr_financing_type='' and	curr_addr_mtg_type<>'' => '3',
																								'-1');
																						
export	string2	CurrAddrActivePhoneList 	:= map(CAaddrChooser=1 => if(clam.address_verification.activePhone=0,'0', '1'),
																		 CAaddrChooser=2 => if(clam.address_verification.activePhone2=0,'0', '1'),
																		 CAaddrChooser=3 => if(clam.address_verification.activePhone3=0,'0', '1'),
																		 '-1');
																		 
export	string10	CurrAddrTaxValue 	:= map(CAaddrChooser=1 => capS((string)clam.address_verification.input_address_information.assessed_total_value, capZero, capMax),
																			 CAaddrChooser=2 => capS((string)clam.address_verification.address_history_1.assessed_total_value, capZero, capMax),
																			 CAaddrChooser=3 => capS((string)clam.address_verification.address_history_2.assessed_total_value, capZero, capMax),
																			 '-1');
																			 
export	string4	CurrAddrTaxYr	:= map( CAaddrChooser=1 => AvyValueChk,
																			CAaddrChooser=2 => Hist1AvyValueChk,
																			CAaddrChooser=3 => Hist2AvyValueChk,
																			'-1');

export	string10	CurrAddrTaxMarketValue	:= map(CAaddrChooser=1 => capS((string)clam.address_verification.input_address_information.assessed_amount, capZero, capMax),
																			 CAaddrChooser=2 => capS((string)clam.address_verification.address_history_1.assessed_amount, capZero, capMax),
																			 CAaddrChooser=3 => capS((string)clam.address_verification.address_history_2.assessed_amount, capZero, capMax),
																			 '-1');
									
export	string10	CurrAddrAVMValue	:= map(CAaddrChooser=1 => capS((string)clam.avm.input_address_information.avm_automated_valuation, capZero, capMax),
													CAaddrChooser=2 => capS((string)clam.avm.address_history_1.avm_automated_valuation, capZero, capMax),
													CAaddrChooser=3 => capS((string)clam.avm.address_history_2.avm_automated_valuation, capZero, capMax),
													'-1');
													
export	string10	CurrAddrAVMValue12	:= map(CAaddrChooser=1 => capS((string)clam.avm.input_address_information.avm_automated_valuation2, capZero, capMax),
													CAaddrChooser=2 => capS((string)clam.avm.address_history_1.avm_automated_valuation2, capZero, capMax),
													CAaddrChooser=3 => capS((string)clam.avm.address_history_2.avm_automated_valuation2, capZero, capMax),
													'-1');	
													
export	string10	CurrAddrAVMValue60	:= map(CAaddrChooser=1 => capS((string)clam.avm.input_address_information.avm_automated_valuation6, capZero, capMax),
													CAaddrChooser=2 => capS((string)clam.avm.address_history_1.avm_automated_valuation6, capZero, capMax),
													CAaddrChooser=3 => capS((string)clam.avm.address_history_2.avm_automated_valuation6, capZero, capMax),
													'-1');	

				shared	curr_Addr_Fips :=  map( CAaddrChooser=1 => clam.avm.input_address_information.avm_median_fips_level,
																CAaddrChooser=2 => clam.avm.address_history_1.avm_median_fips_level,
																CAaddrChooser=3 => clam.avm.address_history_2.avm_median_fips_level,
																0);
				shared	curr_Addr_Geo12 :=  map(CAaddrChooser=1 => clam.avm.input_address_information.avm_median_geo12_level,
																CAaddrChooser=2 => clam.avm.address_history_1.avm_median_geo12_level,
																CAaddrChooser=3 => clam.avm.address_history_2.avm_median_geo12_level,
																0);
				shared	curr_Addr_Geo11 :=  map(CAaddrChooser=1 => clam.avm.input_address_information.avm_median_geo11_level,
																CAaddrChooser=2 => clam.avm.address_history_1.avm_median_geo11_level,
																CAaddrChooser=3 => clam.avm.address_history_2.avm_median_geo11_level,
																0);
												
export	string5	CurrAddrCountyIndex	:= if(CAaddrChooser=4, '-1', trim((string)(decimal4_2)(capR((unsigned)CurrAddrAVMValue / curr_Addr_Fips, 0, 99.0))) );

export	string5	CurrAddrTractIndex	:= if(CAaddrChooser=4, '-1', trim((string)(decimal4_2)(capR((unsigned)CurrAddrAVMValue / curr_Addr_Geo12, 0, 99.0))) );

export	string5	CurrAddrBlockIndex	:= if(CAaddrChooser=4, '-1', trim((string)(decimal4_2)(capR((unsigned)CurrAddrAVMValue / curr_Addr_Geo11, 0, 99.0))) );
	
export	string3	PrevAddrAgeOldestRecord	:= if(PAaddrChooser=4 or PADateFirstReported=0, '-1', 
																						capS((string)round((ut.DaysApart((string)PADateFirstReported,	(string)sysdate)) / 30), capZero, cap960) );

export	string3	PrevAddrAgeNewestRecord	:= if(PAaddrChooser=4 or PADateLastReported=0, '-1', 
																						capS((string)round((ut.DaysApart((string)PADateLastReported,	(string)sysdate)) / 30), capZero, cap960) );
																						
export	string3	PrevAddrLenOfRes 	:= if(PAaddrChooser=4 or PADateFirstReported=0 or PADateLastReported=0, '-1',
																capS( (string)((INTEGER)PrevAddrAgeOldestRecord - (INTEGER)PrevAddrAgeNewestRecord), capZero, cap960) );	
								
								PAdwelltype :=  map(PAaddrChooser=1 => if(clam.shell_input.addr_type='S' and clam.iid.addrvalflag='N', '', clam.shell_input.addr_type),
																	 PAaddrChooser=2 => clam.address_verification.addr_type2,
																	 PAaddrChooser=3 => clam.address_verification.addr_type3,
																	 '');
export	string2	PrevAddrDwellType 	:= if(PAdwelltype='', '-1', PAdwelltype);

export	string2	PrevAddrApplicantOwned 	:= map(PAaddrChooser=1 => checkBoolean(clam.address_verification.input_address_information.applicant_owned),
																					PAaddrChooser=2 => checkBoolean(clam.address_verification.address_history_1.applicant_owned),
																					PAaddrChooser=3 => checkBoolean(clam.address_verification.address_history_2.applicant_owned),
																					'-1');
																					
export	string2	PrevAddrFamilyOwned 	:= map(PAaddrChooser=1 => checkBoolean(clam.address_verification.input_address_information.family_owned and ~clam.address_verification.input_address_information.applicant_owned),
																			 PAaddrChooser=2 => checkBoolean(clam.address_verification.address_history_1.family_owned and ~clam.address_verification.address_history_1.applicant_owned),
																			 PAaddrChooser=3 => checkBoolean(clam.address_verification.address_history_2.family_owned and ~clam.address_verification.address_history_2.applicant_owned),
																			 '-1');
																			 
export	string2	PrevAddrOccupantOwned	:= map(PAaddrChooser=1 => checkBoolean(clam.address_verification.input_address_information.occupant_owned and ~clam.address_verification.input_address_information.applicant_owned and
																													~clam.address_verification.input_address_information.family_owned),
																				 PAaddrChooser=2 => checkBoolean(clam.address_verification.address_history_1.occupant_owned and ~clam.address_verification.address_history_1.applicant_owned and
																													~clam.address_verification.address_history_1.family_owned),
																				 PAaddrChooser=3 => checkBoolean(clam.address_verification.address_history_1.occupant_owned and ~clam.address_verification.address_history_1.applicant_owned and
																														~clam.address_verification.address_history_1.family_owned),
																				 '-1');

export	string3	PrevAddrAgeLastSale	:= if(PAaddrChooser=4 or PALastSaleDate=0 or PALastSaleDate > ageDate, '-1',
																				capS((string)round((ut.DaysApart((string)PALastSaleDate, (string)sysdate)) / 30), capZero, cap960) );

export	string10	PrevAddrLastSalesPrice	:= map(PAaddrChooser=4 or PALastSaleDate=0 or PALastSaleDate > ageDate => '-1',
														PAaddrChooser=1 => capS((string)clam.address_verification.input_address_information.purchase_amount, capZero, capMax),
														PAaddrChooser=2 => capS((string)clam.address_verification.address_history_1.purchase_amount, capZero, capMax),
														PAaddrChooser=3 => capS((string)clam.address_verification.address_history_2.purchase_amount, capZero, capMax),
														'-1');
														
export	string10	PrevAddrTaxValue	:= map(PAaddrChooser=1 => capS((string)clam.address_verification.input_address_information.assessed_total_value, capZero, capMax),
																			 PAaddrChooser=2 => capS((string)clam.address_verification.address_history_1.assessed_total_value, capZero, capMax),
																			 PAaddrChooser=3 => capS((string)clam.address_verification.address_history_2.assessed_total_value, capZero, capMax),
																			 '-1');
																			 
export	string4	PrevAddrTaxYr	:= map( PAaddrChooser=1 => AvyValueChk,
																			PAaddrChooser=2 => Hist1AvyValueChk,
																			PAaddrChooser=3 => Hist2AvyValueChk,
																			'-1');
																			
export	string10	PrevAddrTaxMarketValue	:= map(PAaddrChooser=1 => capS((string)clam.address_verification.input_address_information.assessed_amount, capZero, capMax),
																			 PAaddrChooser=2 => capS((string)clam.address_verification.address_history_1.assessed_amount, capZero, capMax),
																			 PAaddrChooser=3 => capS((string)clam.address_verification.address_history_2.assessed_amount, capZero, capMax),
																			 '-1');
																			 
export	string10	PrevAddrAVMValue	:= map(PAaddrChooser=1 => capS((string)clam.avm.input_address_information.avm_automated_valuation, capZero, capMax),
													PAaddrChooser=2 => capS((string)clam.avm.address_history_1.avm_automated_valuation, capZero, capMax),
													PAaddrChooser=3 => capS((string)clam.avm.address_history_2.avm_automated_valuation, capZero, capMax),
													'-1');
													
				shared	prev_Addr_Fips :=  map( PAaddrChooser=1 => clam.avm.input_address_information.avm_median_fips_level,
																PAaddrChooser=2 => clam.avm.address_history_1.avm_median_fips_level,
																PAaddrChooser=3 => clam.avm.address_history_2.avm_median_fips_level,
																0);
				shared	prev_Addr_Geo12 :=  map(PAaddrChooser=1 => clam.avm.input_address_information.avm_median_geo12_level,
																PAaddrChooser=2 => clam.avm.address_history_1.avm_median_geo12_level,
																PAaddrChooser=3 => clam.avm.address_history_2.avm_median_geo12_level,
																0);
				shared	prev_Addr_Geo11 :=  map(PAaddrChooser=1 => clam.avm.input_address_information.avm_median_geo11_level,
																PAaddrChooser=2 => clam.avm.address_history_1.avm_median_geo11_level,
																PAaddrChooser=3 => clam.avm.address_history_2.avm_median_geo11_level,
																0);			
																
export	string5	PrevAddrCountyIndex	:= if(PAaddrChooser=4, '-1', trim((string)(decimal4_2)(capR((unsigned)PrevAddrAVMValue / prev_Addr_Fips, 0, 99.0))) );

export	string5	PrevAddrTractIndex	:= if(PAaddrChooser=4, '-1', trim((string)(decimal4_2)(capR((unsigned)PrevAddrAVMValue / prev_Addr_Geo12, 0, 99.0))) );

export	string5	PrevAddrBlockIndex	:= if(PAaddrChooser=4, '-1', trim((string)(decimal4_2)(capR((unsigned)PrevAddrAVMValue / prev_Addr_Geo11, 0, 99.0))) );


// MostRecentAddrChooser: 1=use addr_history_1, 2=use addr_history_2, 0=no recent address info on file																	 
export	string4	AddrMostRecentDistance	:= 
	map(	MostRecentAddrChooser=1 => IF(clam.address_verification.distance_in_2_h1 = 9999, '-1', capS((string)clam.address_verification.distance_in_2_h1, capZero, cap9999)),
				MostRecentAddrChooser=2 => IF(clam.address_verification.distance_in_2_h2 = 9999, '-1', capS((string)clam.address_verification.distance_in_2_h2, capZero, cap9999)),
				'-1');
													
export	string2	AddrMostRecentStateDiff	:= 
	map(	MostRecentAddrChooser=1 => IF(clam.address_verification.input_address_information.st<>clam.address_verification.address_history_1.st, '1', '0'),
				MostRecentAddrChooser=2 => IF(clam.address_verification.input_address_information.st<>clam.address_verification.address_history_2.st, '1', '0'),
				'-1');
																			
export	string11	AddrMostRecentTaxDiff	:= 
	map(	MostRecentAddrChooser=1 => if(input_tax_value=0 or ah1_tax_value=0, '-1', (string)preserveNull(in_ah1_diff)),  // diff field is already capped
				MostRecentAddrChooser=2 => if(input_tax_value=0 or ah2_tax_value=0, '-1', (string)preserveNull(in_ah2_diff)),  // diff field is already capped
				'-1');
						
export	string2	AddrRecentEconTrajectory	:= map(MostRecentAddrChooser=1 => hist1Econ + inputEcon,
																								 MostRecentAddrChooser=2 => hist2Econ + inputEcon,
																								 '-1');

export	string3	AddrMostRecentMoveAge	:= if(MostRecentAddrChooser=0, '-1',
	capS((string)round((ut.DaysApart((string)MostRecentDateFirstReported,	(string)sysdate)) / 30), capZero, cap960) );
																											

	shared convertTrajectory_to_index(string2 trajectory) := map(
     trajectory = 'AA' => '6',
     trajectory = 'AB' => '6',
     trajectory = 'AC' => '6',
     trajectory = 'AD' => '6',
     trajectory = 'AE' => '4',
     trajectory = 'AF' => '4',
     trajectory = 'AU' => '5',
     trajectory = 'BA' => '5',
     trajectory = 'BB' => '5',
     trajectory = 'BC' => '5',
     trajectory = 'BD' => '4',
     trajectory = 'BE' => '4',
     trajectory = 'BF' => '4',
     trajectory = 'BU' => '5',   
     trajectory = 'CA' => '5',
     trajectory = 'CB' => '4',
     trajectory = 'CC' => '4',
     trajectory = 'CD' => '3',
     trajectory = 'CE' => '3',
     trajectory = 'CF' => '3',
     trajectory = 'CU' => '5',
     trajectory = 'DA' => '4',
     trajectory = 'DB' => '4',
     trajectory = 'DC' => '4',
     trajectory = 'DD' => '3',
     trajectory = 'DE' => '3',
     trajectory = 'DF' => '2',
     trajectory = 'DU' => '4',
     trajectory = 'EA' => '5',
     trajectory = 'EB' => '5',
     trajectory = 'EC' => '3',
     trajectory = 'ED' => '2',
     trajectory = 'EE' => '2',
     trajectory = 'EF' => '2',
     trajectory = 'EU' => '3',
     trajectory = 'FA' => '4',
     trajectory = 'FB' => '4',
     trajectory = 'FC' => '4',
     trajectory = 'FD' => '3',
     trajectory = 'FE' => '2',
     trajectory = 'FF' => '1',
     trajectory = 'FU' => '1',
     trajectory = 'UA' => '5',
     trajectory = 'UB' => '5',
     trajectory = 'UC' => '5',
     trajectory = 'UD' => '4',
     trajectory = 'UE' => '3',
     trajectory = 'UF' => '2',
     // trajectory = 'UU' => '-1',
     '-1');
		 
// this is experian FCRA batch feed product only where we don't have an input address
export	string2	RecentMoveEconTrajectory	:= hist2Econ + hist1Econ;		
export	string2	AddrRecentEconTrajectoryIndex	:= convertTrajectory_to_index(AddrRecentEconTrajectory);
export	string2	RecentMoveEconTrajectoryIndex	:= convertTrajectory_to_index(RecentMoveEconTrajectory);
		 
export	string1	EducationAttendedCollege	:= 	map(clam.student.file_type='H' => '1', 
													clam.student.file_type='C' => '1',
													clam.student.file_type='O' => '1',
													clam.student.file_type='M' and (clam.student.college_code<>'' or clam.student.college_type<>'' or
																												clam.student.college_name<>'') => '1',
													'0');
													
export	string2	EducationProgram2Yr	:= map(clam.student.file_type in ['', 'M'] => '-1',
																					 clam.student.college_code = '2' => '1',
																					'0');
																					
export	string2	EducationProgram4Yr	:= map(clam.student.file_type in ['', 'M'] => '-1',
																					 clam.student.college_code = '4' => '1',
																					'0');
																					
export	string2	EducationProgramGraduate	:= map(clam.student.file_type in ['', 'M'] => '-1',
																								clam.student.college_code = '1' => '1',
																								'0');
																								
export	string2	EducationInstitutionPrivate	:= map(clam.student.file_type in ['', 'M'] => '-1',
																										clam.student.college_type in ['P', 'R'] => '1',
																										'0');
																										
export	string2	EducationFieldofStudyType	:= map(
		EducationAttendedCollege='0'	                               => '-1', // null
		clam.student.college_major in ['W', 'O']                     => '1', // Art, Music
		clam.student.college_major in ['C', 'F', 'I', 'J', 'K', 'Y'] => '2', // Education, Humanities, Religion, Social Sciences, Liberal Arts, English, Journalism
		clam.student.college_major in ['B', 'P', 'R', 'S', 'Z']      => '3', // Business, Accounting, Marketing, Finance, Management
		clam.student.college_major in ['A', 'H', 'Q']                => '4', // Biological Science, Physical Science, Biology
		clam.student.college_major in ['D', 'M', 'N']                => '5', // Engineering, Computers, Architecture
		clam.student.college_major in ['G']                          => '6', // Law, Legal Studies
		clam.student.college_major in ['E', 'L', 'T', 'V']           => '7', // Health professions, Nursing, Medicine, Chiropractic
		'0');

export	string2	EducationInstitutionRating	:= if(EducationAttendedCollege='1', if(clam.student.college_tier = '', '-1', clam.student.college_tier) , '-1');		// if didn't attended college then '-1' ; changed in bug 173141
	
export	string1	AddrStability 	:= capS(clam.addr_stability, capZero, '6');

export	string2	StatusMostRecent 	:= map(CAaddrChooser=1 => statusAddr1,
																	CAaddrChooser=2 => statusAddr2,
																	CAaddrChooser=3 => statusAddr3,
																	'-1');
																	
export	string2	StatusPrevious 	:= map(PAaddrChooser=1 => statusAddr1,
																	 PAaddrChooser=2 => statusAddr2,
																	 PAaddrChooser=3 => statusAddr3,
																	 '-1');
																	 
export	string2	StatusNextPrevious	:= map((CAaddrChooser=1 and PAaddrChooser=2) OR (CAaddrChooser=2 and PAaddrChooser=1) => statusAddr3,
																	 (CAaddrChooser=1 and PAaddrChooser=3) OR (CAaddrChooser=3 and PAaddrChooser=1) => statusAddr2,
																	 '-1');
																							 
export	string3	AddrChangeCount01	:= capS((string)clam.other_address_info.addrs_last30, capZero, cap255);

	shared addr_change_count03 := clam.other_address_info.addrs_last90;
export	string3	AddrChangeCount03	:= capS((string)addr_change_count03, capZero, cap255);

export	string3	AddrChangeCount06	:= capS((string)clam.velocity_counters.addrs_per_adl_created_6months, capZero, cap255);

export	string3	AddrChangeCount12	:= capS((string)clam.other_address_info.addrs_last12, capZero, cap255);

export	string3	AddrChangeCount24 	:= capS((string)clam.other_address_info.addrs_last24, capZero, cap255);

export	string3	AddrChangeCount60 	:= capS((string)clam.other_address_info.addrs_last_5years, capZero, cap255);

export	string10	EstimatedAnnualIncome	:= capS((string)clam.estimated_income, capZero, capMax) ;
	
export	string1	PropertyOwner	:= checkboolean(clam.address_verification.owned.property_total>0);

export string3 PropOwnedCount := capS((string)clam.address_verification.owned.property_total, capZero, cap255);
export string3 PropRealSourceCount := PropOwnedCount; // as of CBD4, use the same logic as PropOwnedCount but a different name

export	string10	PropOwnedTaxTotal	:= capS((string)clam.address_verification.owned.property_owned_assessed_total, capZero, capMax);

export	string3	PropOwnedHistoricalCount	:= capS((string)(clam.address_verification.owned.property_total + clam.address_verification.sold.property_total + clam.address_verification.ambiguous.property_total), capZero, cap255);

	shared	date_first_purchase := if(clam.other_address_info.date_first_purchase>ageDate, 0, 
															if( ((string)clam.other_address_info.date_first_purchase)[5..6]='00',
																(unsigned)(((string)clam.other_address_info.date_first_purchase)[1..4]+'01'+ ((string)clam.other_address_info.date_first_purchase)[7..8]),
																clam.other_address_info.date_first_purchase));
																
	shared	date_most_recent_purchase := if(clam.other_address_info.date_most_recent_purchase>ageDate, 0, 
																		if(((string)clam.other_address_info.date_most_recent_purchase)[5..6]='00',
																			(unsigned)(((string)clam.other_address_info.date_most_recent_purchase)[1..4]+'01'+((string)clam.other_address_info.date_most_recent_purchase)[7..8]),
																			clam.other_address_info.date_most_recent_purchase));
																			
	shared	date_first_sale := if(clam.other_address_info.date_first_sale>ageDate, 0, clam.other_address_info.date_first_sale);										 	
	shared	date_most_recent_sale := if(clam.other_address_info.date_most_recent_sale>ageDate, 0, clam.other_address_info.date_most_recent_sale);										 	
		
export	string3	PropAgeOldestPurchase	:= if(date_first_purchase=0, '-1', 
																						capS((string)round((ut.DaysApart((string)date_first_purchase,	(string)sysdate)) / 30), capZero, cap960) );
																						
export	string3	PropAgeNewestPurchase	:= if(date_most_recent_purchase=0, '-1', 
																				capS((string)round((ut.DaysApart((string)date_most_recent_purchase,	(string)sysdate)) / 30), capZero, cap960) );
																				
export	string3	PropAgeNewestSale	:= if(date_most_recent_sale=0, '-1', 
															capS((string)round((ut.DaysApart((string)date_most_recent_sale,	(string)sysdate)) / 30), capZero, cap960) );
															
export	string10	PropNewestSalePrice	:= if(clam.address_verification.recent_property_sales.sale_price1=0, '-1',
															capS((string)clam.address_verification.recent_property_sales.sale_price1, capZero, capMax) );
															
export	string5	PropNewestSalePurchaseIndex	:= if(clam.address_verification.recent_property_sales.sale_price1=0, '-1',
							trim((string)(decimal4_2)(capR((clam.address_verification.recent_property_sales.sale_price1 / clam.address_verification.recent_property_sales.prev_purch_price1), (REAL)capZero, 99.0))) ); // sale price / purchase price

export	string3	PropPurchasedCount01	:= capS((string)clam.other_address_info.num_purchase30, capZero, cap255);
export	string3	PropPurchasedCount03	:= capS((string)clam.other_address_info.num_purchase90, capZero, cap255);
export	string3	PropPurchasedCount06	:= capS((string)clam.other_address_info.num_purchase180, capZero, cap255);
export	string3	PropPurchasedCount12	:= capS((string)clam.other_address_info.num_purchase12, capZero, cap255);
export	string3	PropPurchasedCount24	:= capS((string)clam.other_address_info.num_purchase24, capZero, cap255);
export	string3	PropPurchasedCount60	:= capS((string)clam.other_address_info.num_purchase60, capZero, cap255);
	
export	string3	PropSoldCount01	:= capS((string)clam.other_address_info.num_sold30, capZero, cap255);
export	string3	PropSoldCount03	:= capS((string)clam.other_address_info.num_sold90, capZero, cap255);
export	string3	PropSoldCount06	:= capS((string)clam.other_address_info.num_sold180, capZero, cap255);
export	string3	PropSoldCount12	:= capS((string)clam.other_address_info.num_sold12, capZero, cap255);
export	string3	PropSoldCount24 	:= capS((string)clam.other_address_info.num_sold24, capZero, cap255);
export	string3	PropSoldCount60 	:= capS((string)clam.other_address_info.num_sold60, capZero, cap255);

export	string1	AssetOwner	:= checkboolean(clam.watercraft.watercraft_count>0 or clam.aircraft.aircraft_count>0 or clam.address_verification.owned.property_total>0)	;

export string1 AssetVerifiedIdentity := AssetOwner; // as of CBD4, use the same logic as AssetOwner but a different name.
export string1 PropRealVerifiedIdentity := checkboolean( clam.address_verification.owned.property_total > 0 );

export string1 PropPersVerifiedIdentity := checkboolean(clam.aircraft.aircraft_count > 0 or clam.watercraft.watercraft_count > 0);
export string3 PropPersSourceCount := caps((string)(clam.aircraft.aircraft_count + clam.watercraft.watercraft_count), capZero, cap255);

export	string1	WatercraftOwner	:= checkboolean(clam.watercraft.watercraft_count>0);
export	string3	WatercraftCount	:= capS((string)clam.watercraft.watercraft_count, capZero, cap255);
export	string3	WatercraftCount01	:= capS((string)clam.watercraft.watercraft_count30, capZero, cap255);
export	string3	WatercraftCount03	:= capS((string)clam.watercraft.watercraft_count90, capZero, cap255);
export	string3	WatercraftCount06	:= capS((string)clam.watercraft.watercraft_count180, capZero, cap255);
export	string3	WatercraftCount12 	:= capS((string)clam.watercraft.watercraft_count12, capZero, cap255);
export	string3	WatercraftCount24	:= capS((string)clam.watercraft.watercraft_count24, capZero, cap255);
export	string3	WatercraftCount60 	:= capS((string)clam.watercraft.watercraft_count60, capZero, cap255);

export	string1	AircraftOwner	:= checkboolean(clam.aircraft.aircraft_count>0)	;
export	string3	AircraftCount	:= capS((string)clam.aircraft.aircraft_count, capZero, cap255);
export	string3	AircraftCount01	:= capS((string)clam.aircraft.aircraft_count30, capZero, cap255);
export	string3	AircraftCount03	:= capS((string)clam.aircraft.aircraft_count90, capZero, cap255);
export	string3	AircraftCount06	:= capS((string)clam.aircraft.aircraft_count180, capZero, cap255);
export	string3	AircraftCount12 := capS((string)clam.aircraft.aircraft_count12, capZero, cap255);
export	string3	AircraftCount24	:= capS((string)clam.aircraft.aircraft_count24, capZero, cap255);
export	string3	AircraftCount60 := capS((string)clam.aircraft.aircraft_count60, capZero, cap255);
	
export	string2	WealthIndex 	:= if(clam.wealth_indicator in ['0', ''], '-1', capS(clam.wealth_indicator, capZero, '6'));

export	string2	BusinessActiveAssociation	:= map(clam.did=0 => '-1', 
																									(clam.employment.business_ct-clam.employment.dead_business_ct) > 0 => '1', 
																									'0');
																									
export	string2	BusinessInactiveAssociation	:= map(clam.did=0 => '-1',
																									clam.employment.dead_business_ct<>0 => '1',
																									'0');		
																									
export	string3	BusinessAssociationAge	:= if(clam.employment.first_seen_date=0, '-1', 
					capS((string)round((ut.DaysApart((string)clam.employment.first_seen_date, (string)ageDate)) / 30), capZero, cap960) );	
					
export	string100	BusinessTitle	:= if(trim(clam.employment.company_title)='', '-1', clam.employment.company_title);
	shared felony_count := clam.bjl.felony_count;
export	string3	FelonyCount	:= capS((string)felony_count, capZero, cap255);

	shared last_felony_date := if(clam.bjl.last_felony_date>ageDate, 0, clam.bjl.last_felony_date);
export	string3	FelonyAge	:= if(last_felony_date=0, '-1', 
					capS((string)round((ut.DaysApart((string)last_felony_date, (string)sysdate)) / 30), capZero, if(isFCRA,cap84,cap960)) );
					
export	string3	FelonyCount01	:= capS((string)clam.bjl.criminal_count30, capZero, cap255);
	shared felony_count03 := clam.bjl.criminal_count90;
export	string3	FelonyCount03	:= capS((string)felony_count03, capZero, cap255) ;
export	string3	FelonyCount06	:= capS((string)clam.bjl.criminal_count180, capZero, cap255) ;
export	string3	FelonyCount12	:= capS((string)clam.bjl.criminal_count12, capZero, cap255) ;
export	string3	FelonyCount24	:= capS((string)clam.bjl.criminal_count24, capZero, cap255) ;
export	string3	FelonyCount60	:= capS((string)clam.bjl.criminal_count60, capZero, cap255) ;
	
export	string3	LienCount	:= capS((string)(clam.bjl.liens_historical_unreleased_count + clam.bjl.liens_recent_unreleased_count +
														 clam.bjl.liens_historical_released_count + clam.bjl.liens_recent_released_count), capZero, cap255);
														 
shared lien_filed_count := (clam.bjl.liens_historical_unreleased_count + clam.bjl.liens_recent_unreleased_count);
export	string3	LienFiledCount	:= capS((string)lien_filed_count, capZero, cap255);
shared last_lien_filed_date := if((unsigned)clam.bjl.last_liens_unreleased_date>ageDate, 0, (unsigned)clam.bjl.last_liens_unreleased_date);	
export	string3	LienFiledAge	:= if(last_lien_filed_date=0, '-1', capS((string)round((ut.DaysApart((string)last_lien_filed_date, (string)sysdate)) / 30), capZero, if(isFCRA,cap84,cap960)) );

shared last_lien_date := if(
	max( (unsigned4)clam.bjl.last_liens_unreleased_date, clam.bjl.last_liens_released_date ) > ageDate, 0,
	max( (unsigned4)clam.bjl.last_liens_unreleased_date, clam.bjl.last_liens_released_date )
);
export	string3	LienAge	:= if(last_lien_filed_date=0, '-1', capS((string)round((ut.DaysApart((string)last_lien_date, (string)sysdate)) / 30), capZero, if(isFCRA,cap84,cap960)) );

export	string3	LienFiledCount01	:= capS((string)clam.bjl.liens_unreleased_count30, capZero, cap255);
shared lien_filed_count03 := clam.bjl.liens_unreleased_count90;
export	string3	LienFiledCount03	:= capS((string)lien_filed_count03, capZero, cap255);
export	string3	LienFiledCount06	:= capS((string)clam.bjl.liens_unreleased_count180, capZero, cap255);
export	string3	LienFiledCount12	:= capS((string)clam.bjl.liens_unreleased_count12, capZero, cap255);
export	string3	LienFiledCount24	:= capS((string)clam.bjl.liens_unreleased_count24, capZero, cap255);
export	string3	LienFiledCount60	:= capS((string)clam.bjl.liens_unreleased_count60, capZero, cap255);
	
	shared lien_released_count := (clam.bjl.liens_historical_released_count + clam.bjl.liens_recent_released_count);
export	string3	LienReleasedCount	:= capS((string)lien_released_count, capZero, cap255);
		shared last_lien_released_date := if(clam.bjl.last_liens_released_date>ageDate, 0, clam.bjl.last_liens_released_date);
export	string3	LienReleasedAge	:= if(last_lien_released_date=0, '-1', capS((string)round((ut.DaysApart((string)last_lien_released_date, (string)sysdate)) / 30), capZero, if(isFCRA, cap84, cap960)) );
export	string3	LienReleasedCount01	:= capS((string)clam.bjl.liens_released_count30, capZero, cap255);
export	string3	LienReleasedCount03	:= capS((string)clam.bjl.liens_released_count90, capZero, cap255);
export	string3	LienReleasedCount06	:= capS((string)clam.bjl.liens_released_count180, capZero, cap255);
export	string3	LienReleasedCount12	:= capS((string)clam.bjl.liens_released_count12, capZero, cap255);
export	string3	LienReleasedCount24	:= capS((string)clam.bjl.liens_released_count24, capZero, cap255);
export	string3	LienReleasedCount60	:= capS((string)clam.bjl.liens_released_count60, capZero, cap255);
	
export	string10	LienFiledTotal	:= capS((string)
			(clam.liens.liens_unreleased_federal_tax.total_amount +
			clam.liens.liens_unreleased_other_tax.total_amount +
			clam.liens.liens_unreleased_foreclosure.total_amount +
			clam.liens.liens_unreleased_landlord_tenant.total_amount +
			clam.liens.liens_unreleased_civil_judgment.total_amount +
			clam.liens.liens_unreleased_small_claims.total_amount +
			clam.liens.liens_unreleased_other_lj.total_amount), capZero, capMax);

export	string10	LienFederalTaxFiledTotal	:= capS((string)clam.liens.liens_unreleased_federal_tax.total_amount, capZero, capMax);
export	string10	LienTaxOtherFiledTotal	:= capS((string)clam.liens.liens_unreleased_other_tax.total_amount, capZero, capMax);
export	string10	LienForeclosureFiledTotal	:= capS((string)clam.liens.liens_unreleased_foreclosure.total_amount, capZero, capMax);
export	string10	LienLandlordTenantFiledTotal	:= capS((string)clam.liens.liens_unreleased_landlord_tenant.total_amount, capZero, capMax);
export	string10	LienJudgmentFiledTotal	:= capS((string)clam.liens.liens_unreleased_civil_judgment.total_amount, capZero, capMax);
export	string10	LienSmallClaimsFiledTotal	:= capS((string)clam.liens.liens_unreleased_small_claims.total_amount, capZero, capMax);
export	string10	LienOtherFiledTotal	:= capS((string)clam.liens.liens_unreleased_other_lj.total_amount, capZero, capMax);

export	string10	LienReleasedTotal	:= capS((string)
			(clam.liens.liens_released_federal_tax.total_amount +
			clam.liens.liens_released_other_tax.total_amount +
			clam.liens.liens_released_foreclosure.total_amount +
			clam.liens.liens_released_landlord_tenant.total_amount +
			clam.liens.liens_released_civil_judgment.total_amount +
			clam.liens.liens_released_small_claims.total_amount +
			clam.liens.liens_released_other_lj.total_amount), capZero, capMax);

export	string10	LienFederalTaxReleasedTotal	:= capS((string)clam.liens.liens_released_federal_tax.total_amount, capZero, capMax);
export	string10	LienTaxOtherReleasedTotal	:= capS((string)clam.liens.liens_released_other_tax.total_amount, capZero, capMax);
export	string10	LienForeclosureReleasedTotal	:= capS((string)clam.liens.liens_released_foreclosure.total_amount, capZero, capMax);
export	string10	LienLandlordTenantReleasedTotal	:= capS((string)clam.liens.liens_released_landlord_tenant.total_amount, capZero, capMax);
export	string10	LienJudgmentReleasedTotal	:= capS((string)clam.liens.liens_released_civil_judgment.total_amount, capZero, capMax);
export	string10	LienSmallClaimsReleasedTotal	:= capS((string)clam.liens.liens_released_small_claims.total_amount, capZero, capMax);
export	string10	LienOtherReleasedTotal	:= capS((string)clam.liens.liens_released_other_lj.total_amount, capZero, capMax);

export	string3	LienFederalTaxFiledCount	:= capS((string)clam.liens.liens_unreleased_federal_tax.count, capZero, cap255);
export	string3	LienTaxOtherFiledCount	:= capS((string)clam.liens.liens_unreleased_other_tax.count, capZero, cap255);
export	string3	LienForeclosureFiledCount	:= capS((string)clam.liens.liens_unreleased_foreclosure.count, capZero, cap255);
export	string3	LienLandlordTenantFiledCount	:= capS((string)clam.liens.liens_unreleased_landlord_tenant.count, capZero, cap255);
export	string3	LienJudgmentFiledCount	:= capS((string)clam.liens.liens_unreleased_civil_judgment.count, capZero, cap255);
export	string3	LienSmallClaimsFiledCount	:= capS((string)clam.liens.liens_unreleased_small_claims.count, capZero, cap255);
export	string3	LienOtherFiledCount	:= capS((string)clam.liens.liens_unreleased_other_lj.count, capZero, cap255);

export	string3	LienFederalTaxReleasedCount	:= capS((string)clam.liens.liens_released_federal_tax.count, capZero, cap255);
export	string3	LienTaxOtherReleasedCount	:= capS((string)clam.liens.liens_released_other_tax.count, capZero, cap255);
export	string3	LienForeclosureReleasedCount	:= capS((string)clam.liens.liens_released_foreclosure.count, capZero, cap255);
export	string3	LienLandlordTenantReleasedCount	:= capS((string)clam.liens.liens_released_landlord_tenant.count, capZero, cap255);
export	string3	LienJudgmentReleasedCount	:= capS((string)clam.liens.liens_released_civil_judgment.count, capZero, cap255);
export	string3	LienSmallClaimsReleasedCount	:= capS((string)clam.liens.liens_released_small_claims.count, capZero, cap255);
export	string3	LienOtherReleasedCount	:=  capS((string)clam.liens.liens_released_other_lj.count, capZero, cap255);

	shared bankruptcy_count := clam.bjl.filing_count;
export	string3	BankruptcyCount	:= capS((string)bankruptcy_count, capZero, cap255);
	shared bans_date_last_seen := if(clam.bjl.date_last_seen>ageDate, 0, clam.bjl.date_last_seen);
	shared bankruptcy_age := round((ut.DaysApart((string)bans_date_last_seen, (string)sysdate)) / 30);
export	string3	BankruptcyAge	:= if(bans_date_last_seen=0, '-1', 
								capS((string)bankruptcy_age, capZero, if( isFCRA, '120', cap960 )) );
	
export	string3	BankruptcyType	:= if(trim(clam.bjl.filing_type)='', '-1', clam.bjl.filing_type);	;
export	string35	BankruptcyStatus	:= if(trim(clam.bjl.disposition)='', '-1', clam.bjl.disposition);
export	string3	BankruptcyCount01	:= capS((string)clam.bjl.bk_count30, capZero, cap255);
	shared bankruptcy_count03 := clam.bjl.bk_count90;
export	string3	BankruptcyCount03	:= capS((string)bankruptcy_count03, capZero, cap255);
export	string3	BankruptcyCount06	:= capS((string)clam.bjl.bk_count180, capZero, cap255);
export	string3	BankruptcyCount12	:= capS((string)clam.bjl.bk_count12, capZero, cap255);
export	string3	BankruptcyCount24	:= capS((string)clam.bjl.bk_count24, capZero, cap255);
export	string3	BankruptcyCount60	:= capS((string)clam.bjl.bk_count60, capZero, cap255);

	shared eviction_count := clam.bjl.eviction_recent_unreleased_count + clam.bjl.eviction_historical_unreleased_count +
																	clam.bjl.eviction_recent_released_count + clam.bjl.eviction_historical_released_count;
export	string3	EvictionCount	:= capS((string)eviction_count, capZero, cap255);
	shared last_eviction_date := if(clam.bjl.last_eviction_date>ageDate, 0, clam.bjl.last_eviction_date);	
export	string3	EvictionAge	:= if(last_eviction_date=0, '-1', capS((string)round((ut.DaysApart((string)last_eviction_date, (string)sysdate)) / 30), capZero, if(isFCRA, cap84, cap960)) );
export	string3	EvictionCount01	:= capS((string)clam.bjl.eviction_count30, capZero, cap255);
	shared eviction_count03 := clam.bjl.eviction_count90;
export	string3	EvictionCount03	:= capS((string)eviction_count03, capZero, cap255);
export	string3	EvictionCount06	:= capS((string)clam.bjl.eviction_count180, capZero, cap255);
export	string3	EvictionCount12 	:= capS((string)clam.bjl.eviction_count12, capZero, cap255);
export	string3	EvictionCount24 	:= capS((string)clam.bjl.eviction_count24, capZero, cap255);
export	string3	EvictionCount60 	:= capS((string)clam.bjl.eviction_count60, capZero, cap255);	
		
export string1 DerogSeverityIndex := map(
		Felony_Count		       > 0 => '5',
		Eviction_Count		     > 0 => '4',
		Lien_Filed_Count       > 0 => '3',
		Bankruptcy_Count       > 0 => '2',
		Lien_Released_Count    > 0 => '1',
		'0');

// designed specifically for CBD4 so as not to conflict with the above DSI, liens and bankruptcies are collapsed into one group
// ("other derogatory public records") and felonies and evictions are shifted down.
export string1 FraudDerogSeverityIndex := map(
		Felony_Count		       > 0 => '3',
		Eviction_Count		     > 0 => '2',
		Lien_Filed_Count       > 0 => '1',
		Bankruptcy_Count       > 0 => '1',
		Lien_Released_Count    > 0 => '1',
		'0');

// per 91942, DerogCount, DerogRecentCount and DerogAge should use the same data as DerogSeverityIndex:
// liens (released & unreleased), evictions (released & unreleased), felonies, bankruptcies
export String3 DerogCount := capS( (string)(
		clam.bjl.felony_count
	+ clam.bjl.filing_count
	+ clam.bjl.liens_historical_unreleased_count
	+ clam.bjl.liens_recent_unreleased_count
	+ clam.bjl.liens_historical_released_count
	+ clam.bjl.liens_recent_released_count
	+ clam.BJL.eviction_historical_unreleased_count
	+ clam.BJL.eviction_recent_unreleased_count
	+ clam.BJL.eviction_historical_released_count
	+ clam.BJL.eviction_recent_released_count
	), capZero, cap255
);

export string3 DerogRecentCount := capS( (string)(
	  clam.bjl.criminal_count12
	+ clam.bjl.bk_count12
	+ clam.bjl.liens_unreleased_count12
	+ clam.bjl.liens_released_count12
	+ clam.bjl.eviction_count12 // eviction_count12 covers both released and unreleased evictions
	), capZero, cap255);

shared date_last_derog_1 := max(
	clam.bjl.last_felony_date,
	clam.bjl.date_last_seen,
	(unsigned4)clam.bjl.last_liens_unreleased_date,
	clam.bjl.last_liens_released_date,
	clam.bjl.last_eviction_date
);
shared date_last_derog := if( date_last_derog_1 > agedate, 0, date_last_derog_1 );

// For RiskView attributes Raise the upper cap only if an older bankruptcy is on file
export	string3	DerogAge	:= if(date_last_derog=0, '-1', 
	capS((string)round((ut.DaysApart((string)date_last_derog, (string)sysdate)) / 30), capZero, map( not isFCRA => cap960, Bankruptcy_Age > 84 => '120', cap84 )));

export	string3	NonDerogCount	:= capS((string)clam.source_verification.num_nonderogs, capZero, cap255);		
export	string3	NonDerogCount01	:= capS((string)clam.source_verification.num_nonderogs30, capZero, cap255);
	shared nonderog_count03 := clam.source_verification.num_nonderogs90;
export	string3	NonDerogCount03	:= capS((string)nonderog_count03, capZero, cap255);
export	string3	NonDerogCount06	:= capS((string)clam.source_verification.num_nonderogs180, capZero, cap255);
export	string3	NonDerogCount12	:= capS((string)clam.source_verification.num_nonderogs12, capZero, cap255);
export	string3	NonDerogCount24	:= capS((string)clam.source_verification.num_nonderogs24, capZero, cap255);
export	string3	NonDerogCount60	:= capS((string)clam.source_verification.num_nonderogs60, capZero, cap255);


export	string2	RecentActivityIndex	:= map(DerogCount='0' and (integer)NonDerogCount=0 => '-1',
																						Felony_Count03 > 0 or Eviction_Count03 > 0 => '7',
																						Lien_Filed_Count03 > 0 or Bankruptcy_Count03 > 0 => '6',
																						NonDerog_Count03<=1 and Addr_Change_Count03>=2 => '6',
																						NonDerog_Count03<=1 and Addr_Change_Count03 =1 => '5',
																						NonDerog_Count03 =2 and Addr_Change_Count03>=2 => '5',
																						NonDerog_Count03 =2 and Addr_Change_Count03 =1 => '4',
																						NonDerog_Count03 =3 and Addr_Change_Count03>=2 => '4',
																						NonDerog_Count03 =3 and Addr_Change_Count03 =1 => '3',
																						NonDerog_Count03 =2 => '3',
																						NonDerog_Count03 =3 => '2',
																						NonDerog_Count03>=4 => '1',
																						'4');

	
export	string1	VoterRegistrationRecord	:= checkboolean(StringLib.StringFind(clam.header_summary.ver_sources,mdr.sourcetools.src_Voters_v2, 1) > 0);
export	string3	ProfLicCount	:= capS((string)clam.professional_license.proflic_count, capZero, cap255);
	shared pl_date_most_recent := if(clam.professional_license.date_most_recent>ageDate, 0, clam.professional_license.date_most_recent);	
export	string3	ProfLicAge	:= if(pl_date_most_recent=0, '-1', 
	capS((string)round((ut.DaysApart((string)pl_date_most_recent, (string)sysdate)) / 30), capZero, cap960) );
	
export	string60	ProfLicType	:= if(trim(clam.professional_license.license_type)='', '-1', clam.professional_license.license_type);
export	string2	ProfLicTypeCategory	:= if(trim(clam.professional_license.license_type)='', '-1', clam.professional_license.plcategory);
	shared pl_expiration_date := if(clam.professional_license.expiration_date>ageDate, 0, clam.professional_license.date_most_recent);	
export	string2	ProfLicExpired	:= if(clam.professional_license.proflic_count=0, '-1', checkboolean(pl_expiration_date > sysdate) );
										
export	string3	ProfLicCount01	:= capS((string)clam.professional_license.proflic_count30, capZero, cap255);
export	string3	ProfLicCount03	:= capS((string)clam.professional_license.proflic_count90, capZero, cap255);
export	string3	ProfLicCount06	:= capS((string)clam.professional_license.proflic_count180, capZero, cap255);
export	string3	ProfLicCount12	:= capS((string)clam.professional_license.proflic_count12, capZero, cap255);
export	string3	ProfLicCount24	:= capS((string)clam.professional_license.proflic_count24, capZero, cap255);
export	string3	ProfLicCount60	:= capS((string)clam.professional_license.proflic_count60, capZero, cap255);
	
export	string1	InquiryCollectionsRecent	:= checkboolean(clam.acc_logs.collection.count12>0);
export	string1	InquiryPersonalFinanceRecent	:= checkboolean(clam.acc_logs.highriskcredit.count12>0);
export	string1	InquiryOtherRecent	:= checkboolean(clam.acc_logs.auto.count12>0 or 
																										clam.acc_logs.banking.count12>0 or 
																										clam.acc_logs.mortgage.count12>0 or 
																										clam.acc_logs.retail.count12>0 or 
																										clam.acc_logs.communications.count12>0 or 
																										clam.acc_logs.other.count12>0);
																										
export	string3	SubPrimeOfferRequestCount	:= capS((string)clam.impulse.count, capZero, cap255); 
export	string3	SubPrimeOfferRequestCount01	:= capS((string)clam.impulse.count30, capZero, cap255);
export	string3	SubPrimeOfferRequestCount03	:= capS((string)clam.impulse.count90, capZero, cap255);
export	string3	SubPrimeOfferRequestCount06	:= capS((string)clam.impulse.count180, capZero, cap255);
export	string3	SubPrimeOfferRequestCount12	:= capS((string)clam.impulse.count12, capZero, cap255);
export	string3	SubPrimeOfferRequestCount24	:= capS((string)clam.impulse.count24, capZero, cap255);
export	string3	SubPrimeOfferRequestCount60	:= capS((string)clam.impulse.count60, capZero, cap255);

export	string1	HighRiskCreditActivity	:= checkboolean(clam.impulse.count > 0 or clam.acc_logs.highriskcredit.count12>0);  // subprimeoffer or highriskcredit inquiry
	
export	string2	InputPhoneMobile 	:= if(noPhoneinput, '-1', checkBoolean(clam.iid.hriskphoneflag = '1'));	;

export	string3	PhoneEDAAgeOldestRecord	:= if(clam.phone_verification.gong_did.gong_adl_dt_first_seen_full='', '-1', 
		capS((string)round((ut.DaysApart(clam.phone_verification.gong_did.gong_adl_dt_first_seen_full, (string)ageDate)) / 30), capZero, cap960) );
		
export	string3	PhoneEDAAgeNewestRecord	:= if(clam.phone_verification.gong_did.gong_adl_dt_last_seen_full='', '-1', 
		capS((string)round((ut.DaysApart((string)clam.phone_verification.gong_did.gong_adl_dt_last_seen_full, (string)ageDate)) / 30), capZero, cap960) );
	
export	string3	PhoneOtherAgeOldestRecord	:= if(clam.infutor.infutor_date_first_seen=0, '-1', 
		capS((string)round((ut.DaysApart((string)clam.infutor.infutor_date_first_seen, (string)sysdate)) / 30), capZero, cap960) );
		
export	string3	PhoneOtherAgeNewestRecord	:= if(clam.infutor.infutor_date_last_seen=0, '-1', 
		capS((string)round((ut.DaysApart((string)clam.infutor.infutor_date_last_seen, (string)sysdate)) / 30), capZero, cap960) );
		
export	string2	InputPhoneHighRisk	:= if(noPhoneinput, '-1', checkBoolean(clam.iid.hriskphoneflag = '6'));

export	string2	InputPhoneProblems	:= map(noPhoneinput => '-1', 
																					clam.iid.phonetype <> '1' and clam.shell_input.phone10 <> '' => '5',  // phone invalid
																					clam.iid.disthphoneaddr > 10 and clam.iid.disthphoneaddr<>9999 => '4', // distance between phone and address greater than 10 miles
																					clam.shell_input.in_Zipcode<>'' and clam.iid.phonezipflag = '1' => '3', // phone zip mismatch
																					clam.iid.hriskphoneflag = '2' => '2', // phone is a pager
																					clam.iid.phonedissflag and clam.input_validation.homephone => '1', // phone is disconnected
																					'0');  // no problems

export	string2	EmailAddress	:= if(clam.did=0, '-1', checkboolean(clam.email_summary.email_ct>0)); // if did not available, return -1 for information not on file
export string2 OnlineDirectory := EmailAddress; // LI4 uses the term 'OnlineDirectory' instead of 'EmailAddress'

export	string2	InputAddrHighRisk	:= if(noAddrInput, '-1', checkBoolean(clam.iid.hriskaddrflag = '4'));

export	string2	CurrAddrCorrectional	:= map(noAddrInput => '-1',
																CAaddrChooser=1 => checkboolean(clam.iid.hriskaddrflag='4' AND clam.iid.hrisksic = '2225'),
																CAaddrChooser=2 => checkboolean(clam.other_address_info.hist1_isprison),
																CAaddrChooser=3 => checkboolean(clam.other_address_info.hist2_isprison),
																'-1');
																
export	string2	PrevAddrCorrectional	:= map(noAddrInput => '-1',
																PAaddrChooser=1 => checkboolean(clam.iid.hriskaddrflag='4' AND clam.iid.hrisksic = '2225'),
																PAaddrChooser=2 => checkboolean(clam.other_address_info.hist1_isprison),
																PAaddrChooser=3 => checkboolean(clam.other_address_info.hist2_isprison),
																'-1');
																
export	string2	HistoricalAddrCorrectional	:= if(clam.did=0, '-1', checkboolean(clam.other_address_info.isprison) );  // if did not available, return -1 for information not on file

export	string2	InputAddrProblems	:= map(noAddrInput=> '-1',
																					clam.iid.hriskaddrflag='4' AND clam.iid.hrisksic = '2225' => '4',
																					clam.iid.addrvalflag<>'V' => '3',  // valid address
																					clam.iid.zipclass in ['M','U'] => '2',  // military zip
																					clam.iid.zipclass='P' => '1',  // po box zip
																					'0');  // default to be valid

export	string1	SecurityFreeze	:= checkboolean(clam.consumerflags.security_freeze);
export	string1	SecurityAlert	:= checkboolean(clam.consumerflags.security_alert);
export	string1	IDTheftFlag	:= checkboolean(clam.consumerflags.id_theft_flag);
export	string1	ConsumerStatement	:= checkboolean(clam.consumerflags.consumer_statement_flag);
export	string2	PrescreenOptOut(boolean isPrescreen, boolean opt_out_hit)	:= map(not isPreScreen => '-1',
																																								 opt_out_hit => '1',
																																								 '0');


export string10 RelativesPropOwnedTaxTotal := if(clam.relatives.owned.relatives_property_owned_assessed_total=0, '-1', capS((string)clam.relatives.owned.relatives_property_owned_assessed_total, capZero, cap10Byte));


shared InputAddrMobilityRatio := (clam.addr_risk_summary.turnover_1yr_in + clam.addr_risk_summary.turnover_1yr_out)/ clam.addr_risk_summary.occupants_1yr;
export string3 InputAddrMobilityIndex := map(
	noAddrinput => '-1', // address not input or no info on file
	clam.addr_risk_summary.occupants_1yr = 0 => '0', // unable to calculate
	InputAddrMobilityRatio = 0 => '0', // no data for in/out turnover assumed to be an incalculable scenario
	InputAddrMobilityRatio < 0.1 => '0.1',
	round(InputAddrMobilityRatio) >= 10 => (string)round(InputAddrMobilityRatio), // two-digit values show up without trailing decimal ('27' instead of '27.')
	realformat( InputAddrMobilityRatio, 3, 1 )
);


export string3 InputAddrVacantPropCount   := capS( (string)clam.addr_risk_summary.n_vacant_properties, capZero, cap255 );
export string3 InputAddrBusinessCount     := capS( (string)clam.addr_risk_summary.n_business_count, capZero, cap255 );
export string3 InputAddrSingleFamilyCount := capS( (string)clam.addr_risk_summary.n_sfd_count, capZero, cap255 );
export string3 InputAddrMultiFamilyCount  := capS( (string)clam.addr_risk_summary.n_mfd_count, capZero, cap255 );





shared CensusAttr( EASI.Layout_Easi_Census cen ) := MODULE
	export boolean Hit := trim(cen.geolink)!='';
	export string10 MedianIncome := if( not hit or trim(cen.med_hhinc)='', '-1', (string)min((unsigned)cap10Byte, (unsigned)cen.med_hhinc));
	export string10 MedianValue  := if( not hit or trim(cen.med_hval)='',  '-1', (string)min((unsigned)cap10Byte, (unsigned)cen.med_hval));
	export string4 Crime         := if( not hit or trim(cen.totcrime)='', '-1', (string)min(200, (unsigned)trim(cen.totcrime)) );
	export string4 Murder        := if( not hit or trim(cen.murders)='', '-1', (string)min(200, (unsigned)trim(cen.murders)) );
	export string4 CarTheft      := if( not hit or trim(cen.cartheft)='', '-1', (string)min(200, (unsigned)trim(cen.cartheft)) );
	export string4 Burglary      := if( not hit or trim(cen.burglary)='', '-1', (string)min(200, (unsigned)trim(cen.burglary)) );	
END;

export IACensus := CensusAttr( inEasi );
export CACensus := CensusAttr( case( CAAddrChooser, 1=>inEasi, 2=>Easi1, 3=>Easi2, blankEasi ) );
export PACensus := CensusAttr( case( PAAddrChooser, 1=>inEasi, 2=>Easi1, 3=>Easi2, blankEasi ) );
export MRACensus := CensusAttr( case( MostRecentAddrChooser, 1=>Easi1, 2=>Easi2, blankEasi ) ); // Most Recent Address Census

export string11 AddrMostRecentIncomeDiff := if( '-1' in [IACensus.MedianIncome, MRACensus.MedianIncome], '-1', (string)preserveNull((integer)IACensus.MedianIncome - (integer)MRACensus.MedianIncome) );
export string11 AddrMostRecentValueDIff  := if( '-1' in [IACensus.MedianValue,  MRACensus.MedianValue],  '-1', (string)preserveNull((integer)IACensus.MedianValue - (integer)MRACensus.MedianValue) );
export string4  AddrMostRecentCrimeDiff  := if( '-1' in [IACensus.Crime,        MRACensus.Crime],        '-1', (string)preserveNull((integer)IACensus.Crime - (integer)MRACensus.Crime) );



export string3 BusinessInputAddrCount := if( noAddrinput, '-1', (string)min(255,clam.business_header_address_summary.bus_addr_match_cnt) );
export string3 AccidentCount := (string)min(255,clam.accident_data.acc.num_accidents);
export string3 AccidentAge := if(clam.accident_data.acc.datelastaccident=0, '-1', caps((string)round((ut.daysapart((string)clam.accident_data.acc.datelastaccident, (string)sysdate)) / 30), capZero, cap960) );

shared string3 agecalc( unsigned4 dt ) := if(dt=0, '-1', capS((string)round((ut.DaysApart((string)dt, (string)sysdate)) / 30), capZero, cap960) );

export	string3	SearchAgeOldestRecord	:= agecalc( (unsigned4)clam.acc_logs.first_log_date );
export	string3	SearchAgeNewestRecord := agecalc( (unsigned4)clam.acc_logs.last_log_date );

export string3 PRSearchLocateCount                 := (string)min( 255, clam.acc_logs.collection.counttotal );
export string3 PRSearchLocateCount01               := (string)min( 255, clam.acc_logs.collection.count01 );
export string3 PRSearchLocateCount03               := (string)min( 255, clam.acc_logs.collection.count03 );
export string3 PRSearchLocateCount06               := (string)min( 255, clam.acc_logs.collection.count06 );
export string3 PRSearchLocateCount12               := (string)min( 255, clam.acc_logs.collection.count12 );
export string3 PRSearchLocateCount24               := (string)min( 255, clam.acc_logs.collection.count24 );
export string3 PRSearchPersonalFinanceCount        := (string)min( 255, clam.acc_logs.highriskcredit.counttotal );
export string3 PRSearchPersonalFinanceCount01      := (string)min( 255, clam.acc_logs.highriskcredit.count01 );
export string3 PRSearchPersonalFinanceCount03      := (string)min( 255, clam.acc_logs.highriskcredit.count03 );
export string3 PRSearchPersonalFinanceCount06      := (string)min( 255, clam.acc_logs.highriskcredit.count06 );
export string3 PRSearchPersonalFinanceCount12      := (string)min( 255, clam.acc_logs.highriskcredit.count12 );
export string3 PRSearchPersonalFinanceCount24      := (string)min( 255, clam.acc_logs.highriskcredit.count24 );    
export string3 PRSearchOtherCount                  := (string)min( 255, clam.acc_logs.auto.counttotal + clam.acc_logs.banking.counttotal + clam.acc_logs.Mortgage.counttotal + clam.acc_logs.Retail.counttotal + clam.acc_logs.Communications.counttotal + clam.acc_logs.Other.counttotal );
export string3 PRSearchOtherCount01                := (string)min( 255, clam.acc_logs.auto.count01    + clam.acc_logs.banking.count01    + clam.acc_logs.Mortgage.count01    + clam.acc_logs.Retail.count01    + clam.acc_logs.Communications.count01    + clam.acc_logs.Other.count01 );
export string3 PRSearchOtherCount03                := (string)min( 255, clam.acc_logs.auto.count03    + clam.acc_logs.banking.count03    + clam.acc_logs.Mortgage.count03    + clam.acc_logs.Retail.count03    + clam.acc_logs.Communications.count03    + clam.acc_logs.Other.count03 );
export string3 PRSearchOtherCount06                := (string)min( 255, clam.acc_logs.auto.count06    + clam.acc_logs.banking.count06    + clam.acc_logs.Mortgage.count06    + clam.acc_logs.Retail.count06    + clam.acc_logs.Communications.count06    + clam.acc_logs.Other.count06 );
export string3 PRSearchOtherCount12                := (string)min( 255, clam.acc_logs.auto.count12    + clam.acc_logs.banking.count12    + clam.acc_logs.Mortgage.count12    + clam.acc_logs.Retail.count12    + clam.acc_logs.Communications.count12    + clam.acc_logs.Other.count12 );
export string3 PRSearchOtherCount24                := (string)min( 255, clam.acc_logs.auto.count24    + clam.acc_logs.banking.count24    + clam.acc_logs.Mortgage.count24    + clam.acc_logs.Retail.count24    + clam.acc_logs.Communications.count24    + clam.acc_logs.Other.count24 );

export string3 PRSearchRetailCount                  := (string)min( 255, clam.acc_logs.Retail.counttotal );
export string3 PRSearchRetailCount01                := (string)min( 255, clam.acc_logs.Retail.count01    );
export string3 PRSearchRetailCount03                := (string)min( 255, clam.acc_logs.Retail.count03    );
export string3 PRSearchRetailCount06                := (string)min( 255, clam.acc_logs.Retail.count06    );
export string3 PRSearchRetailCount12                := (string)min( 255, clam.acc_logs.Retail.count12    );
export string3 PRSearchRetailCount24                := (string)min( 255, clam.acc_logs.Retail.count24    );

export string3 PRSearchIdentitySSNs                := (string)min( 255, clam.acc_logs.inquiryssnsperadl );
export string3 PRSearchIdentityAddrs               := (string)min( 255, clam.acc_logs.inquiryaddrsperadl );
export string3 PRSearchIdentityPhones              := (string)min( 255, clam.acc_logs.inquiryphonesperadl );
export string3 PRSearchSSNIdentities               := (string)min( 255, clam.acc_logs.inquiryadlsperssn );
export string3 PRSearchAddrIdentities              := (string)min( 255, clam.acc_logs.inquiryadlsperaddr );
export string3 PRSearchPhoneIdentities             := (string)min( 255, clam.acc_logs.inquiryadlsperphone );



	// inquiry attributes relating to chargeback defender
   	export string3 SearchNonCBDAgeOldestRecord := agecalc( (unsigned4)clam.acc_logs.noncbd_first_log_date );
   	export string3 SearchNonCBDAgeNewestRecord := agecalc( (unsigned4)clam.acc_logs.noncbd_last_log_date );
   
   	export string3 SearchCBDAgeOldestRecord    := agecalc( (unsigned4)clam.acc_logs.cbd_first_log_date);
   	export string3 SearchCBDAgeNewestRecord    := agecalc( (unsigned4)clam.acc_logs.cbd_last_log_date);
   
   	export string3 SearchCBDAddrIdentities             := (string)min( 255, clam.acc_logs.cbd_inquiryadlsperaddr );
   	export string3 SearchCBDIdentityAddrs              := (string)min( 255, clam.acc_logs.cbd_inquiryaddrsperadl );
   	export string3 SearchCBDIdentityPhones             := (string)min( 255, clam.acc_logs.cbd_inquiryphonesperadl );
   
   
   	// PRSearchCount is the sum of all auto, banking, ..., other industries -- both Chargeback Defender inquiries and non-Chargeback Defender inquiries
   	// SearchCBDCount will be the same, but use 'cbd' fields
   	export string3 SearchCBDCount                  := (string)min( 255, clam.acc_logs.auto.cbdcounttotal + clam.acc_logs.banking.cbdcounttotal + clam.acc_logs.Mortgage.cbdcounttotal + clam.acc_logs.Retail.cbdcounttotal + clam.acc_logs.Communications.cbdcounttotal + clam.acc_logs.Other.cbdcounttotal );
   	export string3 SearchCBDCount01                := (string)min( 255, clam.acc_logs.auto.cbdcount01    + clam.acc_logs.banking.cbdcount01    + clam.acc_logs.Mortgage.cbdcount01    + clam.acc_logs.Retail.cbdcount01    + clam.acc_logs.Communications.cbdcount01    + clam.acc_logs.Other.cbdcount01 );
    
		// and "oth" fields are non-cbd, which is the difference between all and cbd
   	export string3 SearchOthCount                  := (string)( min(255,
			/* PRSearchOtherCount values */  (clam.acc_logs.auto.counttotal + clam.acc_logs.banking.counttotal + clam.acc_logs.Mortgage.counttotal + clam.acc_logs.Retail.counttotal + clam.acc_logs.Communications.counttotal + clam.acc_logs.Other.counttotal)
			/* SearchCBDCount values     */ -(clam.acc_logs.auto.cbdcounttotal + clam.acc_logs.banking.cbdcounttotal + clam.acc_logs.Mortgage.cbdcounttotal + clam.acc_logs.Retail.cbdcounttotal + clam.acc_logs.Communications.cbdcounttotal + clam.acc_logs.Other.cbdcounttotal )
		));
   	export string3 SearchOthCount01                := (string)( min(255,
			/* PRSearchOtherCount01 values */  (clam.acc_logs.auto.count01 + clam.acc_logs.banking.count01 + clam.acc_logs.Mortgage.count01 + clam.acc_logs.Retail.count01 + clam.acc_logs.Communications.count01 + clam.acc_logs.Other.count01)
			/* SearchCBDCount01 values     */ -(clam.acc_logs.auto.cbdcount01 + clam.acc_logs.banking.cbdcount01 + clam.acc_logs.Mortgage.cbdcount01 + clam.acc_logs.Retail.cbdcount01 + clam.acc_logs.Communications.cbdcount01 + clam.acc_logs.Other.cbdcount01 )
		));
	//

// Bill-to-/Ship-to-specific attributes
	shared boolean knownBT := BillToShipTo.bill_to_out.did<>0;
	shared boolean knownST := BillToShipTo.ship_to_out.did<>0;
	shared boolean btPhoneNotInput := not BillToShipTo.Bill_To_Out.input_validation.HomePhone;
	shared boolean btAddrNotInput	 := not BillToShipTo.Bill_To_Out.input_validation.Address;
	shared boolean stPhoneNotInput := not BillToShipTo.Ship_To_Out.input_validation.HomePhone;
	shared boolean stAddrNotInput	 := not BillToShipTo.Ship_To_Out.input_validation.Address;


	export string2 BillToShipToSameIdentity := map(
		~knownBT or ~knownST => '-1',
		BillToShipTo.bill_to_out.did=BillToShipTo.ship_to_out.did => '1',
		'0');
	export string2 BillToShipToSameName := map(
		BillToShipTo.bill_to_out.shell_input.fname='' or BillToShipTo.bill_to_out.shell_input.lname='' or
		BillToShipTo.ship_to_out.shell_input.fname='' or BillToShipTo.ship_to_out.shell_input.lname='' => '-1',	
		risk_indicators.iid_constants.g((unsigned)BillToShipTo.eddo.firstscore) and risk_indicators.iid_constants.g((unsigned)BillToShipTo.eddo.lastscore) => '1',
		'0');	
	export string2 BillToShipToSameAddr := map(
		btAddrNotInput or stAddrNotInput => '-1',
		risk_indicators.iid_constants.ga((unsigned)BillToShipTo.eddo.addrscore) => '1',
		'0');	
	export string2 BillToFNameFoundEmail := map(
		BillToShipTo.bill_to_out.shell_input.fname='' or BillToShipTo.bill_to_out.shell_input.email_address='' => '-1',
		(integer)BillToShipTo.eddo.efirstscore > 0 => '1',
		'0');	
	export string2 BillToLNameFoundEmail := map(
		BillToShipTo.bill_to_out.shell_input.lname='' or BillToShipTo.bill_to_out.shell_input.email_address='' => '-1',
		(integer)BillToShipTo.eddo.elastscore > 0 => '1',
		'0');	
	export string2 ShipToFNameFoundEmail := map(
		BillToShipTo.ship_to_out.shell_input.fname='' or BillToShipTo.bill_to_out.shell_input.email_address='' => '-1',
		(integer)BillToShipTo.eddo.efirst2score > 0 => '1',
		'0');	
	export string2 ShipToLNameFoundEmail := map(
		BillToShipTo.ship_to_out.shell_input.lname='' or BillToShipTo.bill_to_out.shell_input.email_address='' => '-1',
		(integer)BillToShipTo.eddo.elast2score > 0 => '1',
		'0');	
	export string4 BillToPhoneBillToAddrDist := if(btPhoneNotInput or btAddrNotInput  or BillToShipTo.eddo.distphoneaddr='',    '-1', BillToShipTo.eddo.distphoneaddr);
	export string4 ShipToPhoneShipToAddrDist := if(stPhoneNotInput or stAddrNotInput  or BillToShipTo.eddo.distphone2addr2='',  '-1', BillToShipTo.eddo.distphone2addr2);
	export string4 BillToPhoneShipToAddrDist := if(btPhoneNotInput or stAddrNotInput  or BillToShipTo.eddo.distphoneaddr2='',   '-1', BillToShipTo.eddo.distphoneaddr2);
	export string4 BillToShipToPhoneDist     := if(btPhoneNotInput or stPhoneNotInput or BillToShipTo.eddo.distphonephone2='',  '-1', BillToShipTo.eddo.distphonephone2);
	export string4 BillToShipToAddrDist      := if(btAddrNotInput  or stAddrNotInput  or BillToShipTo.eddo.distaddraddr2='',    '-1', BillToShipTo.eddo.distaddraddr2);
	export string4 BillToAddrShipToPhoneDist := if(btAddrNotInput  or stPhoneNotInput or BillToShipTo.eddo.distaddrphone2='',   '-1', BillToShipTo.eddo.distaddrphone2);

	export string2 BillToShipToRelative := map(
		~knownBT or ~knownST => '-1',
		BillToShipTo.eddo.btst_are_relatives => '1',
		'0');
	export string2 BillToShipToCommonRelative := map(~knownBT or ~knownST => '-1',
		BillToShipTo.eddo.btst_relatives_in_common => '1',
		'0');	


	shared identity_sources := models.common.zip2(clam.header_summary.ver_sources, clam.header_summary.ver_sources_recordcount);

	shared bureau_sources := Risk_Indicators.iid_constants.bureau_sources;
	shared credit_bureau_sourced := count(identity_sources(str1 in bureau_sources)) > 0;
	shared non_credit_bureau_sourced := count(identity_sources(str1 not in bureau_sources)) > 0;
	shared credit_bureau_only := credit_bureau_sourced and not non_credit_bureau_sourced;
	shared non_credit_bureau_only := non_credit_bureau_sourced and not credit_bureau_sourced;

// (9) - Identity is reported as deceased
// (8) - Identity associated with an invalid SSN or a SSN issued prior to date of birth
// (7) - Identity only reported by credit bureaus and reported with a SSN that is associated with multiple individuals
// (6) - Identity found on only non-credit bureau sources and first reported more than one year ago
// (5) - Identity found on credit bureau and non-credit bureau sources but not updated within the last year
// (4) - Identity only reported by credit bureaus
// (3) - Identity first reported within the last year
// (2) - Identity reported by bureau and non-bureau with a SSN that is associated with multiple individuals 
// (1) - Identity found on credit bureau and non-credit bureau sources and updated within the last year
// (-1) - Identity not found
export string2 IdentityRiskLevel := map(
			clam.iid.decsflag='1' or // ssn deceased
			stringlib.stringfind(clam.header_summary.ver_sources, 'DE', 1) > 0 // ADL had death record on header
			=> '9',
			clam.iid.socsdobflag='1' or   	// issued prior to DOB
			not clam.SSN_Verification.Validation.valid   // invalid ssn	
			=> '8',
			credit_bureau_only and // Identity only reported by credit bureaus
			risk_indicators.rcSet.isCodeMI(clam.Velocity_Counters.adls_per_ssn_seen_18months) // reported with a SSN that is associated with multiple individuals
			=> '7', 
			non_credit_bureau_only and (unsigned)age_oldest_record > 12  // Identity found on only non-credit bureau sources and first reported more than one year ago
			=> '6',
			credit_bureau_sourced and non_credit_bureau_sourced and RecentUpdate='0' // Identity found on credit bureau and non-credit bureau sources and  no update within the last year
			=> '5',
			credit_bureau_only // Identity only reported by credit bureaus
			=> '4',  
			(unsigned)Age_Oldest_Record between 0 and 12  and AgeOldestRecord<>'-1' // Identity first reported within the last year
			=> '3',  
			credit_bureau_sourced and non_credit_bureau_sourced and 
			risk_indicators.rcSet.isCodeMI(clam.Velocity_Counters.adls_per_ssn_seen_18months) // reported with a SSN that is associated with multiple individuals
			=> '2',
			credit_bureau_sourced and non_credit_bureau_sourced and RecentUpdate='1' // Identity found on credit bureau and non-credit bureau sources and updated within the last year
			=> '1',
			'-1'); //Identity not found

export string3 IdentityRecordCount := (string)min(255, sum(identity_sources, (integer)str2));				
export string3 IdentitySourceCount := (string)min(255, count(identity_sources));	
export string2 AgeRiskIndicator := map(clam.inferred_age between 1 and 17 => '0',
																clam.inferred_age between 18 and 20 => '18',
																clam.inferred_age between 21 and 69 => '21',
																clam.inferred_age between 70 and 79 => '70',
																clam.inferred_age > 80 => '80',
																'-1');			

export string2 VerAddressNotCurrent := map(noAddrInput => '-1',
	verifiedAddress='0' => '0',
	// verified address with evidence it may not be the most recent
	clam.address_verification.input_address_information.isbestmatch=false and  // not the best address anymore
		(	
		clam.iid.inputAddrNotMostRecent=true or   // verified but not most recent (reason code PA)
		clam.address_verification.input_address_information.applicant_sold=true or  // looks like they already sold the property
		clam.address_verification.edamatchlevel in [1, 2]  // disconnected phone at the input address
		)
	=> '1',
	'2');

export string2 verifiedDL := 	map(trim(clam.iid.verified_dl)<>'' => '1',
																	clam.iid.dl_searched and clam.iid.dl_exists and trim(clam.iid.verified_dl)='' => '0', 																	
																 '-1');

	shared IDVer_Failure_count	 := if(verifiedSSN='0', 1, 0) +
																	if(VerifiedAddress='0', 1, 0) + 
																	if(clam.input_validation.dateofbirth and clam.iid.combo_dobcount=0, 1, 0);
													
export string2 IDVerRiskLevel := map(clam.did=0 => '-1', // Identity not found
	clam.iid.nas_summary = 1 => '7', // Contradicting SSN
	IDVer_Failure_count = 3 => '9', // Failure to verify 3 of 3 (SSN, Address, DOB) 
	IDVer_Failure_count = 2 => '8', // Failure to verify 2 of 3 (SSN, Address, DOB)
	IDVer_Failure_count = 1 => '6', // Failure to verify 1 of 3 (SSN, Address, DOB)
	firstVerified=false => '5', // Failure to verify first name
	lastVerified=false => '4', // Failure to verify last name
	VerAddressNotCurrent='1' => '3', // Verified address, but evidence it is not the most current address
	VerifiedPhone = '0' or VerifiedDL = '0' => '2', // Failure to verify phone or drivers license
	'1'); // Verified all inputs

export string3 VerAddressAssocCount := if(noAddrInput, '-1', (string)min(255, clam.relatives.relatives_at_input_address) ); 
	
	// put the comma delimited strings into datasets to check bureau only counts later
	shared ssn_sources := models.common.zip2(clam.header_summary.ver_ssn_sources, clam.header_summary.ver_ssn_sources_recordcount);
	shared addr_sources := models.common.zip2(clam.header_summary.ver_addr_sources, clam.header_summary.ver_addr_sources_recordcount);
export string3 VerSSNSourceCount := if(noSSNinput, '-1', (string)min(255, count(ssn_sources)) );
export string3 VerPhoneSourceCount := if(noPhoneInput, '-1', (string)min(255, models.common.countw(trim(clam.phone_verification.phone_sources), ',')) );
export string3 VerDobSourceCount := if(noDOBinput, '-1', (string)min(255, models.common.countw(trim(clam.header_summary.ver_dob_sources), ',')) );
export string2 VerSSNCreditBureauCount := if(noSSNinput, '-1', (string)min(9, count(ssn_sources(str1 in bureau_sources))) );  // count of just the bureau sources which have that SSN
// if any of the bureaus has this SSN as deleted, trigger the attribute to 1
export string2 IDVerSSNCreditBureauDelete := map(noSSNinput => '-1',
																								 clam.header_summary.EQ_ssn_nlr or 
																								 clam.header_summary.EN_ssn_nlr or 
																								 clam.header_summary.TN_ssn_nlr => '1',
																									count(ssn_sources(str1 in bureau_sources)) > 0 => '0',
																									'-1');
export string2 VerAddrCreditBureauCount := if(noaddrinput, '-1', (string)min(9, count(addr_sources(str1 in bureau_sources))) );  // count of just the bureau sources which have that address

	shared boolean gong_did := clam.phone_verification.gong_did.gong_did_phone_ct > 0 or 
														 clam.phone_verification.gong_did.gong_did_addr_ct > 0 or 
														 clam.phone_verification.gong_did.gong_did_first_ct > 0 or 
														 clam.phone_verification.gong_did.gong_did_last_ct > 0;
	shared boolean gong_nap := clam.iid.nap_summary in [5,7,8,9,10,11,12] and clam.iid.nap_type <> 'U';
	shared integer Cat_Credit  := if(credit_bureau_sourced, 1, 0);
	shared integer Cat_Edu     := if(count(identity_sources(trim(str1)='SL')) > 0, 1, 0 );
	shared integer Cat_Voter   := if(count(identity_sources(trim(str1)='VO')) > 0, 1, 0 );
	shared integer Cat_ProfLic := if(count(identity_sources(trim(str1)='PL')) > 0, 1, 0 );
	shared integer Cat_DL      := if(count(identity_sources(trim(str1) in ['CY', 'D'])) > 0, 1, 0 );
	shared integer Cat_BusRec  := if(clam.employment.business_ct > 0, 1, 0);
	shared integer Cat_Prop    := if(count(identity_sources(trim(str1)='P')) > 0, 1, 0 );
	shared integer Cat_Assets  := if(count(identity_sources(trim(str1) in ['AR', 'W', 'V'])) > 0, 1, 0 );
	shared integer Cat_Phone   := if(count(identity_sources(trim(str1)='WP')) > 0 or Gong_DID or Gong_NAP, 1, 0 );
	shared integer SRT_Category_Count  := Cat_Credit + Cat_Edu + Cat_Voter + Cat_ProfLic + Cat_DL + Cat_BusRec + Cat_Prop + Cat_Assets + Cat_Phone;
		 
// export string2	SourceRiskLevel := (string)if(clam.truedid=false or SRT_Category_Count = 0, 0, 10-SRT_Category_Count); 
export string2	SourceRiskLevel := map(clam.did=0 => '-1', // Identity not found
																			SRT_Category_Count=9 => '1',  // individuals with all 9 categories are the lowest risk, set value to 1 since 0 isn't possible value
																		 (string)(9-SRT_Category_Count));
	
	shared utility_dates := models.common.zip2(clam.utility.utili_adl_type, clam.utility.utili_adl_dt_first_seen);
	shared identity_source_first_seen_dates := models.common.zip2(clam.header_summary.ver_sources, clam.header_summary.ver_sources_first_seen_date);
	shared string firstUtilityDate := trim(utility_dates(str1<>'Z')[1].str2[1..6]);  // don't include utility records of 'Other' (type='Z')
	shared string firstHeaderDate := trim(identity_source_first_seen_dates[1].str2);
	shared string firstReportedSource := trim(identity_source_first_seen_dates[1].str1);
	shared government_sources := ['BA', 'L2', 'C', 'P', 'PL'];	
	
export string2 SourceFirstReportingIdentity := map(firstReportedSource='' and firstUtilityDate=''=> '0',  // no sources reporting the identity
	firstUtilityDate<>'' and (unsigned)firstUtilityDate < (unsigned)firstHeaderDate => '2', // For response value = 2, return if the first source reporting the identity is the Utility file BUT only if the utility type != "other".  
	firstReportedSource in bureau_sources => '1',	// For response value = 1, return if the first source reporting the identity is Experian, Equifax, or TransUnion. 
	firstReportedSource in government_sources => '3',  // For response value = 3, return if the first source reporting the identity is a bankruptcy, lien, judgment, eviction, criminal, professional license, deed, or assessor record.  
	'4'); // If none of the above conditions is true, return the value = 4.

	shared Identity_source_last_seen_dates := models.common.zip2(clam.header_summary.ver_sources, clam.header_summary.ver_sources_last_seen_date);
	shared bureau_source_first_seen_dates := identity_source_first_seen_dates(str1 in bureau_sources);
	shared bureau_source_last_seen_dates := identity_source_last_seen_dates(str1 in bureau_sources);
	
	shared BureauFirstSeen := fixYYYY00((unsigned)bureau_source_first_seen_dates[1].str2);
	shared BureauLastSeen := fixYYYY00((unsigned)max(bureau_source_last_seen_dates, (unsigned)str2));
	shared bureau_still_updating := count(bureau_source_last_seen_dates)<>0 and round((ut.DaysApart((string)BureauLastSeen, (string)sysdate)) / 30) < 90;  // seen in the last 3 months
	shared identity_source_max_first_seen_dates := models.common.zip2(clam.header_summary.ver_sources, clam.header_summary.ver_sources_max_first_seen_date);
	shared bureau_source_max_first_seen_dates := identity_source_max_first_seen_dates(str1 in bureau_sources);
	shared BureauMaxFirstSeen := fixYYYY00((unsigned)max(bureau_source_max_first_seen_dates, (unsigned)str2));

// 0 - Identity never sourced at Bureau
// 1 - Identity sourced at Bureau, but not currently updated
// 2 - Identity sourced at Bureau, but deleted
// 3 - Identity sourced at Bureau and currently updated
export string1 SourceCreditBureau := map(clam.header_summary.EQ_did_nlr or 
																				clam.header_summary.EN_did_nlr or 
																				clam.header_summary.TN_did_nlr => '2',
																				count(bureau_source_last_seen_dates) > 0 and bureau_still_updating => '3',
																				count(bureau_source_last_seen_dates) > 0 and ~bureau_still_updating => '1',
																				'0');

export string2 SourceCreditBureauCount := map(count(bureau_source_last_seen_dates) >= 3 => '3',
																							count(bureau_source_last_seen_dates) = 2 => '2',
																							count(bureau_source_last_seen_dates) = 1 => '1',
																							'0');
																							
export	string3	SourceCreditBureauAgeOldest	:= if((integer)SourceCreditBureauCount=0 or BureauFirstSeen=0, '-1', capS((string)round((ut.DaysApart((string)BureauFirstSeen, (string)sysdate)) / 30), capZero, cap960) );	
export	string3	SourceCreditBureauAgeNewest := if((integer)SourceCreditBureauCount=0 or BureauLastSeen=0, '-1', capS((string)round((ut.DaysApart((string)BureauLastSeen, (string)sysdate)) / 30), capZero, cap960) );
export	string3	SourceCreditBureauAgeChange := if((integer)SourceCreditBureauCount=0 or BureauMaxFirstSeen=0, '-1', capS((string)round((ut.DaysApart((string)BureauMaxFirstSeen, (string)sysdate)) / 30), capZero, cap960) );



// if source says we have BK or lien on file, but derog shell counts don't show it, set it 1.  this is the main difference between SourcePublicRecordCout and DerogCount in RV attributes
 ver_src_ba := count(identity_source_first_seen_dates(str1='BA')) > 0;  
shared fp_bk_count := if(clam.bjl.filing_count=0 and (ver_src_ba or clam.iid.bansflag='1'), 1, clam.bjl.filing_count);
	shell_lien_count := clam.bjl.liens_historical_unreleased_count
		+ clam.bjl.liens_recent_unreleased_count
		+ clam.bjl.liens_historical_released_count
		+ clam.bjl.liens_recent_released_count;
	ver_src_l2 := count(identity_source_first_seen_dates(str1='L2')) > 0;  
shared fp_lien_count := if(shell_lien_count=0 and ver_src_l2, 1, shell_lien_count);    
shared fp_criminal_count := clam.bjl.criminal_count;
			
export string1 SourcePublicRecord := checkboolean(fp_bk_count>0 or fp_lien_count>0 or fp_criminal_count>0 or eviction_count>0);																							
export string3 SourcePublicRecordCount := (string)min(255, (fp_bk_count + fp_lien_count + fp_criminal_count + eviction_count));	
export string3 SourcePublicRecordCountYear := (string)min(255, 
	clam.bjl.bk_count12 + 
	clam.bjl.liens_unreleased_count12 + 
	clam.bjl.liens_released_count12 + 
	clam.bjl.criminal_count12 + 
	clam.bjl.eviction_count12 ) ;																				

export string1 SourceOccupationalLicense := checkboolean(clam.professional_license.proflic_count>0);
export string1 SourceDoNotMail := checkboolean( risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsDoNotMail, clam.iid.iid_flags));
export string1 SourceAccidents := checkboolean( clam.accident_data.acc.num_accidents>0);
export string1 SourceBusinessRecords := if( (clam.employment.business_ct-clam.employment.dead_business_ct) > 0, '1', '0');
export string1 SourceAssets := checkboolean( clam.watercraft.watercraft_count>0 or clam.vehicles.historical_count>0 or clam.aircraft.aircraft_count>0 );
export string1 SourcePhoneDirectoryAssistance := checkboolean(trim(clam.phone_verification.gong_did.gong_adl_dt_first_seen_full) <> '' );
export string1 SourcePhoneNonPublicDirectory := checkboolean( clam.infutor.infutor_date_first_seen<>0  );

export string3 CorrelationSSNNameCount := if(noSSNinput or noNAMEinput, '-1', (string)min(255, clam.header_summary.ssn_name_source_count) );
export string3 CorrelationSSNAddrCount := if(noSSNinput or noAddrInput, '-1', (string)min(255, clam.header_summary.ssn_addr_source_count) );
export string3 CorrelationAddrNameCount := if(noAddrInput or noNAMEinput, '-1', (string)min(255, clam.header_summary.addr_name_source_count) );
export string3 CorrelationAddrPhoneCount := if(noAddrInput or noPhoneInput, '-1', (string)min(255, clam.header_summary.phone_addr_source_count) );
export string3 CorrelationPhoneLastNameCount := if(nophoneinput or noLASTNAMEinput, '-1', (string)min(255, clam.header_summary.phone_lname_source_count) );
	
	
 _SSNAddrCount := map(clam.header_summary.ssn_addr_source_count <=1 => 0,
											clam.header_summary.ssn_addr_source_count <=3 => 1,
											clam.header_summary.ssn_addr_source_count <=4 => 2,
																																			 3);
																																			 
 _AddrNameCount := map(clam.header_summary.addr_name_source_count <=1 => 0,
											clam.header_summary.addr_name_source_count <=4 => 1,
											clam.header_summary.addr_name_source_count <=6 => 2,
																																			  3);
																																				
 _AddrPhoneCount := map(clam.header_summary.phone_addr_source_count <=0 => 0,
											clam.header_summary.phone_addr_source_count <=1 => 2,
																																			  3); 
																																				
 _PhoneLastNameCount := map(clam.header_summary.phone_lname_source_count <=0 => 0,
											clam.header_summary.phone_lname_source_count <=1 => 2,
																																			  3);
 _PhoneCount := max( _AddrPhoneCount, _PhoneLastNameCount );
     
  newCorrelationRiskLevel_temp := min(9, 10 - ( _SSNAddrCount + _AddrNameCount + _PhoneCount ) );
export string2 CorrelationRiskLevel := (string)newCorrelationRiskLevel_temp; 

// countw on pii on file last 12 months + the unverified elements per ADL
ssns_last_12_months := models.common.countw(trim(clam.header_summary.ssns_on_file_created12months), ',') + clam.acc_logs.unverifiedSSNsPerADL;
dobs_last_12_months := models.common.countw(trim(clam.header_summary.dobs_on_file_created12months), ',') + clam.acc_logs.unverifieddobsPerADL;
addrs_last_12_months := models.common.countw(trim(clam.header_summary.streets_on_file_created12months), ',') + clam.acc_logs.unverifiedaddrsPerADL;
phones_last_12_months := models.common.countw(trim(clam.header_summary.phones_on_file_created12months), ',') + clam.acc_logs.unverifiedphonesPerADL;
VariationRiskLevel_temp := ssns_last_12_months + dobs_last_12_months + addrs_last_12_months + phones_last_12_months;

export string2 VariationRiskLevel := map(clam.did=0 or RecentUpdate='0' => '-1', // no did or no update within the last year
																				VariationRiskLevel_temp=0 => '1', // 0's now become 1-(lowest risk)
																				(string)min(9, VariationRiskLevel_temp) );  
export string3 VariationIdentityCount := (string)min(255, clam.iid.didcount);
export string3 VariationSSNCount := (string)min(255, clam.velocity_counters.ssns_per_adl);
export string3 VariationSSNCountNew := (string)min(255, clam.velocity_counters.ssns_per_adl_created_6months);
export string3 VariationMSourcesSSNCount :=  (string)min(255, clam.velocity_counters.ssns_per_adl_multiple_use);
export string3 VariationMSourcesSSNUnrelCount := (string)min(255, clam.velocity_counters.ssns_per_adl_multiple_use_non_relative);
export string3 VariationLastNameCount := (string)min(255, clam.velocity_counters.lnames_per_adl);
export string3 VariationLastNameCountNew := (string)min(255, clam.velocity_counters.lnames_per_adl180);
export string3 VariationDOBCount := (string)min(255, clam.velocity_counters.dobs_per_adl);
export string3 VariationDOBCountNew := (string)min(255, clam.velocity_counters.dobs_per_adl_created_6months);

export string3 PRSearchCount				:= (string)min( 255, clam.acc_logs.inquiries.counttotal );
export string3 PRSearchCountYear 		:= (string)min( 255, clam.acc_logs.inquiries.count12 );
export string3 PRSearchCountMonth		:= (string)min( 255, clam.acc_logs.inquiries.count01 );
export string3 PRSearchCountWeek		:= (string)min( 255, clam.acc_logs.inquiries.countweek );
export string3 PRSearchCountDay 		:= (string)min( 255, clam.acc_logs.inquiries.countday );

export string3 PRSearchUnverifiedSSNCountYear := (string)min( 255, clam.acc_logs.unverifiedSSNsPerADL );
export string3 PRSearchUnverifiedAddrCountYear :=  (string)min( 255, clam.acc_logs.unverifiedAddrsPerADL );
export string3 PRSearchUnverifiedDOBCountYear := (string)min( 255, clam.acc_logs.unverifiedDOBsPerADL );
export string3 PRSearchUnverifiedPhoneCountYear :=  (string)min( 255, clam.acc_logs.unverifiedPhonesPerADL );

export string3 PRSearchBankingSearchCount	:=  (string)min( 255, clam.acc_logs.banking.counttotal + clam.acc_logs.mortgage.counttotal );
export string3 PRSearchBankingSearchCountYear	:=  (string)min( 255, clam.acc_logs.banking.count12 + clam.acc_logs.mortgage.count12);
export string3 PRSearchBankingSearchCountMonth	:=  (string)min( 255, clam.acc_logs.banking.count01 + clam.acc_logs.mortgage.count01);
export string3 PRSearchBankingSearchCountWeek	:= (string)min( 255, clam.acc_logs.banking.countweek + clam.acc_logs.mortgage.countweek);
export string3 PRSearchBankingSearchCountDay	:= (string)min( 255, clam.acc_logs.banking.countday + clam.acc_logs.mortgage.countday);

export string3 PRSearchHighRiskSearchCount				:= (string)min( 255, clam.acc_logs.highriskcredit.counttotal );
export string3 PRSearchHighRiskSearchCountYear 		:= (string)min( 255, clam.acc_logs.highriskcredit.count12 );
export string3 PRSearchHighRiskSearchCountMonth		:= (string)min( 255, clam.acc_logs.highriskcredit.count01 );
export string3 PRSearchHighRiskSearchCountWeek		:= (string)min( 255, clam.acc_logs.highriskcredit.countweek );
export string3 PRSearchHighRiskSearchCountDay 		:= (string)min( 255, clam.acc_logs.highriskcredit.countday );

export string3 PRSearchFraudSearchCount				:= (string)min( 255, clam.acc_logs.FraudSearches.counttotal );
export string3 PRSearchFraudSearchCountYear 		:= (string)min( 255, clam.acc_logs.FraudSearches.count12 );
export string3 PRSearchFraudSearchCountMonth		:= (string)min( 255, clam.acc_logs.FraudSearches.count01 );
export string3 PRSearchFraudSearchCountWeek		:= (string)min( 255, clam.acc_logs.FraudSearches.countweek );
export string3 PRSearchFraudSearchCountDay 		:= (string)min( 255, clam.acc_logs.FraudSearches.countday );

export string3 PRSearchLocateCountWeek		:= (string)min( 255, clam.acc_logs.collection.countweek );
export string3 PRSearchLocateCountDay 		:= (string)min( 255, clam.acc_logs.collection.countday );

	shared PRSearchAddrSuspIdentityCount := min( 255, clam.acc_logs.inquirySuspciousADLsperAddr );
export string3 PRSearchSSNSearchCount	:= if(noSSNinput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerSSN ) ); 
export string3 PRSearchSSNSearchCountYear	:= if(noSSNinput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerSSNYear ) );
export string3 PRSearchSSNSearchCountMonth	:= if(noSSNinput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerSSNMonth ) ); 
export string3 PRSearchSSNSearchCountWeek	:= if(noSSNinput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerSSNWeek ) );
export string3 PRSearchSSNSearchCountDay	:= if(noSSNinput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerSSNDay ) );
export string3 PRSearchAddrSearchCount	:= if(noAddrInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerAddr ) );
export string3 PRSearchAddrSearchCountYear	:= if(noAddrInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerAddrYear ) );
export string3 PRSearchAddrSearchCountMonth	:= if(noAddrInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerAddrMonth ) );
export string3 PRSearchAddrSearchCountWeek	:= if(noAddrInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerAddrWeek ) );
export string3 PRSearchAddrSearchCountDay	:= if(noAddrInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerAddrDay ) );
export string3 PRSearchPhoneSearchCount	:= if(nophoneInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerPhone ) );
export string3 PRSearchPhoneSearchCountYear	:= if(nophoneInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerPhoneYear ) );
export string3 PRSearchPhoneSearchCountMonth	:= if(nophoneInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerPhoneMonth ) );
export string3 PRSearchPhoneSearchCountWeek	:= if(nophoneInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerPhoneWeek ) );
export string3 PRSearchPhoneSearchCountDay	:= if(nophoneInput, '-1', (string)min( 255, clam.acc_logs.fraudSearchInquiryPerPhoneDay ) );

	PRSearchComponentRiskLevel_temp := (integer)PRSearchSSNSearchCountMonth + 
		abs((integer)PRSearchSSNSearchCountMonth-(integer)PRSearchAddrSearchCountMonth) +
		abs((integer)PRSearchSSNSearchCountMonth-(integer)PRSearchPhoneSearchCountMonth);
																														// floor the 0 values at 1 instead for SearchComponentriskLevel and DivRiskLevel
export string2 PRSearchComponentRiskLevel := (string)min( 9, if(PRSearchComponentRiskLevel_temp<=0, 1, PRSearchComponentRiskLevel_temp) );
	NonRetailOrHR := clam.acc_logs.inquiries.counttotal - clam.acc_logs.retail.counttotal - clam.acc_logs.highriskcredit.counttotal;
	NonRetailOrHRMonth := clam.acc_logs.inquiries.count01 - clam.acc_logs.retail.count01 - clam.acc_logs.highriskcredit.count01;
	NonRetailOrHRYear := clam.acc_logs.inquiries.count12 - clam.acc_logs.retail.count12 - clam.acc_logs.highriskcredit.count12;
	PRSearchVelocityRiskLevel_temp := map(
											clam.acc_logs.highriskcredit.count01 > 0 			=> 9,
											NonRetailOrHRMonth > 4 												=> 9,
											NonRetailOrHRMonth > 2 												=> 8,
											clam.acc_logs.highriskcredit.count12 > 0 			=> 7,
											clam.acc_logs.highriskcredit.counttotal > 0 	=> 6,
											NonRetailOrHRYear > 9 												=> 6,
											NonRetailOrHRMonth > 0 												=> 5,
											NonRetailOrHRYear > 5 												=> 4,
											NonRetailOrHRYear > 1 												=> 2,
											NonRetailOrHR > 2															=> 2,
											NonRetailOrHRYear > 0 												=> 1,
											NonRetailOrHR > 0 														=> 1,
																																			 3);
	inq_peradl2plus := 	if(clam.acc_logs.inquiryssnsperadl>1, 1, 0) + 
											if(clam.acc_logs.inquiryaddrsperadl>1, 1, 0) + 
											if(clam.acc_logs.inquirydobsperadl>1, 1, 0) + 
											if(clam.acc_logs.inquiryphonesperadl>1, 1, 0);								
	// add 1 point for risky velocity per ADL						
	PRSearchVelocityRiskLevel_temp2 := if(inq_peradl2plus > 2, PRSearchVelocityRiskLevel_temp+1, PRSearchVelocityRiskLevel_temp );
export string2 PRSearchVelocityRiskLevel := if(clam.did=0 , '-1',
																								(string)min( 9, PRSearchVelocityRiskLevel_temp2) );											

export string3 AssocCount := (string)min( 255, clam.relatives.relative_count );

export string2 AssocDistanceClosest	:= map(		noAddrInput => '-1',
		clam.relatives.relative_within25miles_count  > 0 => '0',
		clam.relatives.relative_within100miles_count > 0 => '1',
		clam.relatives.relative_within500miles_count > 0 => '2',
		clam.relatives.relative_withinother_count    > 0 => '3',
		'-1'
	);
				
export string3 AssocSuspicousIdentitiesCount := (string)min( 255, clam.relatives.relative_suspicious_identities_count );
export string3 AssocCreditBureauOnlyCount := (string)min( 255, clam.relatives.relative_bureau_only_count );
export string3 AssocCreditBureauOnlyCountMonth := (string)min( 255, clam.relatives.relative_bureau_only_count_created_1month );
export string3 AssocCreditBureauOnlyCountNew := (string)min( 255, clam.relatives.relative_bureau_only_count_created_6months );

export string3 AssocHighRiskTopologyCount := (string)min( 255, clam.relatives.relative_felony_count ); 
	shared assocrisklevel_temp := (integer)AssocHighRiskTopologyCount + (integer)AssocSuspicousIdentitiesCount;
export string2 AssocRiskLevel := if(clam.did=0, '-1',  (string)min( 9, if(assocrisklevel_temp=0, 1, assocrisklevel_temp) ) );  // 0's are now collapsed into 1's bucket

export string2 IPCountry := if(trim(ip2o.ipaddr)='', '-1',trim(StringLib.StringToUpperCase(ip2o.countrycode[1..2])));
export string2 IPState := if(trim(ip2o.ipaddr)='', '-1',if(ipcountry = 'US', StringLib.StringToUpperCase(ip2o.state), ''));
export string2 IPContinent := if(trim(ip2o.ipaddr)='', '-1', ip2o.continent);
	
	shared invalid_ssn_value := if(not clam.SSN_Verification.Validation.valid, 4, 0);
	shared reasoncodeIS_value := if(Risk_Indicators.rcSet.isCodeIS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag), 2, 0);
	shared deceased_value := if(clam.iid.decsflag='1', 4, 0);
	shared ssnpriordob_value := if(clam.iid.socsdobflag='1', 4, 0);																					
	shared invalid_address_value := if(clam.iid.addrvalflag<>'V', 1, 0);
	shared highrisk_address_value := if(clam.iid.hriskaddrflag='4', 1, 0); 
	shared hotlist_address := if(clam.uspis_hotlist, 4, 0);
	shared invalid_phone_value := if(clam.iid.phonetype <> '1' and clam.shell_input.phone10 <> '', 1, 0);
	shared highrisk_phone_value := if(clam.iid.hriskphoneflag = '6', 1, 0);
	shared phone_is_pager := if(clam.iid.hriskphoneflag = '2', 1, 0);
	shared phonezipmismatch := if(clam.shell_input.in_Zipcode<>'' and clam.iid.phonezipflag = '1', 1, 0);
	shared dist_inaddr_phone := if(clam.iid.disthphoneaddr > 10 and clam.iid.disthphoneaddr<>9999, 1, 0);
	shared invalid_DL_value := if(trim(InvalidDL)='1', 1, 0);
	shared ageriskindicator_value := if(AgeRiskIndicator in ['0','80'], 1, 0);
	shared IP_highrisk_country_value := if(Risk_Indicators.rcSet.iscodeIF(ip2o.countrycode), 1, 0);
	shared IP_invalid_value := if(Risk_Indicators.rcSet.iscodeIA(clam.shell_input.ip_address, ip2o.ipaddr<>''), 1, 0);
	shared addr_phone_dl_age_ip_total := invalid_address_value + highrisk_address_value + hotlist_address +
																		invalid_phone_value + highrisk_phone_value + phone_is_pager +
																		phonezipmismatch + dist_inaddr_phone +
																		invalid_dl_value + ageriskindicator_value +
																		ip_highrisk_country_value + ip_invalid_value;		
																		
	shared ValidationRiskLevel_temp := invalid_ssn_value + 
																		reasoncodeIS_value + 
																		deceased_value + 
																		ssnpriordob_value + 
																		addr_phone_dl_age_ip_total;
export string2 ValidationRiskLevel := (string)min(9, if(validationrisklevel_temp=0, 1, validationrisklevel_temp));  // no more 0's, 1 is the lowest risk

export string2 IP_problems := map( trim(ip2o.ipaddr)='' => '-1',
	ipcountry = 'US' => '0',
	ipcountry <> 'US' and ipcountry<>'' => '1',
	'2');

export string3 DivAddrSSNCount := if(noaddrinput, '-1', (string)min(clam.velocity_counters.ssns_per_addr, 255) );
export string3 DivAddrSSNCountNew := if(noaddrinput, '-1', (string)min(clam.velocity_counters.ssns_per_addr_created_6months, 255) );	
export string3 DivSSNLNameCount := if(nossninput, '-1', (string)min( 255, clam.velocity_counters.lnames_per_ssn) );
export string3 DivSSNLNameCountNew := if(nossninput, '-1', (string)min( 255, clam.velocity_counters.lnames_per_ssn_created_6months) );
export string3 DivAddrSSNMSourceCount := if(noaddrinput, '-1', (string)min( 255, clam.velocity_counters.ssns_per_addr_multiple_use ) );
export string3 DivAddrPhoneMSourceCount := if(noaddrinput, '-1', (string)min( 255, clam.velocity_counters.phones_per_addr_multiple_use ) );
export string3 DivPhoneAddrCount := if(noPhoneInput, '-1', (string)min( 255, clam.velocity_counters.addrs_per_phone ) );
export string3 DivPhoneAddrCountNew := if(noPhoneInput, '-1', (string)min( 255, clam.velocity_counters.addrs_per_phone_created_6months ) );
export string3 DivPhoneIdentityMSourceCount := if(noPhoneInput, '-1', (string)min( 255, clam.velocity_counters.adls_per_phone_multiple_use ) );
export string3 DivSSNIdentityCount           := if(noSSNinput, '-1', (string)min( 255, clam.SSN_Verification.adlPerSSN_count) );
export string3 DivSSNIdentityCountNew            := if(noSSNinput, '-1', (string)min( 255, clam.velocity_counters.adls_per_ssn_created_6months) );
export string3 DivSSNAddrCount            := if(noSSNinput, '-1', SSNAddrCount );
export string3 DivSSNAddrCountNew            := if(noSSNinput, '-1', (string)min( 255, clam.velocity_counters.addrs_per_ssn_created_6months) );
export string3 DivAddrIdentityCount     := if(noAddrInput, '-1', (string)min( 255, clam.velocity_counters.adls_per_addr) );
export string3 DivAddrIdentityCountNew     := if(noAddrInput, '-1', (string)min( 255, clam.velocity_counters.adls_per_addr_created_6months) );
export string3 DivAddrPhoneCount     := if(noAddrInput, '-1', (string)min( 255, clam.velocity_counters.phones_per_addr ) );
export string3 DivAddrPhoneCountNew     := if(noAddrInput, '-1', (string)min( 255, clam.velocity_counters.phones_per_addr_created_6months ) );
export string3 DivPhoneIdentityCount    := if(noPhoneInput, '-1', (string)min( 255, clam.velocity_counters.adls_per_phone) );
export string3 DivPhoneIdentityCountNew    := if(noPhoneInput, '-1', (string)min( 255, clam.velocity_counters.adls_per_phone_created_6months) );
export string3 DivSSNIdentityMSourceCount	:= if(nossninput, '-1', (string)min( 255, clam.velocity_counters.adls_per_ssn_multiple_use)		);
export string3 DivSSNIdentityMSourceUrelCount	:= if(nossninput, '-1', (string)min( 255, clam.velocity_counters.adls_per_ssn_multiple_use_non_relative)		);
export string3 DivSSNAddrMSourceCount	:= if(nossninput, '-1', (string)min( 255, clam.velocity_counters.addrs_per_ssn_multiple_use)		);
export string3 DivAddrIdentityMSourceCount	:= if(noaddrinput, '-1', (string)min( 255, clam.velocity_counters.adls_per_addr_multiple_use)		);
	shared AddrSuspIdentityCountNew := min( 255, clam.velocity_counters.suspicious_adls_per_addr_created_6months);
export string3 DivAddrSuspIdentityCountNew	:= if(noaddrinput, '-1', 	(string)AddrSuspIdentityCountNew	);

export string3 DivSearchSSNIdentityCount       := if(noSSNinput, '-1', (string)min( 255, clam.acc_logs.inquiryadlsperssn ) );
export string3 DivSearchAddrIdentityCount      := if(noAddrinput, '-1', (string)min( 255, clam.acc_logs.inquiryadlsperaddr ) );
export string3 DivSearchPhoneIdentityCount     := if(noPhoneinput, '-1', (string)min( 255, clam.acc_logs.inquiryadlsperphone ) );
export string3 DivSearchAddrSuspIdentityCount 		:= if(noAddrInput, '-1', (string)PRSearchAddrSuspIdentityCount );

	DivRiskLevel_val := (integer)power( (integer)SSNIdentitiesRecentCount, 2 ) +
									AddrSuspIdentityCountNew + 
								 (integer)power( (integer)PRSearchSSNIdentities, 2 ) +
									PRSearchAddrSuspIdentityCount;
																						// floor the 0 values at 1 instead for SearchComponentriskLevel and DivRiskLevel
export string2 DivRiskLevel := (string)min(9, if(DivRiskLevel_val=0, 1, DivRiskLevel_val) );
	
export string2 InputPhoneType := if(noPhoneinput, '-1', clam.iid.hphonetypeflag);
export string2 InputAddrType := map(noAddrinput => '-1',
																		clam.iid.hriskaddrflag='4' => '2',
																		clam.business_header_address_summary.bus_addr_match_cnt>0 => '1',
																		'0');


shared InputAddrDwellTypeNonSFRes := if(trim(InputAddrDwellType) in ['S', 'P', 'R'], 0, 1);
InputAddrDeliveryVacant := if(trim(InputAddrDelivery)='4', 1, 0);
NoInputAddrActivePhoneList := if(trim(InputAddrActivePhoneList) = '1', 0, 1);
NotInputAddrOccupantOwned := if(trim(InputAddrOccupantOwned)='1', 0, 1);
AddrStabRisk := map(trim(AddrStability) = '0' => 3, 
										trim(AddrStability) = '1' => 2,
										trim(AddrStability) = '2' => 1,
																													0);

EconTrajRisk := map((integer)AddrRecentEconTrajectoryIndex < 2 => 2,
										(integer)AddrRecentEconTrajectoryIndex = 2 => 1,
																																	0);

	ComponentCharRiskLevel_temp := 1 + InputAddrDwellTypeNonSFRes + InputAddrDeliveryVacant + NoInputAddrActivePhoneList + NotInputAddrOccupantOwned + AddrStabRisk + 	EconTrajRisk;
export string2 ComponentCharRiskLevel := (string)min(9, if(ComponentCharRiskLevel_temp=0, 1, ComponentCharRiskLevel_temp));

// very similar to InputAddrProblems, but with values of 5 added
export	string2	ValidationAddrProblems	:= map(noAddrInput=> '-1',
																					clam.uspis_hotlist => '5',
																					clam.iid.hriskaddrflag='4' AND clam.iid.hrisksic = '2225' => '4', // transient high risk
																					clam.iid.addrvalflag<>'V' => '3',  // valid address
																					clam.iid.zipclass in ['M','U'] => '2',  // military zip
																					clam.iid.zipclass='P' => '1',  // po box zip
																					'0');  // default to be valid

// very similar to InputPhoneProblems, but added value of 6																					
export	string2	ValidationPhoneProblems	:= map(noPhoneinput => '-1', 
																					clam.iid.hriskphoneflag = '5' => '6',  // transient high risk
																					clam.iid.phonetype <> '1' and clam.shell_input.phone10 <> '' => '5',  // phone invalid
																					clam.iid.disthphoneaddr > 10 and clam.iid.disthphoneaddr<>9999 => '4', // distance between phone and address greater than 10 miles
																					clam.shell_input.in_Zipcode<>'' and clam.iid.phonezipflag = '1' => '3', // phone zip mismatch
																					clam.iid.hriskphoneflag = '2' => '2', // phone is a pager
																					clam.iid.phonedissflag and clam.input_validation.homephone => '1', // phone is disconnected
																					'0');  // no problems		

// for the Fraudpoint attribute, they wanted this triggering 1 if occupant owned or applicant owned.  slightly different than InputAddrOccupantOwned in Riskview and Lead Integrity																					
export	string2	FP_InputAddrOccupantOwned 	:=  map(noaddrinput or clam.address_verification.input_address_information.naprop=0 => '-1',
																							clam.address_verification.input_address_information.occupant_owned and 
																							clam.address_verification.input_address_information.applicant_owned => '1',
																							'0');		

export string3 InputAddrNBRHDVacantPropCount   := if(noAddrinput, '-1', (string)min(255, clam.addr_risk_summary.n_vacant_properties) );
export string3 InputAddrNBRHDBusinessCount     := if(noAddrinput, '-1', (string)min(255, clam.addr_risk_summary.n_business_count) );
export string3 InputAddrNBRHDSingleFamilyCount := if(noAddrinput, '-1', (string)min(255, clam.addr_risk_summary.n_sfd_count) );
export string3 InputAddrNBRHDMultiFamilyCount  := if(noAddrinput, '-1', (string)min(255, clam.addr_risk_summary.n_mfd_count) );

export	string2	IDVerSSN	:= map(noSSNinput => '-1', 
																	clam.iid.nas_summary = 1 and risk_indicators.rcSet.isCode29(clam.iid.socsmiskeyflag) => '2', 
																	clam.iid.nas_summary = 1 => '3',
																	risk_indicators.rcSet.isCode29(clam.iid.socsmiskeyflag) => '1', 
																	clam.iid.nas_summary in [7, 9, 10, 11, 12] => '4', 														 
																	'0');

export string2 SourceOnlineDirectory := checkboolean(clam.email_summary.email_ct>0);

export	string2	ValidationSSNProblems	:= map(noSSNInput 								=> '-1',  // not input
								clam.iid.decsflag='1' 		=> '5',   // deceased SSN
								clam.iid.socsdobflag='1'	=> '4',  	// issued prior to DOB
								not clam.SSN_Verification.Validation.valid => '3',  // invalid ssn
								Risk_Indicators.rcSet.isCodeRS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag)	=> '2', // randomized ssn (RS)
								Risk_Indicators.rcSet.isCodeIS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag)  => '1',  	// verified and valid, but was invalid prior to June 25th (reason code IS flag)
								'0');  // valid

// same as SrcsConfirmIDAddrCount, with the exception of adding -1 for no addr input in Fraudpoint attributes
export	string3	IDVerAddressSourceCount	:= if(noaddrinput, '-1',
																	capS((string)map(CAaddrChooser=1 => clam.address_verification.input_address_information.source_count,
																	CAaddrChooser=2 => clam.address_verification.address_history_1.source_count,
																	CAaddrChooser=3 => clam.address_verification.address_history_2.source_count,
																	0), capZero, cap255) );
																	
export string1 SourceWatchList := IF(clam.iid.watchlistHit, '1', '0');
																	
// iBehavior Attributes
shared iBehavior_Number_Of_Sources := IF(TRIM(clam.iBehavior.number_of_sources) = '', 0, (UNSIGNED)clam.iBehavior.number_of_sources);

export string1 SourceOrderActivity := IF(((INTEGER)clam.iBehavior.Offline_Orders + (INTEGER)clam.iBehavior.Online_Orders + (INTEGER)clam.iBehavior.Retail_Orders) <> 0, '1', '0');

export string3 SourceOrderSourceCount := capS((STRING)iBehavior_Number_Of_Sources, capZero, cap255);

export string3 SourceOrderAgeLastOrder := IF((INTEGER)iBehavior_Number_Of_Sources = 0 OR TRIM(clam.iBehavior.Last_Order_Date) IN ['', '0'], '-1', capS((string)ROUND((ut.DaysApart(clam.iBehavior.Last_Order_Date, (string)sysdate)) / 30), capZero, cap960));

// AML Attributes
export string2 IndCitizenshipIndex := Map(SSNNonUS = '1' => '9',
																					(integer)AgeOldestRecord between 0 and 35 => '8',
																					(integer)AgeOldestRecord between 36 and 59 => '7',
																					(integer)AgeOldestRecord between 60 and 119 => '6',
																					PropertyOwner = '1' => '5',
																					// ????????????? => '4',		// how do we determine parents
																					// ????????????? => '3',		// how do we determine parents
																					SSNProblems in ['0','1'] => '2',	// is this accurate?
																					VoterRegistrationRecord = '1' => '1',
																					SubjectOnFile = '0' => '-1',
																					'0');
																	
export string2 IndMobilityIndex := Map(	(unsigned)AddrChangeCount60 >= 5 => '9',
																				(unsigned)AddrChangeCount60 = 4 => '8',
																				(unsigned)AddrChangeCount60 <= 3 => '7',
																				(unsigned)AddrChangeCount60 <= 3 and StatusMostRecent='O' => '6',	
																				round((ut.DaysApart((string)IAdateFirstSeen, (string)sysdate)) / 30) >= 36 and StatusMostRecent='O' => '5',	
																				// ?? => '4',
																				// ?? => '3',
																				round((ut.DaysApart((string)CADateFirstReported, (string)sysdate)) / 30) >= 120 => '2',
																				round((ut.DaysApart((string)CADateFirstReported, (string)sysdate)) / 30) >= 120 and StatusMostRecent='O' => '1',
																				SubjectOnFile = '0' => '-1',
																				'0');
																				
	shared NumNonFelonyCrimes := clam.bjl.criminal_count - (unsigned)FelonyCount;
	shared LienEvictionRecentCountAML := clam.bjl.liens_unreleased_count12
																			+ clam.bjl.liens_released_count12
																			+ clam.bjl.eviction_count12; 
	shared LienEvictionOver12CountAML := ((unsigned)LienCount + clam.bjl.eviction_count) - LienEvictionRecentCountAML;
export string2 IndLegalEventsIndex := Map(CurrAddrCorrectional = '1' => '9',
																					(unsigned)FelonyCount > 0 => '8',
																					NumNonFelonyCrimes > 5 and ((unsigned)LienCount + (unsigned)EvictionCount) >= 5 and PropertyOwner = '0' => '7',	
																					NumNonFelonyCrimes > 5 and ((unsigned)LienCount + (unsigned)EvictionCount) <= 4 and PropertyOwner = '0' => '6',	
																					PropertyOwner = '1' and LienEvictionRecentCountAML >= 1 => '5',	
																					PropertyOwner = '1' and LienEvictionOver12CountAML >= 1 => '4', 
																					CurrAddrCorrectional<>'1' and ((unsigned)FelonyCount +(unsigned)NumNonFelonyCrimes+(unsigned)LienCount+(unsigned)EvictionCount)=0 and PropertyOwner='0' and VoterRegistrationRecord='0' => '3',
																					CurrAddrCorrectional<>'1' and ((unsigned)FelonyCount +(unsigned)NumNonFelonyCrimes+(unsigned)LienCount+(unsigned)EvictionCount)=0 and PropertyOwner='1' and VoterRegistrationRecord='0' => '2',
																					CurrAddrCorrectional<>'1' and ((unsigned)FelonyCount +(unsigned)NumNonFelonyCrimes+(unsigned)LienCount+(unsigned)EvictionCount)=0 and PropertyOwner='1' and VoterRegistrationRecord='1' => '1',
																					SubjectOnFile = '0' => '-1',
																					'0');
																						 

export string2 IndAccesstoFundsIndex := Map(//(unsigned)EstimatedAnnualIncome > 250000 and ??? => '9',	// call the br.key_fein_table to bdid and then search bh to get addresses to match to?
																						//??? => '8',		// agent or officer of an active business
																						(unsigned)EstimatedAnnualIncome > 250000 and WatercraftOwner='1' and AircraftOwner='1' => '7',
																						(unsigned)EstimatedAnnualIncome > 250000 and AircraftOwner='1' => '6',
																						(unsigned)EstimatedAnnualIncome > 250000 and WatercraftOwner='1' => '5',
																						(unsigned)EstimatedAnnualIncome > 250000 => '4',
																						(unsigned)EstimatedAnnualIncome between 100000 and 250000 => '3',
																						(unsigned)EstimatedAnnualIncome between 50000 and 100000 => '2',
																						(unsigned)EstimatedAnnualIncome < 50000 => '1',
																						SubjectOnFile = '0' => '-1',
																						'0');
																						
// 9Individuals SSN reported as tax identification number of a business reported at the individual's residential address and estimated income greater than $250,000 annually
// 8Individual reported as an agent or officer of an active business

export string2 IndBusAssocIndex := Map(	// => '9', BusinessActiveAssociation?
																				// => '8',
																				// => '7',
																				// => '6',
																				// => '5',
																				// => '4', EducationFieldofStudyType??
																				// => '3',
																				// => '2',
																				// => '1',
																				SubjectOnFile = '0' => '-1',
																				'0');

// 9Evidence that the individual owns or is an officer in more than one high risk business and is a high risk professional service provider 
// 8Evidence that the individual owns or is an officer in a high risk business and is a high risk professional service provider 
// 7Evidence that the individual owns or is an officer in more than one high risk business
// 6Evidence that the individual is a high risk professional service provider
// 5Evidence that the individual owns or is an officer in a high risk business
// 4Evidence that the individual has a degree in a high risk field of study
// 3No evidence that the individual is a high risk professional service provider
// 2No evidence that the individual owns or is an officer in a high risk business
// 1No evidence that the individual has a degree in a high risk field of study

export string2 IndHighValAssetsIndex := Map(	// ? and WatercraftOwner and AircraftOwner => '9',
																							// ? and WatercraftOwner and AircraftOwner => '8',
																							// ? and (WatercraftOwner OR AircraftOwner) => '7',
																							// ? and (WatercraftOwner OR AircraftOwner) => '6',
																							// ? and (WatercraftOwner OR AircraftOwner) => '5',
																							// ? or WatercraftOwner OR AircraftOwner => '4',
																							// ? or WatercraftOwner OR AircraftOwner => '3',
																							// ? or WatercraftOwner OR AircraftOwner => '2',
																							SubjectOnFile = '0' => '-1',
																							'0');
																							
// 9More than 10 years of owning 3 or more properties and watercraft and aircraft
// 8More than 10 years of owning 2 or more properties and watercraft and aircraft
// 7More than 10 years of owning 2 or more properties and aircraft or watercraft
// 64 to 9 years of owning 2 or more properties and aircraft or watercraft
// 54 to 9 years of owning a property and watercraft or aircraft
// 42 - 4 years of owning a Property or Watercraft or aircraft
// 3Property or aircraft or watercraft owner for less than 2 years
// 2Property or aircraft or watercraft owner for less than 1 year
// 1No evidence of asset ownership


export string2 IndGeogIndex := Map(	(unsigned)IACensus.crime>=140 and clam.shell_input.st in AML.AMLConstants.setBorderStates => '9',	
																		//??? => '8',  AddrFraud.Key_AddrFraud_GeoLink
																		(unsigned)IACensus.crime>=140 and (	clam.shell_input.st+clam.shell_input.county in AML.AMLConstants.setHIFCA or			
																																				clam.shell_input.st+clam.shell_input.county in AML.AMLConstants.setHIDTA) => '7',
																		
																		(unsigned)IACensus.crime>=140 => '6',	
																		InputAddrHighRisk = '1' => '5',
																		InputAddrDelivery = '4' => '4',
																		(	clam.shell_input.st+clam.shell_input.county in AML.AMLConstants.setHIFCA or		
																			clam.shell_input.st+clam.shell_input.county in AML.AMLConstants.setHIDTA) => '3',
																		(unsigned)IACensus.crime between 60 and 139 => '2',	
																		(unsigned)IACensus.crime between 1 and 59 => '1',	
																		SubjectOnFile = '0' => '-1',
																		'0');

// 9Address in high crime neighborhood that borders a foreign jurisdiction
// 8High number of neighborhood residents reported as convicted felons
// 7Address in high crime neighborhood in a High Intensity Financial Crimes Area or High Intensity Drug Trafficking Area
// 6Address in high crime neighborhood
// 3Address is in a High Intensity Financial Crimes Area or High Intensity Drug Trafficking Area
// 2Address in neighborhood with average crime statistics
// 1Address in neighborhood below average crime statistics

export string2 IndAssocIndex := Map(//??? => '9',
																		//??? => '8',
																		//??? => '7',
																		//??? => '6',
																		//??? => '5',
																		//??? => '4',
																		//??? => '3',
																		//??? => '2',
																		//??? => '1',
																		SubjectOnFile = '0' => '-1',
																		'0');

// 9Over 50% of associates have 4 or more money laundering indexes with scores of 8 or 9
// 8Over 50% of associates have a suspicious activity index score of 8 or 9
// 7One or more associates have a suspicious activity index score of 8 or 9
// 6More than 40% of associates have 3 or more money laundering indexes with scores equal to or greater than 7
// 5More than 20% of associates have 3 or more money laundering indexes with scores equal to or greater than 7
// 4Over 40% of associates have no money laundering indexes with a value of 5 or higher
// 3Over 60% of associates have no money laundering indexes with a value of 5 or higher
// 2At least one associate has a money laundering index with a value of 5 or higher
// 1No associate has a  money laundering index with a  value of 5 or higher


export string2 IndPublicityIndex := Map(//??? => '9',
																				//??? => '8',
																				//??? => '7',
																				//??? => '6',
																				//??? => '5',
																				//??? => '4',
																				//??? => '3',
																				//??? => '2',
																				//??? => '1',
																				SubjectOnFile = '0' => '-1',
																					'0');

// 9Individual to common to accurately assess
// 8Individual found in 40 or more articles containing negative  news in past 90 days
// 7Individual found in 40 or more articles containing negative news in past 24 months
// 6Individual found in 15 or more articles containing  negative news in past 90 days
// 5Individual found in 15 or more articles containing  negativene ws in past 24 months
// 4Individual found in 5 or more articles containing negative  news in past 90 days
// 3Individual found in 5 or more articles containing negative  news in past 24 months
// 2Individual not found in articles containing  negative news in past 90 days
// 1Individual not found in articles containing  negative news in past 24 months

export string2 IndAgeIndex := Map((unsigned)BestReportedAge(false) between 1 and 18 => '9',
																	(unsigned)BestReportedAge(false) between 19 and 21 => '8',
																	(unsigned)BestReportedAge(false) between 22 and 25 => '7',
																	(unsigned)BestReportedAge(false) between 26 and 35 => '6',
																	(unsigned)BestReportedAge(false) between 36 and 50 => '5',
																	(unsigned)BestReportedAge(false) between 51 and 63 => '4',
																	(unsigned)BestReportedAge(false) between 64 and 75 => '3',
																	(unsigned)BestReportedAge(false) between 76 and 85 => '2',
																	(unsigned)BestReportedAge(false) > 85 => '1',
																	SubjectOnFile = '0' => '-1',
																	'0');


// New attributes for Riskview 5.0
	
	// if input address isn't one of your last 3 addresses, yet we have it in the address history, use the dates from the address history summary
	shared	IAdateFirstSeen_v5 := clam.address_verification.input_address_information.date_first_seen;
	shared	InputAddrDateFirstSeen_v5 := if(IAdateFirstSeen_v5=0 and clam.address_history_summary.hist_addr_match > 0, 
																			 clam.address_history_summary.input_addr_first_seen,
																			 IAdateFirstSeen_v5);
	shared	InputAddrDateLastSeen_v5_temp := if(clam.address_verification.input_address_information.date_last_seen=0 and clam.address_history_summary.hist_addr_match > 0, 
																			 clam.address_history_summary.input_addr_last_seen,
																			 clam.address_verification.input_address_information.date_last_seen);	
	shared InputAddrDateLastSeen_v5 := if(InputAddrDateLastSeen_v5_temp > clam.header_summary.header_build_date, clam.header_summary.header_build_date, InputAddrDateLastSeen_v5_temp);																		 

	
shared subjectFirstSeen_v5_temp1 := fixYYYY00((unsigned)identity_source_first_seen_dates[1].str2);
shared subjectFirstSeen_v5_temp := if(InputAddrDateFirstSeen_v5<>0 and InputAddrDateFirstSeen_v5 < subjectFirstSeen_v5_temp1, InputAddrDateFirstSeen_v5, subjectFirstSeen_v5_temp1);
shared subjectLastSeen_v5_temp1 := fixYYYY00((unsigned)max(Identity_source_last_seen_dates, (unsigned)str2));
shared subjectLastSeen_v5_temp := if(InputAddrDateLastSeen_v5 > subjectLastSeen_v5_temp1, InputAddrDateLastSeen_v5, subjectLastSeen_v5_temp1);
// shared subjectFirstSeen_v5_temp := ut.Min2(clam.ssn_verification.header_first_seen, clam.ssn_verification.credit_first_seen);
// shared subjectLastSeen_v5_temp := checkDate6(ut.max2(clam.ssn_verification.header_last_seen, clam.ssn_verification.credit_last_seen));
shared subjectFirstSeen_v5 := if(clam.historydate=999999 and subjectFirstSeen_v5_temp>=clam.header_summary.header_build_date, clam.header_summary.header_build_date, subjectFirstSeen_v5_temp);
shared subjectLastSeen_v5 := if(clam.historydate=999999 and subjectLastSeen_v5_temp>=clam.header_summary.header_build_date, clam.header_summary.header_build_date, subjectLastSeen_v5_temp);

shared BureauFirstSeen_v5_temp := fixYYYY00((unsigned)bureau_source_first_seen_dates[1].str2); 
shared BureauLastSeen_v5_temp := fixYYYY00((unsigned)max(bureau_source_last_seen_dates, (unsigned)str2));
shared BureauFirstSeen_v5 := if(clam.historydate=999999 and BureauFirstSeen_v5_temp>=clam.header_summary.header_build_date, clam.header_summary.header_build_date, BureauFirstSeen_v5_temp);
shared BureauLastSeen_v5 := if(clam.historydate=999999 and BureauLastSeen_v5_temp>=clam.header_summary.header_build_date, clam.header_summary.header_build_date, BureauLastSeen_v5_temp);

export string2 SubjectDeceased := map(not clam.truedid => '-1',
	clam.iid.DIDDeceased => '1', 
	StringLib.StringFind(clam.header_summary.ver_sources,mdr.sourcetools.src_Death_Master, 1) > 0 or
	StringLib.StringFind(clam.header_summary.ver_sources,mdr.sourcetools.src_Death_State, 1) > 0 => '1', 
	'0');

	shared attr_felonies90 := clam.bjl.criminal_count90;	// criminal_count90 is felonies only in FCRA
	shared attr_eviction_count90 := clam.bjl.eviction_count90;
	shared attr_num_unrel_liens90 := clam.bjl.liens_unreleased_count90;
	shared attr_bankruptcy_count90 := clam.bjl.bk_count90;
	shared Derog_Count90 := attr_felonies90 + attr_eviction_count90 + attr_num_unrel_liens90 + attr_bankruptcy_count90; 
	shared attr_num_nonderogs90 := clam.source_verification.num_nonderogs90;
	shared attr_addrs_last90 := clam.other_address_info.addrs_last90;
	
export string2 SubjectActivityIndex03Month	:= 
		map(not clam.truedid => '-1',
		  Derog_Count90=0         AND attr_num_nonderogs90=0 => '-1', 
      attr_felonies90>0        OR attr_eviction_count90>0   => '7', 
      attr_num_unrel_liens90>0 OR attr_bankruptcy_count90>0 => '6',
      attr_num_nonderogs90<=1 AND attr_addrs_last90>=2      => '6',
      attr_num_nonderogs90<=1 AND attr_addrs_last90 =1      => '5',
      attr_num_nonderogs90 =2 AND attr_addrs_last90>=2      => '5',
      attr_num_nonderogs90 =2 AND attr_addrs_last90 =1      => '4',
      attr_num_nonderogs90 =3 AND attr_addrs_last90>=2      => '4',
      attr_num_nonderogs90 =3 AND attr_addrs_last90 =1      => '3',
      attr_num_nonderogs90 =2 => '3',
      attr_num_nonderogs90 in [3,4] => '2',
      attr_num_nonderogs90>=5 => '1',
			'4');

	shared attr_felonies_6months := clam.bjl.criminal_count180;	// criminal_count180 is felonies only in FCRA
	shared attr_eviction_count_6months := clam.bjl.eviction_count180;
	shared attr_num_unrel_liens_6months := clam.bjl.liens_unreleased_count180;
	shared attr_bankruptcy_count_6months := clam.bjl.bk_count180;
	shared Derog_Count_6months := attr_felonies_6months + attr_eviction_count_6months + attr_num_unrel_liens_6months + attr_bankruptcy_count_6months; 
	shared attr_num_nonderogs_6months := clam.source_verification.num_nonderogs180;
	shared attr_addrs_last_6months := clam.velocity_counters.addrs_per_adl_created_6months;
	
export string2 SubjectActivityIndex06Month	:= 
		map(not clam.truedid => '-1',
		  Derog_Count_6months=0         AND attr_num_nonderogs_6months=0 => '-1', 
      attr_felonies_6months>0        OR attr_eviction_count_6months>0   => '7', 
      attr_num_unrel_liens_6months>0 OR attr_bankruptcy_count_6months>0 => '6',
      attr_num_nonderogs_6months<=1 AND attr_addrs_last_6months>=2      => '6',
      attr_num_nonderogs_6months<=1 AND attr_addrs_last_6months =1      => '5',
      attr_num_nonderogs_6months =2 AND attr_addrs_last_6months>=2      => '5',
      attr_num_nonderogs_6months =2 AND attr_addrs_last_6months =1      => '4',
      attr_num_nonderogs_6months =3 AND attr_addrs_last_6months>=2      => '4',
      attr_num_nonderogs_6months =3 AND attr_addrs_last_6months =1      => '3',
      attr_num_nonderogs_6months =2 => '3',
      attr_num_nonderogs_6months in [3,4] => '2',
      attr_num_nonderogs_6months>=5 => '1',
			'4');

	shared attr_felonies_12months := clam.bjl.criminal_count12;	// criminal_count12 is felonies only in FCRA
	shared attr_eviction_count_12months := clam.bjl.eviction_count12;
	shared attr_num_unrel_liens_12months := clam.bjl.liens_unreleased_count12;
	shared attr_bankruptcy_count_12months := clam.bjl.bk_count12;
	shared Derog_Count_12months := attr_felonies_12months + attr_eviction_count_12months + attr_num_unrel_liens_12months + attr_bankruptcy_count_12months; 
	shared attr_num_nonderogs_12months := clam.source_verification.num_nonderogs12;
	shared attr_addrs_last_12months := clam.other_address_info.addrs_last12;
	
export string2 SubjectActivityIndex12Month	:= 
		map(not clam.truedid => '-1',
		  Derog_Count_12months=0         AND attr_num_nonderogs_12months=0 => '-1', 
      attr_felonies_12months>0        OR attr_eviction_count_12months>0   => '7', 
      attr_num_unrel_liens_12months>0 OR attr_bankruptcy_count_12months>0 => '6',
      attr_num_nonderogs_12months<=1 AND attr_addrs_last_12months>=2      => '6',
      attr_num_nonderogs_12months<=1 AND attr_addrs_last_12months =1      => '5',
      attr_num_nonderogs_12months =2 AND attr_addrs_last_12months>=2      => '5',
      attr_num_nonderogs_12months =2 AND attr_addrs_last_12months =1      => '4',
      attr_num_nonderogs_12months =3 AND attr_addrs_last_12months>=2      => '4',
      attr_num_nonderogs_12months =3 AND attr_addrs_last_12months =1      => '3',
      attr_num_nonderogs_12months =2 => '3',
      attr_num_nonderogs_12months in [3,4] => '2',
      attr_num_nonderogs_12months>=5 => '1',
			'4');

export string1 InputProvidedFirstName	:= if(trim(clam.shell_input.fname)<>'', '1', '0');
export string1 InputProvidedLastName	:= if(trim(clam.shell_input.lname)<>'', '1', '0');
export string1 InputProvidedStreetAddress	:= if(trim(clam.shell_input.in_streetaddress)<>'', '1', '0');
export string1 InputProvidedCity	:= if(trim(clam.shell_input.in_city)<>'', '1', '0');
export string1 InputProvidedState	:= if(trim(clam.shell_input.in_state)<>'', '1', '0');
export string1 InputProvidedZipCode	:= if(trim(clam.shell_input.in_zipcode)<>'', '1', '0');
	
	shared string in_ssn := trim(clam.shell_input.ssn);
export string1 InputProvidedSSN := map(	
		in_ssn in ['000000000','111111111','222222222','333333333','444444444','555555555','666666666','777777777','888888888','999999999'] => '0', // set repeating digits as not provided on input
		clam.ADL_Shell_Flags.in_ssnpop=0 and clam.ADL_Shell_Flags.adl_ssn=1 => '1',
		length(in_ssn)=4 => '2',
		in_ssn<>'' and length(in_ssn)=9 => '3', 
		'0');

shared	string in_dob := clam.shell_input.dob;
shared	yearofbirth := (unsigned)in_dob[1..4];
shared	monthofbirth := (unsigned)in_dob[5..6];
shared	dayofbirth := (unsigned)in_dob[7..8];

export string1 InputProvidedDateofBirth	:= 
		map(
		yearofbirth<>0 and monthofbirth<>0 and dayofbirth<>0 => '7', // full dob
		dayofbirth<>0 and yearofbirth<>0 => '6', 
		dayofbirth<>0 and monthofbirth<>0 => '5',
		monthofbirth<>0 and yearofbirth<>0 => '4',
		yearofbirth<>0 and monthofbirth=0 and dayofbirth=0 => '3',
		monthofbirth<>0 and yearofbirth=0 and dayofbirth=0 => '2',
		dayofbirth<>0 and yearofbirth=0 and monthofbirth=0 => '1',
		'0');

export string1 InputProvidedPhone	:= if(trim(clam.shell_input.phone10)<>'', '1', '0');
export string1 InputProvidedLexID	:= map(clam.shell_input.did=0 => '0',
																clam.shell_input.did=clam.did => '2',
																'1');  
																
		
	
export string2 ConfirmationInputSSN	:= map(not clam.truedid or InputProvidedSSN='0' => '-1',
																	~clam.iid.ssnexists => '0',
																	clam.iid.nas_summary in [7, 9, 10, 11, 12] and clam.iid.socsmiskeyflag => '2',
																	clam.iid.nas_summary in [7, 9, 10, 11, 12] => '3',
																	'1');			

export string2 SourceNonDerogProfileIndex := if(not clam.truedid, '-1', (string)clam.source_profile_index);
	
	shared infutor_count := if(clam.infutor.infutor_date_first_seen<>0, 1, 0);
	shared source_directory_count := clam.email_summary.email_ct + infutor_count;
export string2 SourceDirectory	:= map(not clam.truedid => '-1', 
		source_directory_count > 0 => '1', 
		'0');
		
export string3 SourceDirectoryCount := if(not clam.truedid, '-1', capS((string)source_directory_count, capZero, cap255) );
export string2 SourceVoterRegistration := map(not clam.truedid => '-1', 
		StringLib.StringFind(clam.header_summary.ver_sources,mdr.sourcetools.src_Voters_v2, 1) > 0 => '1',
		'0');

export string2 EducationAttendance := map(not clam.truedid => '-1',
													clam.student.file_type='H' => '1', 
													clam.student.file_type='C' => '1',
													clam.student.file_type='O' => '1',
													clam.student.file_type='M' and 
														(clam.student.college_code<>'' or clam.student.college_tier<>'' or clam.student.college_major<>'') => '1',
													clam.student.file_type='' and 
														(clam.student.college_code<>'' or clam.student.college_tier<>'' or clam.student.college_major<>''
														or clam.student.class<>'' or clam.student.income_level_code<>'') => '1',
													'0');
													
export string2 EducationEvidence := map(not clam.truedid => '-1',
															clam.attended_college => '1',
															'0');		
															
export string2 EducationProgramAttended	:= map(not clam.truedid => '-1',
						 EducationAttendance = '1' and clam.student.college_code='2' => '1', // 2 year;
						 EducationAttendance = '1' and clam.student.college_code='4' => '2', // 4 year;
						 EducationAttendance = '1' and clam.student.college_code='1' => '3', // graduate student;
						 '0');

export string2 EducationInstitutionPrivate_v5	:= map(not clam.truedid or clam.student.college_type in ['', 'U'] => '-1',
						 EducationAttendance = '1' and clam.student.college_type in ['P', 'R'] => '1', //  private OR religious);
						 '0');						 

export string2 EducationInstitutionRating_v5 := map(not clam.truedid => '-1',
																				 clam.student.college_tier in ['1','2','3','4','5','6'] => clam.student.college_tier,
																				 '0');

export	string2	ProfLicTypeCategory_v5	:= map(not clam.truedid or trim(clam.professional_license.license_type)='' => '-1', 
	trim(clam.professional_license.plcategory)='' => '0',
	clam.professional_license.plcategory);
																				 
export string2 BusinessAssociation	:= map(not clam.truedid => '-1', 
																				clam.employment.source_ct > 0 => '1', 
																				'0');

export string2 BusinessAssociationIndex := map(not clam.truedid => '-1', 
					(clam.employment.business_ct - clam.employment.dead_business_ct) > 1 => '3',
					(clam.employment.business_ct - clam.employment.dead_business_ct) = 1 => '2',
					clam.employment.dead_business_ct >= 1 => '1',
					'0');
										
export string2 BusinessTitleLeadership	:= map(not clam.truedid or clam.employment.source_ct=0 => '-1', 
					trim(clam.employment.company_title)='' => '0',
					trim(clam.employment.company_title) in riskview.Constants.set_leadership_titles => '1',
					'2');					
					
export string2 AssetPropIndex := map(not(clam.truedid or clam.addrpop) => '-1',
					clam.address_verification.owned.property_total = 0 and clam.address_verification.sold.property_total = 0 and clam.address_verification.ambiguous.property_total = 0 => '0',
					clam.address_verification.owned.property_total = 0 and (clam.address_verification.sold.property_total > 0 or clam.address_verification.ambiguous.property_total > 0) => '1',
					clam.address_verification.owned.property_total = 1 and clam.address_verification.sold.property_total = 0 
					and date_first_purchase=date_most_recent_purchase  and date_first_purchase > 0
					and (integer)PropAgeNewestPurchase <= 24                        => '2',
					clam.address_verification.owned.property_total = 1 => '3',
					'4');			
					
export string3 AssetPropPurchaseCount12Month	:= if(not clam.truedid, '-1', capS((string)clam.other_address_info.num_purchase12, capZero, cap255) );

	shared Input_MortgageType := map(
		~clam.address_verification.input_address_information.applicant_owned => '-1',
		clam.address_verification.input_address_information.type_financing ='ADJ' => '1',
		clam.address_verification.input_address_information.type_financing ='CNV' => '2',
		'0');
	shared Current_MortgageType := map(
		~clam.address_verification.address_history_1.applicant_owned => '-1',
		clam.address_verification.address_history_1.type_financing ='ADJ' => '1',
		clam.address_verification.address_history_1.type_financing ='CNV' => '2',
		'0');	

// first determine which of the 2 addresses are Newest, then output the mortgage type																				
export	string2	AssetPropNewestMortgageType	:= map(not clam.truedid => '-1',
	clam.address_verification.address_history_1.purchase_date >= 
		clam.address_verification.input_address_information.purchase_date => Current_MortgageType,
		Input_MortgageType);		

// patch PropEverSoldCount for cases of ambiguous property
	// num_sold12 in shell also counts ambiguous.  if num_sold12 is greater than sold.property_total, change propEverSoldCount to be the same as num_sold12
	shared propEverSoldCount := map(clam.other_address_info.num_sold12 > clam.address_verification.sold.property_total => clam.other_address_info.num_sold12, 
		(date_first_sale > 0 or date_most_recent_sale > 0) and clam.address_verification.sold.property_total=0 => 1,	// hard code to a 1 if we have dates but don't have a sold count
		clam.address_verification.sold.property_total=0 and clam.address_verification.ambiguous.property_total > 0 => clam.address_verification.ambiguous.property_total,
		clam.address_verification.sold.property_total); 
export string3 AssetPropEverSoldCount	:= if(not clam.truedid, '-1', capS((string)propEverSoldCount, capZero, cap255) );

	sale_within_last5yrs := risk_indicators.iid_constants.checkdays((string)agedate,(string)clam.address_verification.recent_property_sales.sale_date1, risk_indicators.iid_constants.fiveyears, clam.historydate);
export string5 AssetPropSalePurchaseRatio	:= map(not clam.truedid => '-1',
																				 sale_within_last5yrs => PropNewestSalePurchaseIndex, 
																				 '0');
																				 
	shared assetCount := clam.aircraft.aircraft_count + clam.watercraft.watercraft_count;
export string2 AssetPersonal	:= map(not clam.truedid => '-1', 
														 assetCount > 0 => '1',
														 '0');
export string3 AssetPersonalCount	:= if(not clam.truedid, '-1', capS((string)assetCount, capZero, cap255));

	shared number_purchases := (unsigned)clam.ibehavior.total_number_of_orders;
	shared avg_purchase := (unsigned)clam.ibehavior.average_amount_per_order;
export string2 PurchaseActivityIndex	:= map(not clam.truedid => '-1',
	number_purchases=0 => '0',
	number_purchases<3 => '1',
	number_purchases>=3 and avg_purchase < 50 => '2',
	'3');
export string3 PurchaseActivityCount	:= if(purchaseActivityIndex in ['-1', '0'], '-1', capS((string)number_purchases, capZero, cap255));
export string7 PurchaseActivityDollarTotal	:= if(purchaseActivityIndex in ['-1', '0'], '-1', capS((string)((unsigned)clam.ibehavior.total_dollars), capZero,cap7Byte));
	
export string2 DerogSeverityIndex_v5 := map(not clam.truedid => '-1',
		Felony_Count		       > 0 => '5',
		Eviction_Count		     > 0 => '4',
		Lien_Filed_Count       > 0 or Lien_Released_Count    > 0 => '3',
		NumNonFelonyCrimes		 > 0 => '2',
		Bankruptcy_Count       > 0 => '1',
		'0');

// use all criminal records, not just felonies, use unique lien counts		
export String3 DerogCount_v5 := if(not clam.truedid, '-1', 
capS( (string)(Felony_Count + NumNonFelonyCrimes + bankruptcy_count + Lien_Filed_Count + lien_released_count + eviction_count), capZero, cap255) );

export String3 DerogCount12Month := if(not clam.truedid, '-1', 
capS( (string)(clam.bjl.criminal_count12 +
clam.bjl.nonFelony_criminal_count12  +
clam.bjl.bk_count12 + 
clam.bjl.liens_unreleased_count12 + 
clam.bjl.liens_released_count12 + 
clam.bjl.eviction_count12
	), capZero, cap255) );

// add nonfelony date to this calculation for v5
shared date_last_derog_5 := max(
	clam.bjl.last_criminal_date,
	clam.bjl.last_felony_date,
	clam.bjl.date_last_seen,
	(unsigned4)clam.bjl.last_liens_unreleased_date,
	clam.bjl.last_liens_released_date,
	clam.bjl.last_eviction_date
);
	// shared date_last_derogv5 := if( date_last_derog_5 > agedate, 0, date_last_derog_5 );
	export date_last_derogv5 := if( date_last_derog_5 > agedate, 0, date_last_derog_5 );

	shared bankruptcy_age_v5  := Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)bans_date_last_seen, (string)sysdate, true);

shared	crim_sysdate := if(clam.historydate <> 999999, (integer)(((string)clam.historydate)[1..6]), (integer)(clam.crim_build_date[1..6]));

shared date_last_crim_v5 := max(
	clam.bjl.last_criminal_date,
	clam.bjl.last_felony_date
);

shared date_last_derog_v5_noncrim := max(
	clam.bjl.date_last_seen,
	(unsigned4)clam.bjl.last_liens_unreleased_date,
	clam.bjl.last_liens_released_date,
	clam.bjl.last_eviction_date
);

// had to break these 2 up so we're calculating the age of crim from build date instead of the current system date
shared age_last_crim_v5 := Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)date_last_crim_v5, (string)crim_sysdate, true);
shared age_last_derog_noncrim_v5 := Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)date_last_derog_v5_noncrim, (string)sysdate, true);
shared Derog_age_v5_temp := min(age_last_crim_v5, age_last_derog_noncrim_v5);
// patch the age back to 12 months if derogcount12month is > 0
shared Derog_age_v5 := if((unsigned)derogCount12Month>0 and derog_age_v5_temp=13, 12, derog_age_v5_temp) ;

// For RiskView attributes Raise the upper cap only if an older bankruptcy is on file
export	string3	DerogTimeNewest	:= if(not clam.truedid or date_last_derogv5=0, '-1', 
	capS((string)Derog_age_v5 , '1', 
	map( not isFCRA => cap960, 
			bans_date_last_seen<>0 and bankruptcy_age_v5 > 84 => '120', 
			cap84 )));
	

// export	string3	DerogAge_v5	:= if(not clam.truedid or date_last_derogv5=0, '-1', 
	// capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)date_last_derogv5, (string)sysdate, true), '1', 
	// map( not isFCRA => cap960, 
			// bans_date_last_seen<>0 and bankruptcy_age_v5 > 84 => '120', 
			// cap84 )));


export	string3	CriminalNonFelonyCount	:= if(not clam.truedid, '-1', capS((string)NumNonFelonyCrimes, capZero, cap255) );
export	string3	CriminalNonFelonyCount12Month	:= if(not clam.truedid, '-1', capS((string)clam.bjl.nonFelony_criminal_count12, capZero, cap255) );

	shared last_nonfelony_criminal_date := if(clam.bjl.last_nonfelony_criminal_date>ageDate, 0, clam.bjl.last_nonfelony_criminal_date);
export	string3	CriminalNonFelonyTimeNewest	:= if(last_nonfelony_criminal_date=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_nonfelony_criminal_date, (string)sysdate, true), '1', if(isFCRA,cap84,cap960)) ); 
			
export string3 LienJudgmentSeverityIndex := map(not clam.truedid => '-1',
	clam.liens.liens_unreleased_landlord_tenant.count > 0 or
	clam.liens.liens_released_landlord_tenant.count > 0 or
	eviction_count > 0  => '6',
 
	clam.liens.liens_unreleased_small_claims.count > 0 or
	clam.liens.liens_released_small_claims.count > 0 => '5',
	
	clam.liens.liens_unreleased_civil_judgment.count > 0 or
	clam.liens.liens_released_civil_judgment.count > 0 => '4',

	clam.liens.liens_unreleased_federal_tax.count > 0 or
	clam.liens.liens_released_federal_tax.count > 0  or
	clam.liens.liens_unreleased_other_tax.count > 0 or
	clam.liens.liens_released_other_tax.count > 0 => '3',

	clam.liens.liens_unreleased_foreclosure.count > 0 or
	clam.liens.liens_released_foreclosure.count > 0 => '2',
	
	clam.liens.liens_unreleased_other_lj.count > 0 or
	clam.liens.liens_released_other_lj.count > 0 => '1',
 '0');

shared lien_sum := 	clam.liens.liens_unreleased_civil_judgment.count +
	clam.liens.liens_released_civil_judgment.count +
	clam.liens.liens_unreleased_federal_tax.count +
	clam.liens.liens_released_federal_tax.count +
	clam.liens.liens_unreleased_foreclosure.count +
	clam.liens.liens_released_foreclosure.count +
	clam.liens.liens_unreleased_landlord_tenant.count +
	clam.liens.liens_released_landlord_tenant.count +
	clam.liens.liens_unreleased_lispendens.count +
	clam.liens.liens_released_lispendens.count +
	clam.liens.liens_unreleased_other_lj.count +
	clam.liens.liens_released_other_lj.count +
	clam.liens.liens_unreleased_other_tax.count +
	clam.liens.liens_released_other_tax.count +
	clam.liens.liens_unreleased_small_claims.count +
	clam.liens.liens_released_small_claims.count;
	
shared	LienJudgmentCount_temp	:= clam.bjl.liens_historical_unreleased_count + clam.bjl.liens_recent_unreleased_count +
														 clam.bjl.liens_historical_released_count + clam.bjl.liens_recent_released_count;

export string3 LienJudgmentCount := if(not clam.truedid, '-1', 
capS((string)(if(lien_sum < LienJudgmentCount_temp, lien_sum, LienJudgmentCount_temp)), capZero, cap255) );


shared LienJudgmentCount12Month_temp := clam.bjl.liens_unreleased_count12 + clam.bjl.liens_released_count12;

export String3 LienJudgmentCount12Month := if(not clam.truedid, '-1', 
capS( (string)(if(lien_sum < LienJudgmentCount12Month_temp, lien_sum, LienJudgmentCount12Month_temp)), capZero, cap255) );

export String3 LienJudgmentLandlordTenantCount := if(not clam.truedid, '-1', 
capS( (string)(clam.liens.liens_unreleased_landlord_tenant.count + clam.liens.liens_released_landlord_tenant.count), capZero, cap255) );

export String3 LienJudgmentSmallClaimsCount := if(not clam.truedid, '-1', 
capS( (string)(clam.liens.liens_unreleased_small_claims.count + clam.liens.liens_released_small_claims.count), capZero, cap255) );

export String3 LienJudgmentCourtCount := if(not clam.truedid, '-1', 
capS( (string)(clam.liens.liens_unreleased_civil_judgment.count + clam.liens.liens_released_civil_judgment.count), capZero, cap255) );

export String3 LienJudgmentTaxCount := if(not clam.truedid, '-1', 
capS( (string)(clam.liens.liens_unreleased_federal_tax.count +
	clam.liens.liens_released_federal_tax.count +
	clam.liens.liens_unreleased_other_tax.count +
	clam.liens.liens_released_other_tax.count), capZero, cap255) );

export String3 LienJudgmentForeclosureCount := if(not clam.truedid, '-1', 
capS( (string)(clam.liens.liens_unreleased_foreclosure.count + clam.liens.liens_released_foreclosure.count), capZero, cap255) );

export String3 LienJudgmentOtherCount := if(not clam.truedid, '-1', 
capS( (string)(clam.liens.liens_unreleased_other_lj.count + clam.liens.liens_released_other_lj.count), capZero, cap255) );

export	string7	LienJudgmentDollarTotal	:= if(not clam.truedid, '-1', capS((string)
			(clam.liens.liens_released_landlord_tenant.total_amount +
			clam.liens.liens_released_small_claims.total_amount +
			clam.liens.liens_released_civil_judgment.total_amount +
			clam.liens.liens_released_federal_tax.total_amount +
			clam.liens.liens_released_other_tax.total_amount +
			clam.liens.liens_released_foreclosure.total_amount +
			clam.liens.liens_released_other_lj.total_amount +
			
			clam.liens.liens_unreleased_landlord_tenant.total_amount +
			clam.liens.liens_unreleased_small_claims.total_amount +
			clam.liens.liens_unreleased_civil_judgment.total_amount +
			clam.liens.liens_unreleased_federal_tax.total_amount +
			clam.liens.liens_unreleased_other_tax.total_amount +
			clam.liens.liens_unreleased_foreclosure.total_amount +
			clam.liens.liens_unreleased_other_lj.total_amount), capZero, cap7Byte) );


// age attributes in Riskview 5.0 have lower cap of 1 instead of 0 and use the header max build date instead of today's date
	shared 	header_sysDate_version5 := IF(clam.historydate=999999,
		(unsigned4)Risk_Indicators.iid_constants.full_history_date(clam.header_summary.header_build_date),
		(unsigned4)Risk_Indicators.iid_constants.full_history_date(clam.historydate));  
	
	shared Age_Oldest_Record_v5 := capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)subjectFirstSeen_v5 + '01', (string)header_sysDate_version5, true), capOfOne, cap960);
	shared Age_Newest_Record_v5 := if(subjectLastSeen=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)subjectLastSeen_v5 + '31', (string)header_sysDate_version5, true), capZero, cap960) );
	
export	string3	SubjectRecordTimeOldest	:= if(not clam.truedid or subjectFirstSeen_v5=0, '-1', Age_Oldest_Record_v5 );		
export	string3	SubjectRecordTimeNewest := if(not clam.truedid or subjectLastSeen_v5=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)subjectLastSeen_v5 + '31', (string)header_sysDate_version5, true), capOfOne, cap960) );	
export	string2	SubjectNewestRecord12Month	:= map(not clam.truedid => '-1', 
																									(integer)age_newest_record_v5 between 0 and 11 => '1', 
																									// comment this back out, cause other test failures ( _test_189 ) when allowing 12 months to match nonderogs12
																									// (integer)age_newest_record_v5 between 0 and 12 => '1',  // go out to 12 months in history mode to match num_nonderogs12 logic (fix _test_219 )
																									'0');

export	string3	SourceCredHeaderTimeOldest := if(not clam.truedid or (integer)SourceCreditBureauCount=0 or BureauFirstSeen_v5=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)BureauFirstSeen_v5+ '01', (string)header_sysDate_version5, true), capOfOne, cap960) );	
export	string3	SourceCredHeaderTimeNewest := if(not clam.truedid or (integer)SourceCreditBureauCount=0 or BureauLastSeen_v5=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)BureauLastSeen_v5+ '31', (string)header_sysDate_version5, true), capOfOne, cap960) );

export	string3	BusinessAssociationTimeOldest	:= if(not clam.truedid or clam.employment.first_seen_date=0, '-1', 
					capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)clam.employment.first_seen_date, (string)ageDate, true), capOfOne, cap960) );	
					
export	string3	AssetPropPurchaseTimeOldest	:= if(not clam.truedid or date_first_purchase=0, '-1', 
																						capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)date_first_purchase,	(string)sysdate, true), capOfOne, cap960) );
																						
export	string3	AssetPropPurchaseTimeNewest	:= if(not clam.truedid or date_most_recent_purchase=0, '-1', 
																				capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)date_most_recent_purchase,	(string)sysdate, true), capOfOne, cap960) );
																				
export string3 AssetPropSaleTimeOldest := if(not clam.truedid or date_first_sale=0, '-1', 
															capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)date_first_sale,	(string)sysdate, true), capOfOne, cap960) );

export	string3	AssetPropSaleTimeNewest	:= if(not clam.truedid or date_most_recent_sale=0, '-1', 
															capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)date_most_recent_sale,	(string)sysdate, true), capOfOne, cap960) );

	// patch the PropSold12month count for 2 situations where timeNewestSale is different than num_sold12 in the shell shows
	shared num_sold12_v5 := map(clam.other_address_info.num_sold12 = 0 and AssetPropSaleTimeNewest='12' => 1,
															clam.other_address_info.num_sold12 = 1 and AssetPropSaleTimeNewest='13'	=> 0,
															clam.other_address_info.num_sold12);
export string3 AssetPropSoldCount12Month	:= if(not clam.truedid, '-1', capS((string)num_sold12_v5, capZero, cap255) );

															
export	string3	CriminalFelonyTimeNewest	:= if(not clam.truedid or last_felony_date=0, '-1', 
					capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_felony_date, (string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );
					
export	string3	EvictionAge_v5	:= if(not clam.truedid or last_eviction_date=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_eviction_date, (string)sysdate, true), capOfOne, if(isFCRA, cap84, cap960)) );

	shared last_lien_unreleased_date := if((unsigned)clam.bjl.last_liens_unreleased_date>ageDate, 0, (unsigned)clam.bjl.last_liens_unreleased_date);	
	shared last_lien_date_v5 := max(last_lien_released_date, last_lien_unreleased_date);
export	string3	LienJudgmentTimeNewest := if(not clam.truedid or last_lien_date_v5=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_lien_date_v5, (string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );

export string3	BankruptcyTimeNewest	:= if(not clam.truedid or bans_date_last_seen=0, '-1', 
								capS((string)bankruptcy_age_v5, capOfOne, if( isFCRA, '120', cap960 )) );
		
export string2 BankruptcyChapter := map(not clam.truedid => '-1',
			trim(clam.bjl.bk_chapter)='13'=> '2',
			trim(clam.bjl.bk_chapter)='7'=> '1',
			bankruptcy_count=0 => '0',
			'-1');
			
export string2 BankruptcyStatus_v5 := map(not clam.truedid => '-1',
	not clam.bjl.bankrupt => '0',
	stringlib.stringfind(stringlib.stringtouppercase(clam.bjl.disposition), 'DISCHARGED', 1) > 0 => '1',
	stringlib.stringfind(stringlib.stringtouppercase(clam.bjl.disposition), 'DISMISSED', 1) > 0 => '2',
	'-1');
		
export string2 BankruptcyDismissed24Month := map(not clam.truedid => '-1',
	clam.bjl.bk_dismissed_recent_count > 0 => '1',
	'0');
	
export string2 ShortTermLoanRequest	:= map(not clam.truedid => '-1',
	clam.impulse.count > 0 => '1',
	'0');
export string2 ShortTermLoanRequest12Month	:= map(not clam.truedid => '-1',
	clam.impulse.count12 > 0 => '1',
	'0');
export string2 ShortTermLoanRequest24Month	:= map(not clam.truedid => '-1',
	clam.impulse.count24 > 0 => '1',
	'0');

export string2 InquiryAuto12Month	:= if(not clam.truedid, '-1', checkboolean(clam.acc_logs.auto.count12>0) );
export string2 InquiryBanking12Month	:= if(not clam.truedid, '-1', checkboolean( (clam.acc_logs.banking.count12 +
	clam.acc_logs.retail.count12 +
	clam.acc_logs.mortgage.count12 +
	clam.acc_logs.other.count12)>0) );

export string2 InquiryTelcom12Month	:= if(not clam.truedid, '-1', checkboolean(clam.acc_logs.communications.count12>0));
export string2 InquiryNonShortTerm12Month	:= if(not clam.truedid, '-1', checkboolean(clam.acc_logs.inquiries.count12>0) );
export string2 InquiryShortTerm12Month	:= if(not clam.truedid, '-1', checkboolean(clam.acc_logs.highriskcredit.count12>0) );
export string2 InquiryCollections12Month	:= if(not clam.truedid, '-1', checkboolean(clam.acc_logs.collection.count12>0) );

export string3 SSNSubjectCount := if(not clam.truedid or InputProvidedSSN='0', '-1', capS( (string)clam.velocity_counters.adls_per_ssn_seen_18months, capZero, cap255) );
export string2	SSNDeceased	:= map(not clam.truedid or InputProvidedSSN='0' => '-1', clam.iid.decsflag='1' => '1', '0');

export string8 SSNDateLowIssued := if(not clam.truedid 
                                        or InputProvidedSSN='0' 
                                        or trim(clam.iid.socllowissue)='' or trim(clam.iid.socllowissue)='0'
                                        or clam.iid.socllowissue = '20110625'  , '-1', clam.iid.socllowissue);
// export string8 SSNDateLowIssued := if(TRIM(SSNDateLowIssued1)='' OR SSNDateLowIssued1 = '0' ,'-1', SSNDateLowIssued1);
                                     
export string2	SSNProblems_v5	:= map(not clam.truedid or InputProvidedSSN='0' 								=> '-1',  // not input
								clam.iid.decsflag='1' 		=> '5',   // deceased SSN
								clam.iid.socsdobflag='1'	=> '4',  	// issued prior to DOB
								Risk_Indicators.rcSet.isCodeIS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag)  => '3',  	// verified and valid, but was invalid prior to June 25th (reason code IS flag)
								not clam.SSN_Verification.Validation.valid => '2',  // invalid ssn
								Risk_Indicators.rcSet.isCodeRS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag)	=> '1', // randomized ssn (RS)
								'0');  // valid
export string3 AddrOnFileCount := if(not clam.truedid, '-1', capS((string)clam.velocity_counters.addrs_per_adl, capZero, cap255));
 // shared	boolean prison_within_last7yrs := risk_indicators.iid_constants.checkdays((string)ageDate,(string)clam.other_address_info.prisonFSdate, ut.DaysInNYears(7), clam.historydate);
 shared	boolean prison_within_last7yrs := true;
export string2 AddrOnFileCorrectional := if(not clam.truedid, '-1', checkboolean(clam.other_address_info.isprison and prison_within_last7yrs) );
export string2 AddrOnFileCollege := if(not clam.truedid, '-1', checkboolean(clam.address_history_summary.address_history_college_evidence) ); 

 shared	hist1_within_last7yrs := risk_indicators.iid_constants.checkdays((string)ageDate,(string)clam.address_verification.address_history_1.date_last_seen + '01', ut.DaysInNYears(7), clam.historydate);
 shared	hist2_within_last7yrs := risk_indicators.iid_constants.checkdays((string)ageDate,(string)clam.address_verification.address_history_2.date_last_seen + '01', ut.DaysInNYears(7), clam.historydate);
export string2 AddrOnFileHighRisk := map(not clam.truedid => '-1', 
 (clam.address_verification.address_history_1.hr_address=true and hist1_within_last7yrs) or
 (clam.address_verification.address_history_2.hr_address=true and hist2_within_last7yrs) => '1',
 '0');	
 
export	string3	AddrInputTimeOldest	:= if(not clam.truedid or noaddrInput or InputAddrDateFirstSeen_v5=0, '-1', 
																				capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)InputAddrDateFirstSeen_v5  + '01',	(string)header_sysDate_version5, true), capOfOne, cap960) );
																				
export	string3	AddrInputTimeNewest	:= if(not clam.truedid or noaddrInput or InputAddrDateLastSeen_v5=0, '-1', 
																				capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)checkDate6(InputAddrDateLastSeen_v5) + '31',	(string)header_sysDate_version5, true), capOfOne, cap960) );
																				
	shared InputLengthOfRes := ((INTEGER)AddrInputTimeOldest - (INTEGER)AddrInputTimeNewest);
export	string3	AddrInputLengthOfRes 	:= if(not clam.truedid or noaddrInput or InputAddrDateFirstSeen_v5=0 or InputAddrDateLastSeen_v5=0, '-1',
																		capS((string)InputLengthOfRes, capOfOne, cap960) );	
export string3 AddrInputSubjectCount := if(not clam.truedid or InputAddrDwellTypeNonSFRes=1, '-1', 	capS((string)clam.velocity_counters.adls_per_addr_current, capZero, cap255) );
export string2 AddrInputMatchIndex := map(not clam.truedid or noaddrInput => '-1', 
	clam.address_verification.inputaddr_occupancy_index=1 => '2', 	//Input address matches the most current address on file
	clam.address_verification.inputaddr_occupancy_index in [2, 3, 5, 6] => '1',  //Input address matches a previous address on file
	'0');  //Input address does not match any address on file

export string2 AddrInputOwnershipIndex := map(not clam.truedid or noaddrInput => '-1',
	clam.address_verification.input_address_information.naprop=4 or clam.address_verification.input_address_information.applicant_owned => '4', // applicant owned
	clam.address_verification.input_address_information.naprop=3 => '3', // family owned
	clam.address_verification.input_address_information.occupant_owned => '2',  // occupant owned
	~clam.address_verification.input_address_information.occupant_owned and clam.iid.dwelltype not in ['','S'] => '1',// rent,
	'0');

export string2 AddrInputPhoneService := map(noaddrInput => '-1',
	clam.address_verification.activephone<>0 => '1',
	'0');
	
export string3 AddrInputPhoneCount := map(noAddrInput => '-1', capS((string)clam.velocity_counters.phones_per_addr_current, capZero, cap255));

export string2 AddrInputDwellType := map(noAddrInput or IADwellType='' => '-1',
	IADwelltype in ['U', 'M'] => 'U',  // add military dwelltype to the category of U for 5.0
	IADwelltype);

export string2 AddrInputDwellTypeIndex := map(noAddrInput => '-1',
	IADwelltype in ['S','R','G'] => '3',
	IADwelltype = 'P' => '2',		
	IADwelltype in ['H', 'F'] => '1',
	'0');
	
export string2 AddrInputDelivery := map(noAddrInput => '-1',
	clam.advo_input_addr.address_vacancy_indicator='Y' => '4',  // vacant address
	clam.advo_input_addr.seasonal_delivery_indicator='E' or clam.advo_input_addr.college_indicator='Y' => '3',  // educational institution
	clam.advo_input_addr.throw_back_indicator='Y' => '2',  // mail is sent to PO box instead of the home address
	clam.advo_input_addr.seasonal_delivery_indicator='Y' and clam.advo_input_addr.residential_or_business_ind in ['A','C'] => '1',  // seasonal residential
	'-1');
	
export string3 AddrInputTimeLastSale := if(not clam.truedid or clam.address_verification.input_address_information.purchase_date=0 or 
																						clam.address_verification.input_address_information.purchase_date>ageDate, '-1', 
																		capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)clam.address_verification.input_address_information.purchase_date, (string)sysdate, true), capofOne, cap960) );	
																		
																		
export	string7	AddrInputLastSalePrice	:= if(noaddrinput or clam.address_verification.input_address_information.purchase_amount=0 or
																								clam.address_verification.input_address_information.purchase_date>ageDate, '-1', 
																								capS((string)clam.address_verification.input_address_information.purchase_amount, capZero, cap7Byte));

export	string7	AddrInputTaxValue 	:= if(noaddrinput, '-1', 
																								capS((string)clam.address_verification.input_address_information.assessed_total_value, capZero, cap7Byte));

export	string7	AddrInputTaxMarketValue	:= if(noaddrinput, '-1', 
																								capS((string)clam.address_verification.input_address_information.assessed_amount, capZero, cap7Byte));

export string7 AddrInputAVMValue := if(noaddrinput, '-1', 
																				  capS((string)clam.avm.input_address_information.avm_automated_valuation, capZero, cap7Byte));
																					
export string7 AddrInputAVMValue12Month	:= if(noaddrinput, '-1', 
																				  capS((string)clam.avm.input_address_information.avm_automated_valuation2, capZero, cap7Byte));  // valuation2 = 1 year prior	
																					
export string7 AddrInputAVMValue60Month	:= if(noaddrinput, '-1', 
																				  capS((string)clam.avm.input_address_information.avm_automated_valuation6, capZero, cap7Byte));  // valuation6 = 5 years prior

export string5 AddrInputAVMRatio12MonthPrior := map(noaddrinput or AddrInputAVMValue='-1' => '-1', 
	clam.avm.input_address_information.avm_automated_valuation2 = 0 => '0',
	trim((string)(decimal4_2)(capR(clam.avm.input_address_information.avm_automated_valuation / clam.avm.input_address_information.avm_automated_valuation2, 0, 99.0))) );
																					
export string5 AddrInputAVMRatio60MonthPrior := map(noaddrinput or AddrInputAVMValue='-1' => '-1', 
	clam.avm.input_address_information.avm_automated_valuation6 = 0 => '0',
	trim((string)(decimal4_2)(capR(clam.avm.input_address_information.avm_automated_valuation / clam.avm.input_address_information.avm_automated_valuation6, 0, 99.0))) );

export string2 AddrInputProblems	:= map(noAddrInput=> '-1',
											clam.iid.hriskaddrflag='4' AND clam.iid.hrisksic = '2225' => '5',  // prison or correctional facility
											clam.iid.zipclass in ['M','U'] => '4',  // non-residential (unique corporate or military zip)
											clam.iid.hriskaddrflag='4' AND clam.iid.hrisksic <> '2225' => '3',  // high risk, non prison																					
											clam.iid.addrvalflag<>'V' => '2',  // invalid address
											clam.iid.zipclass='P' => '1',  // po box zip
											'0');  // default to be valid

	shared AH1DateLastSeen_temp := checkDate6(fixYYYY00(clam.address_verification.address_history_1.date_last_seen));	
	shared AH1DateLastSeen := if(AH1DateLastSeen_temp > clam.header_summary.header_build_date, clam.header_summary.header_build_date, AH1DateLastSeen_temp);	
export string3 AddrCurrentTimeOldest := if(not clam.truedid or AH1dateFirstSeen=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)AH1dateFirstSeen + '01',	(string)header_sysDate_version5, true), CapofOne, cap960) );
export string3 AddrCurrentTimeNewest := if(not clam.truedid or AH1DateLastSeen=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)AH1DateLastSeen + '31',	(string)header_sysDate_version5, true), CapofOne, cap960) );
	shared CurrentLengthOfRes := ((INTEGER)AddrCurrentTimeOldest - (INTEGER)AddrCurrentTimeNewest);
export string3 AddrCurrentLengthOfRes := if(not clam.truedid or AH1dateFirstSeen=0 or AH1DateLastSeen=0, '-1',
																capS((string)currentLengthOfRes, capOfOne, cap960) );
	
export string2 AddrCurrentSubjectOwned := map(not clam.truedid or clam.address_verification.address_history_1.naprop=0 => '-1',
																							clam.address_verification.address_history_1.applicant_owned => '1',
																							'0');	
	
export string2 AddrCurrentDeedMailing :=  map(not clam.truedid or clam.address_verification.address_history_1.naprop=0 => '-1',
																							clam.address_verification.address_history_1.occupant_owned and 
																								~clam.address_verification.address_history_1.applicant_owned and
																								~clam.address_verification.address_history_1.family_owned => '1',
																							'0');
																							
export string2 AddrCurrentOwnershipIndex := map(not clam.truedid => '-1',	
	clam.address_verification.address_history_1.naprop=4 or clam.address_verification.address_history_1.applicant_owned  => '4', // applicant owned
	clam.address_verification.address_history_1.naprop=3 => '3', // family owned
	clam.address_verification.address_history_1.occupant_owned => '2',  // occupant owned
	~clam.address_verification.address_history_1.occupant_owned and clam.address_verification.addr_type2 not in ['','S'] => '1',// rent,
	'0');
	
export string2 AddrCurrentPhoneService := map(not clam.truedid => '-1',
	clam.address_verification.activephone2<>0 => '1',
	'0');

export string2 AddrCurrentDwellType := map(not clam.truedid or clam.address_verification.addr_type2 ='' => '-1',
	clam.address_verification.addr_type2 in ['U', 'M'] => 'U',  // add military dwelltype to the category of U for 5.0
	clam.address_verification.addr_type2);


export string2 AddrCurrentDwellTypeIndex := map(not clam.truedid => '-1',
	clam.address_verification.addr_type2 in ['S','R','G'] => '3',
	clam.address_verification.addr_type2 = 'P' => '2',		
	clam.address_verification.addr_type2 in ['H', 'F'] => '1',
	'0');
	
export string3 AddrCurrentTimeLastSale := if(not clam.truedid or clam.address_verification.address_history_1.purchase_date=0 or 
	clam.address_verification.address_history_1.purchase_date>ageDate, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)clam.address_verification.address_history_1.purchase_date, (string)sysdate, true), capofOne, cap960) );	

export string7 AddrCurrentLastSalesPrice := if(not clam.truedid or clam.address_verification.address_history_1.purchase_amount=0 or
																								clam.address_verification.address_history_1.purchase_date>ageDate, '-1', 
																								capS((string)clam.address_verification.address_history_1.purchase_amount, capZero, cap7Byte));

export string7 AddrCurrentTaxValue := if(not clam.truedid, '-1', 
																								capS((string)clam.address_verification.address_history_1.assessed_total_value, capZero, cap7Byte));

export string4 AddrCurrentTaxYr := if(not clam.truedid, '-1', Hist1AvyValueChk);

export string7 AddrCurrentTaxMarketValue	:= if(not clam.truedid, '-1', 
																								capS((string)clam.address_verification.address_history_1.assessed_amount, capZero, cap7Byte));

export string7 AddrCurrentAVMValue := if(not clam.truedid, '-1', 
																				  capS((string)clam.avm.address_history_1.avm_automated_valuation, capZero, cap7Byte));
																					
export string7 AddrCurrentAVMValue12Month	:= if(not clam.truedid, '-1', 
																				  capS((string)clam.avm.address_history_1.avm_automated_valuation2, capZero, cap7Byte));  // valuation2 = 1 year prior	
																					
export string7 AddrCurrentAVMValue60Month	:= if(not clam.truedid, '-1', 
																				  capS((string)clam.avm.address_history_1.avm_automated_valuation6, capZero, cap7Byte));  // valuation6 = 5 years prior

export string5 AddrCurrentAVMRatio12MonthPrior := map(not clam.truedid or AddrCurrentAVMValue='-1' => '-1', 
	clam.avm.address_history_1.avm_automated_valuation2 = 0 => '0',
	trim((string)(decimal4_2)(capR(clam.avm.address_history_1.avm_automated_valuation / clam.avm.address_history_1.avm_automated_valuation2, 0, 99.0))) );
																					
export string5 AddrCurrentAVMRatio60MonthPrior := map(not clam.truedid or AddrCurrentAVMValue='-1' => '-1', 
	clam.avm.address_history_1.avm_automated_valuation6 = 0 => '0',
	trim((string)(decimal4_2)(capR(clam.avm.address_history_1.avm_automated_valuation / clam.avm.address_history_1.avm_automated_valuation6, 0, 99.0))) );

export	string5	AddrCurrentCountyRatio	:= if(not clam.truedid, '-1', 
																					trim((string)(decimal4_2)(capR(clam.avm.address_history_1.avm_automated_valuation / clam.avm.address_history_1.avm_median_fips_level, 0, 99.0))) );
																					
export	string5	AddrCurrentTractRatio	:= if(not clam.truedid, '-1', 
																					trim((string)(decimal4_2)(capR(clam.avm.address_history_1.avm_automated_valuation / clam.avm.address_history_1.avm_median_geo12_level, 0, 99.0))) );
																					
export	string5	AddrCurrentBlockRatio	:= if(not clam.truedid, '-1', 
																					trim((string)(decimal4_2)(capR(clam.avm.address_history_1.avm_automated_valuation / clam.avm.address_history_1.avm_median_geo11_level, 0, 99.0))) );
	
export string2 AddrCurrentCorrectional := map(not clam.truedid => '-1',
	clam.other_address_info.hist1_isprison => '1', 
	'0');  
		
	shared AH2DateLastSeen_temp := checkDate6(fixYYYY00(clam.address_verification.address_history_2.date_last_seen));
	shared AH2DateLastSeen := if(AH2DateLastSeen_temp > clam.header_summary.header_build_date, clam.header_summary.header_build_date, AH2DateLastSeen_temp);	

export string3 AddrPreviousTimeOldest := if(not clam.truedid or AH2dateFirstSeen=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)AH2dateFirstSeen + '01',	(string)header_sysDate_version5, true), CapofOne, cap960) );
export string3 AddrPreviousTimeNewest := if(not clam.truedid or AH2DateLastSeen=0, '-1', capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)AH2DateLastSeen + '31',	(string)header_sysDate_version5, true), CapofOne, cap960) );
	shared PreviousLengthOfRes := ((INTEGER)AddrPreviousTimeOldest - (INTEGER)AddrPreviousTimeNewest);
export string3 AddrPreviousLengthOfRes := if(not clam.truedid or AH2dateFirstSeen=0 or AH2DateLastSeen=0, '-1',
																capS((string)PreviousLengthOfRes, CapofOne, cap960) );
	
export string2 AddrPreviousSubjectOwned := map(not clam.truedid or clam.address_verification.address_history_2.naprop=0 => '-1',
	clam.address_verification.address_history_2.applicant_owned	=> '3',
	clam.address_verification.address_history_2.applicant_sold => '2',
	'1');
			
export string2 AddrPreviousOwnershipIndex := map(not clam.truedid  => '-1',
 	clam.address_verification.address_history_2.applicant_owned => '1', // applicant owned
	clam.address_verification.address_history_2.family_owned => '2', // family owned
	clam.address_verification.address_history_2.applicant_sold => '3',  // applicant sold
	clam.address_verification.address_history_2.family_sold => '4', // family sold
	clam.address_verification.address_history_2.naprop=0 => '5',
	'0');
	
export string2 AddrPreviousDwellType := map(not clam.truedid or clam.address_verification.addr_type3 ='' => '-1',
	clam.address_verification.addr_type3 in ['U', 'M'] => 'U',  // add military dwelltype to the category of U for 5.0
	clam.address_verification.addr_type3);
	
export string2 AddrPreviousDwellTypeIndex := map(not clam.truedid => '-1',
	clam.address_verification.addr_type3 in ['S','R','G'] => '3',
	clam.address_verification.addr_type3 = 'P' => '2',		
	clam.address_verification.addr_type3 in ['H', 'F'] => '1',
	'0');	
	
	shared	boolean ah2_within_last7yrs := risk_indicators.iid_constants.checkdays((string)ageDate,(string)AH2dateFirstSeen + '01', ut.DaysInNYears(7), clam.historydate);
export string2 AddrPreviousCorrectional := map(not clam.truedid => '-1',
	clam.other_address_info.hist2_isprison and ah2_within_last7yrs => '1', '0'); 

	shared move_within_last5yrs := risk_indicators.iid_constants.checkdays((string)ageDate,(string)AH2dateFirstSeen + '01', ut.DaysInNYears(5), clam.historydate);
export	string5	AddrLastMoveTaxRatioDiff	:= if(not clam.truedid or not move_within_last5yrs, '-1', 
																					trim((string)(decimal4_2)(capR(clam.address_verification.address_history_1.assessed_total_value / clam.address_verification.address_history_2.assessed_total_value, 0, 99.0))) );
	
export string2 AddrLastMoveEconTrajectory := if(not clam.truedid, '-1', (string)clam.economic_trajectory);
export string2 AddrLastMoveEconTrajectoryIndex := if(not clam.truedid, '-1', (string)clam.economic_trajectory_index);
export string2 PhoneInputProblems := map(noPhoneinput => '-1', 
	clam.iid.phonetype <> '1' and clam.shell_input.phone10 <> '' => '6',  // phone invalid
	clam.iid.hriskphoneflag = '2' => '5', // phone is a pager
	clam.shell_input.in_Zipcode<>'' and clam.iid.phonezipflag = '1' => '4', // phone zip mismatch
	clam.iid.hriskphoneflag = '5' => '3',  // transient high risk
	clam.iid.disthphoneaddr > 10 and clam.iid.disthphoneaddr<>9999 => '2', // distance between phone and address greater than 10 miles	
	clam.iid.phonedissflag and clam.input_validation.homephone => '1', // phone is disconnected
	'0');  // no problems		

export string3 PhoneInputSubjectCount := if(noPhoneinput, '-1', capS((string)clam.velocity_counters.adls_per_phone_current, capZero, cap255) );	


export string1 ConfirmationSubjectFound := 
  if(riskview.constants.noscore(clam.iid.nas_summary,clam.iid.nap_summary, clam.address_verification.input_address_information.naprop, clam.truedid), 
  '0',  // subject not found
  '1');  // subject found

export	string7	AssetPropCurrentTaxTotal	:= if(not clam.truedid or clam.address_verification.owned.property_total < 1, '-1', 
	capS((string)clam.address_verification.owned.property_owned_assessed_total, capZero, cap7Byte) );

export	string7	AssetPropNewestSalePrice	:= if(not clam.truedid or clam.address_verification.recent_property_sales.sale_price1=0, '-1',
															capS((string)clam.address_verification.recent_property_sales.sale_price1, capZero, cap7Byte) );
															
//Juli Attributes

  shared eviction_count_lnj := clam.LnJ_attributes.lnj_eviction_recent_unreleased_count + 
															clam.LnJ_attributes.lnj_eviction_historical_unreleased_count +
															clam.LnJ_attributes.lnj_eviction_recent_released_count + 
															clam.LnJ_attributes.lnj_eviction_historical_released_count;
export String3 LnJEvictionTotalCount	:= capS((string)eviction_count_lnj, capZero, cap255);

export	string3	LnJEvictionTotalCount12Month	:= capS((string)clam.LnJ_attributes.lnj_eviction_count12, capZero, cap255);

export string3 LnJLienJudgmentSeverityIndex := map(not clam.truedid => '-1',
	clam.LnJ_attributes.LnJ_unreleased_landlord_tenant_cnt > 0 or
	clam.LnJ_attributes.LnJ_released_landlord_tenant_cnt > 0 or
	(integer) LnJEvictionTotalCount > 0  => '6',
 
	clam.LnJ_attributes.LnJ_unreleased_small_claims_cnt > 0 or
	clam.LnJ_attributes.LnJ_released_small_claims_cnt > 0 => '5',
	
	clam.LnJ_attributes.LnJ_unreleased_civil_judgment_cnt > 0 or
	clam.LnJ_attributes.LnJ_released_civil_judgment_cnt > 0 => '4',

	clam.LnJ_attributes.LnJ_unreleased_federal_tax_cnt > 0 or
	clam.LnJ_attributes.LnJ_released_federal_tax_cnt > 0  or
	clam.LnJ_attributes.LnJ_unreleased_other_tax_cnt > 0 or
	clam.LnJ_attributes.LnJ_released_other_tax_cnt > 0 => '3',

	clam.LnJ_attributes.LnJ_unreleased_foreclosure_cnt > 0 or
	clam.LnJ_attributes.LnJ_released_foreclosure_cnt > 0 => '2',
	
	clam.LnJ_attributes.LnJ_unreleased_other_lj_cnt > 0 or
	clam.LnJ_attributes.LnJ_released_other_lj_cnt > 0 => '1',
 '0');
 
shared lien_lnj_sum := 
	clam.LnJ_attributes.LnJ_unreleased_civil_judgment_cnt +
	clam.LnJ_attributes.LnJ_released_civil_judgment_cnt +
	clam.LnJ_attributes.LnJ_unreleased_federal_tax_cnt +
	clam.LnJ_attributes.LnJ_released_federal_tax_cnt +
	clam.LnJ_attributes.LnJ_unreleased_foreclosure_cnt +
	clam.LnJ_attributes.LnJ_released_foreclosure_cnt +
	clam.LnJ_attributes.LnJ_unreleased_landlord_tenant_cnt +
	clam.LnJ_attributes.LnJ_released_landlord_tenant_cnt +
	clam.LnJ_attributes.LnJ_unreleased_lispendens_cnt +
	clam.LnJ_attributes.LnJ_released_lispendens_cnt +
	clam.LnJ_attributes.LnJ_unreleased_other_lj_cnt +
	clam.LnJ_attributes.LnJ_released_other_lj_cnt +
	clam.LnJ_attributes.LnJ_unreleased_other_tax_cnt+
	clam.LnJ_attributes.LnJ_released_other_tax_cnt +
	clam.LnJ_attributes.LnJ_unreleased_small_claims_cnt +
	clam.LnJ_attributes.LnJ_released_small_claims_cnt; 
	// clam.LnJ_attributes.LnJ_unreleased_Mechanics_cnt + 
	// clam.LnJ_attributes.LnJ_released_Mechanics_cnt;
	
shared	LienJudgmentCount_temp_lnJ	:= clam.LnJ_attributes.lnj_historical_unreleased_count +
														clam.LnJ_attributes.lnj_recent_unreleased_count +
														clam.LnJ_attributes.lnj_historical_released_count +
														clam.LnJ_attributes.lnj_recent_released_count;

export string3 LnJLienJudgmentCount := if(not clam.truedid, '-1', 
capS((string)(if(lien_lnj_sum < LienJudgmentCount_temp_lnJ, 
		lien_LnJ_sum, LienJudgmentCount_temp_lnJ)), capZero, cap255) );
		

shared LienJudgmentCount12Month_LnJ:= clam.LnJ_attributes.LnJ_unreleased_count12 + 
clam.LnJ_attributes.LnJ_released_count12;

export String3 LnJLienJudgmentCount12Month := if(not clam.truedid, '-1', 
capS( (string)(if(lien_lnj_sum < LienJudgmentCount12Month_LnJ, lien_lnj_sum, 
LienJudgmentCount12Month_LnJ)), capZero, cap255) );		

export String3 LnJJudgmentSmallClaimsCount := if(not clam.truedid, '-1', 
capS( (string)(clam.LnJ_attributes.lnj_unreleased_small_claims_cnt + 
clam.LnJ_attributes.lnj_released_small_claims_cnt), capZero, cap255) );

export String3 LnJJudgmentCourtCount := if(not clam.truedid, '-1', 
capS( (string)(clam.LnJ_attributes.lnj_unreleased_civil_judgment_cnt+
 clam.LnJ_attributes.lnj_released_civil_judgment_cnt), capZero, cap255) );
 
export String3 LnJLienTaxCount := if(not clam.truedid, '-1', 
capS( (string)(clam.LnJ_attributes.LnJ_unreleased_federal_tax_cnt +
	clam.LnJ_attributes.LnJ_released_federal_tax_cnt +
	clam.LnJ_attributes.LnJ_unreleased_other_tax_cnt +
	clam.LnJ_attributes.LnJ_released_other_tax_cnt), capZero, cap255) );
	
export String3 LnJJudgmentForeclosureCount := if(not clam.truedid, '-1', 
capS( (string)(clam.LnJ_attributes.lnj_unreleased_foreclosure_cnt + 
clam.LnJ_attributes.lnj_released_foreclosure_cnt), capZero, cap255) );

export String3 LnJLienJudgmentOtherCount := if(not clam.truedid, '-1', 
capS( (string)(clam.LnJ_attributes.LnJ_unreleased_other_lj_cnt + 
clam.LnJ_attributes.LnJ_released_other_lj_cnt), capZero, cap255) );

export	string7	LnJLienJudgmentDollarTotal	:= if(not clam.truedid, '-1', capS((string)
			(clam.LnJ_attributes.LnJ_released_landlord_tenant_amt +
			clam.LnJ_attributes.LnJ_released_small_claims_amt +
			clam.LnJ_attributes.LnJ_released_civil_judgment_amt +
			clam.LnJ_attributes.LnJ_released_federal_tax_amt +
			clam.LnJ_attributes.LnJ_released_other_tax_amt +
			clam.LnJ_attributes.LnJ_released_foreclosure_amt +
			clam.LnJ_attributes.LnJ_released_other_lj_amt +
			// clam.LnJ_attributes.lnJ_released_Mechanics_amt +
			
			clam.LnJ_attributes.LnJ_unreleased_landlord_tenant_amt +
			clam.LnJ_attributes.LnJ_unreleased_small_claims_amt +
			clam.LnJ_attributes.LnJ_unreleased_civil_judgment_amt +
			clam.LnJ_attributes.LnJ_unreleased_federal_tax_amt +
			clam.LnJ_attributes.LnJ_unreleased_other_tax_amt +
			clam.LnJ_attributes.LnJ_unreleased_foreclosure_amt +
			clam.LnJ_attributes.LnJ_unreleased_other_lj_amt
			// clam.LnJ_attributes.lnJ_unreleased_Mechanics_amt 
			), capZero, cap7Byte) );

	shared last_eviction_date_lnj := if(clam.LnJ_attributes.lnj_last_eviction_date>ageDate, 0, clam.LnJ_attributes.lnj_last_eviction_date);

export	string3	LnJEvictionTimeNewest	:= if(not clam.truedid or last_eviction_date_lnj=0, '-1', 
		capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_eviction_date_lnj, 
		(string)sysdate, true), capOfOne, if(isFCRA, cap84, cap960)) );
		
	shared last_lien_unreleased_date_lnj := if((unsigned)clam.LnJ_attributes.LnJ_last_unreleased_date>ageDate, 0,
							(unsigned)clam.LnJ_attributes.LnJ_last_unreleased_date);	
  shared last_lien_released_date_jnl := if(clam.LnJ_attributes.LnJ_last_released_date>ageDate, 0, 
							clam.LnJ_attributes.LnJ_last_released_date);

	shared last_lien_date_v5_lnj := max(last_lien_released_date_jnl, last_lien_unreleased_date_lnj);
export	string3	LnJLienJudgmentTimeNewest := if(not clam.truedid or last_lien_date_v5_lnj=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_lien_date_v5_lnj,
	(string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );

//new for Liens and Judgments	
export string3 LnJLienCount   :=  if(not clam.truedid, '-1', 
	capS( (string)(clam.LnJ_attributes.lnj_lien_cnt), capZero, cap255) );

	shared last_lien_released_date_lj := if(clam.LnJ_attributes.lnj_last_lien_released_date>ageDate, 0, clam.LnJ_attributes.lnj_last_lien_released_date);
	shared last_lien_unreleased_date_lj := if((unsigned)clam.LnJ_attributes.lnj_last_lien_unreleased_date>ageDate, 0, (unsigned)clam.LnJ_attributes.lnj_last_lien_unreleased_date);	
	shared last_lien_date_lj := max(last_lien_released_date_lj, last_lien_unreleased_date_lj);

export	string3	LnJLienTimeNewest := if(not clam.truedid or last_lien_date_lj=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_lien_date_lj, 
	(string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );

export string7 LnJLienDollarTotal            := if(not clam.truedid, '-1', capS((string)
			(clam.LnJ_attributes.lnj_lien_total
			), capZero, cap7Byte) );

	shared last_lien_Tax_released_date := if(clam.LnJ_attributes.lnj_last_allTax_released_date>ageDate, 0, clam.LnJ_attributes.lnj_last_allTax_released_date);
	shared last_lien_Tax_unreleased_date := if((unsigned)clam.LnJ_attributes.lnj_last_allTax_unreleased_date>ageDate, 0, (unsigned)clam.LnJ_attributes.lnj_last_allTax_unreleased_date);	
	shared last_lien_Tax_date_lj := max(last_lien_Tax_released_date, last_lien_Tax_unreleased_date);

export	string3	LnJLienTaxTimeNewest := if(not clam.truedid or last_lien_Tax_date_lj=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_lien_Tax_date_lj, 
	(string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );

export string7 LnJLienTaxDollarTotal         := if(not clam.truedid, '-1', capS((string)
		(clam.LnJ_attributes.lnj_liens_unreleased_all_tax_amt +
		 clam.LnJ_attributes.lnj_liens_released_all_tax_amt),
		capZero, cap7Byte) );
export string3 LnJLienTaxStateCount          := if(not clam.truedid, '-1', capS((string)
		(clam.LnJ_attributes.lnj_liens_unreleased_state_tax_cnt +
		 clam.LnJ_attributes.lnj_liens_released_state_tax_cnt),
		capZero, cap255) );

	shared last_lien_State_released_date := if(clam.LnJ_attributes.lnj_last_state_released_date>ageDate, 0, clam.LnJ_attributes.lnj_last_state_released_date);
	shared last_lien_State_unreleased_date := if((unsigned)clam.LnJ_attributes.lnj_last_state_unreleased_date>ageDate, 0, (unsigned)clam.LnJ_attributes.lnj_last_state_unreleased_date);	
	shared last_lien_State_date_lj := max(last_lien_State_released_date, last_lien_State_unreleased_date);

export	string3	LnJLienTaxStateTimeNewest := if(not clam.truedid or last_lien_State_date_lj=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_lien_State_date_lj, 
	(string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );

export string7 LnJLienTaxStateDollarTotal    := if(not clam.truedid, '-1', capS((string)
		(clam.LnJ_attributes.lnj_liens_unreleased_state_tax_amt +
		 clam.LnJ_attributes.lnj_liens_released_state_tax_amt),
		capZero, cap7Byte) );
export string3 LnJLienTaxFederalCount        := if(not clam.truedid, '-1', capS((string)
		(clam.LnJ_attributes.lnj_liens_unreleased_federal_tax_cnt +
		 clam.LnJ_attributes.lnj_liens_released_federal_tax_cnt),
		capZero, cap255) );

	shared last_lien_Federal_released_date := if(clam.LnJ_attributes.lnj_last_federal_released_date>ageDate, 0, clam.LnJ_attributes.lnj_last_federal_released_date);
	shared last_lien_Federal_unreleased_date := if((unsigned)clam.LnJ_attributes.lnj_last_federal_unreleased_date>ageDate, 0, (unsigned)clam.LnJ_attributes.lnj_last_federal_unreleased_date);	
	shared last_lien_Federal_date_lj := max(last_lien_Federal_released_date, last_lien_Federal_unreleased_date);

export	string3	LnJLienTaxFederalTimeNewest := if(not clam.truedid or last_lien_Federal_date_lj=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_lien_Federal_date_lj, 
	(string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );

export string7 LnJLienTaxFederalDollarTotal  := if(not clam.truedid, '-1', capS((string)
		(clam.LnJ_attributes.lnj_liens_unreleased_federal_tax_amt +
		 clam.LnJ_attributes.lnj_liens_released_federal_tax_amt),
		capZero, cap7Byte) );
export string3 LnJJudgmentCount               :=  if(not clam.truedid, '-1', 
	capS( (string)(clam.LnJ_attributes.lnj_jgmt_cnt), capZero, cap255) );

	shared last_jmgt_released_date := if(clam.LnJ_attributes.lnj_last_jgmt_released_date>ageDate, 0, clam.LnJ_attributes.lnj_last_jgmt_released_date);
	shared last_jgmt_unreleased_date := if((unsigned)clam.LnJ_attributes.lnj_last_jgmt_unreleased_date>ageDate, 0, (unsigned)clam.LnJ_attributes.lnj_last_jgmt_unreleased_date);	
	shared last_lien_date_jgmt := max(last_jmgt_released_date, last_jgmt_unreleased_date);

export	string3	LnJJudgmentTimeNewest := if(not clam.truedid or last_lien_date_jgmt=0, '-1', 
	capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_lien_date_jgmt, 
	(string)sysdate, true), capOfOne, if(isFCRA,cap84,cap960)) );

export string7	LnJJudgmentDollarTotal	:= if(not clam.truedid, '-1', capS((string)
			(clam.LnJ_attributes.lnj_jgmt_total
			), capZero, cap7Byte) );
END;