import Models, Risk_Indicators, ut, riskview, Std;

export getRVAttributes(grouped DATASET(risk_indicators.Layout_Boca_Shell) clam, string30 account_value, boolean isPreScreen = false, boolean opt_out_hit = false, 
	string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction, UNSIGNED8 BSOptions = 0) := FUNCTION

//=================================================
//=== is the transaction coming from Experian?  ===	
//=================================================
ExperianTransaction := DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]='0';	

Models.Layout_RVAttributes.Layout_rvAttrSeqWithAddrAppend intoAttributes(clam le) := TRANSFORM
	self.seq := le.seq;
	self.AccountNumber:= account_value;
	
	DoAddressAppend := Risk_Indicators.iid_constants.CheckBSOptionFlag(Risk_Indicators.iid_constants.BSOptions.IncludeAddressAppend, BSOptions);
	
	attr := Models.Attributes_Master(le,true);
		
	fulldate := (unsigned4)risk_indicators.iid_constants.myGetDate(le.historydate);	// full history date

	getPreviousMonth(unsigned histdate) := FUNCTION
			rollBack := trim(((string)histdate)[5..6])='01';
			histYear := if(rollBack, (unsigned)((trim((string)histdate)[1..4]))-1, (unsigned)(trim((string)histdate)[1..4]));
			histMonth := if(rollBack, 12, (unsigned)((trim((string)histdate)[5..6]))-1);
			return (unsigned)(intformat(histYear,4,1) + intformat(histMonth,2,1));
	END;

	checkDate6(unsigned3 foundDate) := FUNCTION
			outDate := if(foundDate >= le.historyDate, getPreviousMonth(le.historyDate), foundDate);
			return outDate;
	END;
	
	// this function is for correcting months of 00 in header dates.  
// header dates are unsigned3 values, even though layout_address_informationv3 allows unsigned4, the values are still YYYYMM 										
 unsigned3 fixYYYY00( unsigned YYYYMM ) := if( YYYYMM > 0 and YYYYMM % 100 = 0, YYYYMM + 1, YYYYMM );
	
	// Places a lower bounds at 0.
	capLowerZero(INTEGER input) := FUNCTION
		RETURN(IF(input < 0, 0, input));
	END;
	capAtOne:= 1;
	capZero := 0;
	cap255 := 255;
	cap9999 := 9999;
	capMax := 9999999999;
	capMax2:= 99999999999;
	capMax3:=	999999999999;
	
	capU(UNSIGNED input, UNSIGNED lower, UNSIGNED upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;
	capI(INTEGER input, INTEGER lower, INTEGER upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;
	capR(REAL input, REAL lower, REAL upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;
	
	// to account for the loss of TS source from fcra, double count EQ if the consumer was on file with EQ for more than 9 years
	onFileEQ9years := if((unsigned)le.source_verification.adl_eqfs_first_seen=0, false,
	if(risk_indicators.iid_constants.checkdays((string)fulldate,le.source_verification.adl_eqfs_first_seen+'01',
																																								risk_indicators.iid_constants.nineyears, le.historydate), false, true));
																																								
	add1U(UNSIGNED field) := FUNCTION
		RETURN(IF(onFileEQ9years, field+1, field));
	END;	

	
	
	// VERSION 1 ---------------------------------------------------------------------------------------------
	// LifeStyle
	self.lifestyle.dwelltype := if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type);
	self.lifestyle.assessed_amount := le.address_verification.input_address_information.assessed_amount;
	self.lifestyle.applicant_owned := le.address_verification.input_address_information.applicant_owned;
	self.lifestyle.family_owned := le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned;
	self.lifestyle.occupant_owned := le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																	 ~le.address_verification.input_address_information.family_owned;
	self.lifestyle.isbestmatch := ~le.address_verification.input_address_information.isbestmatch;
	self.lifestyle.date_first_seen := le.address_verification.input_address_information.date_first_seen;
	self.lifestyle.date_first_seen2 := le.address_verification.address_history_1.date_first_seen;
	self.lifestyle.date_first_seen3 := le.address_verification.address_history_2.date_first_seen;
	
	crim_flag := le.bjl.criminal_count > 0;
	liens_historical_unrel_flag := le.bjl.liens_historical_unreleased_count > 0;// should this be recent as well?
	num_derog_sources := (integer)crim_flag + (integer)le.bjl.bankrupt + (integer)liens_historical_unrel_flag;
	max_source_count1 := Max(le.name_verification.source_count, le.address_verification.input_address_information.source_count);
	max_source_count := Max(max_source_count1, le.ssn_verification.header_count);
	num_nonderogs := Max(max_source_count-num_derog_sources, 0);
	self.lifestyle.number_nonderogs :=(string)add1U(num_nonderogs);
	
	last_seen := Max(le.ssn_verification.header_last_seen, le.ssn_verification.credit_last_seen);
	self.lifestyle.date_last_seen := checkDate6(last_seen);
	sysdate := if(le.historydate <> 999999, (integer)(((string)le.historydate)[1..6]), (integer)(((string)Std.Date.Today())[1..6]));
	self.lifestyle.recent_update := (sysdate - last_seen) < 100;
	//self.lifestyle.license_type := '';//le.professional_license.license_type;

	// Demographic
	/* The following accounts for randomized socials - This code is located within Risk_Indicators.iid_getSSNFlags:
				ssnLowIssue - If possibly randomized, set low issue to the first date of randomization - June 25th, 2011
				ssnHighIssue - If possibly randomized, set to the current date (Or archive date if running in archive mode)
	*/
	randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.shell_input.ssn, le.iid.socsvalflag, le.iid.socllowissue, le.iid.socsRCISflag);
	ssnLowIssue := le.iid.socllowissue;
	ssnHighIssue := le.iid.soclhighissue;	
	//self.dems.age := '';// not going to do
	self.dems.ssn_issued := le.ssn_verification.validation.issued;
	self.dems.low_issue_date := if((unsigned)ssnLowIssue>fullDate, 0, (unsigned)ssnLowIssue);
	self.dems.high_issue_date := if((unsigned)ssnHighIssue>fullDate, 0, (unsigned)ssnHighIssue);
	self.dems.nonUS_ssn := le.iid.non_us_ssn OR 
												 (le.shell_input.ssn[1]='9' and le.shell_input.ssn[4] in ['7','8']);// ITIN logic;
	self.dems.ssn_issue_state := le.ssn_verification.validation.issue_state;
	self.dems.ssn_first_seen := ut.Min2(le.ssn_verification.header_first_seen, le.ssn_verification.credit_first_seen);

	// Financial
	self.finance.phone_full_name_match := le.iid.nap_summary in [9,12];
	self.finance.phone_last_name_match := le.iid.nap_summary in [7,9,11,12]/* or le.iid.phonelastcount>0*/;
	self.finance.nap_status := map(le.iid.hriskphoneflag = '5' => 'D',
																 le.iid.phonevalflag in ['1','2'] => 'C',
																 '');
	//self.finance.credit_first_seen := le.ssn_verification.credit_first_seen;		

	// Property
	self.property.property_owned_total := le.address_verification.owned.property_total;
	self.property.property_owned_assessed_total := le.address_verification.owned.property_owned_assessed_total;
	self.property.property_historically_owned := le.address_verification.owned.property_total + le.address_verification.sold.property_total + le.address_verification.ambiguous.property_total;
	//self.property.date_most_recent_purchase := 0;/*ut.max2(ut.max2(le.address_verification.input_address_information.purchase_date,
																									//le.address_verification.address_history_1.purchase_date),
																									//le.address_verification.address_history_2.purchase_date);*/
	//self.property.date_first_purchase := 0;//le.other_address_info.date_first_purchase;

	// Derogatory
	self.derogs.criminal_count := le.bjl.felony_count;
	self.derogs.filing_count := le.bjl.filing_count;
	self.derogs.date_last_seen := if(le.bjl.date_last_seen>fulldate, 0, le.bjl.date_last_seen);
	self.derogs.disposition := le.bjl.disposition;
	self.derogs.liens_historical_unreleased_count := le.bjl.liens_historical_unreleased_count;
	self.derogs.liens_recent_unreleased_count := le.bjl.liens_recent_unreleased_count;
	//self.derogs.judgements_count := 0;// todo
	//self.derogs.evictions_count := 0;// todo
	//self.derogs.foreclosure_count := 0;// todo, I don't think this is FCRAable because of the FARES contract
	self.derogs.total_number_derogs := le.bjl.felony_count + le.bjl.filing_count + le.bjl.liens_historical_unreleased_count;// should this include recent unreleased?
	//self.derogs.date_last_derog := 0;//ut.max2(ut.max2(le.bjl.last_criminal_date, (integer)le.bjl.last_liens_unreleased_date),le.bjl.date_last_seen);
	
	
	
	// VERSION 2 fields---------------------------------------------------------------------------------------------------------

	// Identity Authentication Attributes
	self.version2.SSNFirstSeen := ut.Min2(le.ssn_verification.header_first_seen, le.ssn_verification.credit_first_seen);
	self.version2.DateLastSeen := self.lifestyle.date_last_seen;
	self.version2.isRecentUpdate := self.lifestyle.recent_update;
	// I moved numSources down below the calculation for current address
	self.version2.isPhoneFullNameMatch := self.finance.phone_full_name_match;
	self.version2.isPhoneLastNameMatch := self.finance.phone_last_name_match;
	self.version2.isSSNInvalid := ~le.SSN_Verification.Validation.valid; 
	self.version2.isPhoneInvalid := le.iid.phonetype <> '1' and le.shell_input.phone10 <> '';
	self.version2.isAddrInvalid := le.iid.addrvalflag='N' and ((le.shell_input.in_StreetAddress<>'' and le.shell_input.in_City<>'' and 
																 le.shell_input.in_State<>'') or (le.shell_input.in_StreetAddress<>'' and le.shell_input.in_Zipcode<>''));
	self.version2.isDLInvalid := le.iid.drlcvalflag in ['1','3'];
	self.version2.isNoVer := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

	
	
	// SSN Attributes
	self.version2.isDeceased := le.iid.decsflag='1';
	self.version2.DeceasedDate := if(le.ssn_verification.Validation.deceasedDate>fullDate, 0, le.ssn_verification.Validation.deceasedDate);//le.ssn_verification.Validation.deceasedDate;
	self.version2.isSSNValid := le.SSN_Verification.Validation.valid;
	self.version2.isRecentIssue := (sysdate - (INTEGER)(le.iid.soclhighissue[1..6])) < 100 AND sysdate <= Risk_Indicators.iid_constants.randomSSN1Year;
	self.version2.LowIssueDate := if((unsigned)ssnLowIssue>fullDate, 0, (unsigned)ssnLowIssue);
	self.version2.HighIssueDate := if((unsigned)ssnHighIssue>fullDate, 0, (unsigned)ssnHighIssue);
	self.version2.IssueState := le.iid.soclstate;
	self.version2.isNonUS := le.iid.non_us_ssn OR 
												 (le.shell_input.ssn[1]='9' and le.shell_input.ssn[4] in ['7','8']);// ITIN logic;
	self.version2.isIssued3 := // If it is not a randomized social and only issued within the last 36 months
																(~randomizedSocial AND (sysdate - (INTEGER)(le.iid.socllowissue[1..6])) < 300) OR 
																// Or it was possibly randomized and the date is prior to June 25th, 2014
																(randomizedSocial AND sysdate <= Risk_Indicators.iid_constants.randomSSN3Years);
	self.version2.isIssuedAge5 := ((INTEGER)(le.iid.socllowissue[1..6]) - (INTEGER)(le.shell_input.Dob[1..6])) > 500 AND (INTEGER)(le.shell_input.Dob[1..4]) > 1990 AND (INTEGER)(le.shell_input.Dob[1..6]) < 200606;
	
	// Characteristics of Input Address
	self.version2.IADateFirstReported := le.address_verification.input_address_information.date_first_seen;
	self.version2.IADateLastReported := checkDate6(le.address_verification.input_address_information.date_last_seen);
	self.version2.IALenOfRes := capU(if(self.version2.IADateFirstReported <> 0 and
																 self.version2.IADateLastReported <> 0,
																		capLowerZero(round((ut.DaysApart((string)self.version2.IADateFirstReported, 
																												(string)self.version2.IADateLastReported)) / 30)), 
																 0), capZero, cap255);
	self.version2.IADwellType := if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type);
	self.version2.IALandUseCode := le.avm.input_address_information.avm_land_use_code;
	self.version2.IAAssessedValue := capU(le.address_verification.input_address_information.assessed_amount, capZero, capMax);
	self.version2.IAisOwnedBySubject := le.address_verification.input_address_information.applicant_owned;
	self.version2.IAisFamilyOwned := le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned;
	self.version2.IAisOccupantOwned := le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																		 ~le.address_verification.input_address_information.family_owned;
	self.version2.IALastSaleDate := if(le.address_verification.input_address_information.purchase_date>fullDate, 0, le.address_verification.input_address_information.purchase_date);
	self.version2.IALastSaleAmount := capU(if(le.address_verification.input_address_information.purchase_date>fullDate, 0, le.address_verification.input_address_information.purchase_amount), capZero, capMax);
	self.version2.IAisNotPrimaryRes := ~le.address_verification.input_address_information.isbestmatch;
	self.version2.IAPhoneListed := capU(le.Address_Verification.edaMatchLevel, capZero, 4);
	self.version2.IAPhoneNumber := le.Address_Verification.activePhone;
	
	// Characteristics of Current Address (Most Recent Date First Reported)
	
	// current address pick for matching isbestmatch, assuming 1 of the 3 addresses are best
	CAaddrChooser := map(le.address_verification.input_address_information.isbestmatch  => 1, // input is current
											 le.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
											 le.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
											 4);	// don't know what the current address is
	
											 
	currAddr := map(CAaddrChooser=1 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range, 
																																 le.address_verification.input_address_information.predir, 
																																 le.address_verification.input_address_information.prim_name,
																																 le.address_verification.input_address_information.addr_suffix, 
																																 le.address_verification.input_address_information.postdir, 
																																 le.address_verification.input_address_information.unit_desig, 
																																 le.address_verification.input_address_information.sec_range),
									CAaddrChooser=2 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range, 
																																 le.address_verification.address_history_1.predir, 
																																 le.address_verification.address_history_1.prim_name,
																																 le.address_verification.address_history_1.addr_suffix, 
																																 le.address_verification.address_history_1.postdir, 
																																 le.address_verification.address_history_1.unit_desig, 
																																 le.address_verification.address_history_1.sec_range),
									CAaddrChooser=3 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_2.prim_range, 
																																 le.address_verification.address_history_2.predir, 
																																 le.address_verification.address_history_2.prim_name,
																																 le.address_verification.address_history_2.addr_suffix, 
																																 le.address_verification.address_history_2.postdir, 
																																 le.address_verification.address_history_2.unit_desig, 
																																 le.address_verification.address_history_2.sec_range),
									'');
	currAddrSt := map(CAaddrChooser=1 => le.address_verification.input_address_information.st,
										CAaddrChooser=2 => le.address_verification.address_history_1.st,
										CAaddrChooser=3 => le.address_verification.address_history_2.st,
										'');
										
	// fits in above
	self.version2.NumSources := capU(map(CAaddrChooser=1 => add1U(le.address_verification.input_address_information.source_count),
																	CAaddrChooser=2 => add1U(le.address_verification.address_history_1.source_count),
																	CAaddrChooser=3 =>add1U( le.address_verification.address_history_2.source_count),
																	0), capZero, cap255);
	
	self.version2.CADateFirstReported := map(CAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
																					 CAaddrChooser=2 =>	le.address_verification.address_history_1.date_first_seen,
																					 CAaddrChooser=3 => le.address_verification.address_history_2.date_first_seen,
																					 0);
	self.version2.CADateLastReported := checkDate6( 
																					map(CAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
																							CAaddrChooser=2 => le.address_verification.address_history_1.date_last_seen,
																							CAaddrChooser=3 => le.address_verification.address_history_2.date_last_seen,
																							0));
	self.version2.CALenOfRes := capU(if(self.version2.CADateFirstReported <> 0 and self.version2.CADateLastReported <> 0,
																		capLowerZero(round((ut.DaysApart((string)self.version2.CADateFirstReported, 
																												(string)self.version2.CADateLastReported)) / 30)), 
																		0), capZero, cap255);
	self.version2.CADwellType := map(CAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
																	 CAaddrChooser=2 => le.address_verification.addr_type2,
																	 CAaddrChooser=3 => le.address_verification.addr_type3,
																	 '');
	self.version2.CALandUseCode := map(CAaddrChooser=1 => le.avm.input_address_information.avm_land_use_code,
																		 CAaddrChooser=2 => le.avm.address_history_1.avm_land_use_code,
																		 CAaddrChooser=3 => le.avm.address_history_2.avm_land_use_code,
																		 '');
	self.version2.CAAssessedValue := capU(map(CAaddrChooser=1 => le.address_verification.input_address_information.assessed_amount,
																			 CAaddrChooser=2 => le.address_verification.address_history_1.assessed_amount,
																			 CAaddrChooser=3 => le.address_verification.address_history_2.assessed_amount,
																			 0), capZero, capMax);
	self.version2.CAisOwnedBySubject := map(CAaddrChooser=1 => le.address_verification.input_address_information.applicant_owned,
																					CAaddrChooser=2 => le.address_verification.address_history_1.applicant_owned,
																					CAaddrChooser=3 => le.address_verification.address_history_2.applicant_owned,
																					false);
	self.version2.CAisFamilyOwned := map(CAaddrChooser=1 => le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned,
																			 CAaddrChooser=2 => le.address_verification.address_history_1.family_owned and ~le.address_verification.address_history_1.applicant_owned,
																			 CAaddrChooser=3 => le.address_verification.address_history_2.family_owned and ~le.address_verification.address_history_2.applicant_owned,
																			 false);
	self.version2.CAisOccupantOwned := map(CAaddrChooser=1 => le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																														~le.address_verification.input_address_information.family_owned,
																				 CAaddrChooser=2 => le.address_verification.address_history_1.occupant_owned and ~le.address_verification.address_history_1.applicant_owned and
																														~le.address_verification.address_history_1.family_owned,
																				 CAaddrChooser=3 => le.address_verification.address_history_2.occupant_owned and ~le.address_verification.address_history_2.applicant_owned and
																														~le.address_verification.address_history_2.family_owned,
																				 false);
	CALastSaleDate := map(CAaddrChooser=1 => le.address_verification.input_address_information.purchase_date,
												CAaddrChooser=2 => le.address_verification.address_history_1.purchase_date,
												CAaddrChooser=3 => le.address_verification.address_history_2.purchase_date,
												0);//just guessing here
	self.version2.CALastSaleDate := if(CALastSaleDate>fullDate, 0, CALastSaleDate);
	self.version2.CALastSaleAmount := capU(if(CALastSaleDate>fullDate, 0, 
																				map(CAaddrChooser=1 => le.address_verification.input_address_information.purchase_amount,
																						CAaddrChooser=2 => le.address_verification.address_history_1.purchase_amount,
																						CAaddrChooser=3 => le.address_verification.address_history_2.purchase_amount,
																						0)), capZero, capMax);//just guessing here
	self.version2.CAisNotPrimaryRes := map(CAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
																				 CAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
																				 CAaddrChooser=3 => ~le.address_verification.address_history_2.isbestmatch,
																				 true);
	self.version2.CAPhoneListed := capU(map(CAaddrChooser=1 => le.address_verification.edaMatchLevel,
																		 CAaddrChooser=2 => le.address_verification.edaMatchLevel2,
																		 CAaddrChooser=3 => le.address_verification.edaMatchLevel3,
																		 0), capZero, 4);
	self.version2.CAPhoneNumber := map(CAaddrChooser=1 => le.address_verification.activePhone,
																		 CAaddrChooser=2 => le.address_verification.activePhone2,
																		 CAaddrChooser=3 => le.address_verification.activePhone3,
																		 0);
	
	// Characteristics of Previous Address (next most recently reported)
	
	// Previous address picker assumes that either the input or Address history 1 is current
	PAaddrChooser_temp := map(CAaddrChooser=1 => 2, // if input is current, then pick history 1 as previous
											 CAaddrChooser=2 and le.address_verification.input_address_information.date_last_seen > le.address_verification.address_history_2.date_last_seen => 1,	// if hist 1 is current and input date last seen > hist 2 date last seen then input is previous
											 CAaddrChooser=2 and le.address_verification.input_address_information.date_last_seen = le.address_verification.address_history_2.date_last_seen and
													le.address_verification.input_address_information.date_first_seen >= le.address_verification.address_history_2.date_first_seen => 1,	// if hist 1 is current and input date last seen = hist 2 date last seen and input date first seen >= hist 2 date first seen then input is previous
											 CAaddrChooser=3 and le.address_verification.input_address_information.date_last_seen > le.address_verification.address_history_1.date_last_seen => 1, // if hist 2 is current and input date last seen > hist 1 date last seen then input is previous
											 CAaddrChooser=3 and le.address_verification.input_address_information.date_last_seen = le.address_verification.address_history_1.date_last_seen and
													le.address_verification.input_address_information.date_first_seen >= le.address_verification.address_history_1.date_first_seen => 1,	// if hist 2 is current and input date last seen = hist 1 date last seen and input date first seen >= hist 1 date first seen then input is previous
											 CAaddrChooser=2 => 3,	// if none of the above and hist 1 is current, then hist 2 is previous
											 CAaddrChooser=4 => 4,	// no Current address chosen
											 2);	// if none of the above and hist 2 is current, then hist 1 is previous
	
	// override the previous address chooser to 4 if the address selected as previous doesn't actually exist
	PAaddrChooser := if( (PAaddrChooser_temp=1 and le.address_verification.input_address_information.prim_name='') or
											 (PAaddrChooser_temp=2 and le.address_verification.address_history_1.prim_name='') or
											 (PAaddrChooser_temp=3 and le.address_verification.address_history_2.prim_name=''), 
											 4,
											 PAaddrChooser_temp);
											 
	
											 
	prevAddr := map(PAaddrChooser=1 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range, 
																																 le.address_verification.input_address_information.predir, 
																																 le.address_verification.input_address_information.prim_name,
																																 le.address_verification.input_address_information.addr_suffix, 
																																 le.address_verification.input_address_information.postdir, 
																																 le.address_verification.input_address_information.unit_desig, 
																																 le.address_verification.input_address_information.sec_range),
									PAaddrChooser=2 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range, 
																																 le.address_verification.address_history_1.predir, 
																																 le.address_verification.address_history_1.prim_name,
																																 le.address_verification.address_history_1.addr_suffix, 
																																 le.address_verification.address_history_1.postdir, 
																																 le.address_verification.address_history_1.unit_desig, 
																																 le.address_verification.address_history_1.sec_range),
									PAaddrChooser=3 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_2.prim_range, 
																																 le.address_verification.address_history_2.predir, 
																																 le.address_verification.address_history_2.prim_name,
																																 le.address_verification.address_history_2.addr_suffix, 
																																 le.address_verification.address_history_2.postdir, 
																																 le.address_verification.address_history_2.unit_desig, 
																																 le.address_verification.address_history_2.sec_range),
									'');
	prevAddrSt := map(PAaddrChooser=1 => le.address_verification.input_address_information.st,
										PAaddrChooser=2 => le.address_verification.address_history_1.st,
										PAaddrChooser=3 => le.address_verification.address_history_2.st,
										'');
											 
	self.version2.PADateFirstReported := map(PAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
																					 PAaddrChooser=2 =>	le.address_verification.address_history_1.date_first_seen,
																					 PAaddrChooser=3 => le.address_verification.address_history_2.date_first_seen,
																					 0);
	self.version2.PADateLastReported := checkDate6( 
																					map(PAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
																							PAaddrChooser=2 => le.address_verification.address_history_1.date_last_seen,
																							PAaddrChooser=3 => le.address_verification.address_history_2.date_last_seen,
																							0));
	self.version2.PALenOfRes := capU(if(self.version2.PADateFirstReported <> 0 and self.version2.PADateLastReported <> 0,
																		capLowerZero(round((ut.DaysApart((string)self.version2.PADateFirstReported, 
																												(string)self.version2.PADateLastReported)) / 30)), 
																 0), capZero, cap255);
	self.version2.PADwellType := map(PAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
																	 PAaddrChooser=2 => le.address_verification.addr_type2,
																	 PAaddrChooser=3 => le.address_verification.addr_type3,
																	 '');
	self.version2.PALandUseCode := map(PAaddrChooser=1 => le.avm.input_address_information.avm_land_use_code,
																		 PAaddrChooser=2 => le.avm.address_history_1.avm_land_use_code,
																		 PAaddrChooser=3 => le.avm.address_history_2.avm_land_use_code,
																		 '');
	self.version2.PAAssessedValue := capU(map(PAaddrChooser=1 => le.address_verification.input_address_information.assessed_amount,
																			 PAaddrChooser=2 => le.address_verification.address_history_1.assessed_amount,
																			 PAaddrChooser=3 => le.address_verification.address_history_2.assessed_amount,
																			 0), capZero, capMax2);
	self.version2.PAisOwnedBySubject := map(PAaddrChooser=1 => le.address_verification.input_address_information.applicant_owned,
																					PAaddrChooser=2 => le.address_verification.address_history_1.applicant_owned,
																					PAaddrChooser=3 => le.address_verification.address_history_2.applicant_owned,
																					0);
	self.version2.PAisFamilyOwned := map(PAaddrChooser=1 => le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned,
																			 PAaddrChooser=2 => le.address_verification.address_history_1.family_owned and ~le.address_verification.address_history_1.applicant_owned,
																			 PAaddrChooser=3 => le.address_verification.address_history_2.family_owned and ~le.address_verification.address_history_2.applicant_owned,
																			 false);
	self.version2.PAisOccupantOwned := map(PAaddrChooser=1 => le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																													~le.address_verification.input_address_information.family_owned,
																				 PAaddrChooser=2 => le.address_verification.address_history_1.occupant_owned and ~le.address_verification.address_history_1.applicant_owned and
																													~le.address_verification.address_history_1.family_owned,
																				 PAaddrChooser=3 => le.address_verification.address_history_2.occupant_owned and ~le.address_verification.address_history_2.applicant_owned and
																														~le.address_verification.address_history_2.family_owned,
																				 false);
	PALastSaleDate := map(PAaddrChooser=1 => le.address_verification.input_address_information.purchase_date,
												PAaddrChooser=2 => le.address_verification.address_history_1.purchase_date,
												PAaddrChooser=3 => le.address_verification.address_history_2.purchase_date,
												0);//just guessing here
	self.version2.PALastSaleDate := if(PALastSaleDate>fullDate, 0, PALastSaleDate);
	self.version2.PALastSaleAmount := capU(if(PALastSaleDate>fullDate, 0, 
																				map(PAaddrChooser=1 => le.address_verification.input_address_information.purchase_amount,
																						PAaddrChooser=2 => le.address_verification.address_history_1.purchase_amount,
																						PAaddrChooser=3 => le.address_verification.address_history_2.purchase_amount,
																						0)), capZero, capMax);//just guessing here
	self.version2.PAisNotPrimaryRes := map(PAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
																				 PAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
																				 PAaddrChooser=3 => ~le.address_verification.address_history_2.isbestmatch,
																				 true);
	self.version2.PAPhoneListed := capU(map(PAaddrChooser=1 => le.address_verification.edaMatchLevel,
																		 PAaddrChooser=2 => le.address_verification.edaMatchLevel2,
																		 PAaddrChooser=3 => le.address_verification.edaMatchLevel3,
																		 0), capZero, 4);
	self.version2.PAPhoneNumber := map(PAaddrChooser=1 => le.address_verification.activePhone,
																		 PAaddrChooser=2 => le.address_verification.activePhone2,
																		 PAaddrChooser=3 => le.address_verification.activePhone3,
																		 0);
	
	// Differences between Input Address and Current Address
	self.version2.isInputCurrMatch := CAaddrChooser=1;
	self.version2.DistInputCurr := capU(map(CAaddrChooser=1 => 0,// same address as input
																		 CAaddrChooser=2 => le.address_verification.distance_in_2_h1,// compare input to history 1
																		 CAaddrChooser=3 => le.address_verification.distance_in_2_h2,// compare input to history 2
																		 9999), capZero, cap9999);	// no distance calculated
	self.version2.isDiffState := ~(currAddrSt = (StringLib.StringToUpperCase(le.shell_input.in_state)));
	self.version2.AssessedDiff := if(~CAaddrChooser=1, map(CAaddrChooser=2 => le.address_verification.address_history_1.assessed_amount - 
																																						le.address_verification.input_address_information.assessed_amount,
																												 CAaddrChooser=3 => le.address_verification.address_history_2.assessed_amount - 
																																						le.address_verification.input_address_information.assessed_amount,
																												 0), 
																		0);
	
	
	inputEcon := EconCode(le.iid.dwelltype, le.address_verification.input_address_information.assessed_amount, 
												le.avm.input_address_information, (unsigned)le.address_verification.input_address_information.census_home_value);
	hist1Econ := EconCode(le.address_verification.addr_type2, le.address_verification.address_history_1.assessed_amount, 
												le.avm.address_history_1, (unsigned)le.address_verification.address_history_1.census_home_value);											
	hist2Econ := EconCode(le.address_verification.addr_type3, le.address_verification.address_history_2.assessed_amount, 
												le.avm.address_history_2, (unsigned)le.address_verification.address_history_2.census_home_value);
																							
	CAeconCode := map(CAaddrChooser=1 => inputEcon,
										CAaddrChooser=2 => hist1Econ,
										CAaddrChooser=3 => hist2Econ,
										'U');
	PAeconCode := map(PAaddrChooser=1 => inputEcon,
										PAaddrChooser=2 => hist1Econ,
										PAaddrChooser=3 => hist2Econ,
										'U');

	self.version2.EcoTrajectory := CAeconCode+inputEcon;
	
	// Differences between Current Address and Previous Address
	self.version2.isInputPrevMatch := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range, 
																																le.address_verification.input_address_information.predir, 
																																le.address_verification.input_address_information.prim_name,
																																le.address_verification.input_address_information.addr_suffix, 
																																le.address_verification.input_address_information.postdir, 
																																le.address_verification.input_address_information.unit_desig, 
																																le.address_verification.input_address_information.sec_range) =
																																prevAddr and prevAddr <> '';
	self.version2.DistCurrPrev := capU(map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => le.address_verification.distance_in_2_h1,
																		CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => le.address_verification.distance_in_2_h2,
																		CAaddrChooser=2 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=2 => le.address_verification.distance_h1_2_h2,
																		9999), capZero, cap9999);
	self.version2.isDiffState2 := if(~self.version2.isInputPrevMatch, ~(prevAddrSt = currAddrSt), false);
	self.version2.AssessedDiff2 := if(~self.version2.isInputPrevMatch, self.version2.CAAssessedValue - self.version2.PAAssessedValue, 0);
	self.version2.EcoTrajectory2 := PAeconCode+CAeconCode;
	
	self.version2.mobility_indicator := TRIM((STRING)capU((UNSIGNED)le.mobility_indicator, capZero, 6));
	
	statusAddr1 := map(le.address_verification.input_address_information.applicant_owned or 
														le.address_verification.input_address_information.applicant_sold or
														le.address_verification.input_address_information.family_owned or 
														le.address_verification.input_address_information.family_sold => 'O',// owned
										 ~le.address_verification.input_address_information.occupant_owned and
														le.iid.dwelltype not in ['','S'] => 'R',// rent,
										 'U');// unknown
	statusAddr2 := map(le.address_verification.address_history_1.applicant_owned or 
														le.address_verification.address_history_1.applicant_sold or
														le.address_verification.address_history_1.family_owned or 
														le.address_verification.address_history_1.family_sold => 'O',// owned
										 ~le.address_verification.address_history_1.occupant_owned and 
														le.address_verification.addr_type2 not in ['','S'] => 'R',// rent,
										 'U');// unknown;
	statusAddr3 := map(le.address_verification.address_history_2.applicant_owned or 
														le.address_verification.address_history_2.applicant_sold or
														le.address_verification.address_history_2.family_owned or 
														le.address_verification.address_history_2.family_sold => 'O',// owned
										 ~le.address_verification.address_history_2.occupant_owned and 
														le.address_verification.addr_type3 not in ['','S'] => 'R',// rent,
										 'U');// unknown;
	
	self.version2.statusAddr := map(CAaddrChooser=1 => statusAddr1,
																	CAaddrChooser=2 => statusAddr2,
																	CAaddrChooser=3 => statusAddr3,
																	'U');
																	
	self.version2.statusAddr2 := map(PAaddrChooser=1 => statusAddr1,
																	 PAaddrChooser=2 => statusAddr2,
																	 PAaddrChooser=3 => statusAddr3,
																	 'U');
	self.version2.statusAddr3 := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => statusAddr3,
																	 CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => statusAddr2,
																	 'U'/*if(le.iid.chronodate_first<self.version2.PADateFirstReported, le.iid.chronodate_first, 
																				 if(le.iid.chronodate_first2<self.version2.PADateFirstReported, le.iid.chronodate_first2,
																							 le.iid.chronodate_first3))*/);
	self.version2.PADateFirstReported2 := map(PAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
																						PAaddrChooser=2 => le.address_verification.address_history_1.date_first_seen,
																						PAaddrChooser=3 => le.address_verification.address_history_2.date_first_seen,
																						0);
	self.version2.NPADateFirstReported := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => le.address_verification.address_history_2.date_first_seen,
																						CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => le.address_verification.address_history_1.date_first_seen,
																						CAaddrChooser=4 => 0,	// if we dont know what current is, then 0
																						if(le.iid.chronodate_first<self.version2.PADateFirstReported, le.iid.chronodate_first, 
																									if(le.iid.chronodate_first2<self.version2.PADateFirstReported, le.iid.chronodate_first2,
																												le.iid.chronodate_first3)));// does this make sense?  assuming one of the chronodates is the third address, pick the one that is less than the pa date
	self.version2.addrChanges30 := capU(le.other_address_info.addrs_last30, capZero, cap255);
	self.version2.addrChanges90 := capU(le.other_address_info.addrs_last90, capZero, cap255);
	self.version2.addrChanges180 := capU(le.velocity_counters.addrs_per_adl_created_6months, capZero, cap255);
	self.version2.addrChanges12 := capU(le.other_address_info.addrs_last12, capZero, cap255);
	self.version2.addrChanges24 := capU(le.other_address_info.addrs_last24, capZero, cap255);
	self.version2.addrChanges36 := capU(le.other_address_info.addrs_last36, capZero, cap255);
	self.version2.addrChanges60 := capU(le.other_address_info.addrs_last_5years, capZero, cap255);
	
	// Property and Asset Information
	self.version2.property_owned_total := capU(le.address_verification.owned.property_total, capZero, cap255);
	self.version2.property_owned_assessed_total := capU(le.address_verification.owned.property_owned_assessed_total, capZero, capMax3);
	self.version2.property_historically_owned := capU(le.address_verification.owned.property_total + le.address_verification.sold.property_total + le.address_verification.ambiguous.property_total, capZero, cap255);
	self.version2.date_first_purchase := if(le.other_address_info.date_first_purchase>fullDate, 0, le.other_address_info.date_first_purchase);
	self.version2.date_most_recent_purchase := if(le.other_address_info.date_most_recent_purchase>fullDate, 0, le.other_address_info.date_most_recent_purchase);
	self.version2.date_most_recent_sale := if(le.other_address_info.date_most_recent_sale>fullDate, 0, le.other_address_info.date_most_recent_sale);
	self.version2.numPurchase30 := capU(le.other_address_info.num_purchase30, capZero, cap255);
	self.version2.numPurchase90 := capU(le.other_address_info.num_purchase90, capZero, cap255);
	self.version2.numPurchase180 := capU(le.other_address_info.num_purchase180, capZero, cap255);
	self.version2.numPurchase12 := capU(le.other_address_info.num_purchase12, capZero, cap255);
	self.version2.numPurchase24 := capU(le.other_address_info.num_purchase24, capZero, cap255);
	self.version2.numPurchase36 := capU(le.other_address_info.num_purchase36, capZero, cap255);
	self.version2.numPurchase60 := capU(le.other_address_info.num_purchase60, capZero, cap255);
	self.version2.numSold30 := capU(le.other_address_info.num_sold30, capZero, cap255);
	self.version2.numSold90 := capU(le.other_address_info.num_sold90, capZero, cap255);
	self.version2.numSold180 := capU(le.other_address_info.num_sold180, capZero, cap255);
	self.version2.numSold12 := capU(le.other_address_info.num_sold12, capZero, cap255);
	self.version2.numSold24 := capU(le.other_address_info.num_sold24, capZero, cap255);
	self.version2.numSold36 := capU(le.other_address_info.num_sold36, capZero, cap255);
	self.version2.numSold60 := capU(le.other_address_info.num_sold60, capZero, cap255);
	self.version2.numWatercraft := capU(le.watercraft.watercraft_count, capZero, cap255);
	self.version2.numWatercraft30 := capU(le.watercraft.watercraft_count30, capZero, cap255);
	self.version2.numWatercraft90 := capU(le.watercraft.watercraft_count90, capZero, cap255);
	self.version2.numWatercraft180 := capU(le.watercraft.watercraft_count180, capZero, cap255);
	self.version2.numWatercraft12 := capU(le.watercraft.watercraft_count12, capZero, cap255);
	self.version2.numWatercraft24 := capU(le.watercraft.watercraft_count24, capZero, cap255);
	self.version2.numWatercraft36 := capU(le.watercraft.watercraft_count36, capZero, cap255);
	self.version2.numWatercraft60 := capU(le.watercraft.watercraft_count60, capZero, cap255);
	self.version2.numAircraft := capU(le.aircraft.aircraft_count, capZero, cap255);
	self.version2.numAircraft30 := capU(le.aircraft.aircraft_count30, capZero, cap255);
	self.version2.numAircraft90 := capU(le.aircraft.aircraft_count90, capZero, cap255);
	self.version2.numAircraft180 := capU(le.aircraft.aircraft_count180, capZero, cap255);
	self.version2.numAircraft12 := capU(le.aircraft.aircraft_count12, capZero, cap255);
	self.version2.numAircraft24 := capU(le.aircraft.aircraft_count24, capZero, cap255);
	self.version2.numAircraft36 := capU(le.aircraft.aircraft_count36, capZero, cap255);
	self.version2.numAircraft60 := capU(le.aircraft.aircraft_count60, capZero, cap255);
	self.version2.wealth_indicator := TRIM((STRING)capU((UNSIGNED)le.wealth_indicator, capZero, 6));
	
	// Derogatory Public Records
	self.version2.total_number_derogs := capU(le.bjl.felony_count + le.bjl.filing_count + le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count, capZero, cap255);
	date_last_derog := Max(Max(le.bjl.last_felony_date, (integer)le.bjl.last_liens_unreleased_date),le.bjl.date_last_seen);
	self.version2.date_last_derog := if(date_last_derog>fullDate, 0, date_last_derog);
	self.version2.felonies := capU(le.bjl.felony_count, capZero, cap255);
	self.version2.date_last_conviction := if(le.bjl.last_felony_date>fullDate, 0, le.bjl.last_felony_date);
	self.version2.felonies30 := capU(le.bjl.criminal_count30, capZero, cap255);
	self.version2.felonies90 := capU(le.bjl.criminal_count90, capZero, cap255);
	self.version2.felonies180 := capU(le.bjl.criminal_count180, capZero, cap255);
	self.version2.felonies12 := capU(le.bjl.criminal_count12, capZero, cap255);
	self.version2.felonies24 := capU(le.bjl.criminal_count24, capZero, cap255);
	self.version2.felonies36 := capU(le.bjl.criminal_count36, capZero, cap255);
	self.version2.felonies60 := capU(le.bjl.criminal_count60, capZero, cap255);
	self.version2.num_liens := capU(le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count +
														 le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count, capZero, cap255);
	self.version2.num_unreleased_liens := capU(le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count, capZero, cap255);
	self.version2.date_last_unreleased := if((unsigned)le.bjl.last_liens_unreleased_date>fullDate, 0, (unsigned)le.bjl.last_liens_unreleased_date);
	self.version2.num_unreleased_liens30 := capU(le.bjl.liens_unreleased_count30, capZero, cap255);
	self.version2.num_unreleased_liens90 := capU(le.bjl.liens_unreleased_count90, capZero, cap255);
	self.version2.num_unreleased_liens180 := capU(le.bjl.liens_unreleased_count180, capZero, cap255);
	self.version2.num_unreleased_liens12 := capU(le.bjl.liens_unreleased_count12, capZero, cap255);
	self.version2.num_unreleased_liens24 := capU(le.bjl.liens_unreleased_count24, capZero, cap255);
	self.version2.num_unreleased_liens36 := capU(le.bjl.liens_unreleased_count36, capZero, cap255);
	self.version2.num_unreleased_liens60 := capU(le.bjl.liens_unreleased_count60, capZero, cap255);
	self.version2.num_released_liens := capU(le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count, capZero, cap255);
	self.version2.date_last_released := if(le.bjl.last_liens_released_date>fullDate, 0, le.bjl.last_liens_released_date);
	self.version2.num_released_liens30 := capU(le.bjl.liens_released_count30, capZero, cap255);
	self.version2.num_released_liens90 := capU(le.bjl.liens_released_count90, capZero, cap255);
	self.version2.num_released_liens180 := capU(le.bjl.liens_released_count180, capZero, cap255);
	self.version2.num_released_liens12 := capU(le.bjl.liens_released_count12, capZero, cap255);
	self.version2.num_released_liens24 := capU(le.bjl.liens_released_count24, capZero, cap255);
	self.version2.num_released_liens36 := capU(le.bjl.liens_released_count36, capZero, cap255);
	self.version2.num_released_liens60 := capU(le.bjl.liens_released_count60, capZero, cap255);
	self.version2.bankruptcy_count := capU(le.bjl.filing_count, capZero, cap255);
	self.version2.date_last_bankruptcy := if(le.bjl.date_last_seen>fullDate, 0, le.bjl.date_last_seen);
	self.version2.filing_type := le.bjl.filing_type;
	self.version2.disposition := le.bjl.disposition;
	self.version2.bankruptcy_count30 := capU(le.bjl.bk_count30, capZero, cap255);
	self.version2.bankruptcy_count90 := capU(le.bjl.bk_count90, capZero, cap255);
	self.version2.bankruptcy_count180 := capU(le.bjl.bk_count180, capZero, cap255);
	self.version2.bankruptcy_count12 := capU(le.bjl.bk_count12, capZero, cap255);
	self.version2.bankruptcy_count24 := capU(le.bjl.bk_count24, capZero, cap255);
	self.version2.bankruptcy_count36 := capU(le.bjl.bk_count36, capZero, cap255);
	self.version2.bankruptcy_count60 := capU(le.bjl.bk_count60, capZero, cap255);
	self.version2.eviction_count := capU(le.bjl.eviction_recent_unreleased_count + le.bjl.eviction_historical_unreleased_count +
																	le.bjl.eviction_recent_released_count + le.bjl.eviction_historical_released_count, capZero, cap255);
	self.version2.date_last_eviction := if(le.bjl.last_eviction_date>fullDate, 0, le.bjl.last_eviction_date);
	self.version2.eviction_count30 := capU(le.bjl.eviction_count30, capZero, cap255);
	self.version2.eviction_count90 := capU(le.bjl.eviction_count90, capZero, cap255);
	self.version2.eviction_count180 := capU(le.bjl.eviction_count180, capZero, cap255);
	self.version2.eviction_count12 := capU(le.bjl.eviction_count12, capZero, cap255);
	self.version2.eviction_count24 := capU(le.bjl.eviction_count24, capZero, cap255);
	self.version2.eviction_count36 := capU(le.bjl.eviction_count36, capZero, cap255);
	self.version2.eviction_count60 := capU(le.bjl.eviction_count60, capZero, cap255);
	
	// Non-Derogatory Public Records
	self.version2.num_nonderogs := capU(add1U(le.source_verification.num_nonderogs), capZero, cap255);// compare this to attributes 1 field, should be the same
	self.version2.num_nonderogs30 := capU(le.source_verification.num_nonderogs30, capZero, cap255);
	self.version2.num_nonderogs90 := capU(le.source_verification.num_nonderogs90, capZero, cap255);
	self.version2.num_nonderogs180 := capU(le.source_verification.num_nonderogs180, capZero, cap255);
	self.version2.num_nonderogs12 := capU(le.source_verification.num_nonderogs12, capZero, cap255);
	self.version2.num_nonderogs24 := capU(le.source_verification.num_nonderogs24, capZero, cap255);
	self.version2.num_nonderogs36 := capU(le.source_verification.num_nonderogs36, capZero, cap255);
	self.version2.num_nonderogs60 := capU(le.source_verification.num_nonderogs60, capZero, cap255);
	self.version2.num_proflic := capU(le.professional_license.proflic_count, capZero, cap255);
	self.version2.date_last_proflic := if(le.professional_license.date_most_recent>fullDate, 0, le.professional_license.date_most_recent);
	self.version2.proflic_type := le.professional_license.license_type;
	self.version2.expire_date_last_proflic := IF((UNSIGNED)((string)le.professional_license.expiration_date)[1..4] > 2100 OR (UNSIGNED)((string)le.professional_license.expiration_date)[1..4] < 1989, 999999, le.professional_license.expiration_date); // 999999 indicates this attribute should be blanked out
	self.version2.num_proflic30 := capU(le.professional_license.proflic_count30, capZero, cap255);
	self.version2.num_proflic90 := capU(le.professional_license.proflic_count90, capZero, cap255);
	self.version2.num_proflic180 := capU(le.professional_license.proflic_count180, capZero, cap255);
	self.version2.num_proflic12 := capU(le.professional_license.proflic_count12, capZero, cap255);
	self.version2.num_proflic24 := capU(le.professional_license.proflic_count24, capZero, cap255);
	self.version2.num_proflic36 := capU(le.professional_license.proflic_count36, capZero, cap255);
	self.version2.num_proflic60 := capU(le.professional_license.proflic_count60, capZero, cap255);
	self.version2.num_proflic_exp30 := capU(le.professional_license.expire_count30, capZero, cap255);
	self.version2.num_proflic_exp90 := capU(le.professional_license.expire_count90, capZero, cap255);
	self.version2.num_proflic_exp180 := capU(le.professional_license.expire_count180, capZero, cap255);
	self.version2.num_proflic_exp12 := capU(le.professional_license.expire_count12, capZero, cap255);
	self.version2.num_proflic_exp24 := capU(le.professional_license.expire_count24, capZero, cap255);
	self.version2.num_proflic_exp36 := capU(le.professional_license.expire_count36, capZero, cap255);
	self.version2.num_proflic_exp60 := capU(le.professional_license.expire_count60, capZero, cap255);
	
	// Higher Risk Address and Phone Attributes
	self.version2.isAddrHighRisk := le.iid.hriskaddrflag = '4';
	self.version2.isPhoneHighRisk := le.iid.hriskphoneflag = '6';
	self.version2.isAddrPrison := le.iid.hriskaddrflag='4' AND le.iid.hrisksic = '2225';
	self.version2.isZipPOBox := le.iid.zipclass='P';
	self.version2.isZipCorpMil := le.iid.zipclass in ['M','U'];
	self.version2.phoneStatus := map(le.iid.phonedissflag and le.input_validation.homephone => 'D',
																	 le.iid.phonevalflag in ['1','2'] or (le.iid.phonevalflag = '3' and le.iid.phonephonecount>0) => 'C',	// unknown phone usage but a phone hit (removed phones we dont know about)
																	 '');
	self.version2.isPhonePager := le.iid.hriskphoneflag = '2';
	self.version2.isPhoneMobile := le.iid.hriskphoneflag = '1';
	self.version2.isPhoneZipMismatch := le.iid.phonezipflag = '1';
	self.version2.phoneAddrDist := capU(le.iid.disthphoneaddr, capZero, cap9999);
	
	// fcra corrections flags
	self.version2.SecurityFreeze := le.consumerflags.security_freeze;
	self.version2.SecurityAlert := le.consumerflags.security_alert;
	self.version2.IdTheftFlag := le.consumerflags.id_theft_flag;
	self.version2.DisputeFlag := le.consumerflags.dispute_flag;
	self.version2.NegativeAlert := le.consumerflags.negative_alert;
	self.version2.CorrectedFlag := le.consumerflags.corrected_flag;

	
	
	// VERSION 3 fields---------------------------------------------------------------------------------------------------------
	checkBoolean(boolean x) := if(x, '1', '0');
	cap150 := '150';
	cap960 := '960';
	getMin(string input, string lowerBound, string upperBound) := IF((unsigned)input < (unsigned)upperBound, IF((UNSIGNED)input < (UNSIGNED)lowerBound and input <> '', lowerBound, input), upperBound);	// get smaller number and make sure the lower bounds is not exceeded
  sysdateV3 := if(le.historydate <> 999999, (integer)(((string)le.historydate)[1..6]), (integer)le.header_summary.header_build_date);
  checkHdrBldDate(unsigned FoundDate, unsigned HdrBldDate) := FUNCTION
			outDate := if(foundDate >= HdrBldDate, HdrBldDate, foundDate);
			return outDate;
	END;
	
	// per mike woodberry 4-13-10, if first seen months are 00, set them to 01 
	IAdateFirstSeen := if(((string)le.address_verification.input_address_information.date_first_seen)[5..6]='00', (unsigned)(((string)le.address_verification.input_address_information.date_first_seen)[1..4]+'01'),
																																																							le.address_verification.input_address_information.date_first_seen);
	AH1dateFirstSeen := if(((string)le.address_verification.address_history_1.date_first_seen)[5..6]='00', 	(unsigned)(((string)le.address_verification.address_history_1.date_first_seen)[1..4]+'01'),
																																																				le.address_verification.address_history_1.date_first_seen);
	AH2dateFirstSeen := if(((string)le.address_verification.address_history_2.date_first_seen)[5..6]='00', 	(unsigned)(((string)le.address_verification.address_history_2.date_first_seen)[1..4]+'01'),
																																																				le.address_verification.address_history_2.date_first_seen);
																																																

	// Identity Authentication Attributes
	subjectFirstSeen := fixYYYY00(ut.Min2(le.ssn_verification.header_first_seen, le.ssn_verification.credit_first_seen));
	subjectLastSeen := checkHdrBldDate(fixYYYY00(Max(le.ssn_verification.header_last_seen, le.ssn_verification.credit_last_seen)), le.header_summary.header_build_date);
	self.version3.AgeOldestRecord := getMin(if(subjectFirstSeen=0, '', (string)round((ut.DaysApart((string)subjectFirstSeen, (string)sysdateV3)) / 30)), (STRING)capAtOne, cap960);
	self.version3.AgeNewestRecord := getMin(if(subjectLastSeen=0, '', (string)round((ut.DaysApart((string)subjectLastSeen, (string)sysdateV3)) / 30)), (STRING)capAtOne, cap960);
	self.version3.isRecentUpdate := (sysdateV3 - last_seen) < 100;
	self.version3.NumSources := capU(map(CAaddrChooser=1 => add1U(le.address_verification.input_address_information.source_count),
																	CAaddrChooser=2 => add1U(le.address_verification.address_history_1.source_count),
																	CAaddrChooser=3 => add1U(le.address_verification.address_history_2.source_count),
																	0), capZero, cap255);

	phoneNotInput := le.shell_input.phone10='';
	phoneNotFound := le.shell_input.phone10='' or le.iid.phonephonecount=0;
	self.version3.VerifiedPhoneFullName := if(phoneNotFound, '', checkBoolean(self.finance.phone_full_name_match));
	self.version3.VerifiedPhoneLastName := if(phoneNotFound, '', checkBoolean(self.finance.phone_last_name_match));
	self.version3.InvalidPhone := if(phoneNotInput, '', checkBoolean(le.iid.phonetype <> '1' and le.shell_input.phone10 <> ''));
	
	ssnNotInput := le.shell_input.SSN='';
	self.version3.InvalidSSN := if(ssnNotInput, '', checkBoolean(~le.SSN_Verification.Validation.valid));

	addrNotInput :=  ~((le.shell_input.in_StreetAddress<>'' and le.shell_input.in_City<>'' and le.shell_input.in_State<>'') or (le.shell_input.in_StreetAddress<>'' and le.shell_input.in_Zipcode<>''));
	// I am not sure naprop is the universal way to show no property found, so we should check addrNotFound=true and the value is a false type
	addrNotFound :=  addrNotInput or le.address_verification.input_address_information.naprop=0;	//TODO: possibly need to find a way to know if property is found, does this work?
	self.version3.InvalidAddr := if(addrNotInput, '', checkBoolean(le.iid.addrvalflag='N'));

	dlNotInput := le.shell_input.dl_Number='' or le.shell_input.dl_state=''; 
	self.version3.InvalidDL := if(dlNotInput, '', checkBoolean(le.iid.drlcvalflag in ['1','3']));
	
	self.version3.isNoVer := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

	// SSN Attributes
	self.version3.SSNDeceased := if(ssnNotInput, '', checkBoolean(le.iid.decsflag='1'));
	self.version3.DeceasedDate := if(le.ssn_verification.Validation.deceasedDate=0 or le.ssn_verification.Validation.deceasedDate>fullDate, '', (string)le.ssn_verification.Validation.deceasedDate);	
	self.version3.SSNValid := if(ssnNotInput, '', checkBoolean(le.SSN_Verification.Validation.valid));
	self.version3.RecentIssue := if(ssnNotInput, '', checkBoolean((sysdate - (INTEGER)(le.iid.soclhighissue[1..6])) < 100 AND sysdate <= Risk_Indicators.iid_constants.randomSSN1Year));

//============================================
//=== If the transaction is from Experian  ===
//=== and customer is requesting version 3 ===
//=== attributes                           ===
//=== convert the 6 digit date to 8 digits ===
//============================================
  v3_LowIssueDate            :=	if((unsigned)ssnLowIssue=0 or (unsigned)ssnLowIssue>fullDate, '', (string)((unsigned)ssnLowIssue));
	v3_HighIssueDate           := if((unsigned)ssnHighIssue=0 or (unsigned)ssnHighIssue>fullDate, '', (string)((unsigned)ssnHighIssue));
	
	Needtofix6Low              := length(v3_LowIssueDate) = 6 AND ExperianTransaction;  
	self.version3.LowIssueDate := if(Needtofix6Low, v3_LowIssueDate + '01', v3_LowIssueDate);
	
	Needtofix6High              := length(v3_HighIssueDate) = 6 AND ExperianTransaction;  
	self.version3.HighIssueDate := if(Needtofix6High, V3_HighIssueDate + (STRING)Ut.Month_Days((INTEGER)v3_HighIssueDate), v3_HighIssueDate);
	
	
	self.version3.IssueState := le.iid.soclstate;
	self.version3.NonUS := if(ssnNotInput, '', checkBoolean(le.iid.non_us_ssn OR 
																														(le.shell_input.ssn[1]='9' and le.shell_input.ssn[4] in ['7','8'])));// ITIN logic;
	self.version3.Issued3 := if(ssnNotInput, '', checkBoolean(// If it is not a randomized social and only issued within the last 36 months
																														(~randomizedSocial AND (sysdate - (INTEGER)(le.iid.socllowissue[1..6])) < 300) OR 
																														// Or it was possibly randomized and the date is prior to June 25th, 2014
																														(randomizedSocial AND sysdate <= Risk_Indicators.iid_constants.randomSSN3Years)));
	self.version3.IssuedAge5 := if(ssnNotInput, '', checkBoolean(((INTEGER)(le.iid.socllowissue[1..6]) - (INTEGER)(le.shell_input.Dob[1..6])) > 500 AND (INTEGER)(le.shell_input.Dob[1..4]) > 1990 AND (INTEGER)(le.shell_input.Dob[1..6]) < 200606));
	
	// Characteristics of Input Address

		
	self.version3.IAAgeOldestRecord := getMin(if(IAdateFirstSeen=0, '', 
																				(string)round((ut.DaysApart((string)checkHdrBldDate(IAdateFirstSeen,le.header_summary.header_build_date) ,	(string)sysdateV3)) / 30)), (STRING)capAtOne, cap960);
	self.version3.IAAgeNewestRecord := getMin(if(le.address_verification.input_address_information.date_last_seen=0, '', 
																				(string)round((ut.DaysApart((string)checkHdrBldDate(checkDate6(le.address_verification.input_address_information.date_last_seen), le.header_summary.header_build_date),	(string) sysdateV3)) / 30)), (STRING)capAtOne, cap960);
	self.version3.IALenOfRes := if(addrNotInput, '', if(self.version3.IAAgeOldestRecord<>'' and self.version3.IAAgeNewestRecord<>'',
																		TRIM((string)capI(((INTEGER)self.version3.IAAgeOldestRecord - (INTEGER)self.version3.IAAgeNewestRecord), (INTEGER)capAtOne, (INTEGER)cap960)),
																		''));	
	self.version3.IADwellType := if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type);
	self.version3.IALandUseCode := le.avm.input_address_information.avm_land_use_code;
	self.version3.IAAssessedValue := if(addrNotFound and le.address_verification.input_address_information.assessed_amount=0, '', TRIM((string)capU(le.address_verification.input_address_information.assessed_amount, capZero, capMax)));
	self.version3.IAOwnedBySubject := if(addrNotFound and ~le.address_verification.input_address_information.applicant_owned and
																												~le.address_verification.input_address_information.family_owned and
																												~le.address_verification.input_address_information.occupant_owned, '', checkBoolean(le.address_verification.input_address_information.applicant_owned));
	self.version3.IAFamilyOwned := if(addrNotFound and ~le.address_verification.input_address_information.applicant_owned and
																												~le.address_verification.input_address_information.family_owned and
																												~le.address_verification.input_address_information.occupant_owned, '', checkBoolean(le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned));
	self.version3.IAOccupantOwned := if(addrNotFound and ~le.address_verification.input_address_information.applicant_owned and
																												~le.address_verification.input_address_information.family_owned and
																												~le.address_verification.input_address_information.occupant_owned, '', checkBoolean(le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																																																																						~le.address_verification.input_address_information.family_owned));
	self.version3.IAAgeLastSale := getMin(if(le.address_verification.input_address_information.purchase_date=0 or le.address_verification.input_address_information.purchase_date>fullDate, '', 
																		(string)round((ut.DaysApart((string)le.address_verification.input_address_information.purchase_date, (string)sysdate)) / 30)), (STRING)capZero, cap960);	
	self.version3.IALastSaleAmount := if((addrNotFound and le.address_verification.input_address_information.purchase_amount=0) or le.address_verification.input_address_information.purchase_date>fullDate, '', (string)capU(le.address_verification.input_address_information.purchase_amount, capZero, capMax));
	noPrimaryRes := ~le.address_verification.input_address_information.isbestmatch and ~le.address_verification.address_history_1.isbestmatch and ~le.address_verification.address_history_2.isbestmatch;
	self.version3.IANotPrimaryRes := if(addrNotInput or noPrimaryRes, '', checkBoolean(~le.address_verification.input_address_information.isbestmatch));
	self.version3.IAPhoneListed := if(addrNotInput, '', TRIM((string)capU(le.Address_Verification.edaMatchLevel, capZero, 4)));
	self.version3.IAPhoneNumber := if(addrNotInput or le.address_verification.activePhone=0, '', TRIM((string)le.Address_Verification.activePhone));
	
	
	CADateFirstReported := map(CAaddrChooser=1 => IAdateFirstSeen,
														 CAaddrChooser=2 =>	AH1dateFirstSeen,
														 CAaddrChooser=3 => AH2dateFirstSeen,
														 0);
	self.version3.CAAgeOldestRecord := getMin(if(CADateFirstReported=0, '', TRIM((string)round((ut.DaysApart((string)CADateFirstReported, (string)sysdateV3)) / 30))), (STRING)capAtOne, cap960);
	
	CADateLastReported := checkDate6(map(CAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
																			CAaddrChooser=2 => le.address_verification.address_history_1.date_last_seen,
																			CAaddrChooser=3 => le.address_verification.address_history_2.date_last_seen,
																			0));
	self.version3.CAAgeNewestRecord := getMin(if(CADateLastReported=0, '', TRIM((string)round((ut.DaysApart((string)checkHdrBldDate(CADateLastReported,le.header_summary.header_build_date) ,	(string)sysdateV3)) / 30))), (STRING)capAtOne, cap960);
	
	self.version3.CALenOfRes := if(self.version3.CAAgeOldestRecord<>'' and self.version3.CAAgeNewestRecord<>'',
																TRIM((string)capI(((INTEGER)self.version3.CAAgeOldestRecord - (INTEGER)self.version3.CAAgeNewestRecord), (INTEGER)capAtOne, (INTEGER)cap960)),
																'');
																 
	self.version3.CADwellType := map(CAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
																	 CAaddrChooser=2 => le.address_verification.addr_type2,
																	 CAaddrChooser=3 => le.address_verification.addr_type3,
																	 '');
	self.version3.CALandUseCode := map(CAaddrChooser=1 => le.avm.input_address_information.avm_land_use_code,
																		 CAaddrChooser=2 => le.avm.address_history_1.avm_land_use_code,
																		 CAaddrChooser=3 => le.avm.address_history_2.avm_land_use_code,
																		 '');
	self.version3.CAAssessedValue := TRIM(map(CAaddrChooser=1 => (string)capU(le.address_verification.input_address_information.assessed_amount, capZero, capMax),
																			 CAaddrChooser=2 => (string)capU(le.address_verification.address_history_1.assessed_amount, capZero, capMax),
																			 CAaddrChooser=3 => (string)capU(le.address_verification.address_history_2.assessed_amount, capZero, capMax),
																			 ''));
	self.version3.CAOwnedBySubject := map(CAaddrChooser=1 => checkBoolean(le.address_verification.input_address_information.applicant_owned),
																					CAaddrChooser=2 => checkBoolean(le.address_verification.address_history_1.applicant_owned),
																					CAaddrChooser=3 => checkBoolean(le.address_verification.address_history_2.applicant_owned),
																					'');
	self.version3.CAFamilyOwned := map(CAaddrChooser=1 => checkBoolean(le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned),
																			 CAaddrChooser=2 => checkBoolean(le.address_verification.address_history_1.family_owned and ~le.address_verification.address_history_1.applicant_owned),
																			 CAaddrChooser=3 => checkBoolean(le.address_verification.address_history_2.family_owned and ~le.address_verification.address_history_2.applicant_owned),
																			 '');
	self.version3.CAOccupantOwned := map(CAaddrChooser=1 => checkBoolean(le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
														~le.address_verification.input_address_information.family_owned),
				 CAaddrChooser=2 => checkBoolean(le.address_verification.address_history_1.occupant_owned and ~le.address_verification.address_history_1.applicant_owned and
														~le.address_verification.address_history_1.family_owned),
				 CAaddrChooser=3 => checkBoolean(le.address_verification.address_history_2.occupant_owned and ~le.address_verification.address_history_2.applicant_owned and
														~le.address_verification.address_history_2.family_owned),
				 '');
	
	self.version3.CAAgeLastSale := getMin(if(CALastSaleDate=0 or CALastSaleDate>fullDate, '', TRIM((string)round((ut.DaysApart((string)CALastSaleDate, (string)sysdate)) / 30))), (STRING)capZero, cap960);
	self.version3.CALastSaleAmount := if(CALastSaleDate>fullDate, '', 
																				TRIM(map(CAaddrChooser=1 => (string)capU(le.address_verification.input_address_information.purchase_amount, capZero, capMax),
																						CAaddrChooser=2 => (string)capU(le.address_verification.address_history_1.purchase_amount, capZero, capMax),
																						CAaddrChooser=3 => (string)capU(le.address_verification.address_history_2.purchase_amount, capZero, capMax),
																						'')));//just guessing here																																	
	self.version3.CANotPrimaryRes := map(CAaddrChooser=1 => checkBoolean(~le.address_verification.input_address_information.isbestmatch),
																			 CAaddrChooser=2 => checkBoolean(~le.address_verification.address_history_1.isbestmatch),
																			 CAaddrChooser=3 => checkBoolean(~le.address_verification.address_history_2.isbestmatch),
																			 '');
	self.version3.CAPhoneListed := TRIM(map(CAaddrChooser=1 => (string)capU(le.address_verification.edaMatchLevel, capZero, 4),
																		 CAaddrChooser=2 => (string)capU(le.address_verification.edaMatchLevel2, capZero, 4),
																		 CAaddrChooser=3 => (string)capU(le.address_verification.edaMatchLevel3, capZero, 4),
																		 ''));
	self.version3.CAPhoneNumber := TRIM(map(CAaddrChooser=1 => if(le.address_verification.activePhone=0,'',(string)le.address_verification.activePhone),
																		 CAaddrChooser=2 => if(le.address_verification.activePhone2=0,'',(string)le.address_verification.activePhone2),
																		 CAaddrChooser=3 => if(le.address_verification.activePhone3=0,'',(string)le.address_verification.activePhone3),
																		 ''));
	
	PADateFirstReported := map(PAaddrChooser=1 => IAdateFirstSeen,
														 PAaddrChooser=2 =>	AH1dateFirstSeen,
														 PAaddrChooser=3 => AH2dateFirstSeen,
														 0);
	self.version3.PAAgeOldestRecord := getMin(if(PADateFirstReported=0, '', TRIM((string)round((ut.DaysApart((string)checkHdrBldDate(PADateFirstReported,le.header_summary.header_build_date),	(string)sysdateV3)) / 30))), (STRING)capAtOne, cap960);
														 
	PADateLastReported := checkDate6(map(PAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
																			PAaddrChooser=2 => le.address_verification.address_history_1.date_last_seen,
																			PAaddrChooser=3 => le.address_verification.address_history_2.date_last_seen,
																			0));
	self.version3.PAAgeNewestRecord := getMin(if(PADateLastReported=0, '', TRIM((string)round((ut.DaysApart((string)checkHdrBldDate(PADateLastReported,le.header_summary.header_build_date),	(string)sysdateV3)) / 30))), (STRING)capAtOne, cap960);

	self.version3.PALenOfRes := if(self.version3.PAAgeOldestRecord<>'' and self.version3.PAAgeNewestRecord<>'',
																TRIM((string)capI(((INTEGER)self.version3.PAAgeOldestRecord - (INTEGER)self.version3.PAAgeNewestRecord), (INTEGER)capAtOne, (INTEGER)cap960)),
																'');	

	self.version3.PADwellType := map(PAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
																	 PAaddrChooser=2 => le.address_verification.addr_type2,
																	 PAaddrChooser=3 => le.address_verification.addr_type3,
																	 '');
	self.version3.PALandUseCode := map(PAaddrChooser=1 => le.avm.input_address_information.avm_land_use_code,
																		 PAaddrChooser=2 => le.avm.address_history_1.avm_land_use_code,
																		 PAaddrChooser=3 => le.avm.address_history_2.avm_land_use_code,
																		 '');
	self.version3.PAAssessedValue := TRIM(map(PAaddrChooser=1 => (string)capU(le.address_verification.input_address_information.assessed_amount, capZero, capMax),
																			 PAaddrChooser=2 => (string)capU(le.address_verification.address_history_1.assessed_amount, capZero, capMax),
																			 PAaddrChooser=3 => (string)capU(le.address_verification.address_history_2.assessed_amount, capZero, capMax),
																			 ''));
	self.version3.PAOwnedBySubject := map(PAaddrChooser=1 => checkBoolean(le.address_verification.input_address_information.applicant_owned),
																					PAaddrChooser=2 => checkBoolean(le.address_verification.address_history_1.applicant_owned),
																					PAaddrChooser=3 => checkBoolean(le.address_verification.address_history_2.applicant_owned),
																					'');
	self.version3.PAFamilyOwned := map(PAaddrChooser=1 => checkBoolean(le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned),
																			 PAaddrChooser=2 => checkBoolean(le.address_verification.address_history_1.family_owned and ~le.address_verification.address_history_1.applicant_owned),
																			 PAaddrChooser=3 => checkBoolean(le.address_verification.address_history_2.family_owned and ~le.address_verification.address_history_2.applicant_owned),
																			 '');
	self.version3.PAOccupantOwned := map(PAaddrChooser=1 => checkBoolean(le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																													~le.address_verification.input_address_information.family_owned),
																				 PAaddrChooser=2 => checkBoolean(le.address_verification.address_history_1.occupant_owned and ~le.address_verification.address_history_1.applicant_owned and
																													~le.address_verification.address_history_1.family_owned),
																				 PAaddrChooser=3 => checkBoolean(le.address_verification.address_history_1.occupant_owned and ~le.address_verification.address_history_1.applicant_owned and
																														~le.address_verification.address_history_1.family_owned),
																				 '');
	
	self.version3.PAAgeLastSale := getMin(if(PALastSaleDate=0 or PALastSaleDate>fullDate, '', TRIM((string)round((ut.DaysApart((string)PALastSaleDate, (string)sysdate)) / 30))), (STRING)capZero, cap960);

	self.version3.PALastSaleAmount := if(PALastSaleDate>fullDate, '', 
																				TRIM(map(PAaddrChooser=1 => (string)capU(le.address_verification.input_address_information.purchase_amount, capZero, capMax),
																						PAaddrChooser=2 => (string)capU(le.address_verification.address_history_1.purchase_amount, capZero, capMax),
																						PAaddrChooser=3 => (string)capU(le.address_verification.address_history_2.purchase_amount, capZero, capMax),
																						'')));//just guessing here

	self.version3.PAPhoneListed := TRIM(map(PAaddrChooser=1 => (string)capU(le.address_verification.edaMatchLevel, capZero, 4),
																		 PAaddrChooser=2 => (string)capU(le.address_verification.edaMatchLevel2, capZero, 4),
																		 PAaddrChooser=3 => (string)capU(le.address_verification.edaMatchLevel3, capZero, 4),
																		 ''));
	self.version3.PAPhoneNumber := map(PAaddrChooser=1 => if(le.address_verification.activePhone=0,'',(string)le.address_verification.activePhone),
																		 PAaddrChooser=2 => if(le.address_verification.activePhone2=0,'',(string)le.address_verification.activePhone2),
																		 PAaddrChooser=3 => if(le.address_verification.activePhone3=0,'',(string)le.address_verification.activePhone3),
																		 '');
	
	// Differences between Input Address and Current Address
	self.version3.InputCurrMatch := if(addrNotInput or CAaddrChooser=4, '', checkBoolean(CAaddrChooser=1));
	self.version3.DistInputCurr := if(addrNotInput or CAaddrChooser=4, '',
																TRIM(map(	CAaddrChooser=1 => '0',// same address as input
																		CAaddrChooser=2 => IF(le.address_verification.distance_in_2_h1 = 9999, '', (string)capU(le.address_verification.distance_in_2_h1, capZero, cap9999)),// compare input to history 1
																		CAaddrChooser=3 => IF(le.address_verification.distance_in_2_h2 = 9999, '', (string)capU(le.address_verification.distance_in_2_h2, capZero, cap9999)),// compare input to history 2
																		'')));	// no distance calculated
	self.version3.DiffState := if(currAddrSt='' or le.shell_input.in_state='', '', checkBoolean(~(currAddrSt = (StringLib.StringToUpperCase(le.shell_input.in_state)))));
	self.version3.AssessedDiff := TRIM(if(le.address_verification.input_address_information.assessed_amount=0 or CAaddrChooser=4, '',
															if(~CAaddrChooser=1, map(	CAaddrChooser=2 and le.address_verification.address_history_1.assessed_amount<>0 => (string)(MIN(MAX(	le.address_verification.address_history_1.assessed_amount - 
																																																										le.address_verification.input_address_information.assessed_amount, -999999999), 999999999)),
																								CAaddrChooser=3 and le.address_verification.address_history_2.assessed_amount<>0 => (string)(MIN(MAX(	le.address_verification.address_history_2.assessed_amount - 
																																																										le.address_verification.input_address_information.assessed_amount, -999999999), 999999999)),
																								''), 
																						'')));
	
	
	self.version3.EcoTrajectory := if((addrNotFound and inputEcon='U') or CAaddrChooser=4, '', CAeconCode+inputEcon);
	
	// Differences between Current Address and Previous Address
	self.version3.InputPrevMatch := if(addrNotInput or PAaddrChooser=4, '', 
																	checkBoolean(Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range, 
																																le.address_verification.input_address_information.predir, 
																																le.address_verification.input_address_information.prim_name,
																																le.address_verification.input_address_information.addr_suffix, 
																																le.address_verification.input_address_information.postdir, 
																																le.address_verification.input_address_information.unit_desig, 
																																le.address_verification.input_address_information.sec_range) =
																																prevAddr and prevAddr <> ''));
	self.version3.DistCurrPrev := TRIM(map(	CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => IF(le.address_verification.distance_in_2_h1 = 9999, '', (string)capU(le.address_verification.distance_in_2_h1, capZero, cap9999)),
													CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => IF(le.address_verification.distance_in_2_h2 = 9999, '', (string)capU(le.address_verification.distance_in_2_h2, capZero, cap9999)),
													CAaddrChooser=2 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=2 => IF(le.address_verification.distance_h1_2_h2 = 9999, '', (string)capU(le.address_verification.distance_h1_2_h2, capZero, cap9999)),
													''));
	self.version3.DiffState2 := if(currAddrSt='' or prevAddrSt='', '', checkBoolean( ~(prevAddrSt = currAddrSt)));
	self.version3.AssessedDiff2 := TRIM(if((unsigned)self.version3.CAAssessedValue=0 or (unsigned)self.version3.PAAssessedValue=0, '', (string)(MIN(MAX((integer)self.version3.CAAssessedValue - (integer)self.version3.PAAssessedValue, -999999999), 999999999))));
	self.version3.EcoTrajectory2 := if(CAaddrChooser=4 or PAaddrChooser=4, '', PAeconCode+CAeconCode);
	
	// Transient Person Attributes
	self.version3.mobility_indicator := TRIM((STRING)capU((UNSIGNED)le.mobility_indicator, capZero, 6));
	
	
	self.version3.statusAddr := map(CAaddrChooser=1 => statusAddr1,
																	CAaddrChooser=2 => statusAddr2,
																	CAaddrChooser=3 => statusAddr3,
																	'');
																	
	self.version3.statusAddr2 := map(PAaddrChooser=1 => statusAddr1,
																	 PAaddrChooser=2 => statusAddr2,
																	 PAaddrChooser=3 => statusAddr3,
																	 '');
	self.version3.statusAddr3 := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => statusAddr3,
																	 CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => statusAddr2,
																	 ''/*if(le.iid.chronodate_first<self.version3.PADateFirstReported, le.iid.chronodate_first, 
																				 if(le.iid.chronodate_first2<self.version3.PADateFirstReported, le.iid.chronodate_first2,
																							 le.iid.chronodate_first3))*/);

	self.version3.addrChanges30 := capU(le.other_address_info.addrs_last30, capZero, cap255);
	self.version3.addrChanges90 := capU(le.other_address_info.addrs_last90, capZero, cap255);
	self.version3.addrChanges180 := capU(le.velocity_counters.addrs_per_adl_created_6months, capZero, cap255);
	self.version3.addrChanges12 := capU(le.other_address_info.addrs_last12, capZero, cap255);
	self.version3.addrChanges24 := capU(le.other_address_info.addrs_last24, capZero, cap255);
	self.version3.addrChanges36 := capU(le.other_address_info.addrs_last36, capZero, cap255);
	self.version3.addrChanges60 := capU(le.other_address_info.addrs_last_5years, capZero, cap255);
	
	// Property and Asset Information
	self.version3.property_owned_total := capU(le.address_verification.owned.property_total, capZero, cap255);
	self.version3.property_owned_assessed_total := capU(le.address_verification.owned.property_owned_assessed_total, capZero, capMax);
	self.version3.property_historically_owned := capU((le.address_verification.owned.property_total + le.address_verification.sold.property_total + le.address_verification.ambiguous.property_total), capZero, cap255);
	
	dfp := if(le.other_address_info.date_first_purchase>fullDate, 0, 
																																if(((string)le.other_address_info.date_first_purchase)[5..6]='00',(unsigned)(((string)le.other_address_info.date_first_purchase)[1..4]+'01'+((string)le.other_address_info.date_first_purchase)[7..8]),
																																																																le.other_address_info.date_first_purchase));
	self.version3.PropAgeOldestPurchase := getMin(if(dfp=0, '', (string)round((ut.DaysApart((string)le.other_address_info.date_first_purchase,	(string)sysdate)) / 30)), (STRING)capZero, cap960);
	
	dmrp := if(le.other_address_info.date_most_recent_purchase>fullDate, 0, 
																																				if(((string)le.other_address_info.date_most_recent_purchase)[5..6]='00',(unsigned)(((string)le.other_address_info.date_most_recent_purchase)[1..4]+'01'+((string)le.other_address_info.date_most_recent_purchase)[7..8]),
																																																																							le.other_address_info.date_most_recent_purchase));
	self.version3.PropAgeNewestPurchase := getMin(if(dmrp=0, '', (string)round((ut.DaysApart((string)le.other_address_info.date_most_recent_purchase,	(string)sysdate)) / 30)), (STRING)capZero, cap960);
	
	dmrs := if(le.other_address_info.date_most_recent_sale>fullDate, 0, le.other_address_info.date_most_recent_sale);
	self.version3.PropAgeNewestSale := getMin(if(dmrs=0, '', (string)round((ut.DaysApart((string)le.other_address_info.date_most_recent_sale,	(string)sysdate)) / 30)), (STRING)capZero, cap960);
	
	self.version3.numPurchase30 := capU(le.other_address_info.num_purchase30, capZero, cap255);
	self.version3.numPurchase90 := capU(le.other_address_info.num_purchase90, capZero, cap255);
	self.version3.numPurchase180 := capU(le.other_address_info.num_purchase180, capZero, cap255);
	self.version3.numPurchase12 := capU(le.other_address_info.num_purchase12, capZero, cap255);
	self.version3.numPurchase24 := capU(le.other_address_info.num_purchase24, capZero, cap255);
	self.version3.numPurchase36 := capU(le.other_address_info.num_purchase36, capZero, cap255);
	self.version3.numPurchase60 := capU(le.other_address_info.num_purchase60, capZero, cap255);
	self.version3.numSold30 := capU(le.other_address_info.num_sold30, capZero, cap255);
	self.version3.numSold90 := capU(le.other_address_info.num_sold90, capZero, cap255);
	self.version3.numSold180 := capU(le.other_address_info.num_sold180, capZero, cap255);
	self.version3.numSold12 := capU(le.other_address_info.num_sold12, capZero, cap255);
	self.version3.numSold24 := capU(le.other_address_info.num_sold24, capZero, cap255);
	self.version3.numSold36 := capU(le.other_address_info.num_sold36, capZero, cap255);
	self.version3.numSold60 := capU(le.other_address_info.num_sold60, capZero, cap255);
	self.version3.numWatercraft := capU(le.watercraft.watercraft_count, capZero, cap255);
	self.version3.numWatercraft30 := capU(le.watercraft.watercraft_count30, capZero, cap255);
	self.version3.numWatercraft90 := capU(le.watercraft.watercraft_count90, capZero, cap255);
	self.version3.numWatercraft180 := capU(le.watercraft.watercraft_count180, capZero, cap255);
	self.version3.numWatercraft12 := capU(le.watercraft.watercraft_count12, capZero, cap255);
	self.version3.numWatercraft24 := capU(le.watercraft.watercraft_count24, capZero, cap255);
	self.version3.numWatercraft36 := capU(le.watercraft.watercraft_count36, capZero, cap255);
	self.version3.numWatercraft60 := capU(le.watercraft.watercraft_count60, capZero, cap255);
	self.version3.numAircraft := capU(le.aircraft.aircraft_count, capZero, cap255);
	self.version3.numAircraft30 := capU(le.aircraft.aircraft_count30, capZero, cap255);
	self.version3.numAircraft90 := capU(le.aircraft.aircraft_count90, capZero, cap255);
	self.version3.numAircraft180 := capU(le.aircraft.aircraft_count180, capZero, cap255);
	self.version3.numAircraft12 := capU(le.aircraft.aircraft_count12, capZero, cap255);
	self.version3.numAircraft24 := capU(le.aircraft.aircraft_count24, capZero, cap255);
	self.version3.numAircraft36 := capU(le.aircraft.aircraft_count36, capZero, cap255);
	self.version3.numAircraft60 := capU(le.aircraft.aircraft_count60, capZero, cap255);
	self.version3.wealth_indicator := TRIM((STRING)capU((UNSIGNED)le.wealth_indicator, capZero, 6));
	
	// Derogatory Public Records
	eviction_count := le.BJL.eviction_historical_unreleased_count + le.BJL.eviction_recent_unreleased_count;	// get only unreleased evictions, just like liens
	self.version3.total_number_derogs := capU((le.bjl.felony_count + le.bjl.filing_count + le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count + eviction_count), capZero, cap255);
	date_last_derogv31 := Max(le.bjl.last_felony_date, (integer)le.bjl.last_liens_unreleased_date);
	date_last_derogv32 := Max(le.bjl.date_last_seen, if(eviction_count>0, le.bjl.last_eviction_date, 0));	// only use the eviction date if there is an unreleased eviction
	date_last_derogv3 := Max(date_last_derogv31, date_last_derogv32);
	
	self.version3.felonies := capU(le.bjl.felony_count, capZero, cap255);
	lfd := if(le.bjl.last_felony_date>fullDate, 0, le.bjl.last_felony_date);
	self.version3.FelonyAge := getMin(if(lfd=0, '', (string)round((ut.DaysApart((string)le.bjl.last_felony_date, (string)sysdate)) / 30)), (STRING)capZero, '84');
	
	self.version3.felonies30 := capU(le.bjl.criminal_count30, capZero, cap255);
	self.version3.felonies90 := capU(le.bjl.criminal_count90, capZero, cap255);
	self.version3.felonies180 := capU(le.bjl.criminal_count180, capZero, cap255);
	self.version3.felonies12 := capU(le.bjl.criminal_count12, capZero, cap255);
	self.version3.felonies24 := capU(le.bjl.criminal_count24, capZero, cap255);
	self.version3.felonies36 := capU(le.bjl.criminal_count36, capZero, cap255);
	self.version3.felonies60 := capU(le.bjl.criminal_count60, capZero, cap255);
	self.version3.num_liens := capU((le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count +
														 le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count), capZero, cap255);
	self.version3.num_unreleased_liens := capU((le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count), capZero, cap255);
	
	llud := if((unsigned)le.bjl.last_liens_unreleased_date>fullDate, 0, (unsigned)le.bjl.last_liens_unreleased_date);
	self.version3.LienFiledAge := getMin(if(llud=0, '', (string)round((ut.DaysApart((string)le.bjl.last_liens_unreleased_date, (string)sysdate)) / 30)), (STRING)capZero, '84');
	
	self.version3.num_unreleased_liens30 := capU(le.bjl.liens_unreleased_count30, capZero, cap255);
	self.version3.num_unreleased_liens90 := capU(le.bjl.liens_unreleased_count90, capZero, cap255);
	self.version3.num_unreleased_liens180 := capU(le.bjl.liens_unreleased_count180, capZero, cap255);
	self.version3.num_unreleased_liens12 := capU(le.bjl.liens_unreleased_count12, capZero, cap255);
	self.version3.num_unreleased_liens24 := capU(le.bjl.liens_unreleased_count24, capZero, cap255);
	self.version3.num_unreleased_liens36 := capU(le.bjl.liens_unreleased_count36, capZero, cap255);
	self.version3.num_unreleased_liens60 := capU(le.bjl.liens_unreleased_count60, capZero, cap255);
	self.version3.num_released_liens := capU((le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count), capZero, cap255);
	
	llrd := if(le.bjl.last_liens_released_date>fullDate, 0, le.bjl.last_liens_released_date);
	self.version3.LienReleasedAge := getMin(if(llrd=0, '', (string)round((ut.DaysApart((string)le.bjl.last_liens_released_date, (string)sysdate)) / 30)), (STRING)capZero, '84');
	
	self.version3.num_released_liens30 := capU(le.bjl.liens_released_count30, capZero, cap255);
	self.version3.num_released_liens90 := capU(le.bjl.liens_released_count90, capZero, cap255);
	self.version3.num_released_liens180 := capU(le.bjl.liens_released_count180, capZero, cap255);
	self.version3.num_released_liens12 := capU(le.bjl.liens_released_count12, capZero, cap255);
	self.version3.num_released_liens24 := capU(le.bjl.liens_released_count24, capZero, cap255);
	self.version3.num_released_liens36 := capU(le.bjl.liens_released_count36, capZero, cap255);
	self.version3.num_released_liens60 := capU(le.bjl.liens_released_count60, capZero, cap255);
	
	bdls := if(le.bjl.date_last_seen>fullDate, 0, le.bjl.date_last_seen);
	self.version3.BankruptcyAge := getMin(if(bdls=0, '', (string)round((ut.DaysApart((string)le.bjl.date_last_seen, (string)sysdate)) / 30)), (STRING)capZero, '120');
	
	// Raise the upper cap only if an older bankruptcy is on file
	dld := if(date_last_derogv3>fullDate, 0, date_last_derogv3);
	self.version3.DerogAge := getMin(if(dld=0, '', (string)round((ut.DaysApart((string)date_last_derogv3, (string)sysdate)) / 30)), (STRING)capZero, IF((UNSIGNED)SELF.version3.BankruptcyAge > 84, '120', '84'));
	
	self.version3.filing_type := le.bjl.filing_type;
	self.version3.disposition := le.bjl.disposition;
	self.version3.bankruptcy_count := capU(le.bjl.filing_count, capZero, cap255);
	self.version3.bankruptcy_count30 := capU(le.bjl.bk_count30, capZero, cap255);
	self.version3.bankruptcy_count90 := capU(le.bjl.bk_count90, capZero, cap255);
	self.version3.bankruptcy_count180 := capU(le.bjl.bk_count180, capZero, cap255);
	self.version3.bankruptcy_count12 := capU(le.bjl.bk_count12, capZero, cap255);
	self.version3.bankruptcy_count24 := capU(le.bjl.bk_count24, capZero, cap255);
	self.version3.bankruptcy_count36 := capU(le.bjl.bk_count36, capZero, cap255);
	self.version3.bankruptcy_count60 := capU(le.bjl.bk_count60, capZero, cap255);
	self.version3.eviction_count := capU((le.bjl.eviction_recent_unreleased_count + le.bjl.eviction_historical_unreleased_count +
																	le.bjl.eviction_recent_released_count + le.bjl.eviction_historical_released_count), capZero, cap255);
														
	bled := if(le.bjl.last_eviction_date>fullDate, 0, le.bjl.last_eviction_date);													
	self.version3.EvictionAge := getMin(if(bled=0, '', (string)round((ut.DaysApart((string)le.bjl.last_eviction_date, (string)sysdate)) / 30)), (STRING)capZero, '84');
	
	self.version3.eviction_count30 := capU(le.bjl.eviction_count30, capZero, cap255);
	self.version3.eviction_count90 := capU(le.bjl.eviction_count90, capZero, cap255);
	self.version3.eviction_count180 := capU(le.bjl.eviction_count180, capZero, cap255);
	self.version3.eviction_count12 := capU(le.bjl.eviction_count12, capZero, cap255);
	self.version3.eviction_count24 := capU(le.bjl.eviction_count24, capZero, cap255);
	self.version3.eviction_count36 := capU(le.bjl.eviction_count36, capZero, cap255);
	self.version3.eviction_count60 := capU(le.bjl.eviction_count60, capZero, cap255);
	
	// Non-Derogatory Public Records
	self.version3.num_nonderogs := capU(add1U(le.source_verification.num_nonderogs), capZero, cap255);		
	self.version3.num_nonderogs30 := capU(le.source_verification.num_nonderogs30, capZero, cap255);
	self.version3.num_nonderogs90 := capU(le.source_verification.num_nonderogs90, capZero, cap255);
	self.version3.num_nonderogs180 := capU(le.source_verification.num_nonderogs180, capZero, cap255);
	self.version3.num_nonderogs12 := capU(le.source_verification.num_nonderogs12, capZero, cap255);
	self.version3.num_nonderogs24 := capU(le.source_verification.num_nonderogs24, capZero, cap255);
	self.version3.num_nonderogs36 := capU(le.source_verification.num_nonderogs36, capZero, cap255);
	self.version3.num_nonderogs60 := capU(le.source_verification.num_nonderogs60, capZero, cap255);

	plmrd := if(le.professional_license.date_most_recent>fullDate, 0, le.professional_license.date_most_recent);
	self.version3.ProfLicAge := getMin(if(plmrd=0, '', (string)round((ut.DaysApart((string)le.professional_license.date_most_recent, (string)sysdate)) / 30)), (STRING)capZero, cap960);

	self.version3.proflic_type := if(le.professional_license.proflic_count=0, '', le.professional_license.license_type);
	self.version3.expire_date_last_proflic := if(le.professional_license.expiration_date=0 OR (UNSIGNED)((string)le.professional_license.expiration_date)[1..4] > 2100 OR (UNSIGNED)((String)le.professional_license.expiration_date)[1..4] < 1989, '', TRIM((string)le.professional_license.expiration_date));
	self.version3.num_proflic := capU(le.professional_license.proflic_count, capZero, cap255);
	self.version3.num_proflic30 := capU(le.professional_license.proflic_count30, capZero, cap255);
	self.version3.num_proflic90 := capU(le.professional_license.proflic_count90, capZero, cap255);
	self.version3.num_proflic180 := capU(le.professional_license.proflic_count180, capZero, cap255);
	self.version3.num_proflic12 := capU(le.professional_license.proflic_count12, capZero, cap255);
	self.version3.num_proflic24 := capU(le.professional_license.proflic_count24, capZero, cap255);
	self.version3.num_proflic36 := capU(le.professional_license.proflic_count36, capZero, cap255);
	self.version3.num_proflic60 := capU(le.professional_license.proflic_count60, capZero, cap255);
	self.version3.num_proflic_exp30 := capU(le.professional_license.expire_count30, capZero, cap255);
	self.version3.num_proflic_exp90 := capU(le.professional_license.expire_count90, capZero, cap255);
	self.version3.num_proflic_exp180 := capU(le.professional_license.expire_count180, capZero, cap255);
	self.version3.num_proflic_exp12 := capU(le.professional_license.expire_count12, capZero, cap255);
	self.version3.num_proflic_exp24 := capU(le.professional_license.expire_count24, capZero, cap255);
	self.version3.num_proflic_exp36 := capU(le.professional_license.expire_count36, capZero, cap255);
	self.version3.num_proflic_exp60 := capU(le.professional_license.expire_count60, capZero, cap255);
	
	// Higher Risk Address and Phone Attributes
	self.version3.AddrHighRisk := if(addrNotInput, '', checkBoolean(le.iid.hriskaddrflag = '4'));
	self.version3.PhoneHighRisk := if(phoneNotInput, '', checkBoolean(le.iid.hriskphoneflag = '6'));
	self.version3.AddrPrison := if(addrNotInput, '', checkBoolean(le.iid.hriskaddrflag='4' AND le.iid.hrisksic = '2225'));
	self.version3.ZipPOBox := if(le.shell_input.in_Zipcode='', '', checkBoolean(le.iid.zipclass='P'));
	self.version3.ZipCorpMil := if(le.shell_input.in_Zipcode='', '', checkBoolean(le.iid.zipclass in ['M','U']));
	self.version3.phoneStatus := if(phoneNotInput, '',
																map(le.iid.phonedissflag and le.input_validation.homephone => 'D',
																	  le.iid.phonevalflag in ['1','2'] or (le.iid.phonevalflag = '3' and le.iid.phonephonecount>0) => 'C',	// unknown phone usage but a phone hit (removed phones we dont know about)
																	  ''));
	self.version3.PhonePager := if(phoneNotInput, '', checkBoolean(le.iid.hriskphoneflag = '2'));
	self.version3.PhoneMobile := if(phoneNotInput, '', checkBoolean(le.iid.hriskphoneflag = '1'));
	self.version3.PhoneZipMismatch := if(phoneNotInput or le.shell_input.in_Zipcode='', '', checkBoolean(le.iid.phonezipflag = '1'));
	self.version3.phoneAddrDist := if(phoneNotInput or addrNotInput, '', IF(le.iid.disthphoneaddr = 9999, '', TRIM((string)capU(le.iid.disthphoneaddr, capZero, cap9999))));
	
	// fcra corrections flags
	self.version3.SecurityFreeze := le.consumerflags.security_freeze;
	self.version3.SecurityAlert := le.consumerflags.security_alert;
	self.version3.IdTheftFlag := le.consumerflags.id_theft_flag;
	self.version3.CorrectedFlag := le.consumerflags.corrected_flag;
	
	self.version3.SSNNotFound := if(ssnNotInput, '', if(~le.iid.ssnexists, '1', '0'));
	
	firstVerified := le.iid.nap_summary in [3, 4, 8, 9, 10, 12] or le.iid.nas_summary in [3, 4, 8, 9, 10, 12];
	lastVerified := le.iid.nap_summary in [5, 7, 8, 9, 11, 12] or le.iid.nas_summary in [5, 7, 8, 9, 11, 12];
	self.version3.VerifiedName := map(firstVerified and lastVerified => 3,
																		lastVerified => 2,
																		firstVerified => 1,
																		0);
	
	self.version3.VerifiedSSN := map(le.iid.nas_summary in [7, 9, 10, 11, 12] => 2, 
																	 le.iid.nas_summary = 1 => 1,
																	 0);
	
	self.version3.VerifiedPhone := map(le.iid.nap_summary in [6, 7, 9, 10, 11, 12] => 2,
																		 le.iid.nap_summary = 1 => 1,	
																		 0);
	
	self.version3.VerifiedAddress := map(le.iid.nap_summary in [5, 8, 10, 11, 12] => 1,
																			 le.iid.nas_summary in [5, 8, 10, 11, 12] => 1, 
																			 0);

	self.version3.VerifiedDOB := map(le.dobmatchlevel='8' => 7, // Full Date of Birth verified
																	 le.dobmatchlevel='5' => 6, // Day and year verified
																	 le.dobmatchlevel='4' => 5, // Month and day verified
																	 le.dobmatchlevel='7' => 4, // Month and year verified
																	 le.dobmatchlevel='6' => 3, // Year only verified
																	 le.dobmatchlevel='3' => 2, // Month only verified
																	 le.dobmatchlevel='2' => 1, // Day only verified
																	 0);
	

	ageDate := Risk_Indicators.iid_constants.myGetDate(le.historydate);
	self.version3.InferredMinimumAge := getMin(if(le.inferred_age=0 OR (isPrescreen AND (le.inferred_age < 21 OR (ut.Age(le.reported_dob, (unsigned)ageDate)) < 21)), '', (string)le.inferred_age), (STRING)capZero, cap150);
	self.version3.BestReportedAge := getMin(if(le.reported_dob=0 OR (isPrescreen AND (le.inferred_age < 21 OR (ut.Age(le.reported_dob, (unsigned)ageDate)) < 21)), '', (string)ut.Age(le.reported_dob, (unsigned)ageDate)), (STRING)capZero, cap150);

	self.version3.SubjectSSNCount := capU(le.velocity_counters.ssns_per_adl, capZero, cap255);
	self.version3.SubjectAddrCount := capU(le.velocity_counters.addrs_per_adl, capZero, cap255);
	self.version3.SubjectPhoneCount := capU(le.velocity_counters.phones_per_adl, capZero, cap255);
	self.version3.SubjectSSNRecentCount := capU(le.velocity_counters.ssns_per_adl_created_6months, capZero, cap255);
	self.version3.SubjectAddrRecentCount := capU(le.velocity_counters.addrs_per_adl_created_6months, capZero, cap255);
	self.version3.SubjectPhoneRecentCount := capU(le.velocity_counters.phones_per_adl_created_6months, capZero, cap255);
	
	self.version3.SSNIdentitiesCount := capU(le.SSN_Verification.adlPerSSN_count, capZero, cap255);
	self.version3.SSNAddrCount := capU(if(le.velocity_counters.addrs_per_ssn<le.velocity_counters.addrs_per_ssn_created_6months, 255, le.velocity_counters.addrs_per_ssn), capZero, cap255);	// if total count < recent count, that means recent > 255, so set it to 255
	self.version3.SSNIdentitiesRecentCount := capU(le.velocity_counters.adls_per_ssn_created_6months, capZero, cap255);
	self.version3.SSNAddrRecentCount := capU(le.velocity_counters.addrs_per_ssn_created_6months, capZero, cap255);
	
	self.version3.InputAddrIdentitiesCount := capU(le.velocity_counters.adls_per_addr, capZero, cap255);
	self.version3.InputAddrSSNCount := capU(le.velocity_counters.ssns_per_addr, capZero, cap255);
	self.version3.InputAddrPhoneCount := capU(le.velocity_counters.phones_per_addr, capZero, cap255);
	self.version3.InputAddrIdentitiesRecentCount := capU(le.velocity_counters.adls_per_addr_created_6months, capZero, cap255);
	self.version3.InputAddrSSNRecentCount := capU(le.velocity_counters.ssns_per_addr_created_6months, capZero, cap255);
	self.version3.InputAddrPhoneRecentCount := capU(le.velocity_counters.phones_per_addr_created_6months, capZero, cap255);
	
	self.version3.PhoneIdentitiesCount := capU(le.velocity_counters.adls_per_phone, capZero, cap255);
	self.version3.PhoneIdentitiesRecentCount := capU(le.velocity_counters.adls_per_phone_created_6months, capZero, cap255);
	
	self.version3.SSNIssuedPriorDOB := if(ssnNotInput, '', if(le.ssn_verification.validation.dob_mismatch=0, '0', '1'));	// check this
	
	self.version3.InputAddrTaxYr := le.address_verification.input_address_information.assessed_value_year;
	self.version3.InputAddrTaxMarketValue := capU((UNSIGNED)le.avm.input_address_information.avm_market_total_value, capZero, capMax);		// per Mike:  this value may not correspond to assessed value and assessed value year
	self.version3.InputAddrAVMTax := capU(le.avm.input_address_information.avm_tax_assessment_valuation, capZero, capMax);
	self.version3.InputAddrAVMSalesPrice := capU(le.avm.input_address_information.avm_price_index_valuation, capZero, capMax);
	self.version3.InputAddrAVMHedonic := capU(le.avm.input_address_information.avm_hedonic_valuation, capZero, capMax);
	self.version3.InputAddrAVMValue := capU(le.avm.input_address_information.avm_automated_valuation, capZero, capMax);
	self.version3.InputAddrAVMConfidence := capU(le.avm.input_address_information.avm_confidence_score, capZero, 99);
	self.version3.InputAddrCountyIndex := capR(le.avm.input_address_information.avm_automated_valuation / le.avm.input_address_information.avm_median_fips_level, (REAL)capZero, 99.0);
	self.version3.InputAddrTractIndex := capR(le.avm.input_address_information.avm_automated_valuation / le.avm.input_address_information.avm_median_geo12_level, (REAL)capZero, 99.0);
	self.version3.InputAddrBlockIndex := capR(le.avm.input_address_information.avm_automated_valuation / le.avm.input_address_information.avm_median_geo11_level, (REAL)capZero, 99.0);

	self.version3.CurrAddrTaxYr := map( CAaddrChooser=1 => le.address_verification.input_address_information.assessed_value_year,
																			CAaddrChooser=2 => le.address_verification.address_history_1.assessed_value_year,
																			CAaddrChooser=3 => le.address_verification.address_history_2.assessed_value_year,
																			'');
	self.version3.CurrAddrTaxMarketValue := capU(map(CAaddrChooser=1 => (unsigned)le.avm.input_address_information.avm_market_total_value,
																							CAaddrChooser=2 => (unsigned)le.avm.address_history_1.avm_market_total_value,
																							CAaddrChooser=3 => (unsigned)le.avm.address_history_2.avm_market_total_value,
																							0), capZero, capMax);		// per Mike:  this value may not correspond to assessed value and assessed value year
	self.version3.CurrAddrAVMTax := capU(map(CAaddrChooser=1 => le.avm.input_address_information.avm_tax_assessment_valuation,
																			CAaddrChooser=2 => le.avm.address_history_1.avm_tax_assessment_valuation,
																			CAaddrChooser=3 => le.avm.address_history_2.avm_tax_assessment_valuation,
																			0), capZero, capMax);
	self.version3.CurrAddrAVMSalesPrice := capU(map( CAaddrChooser=1 => le.avm.input_address_information.avm_price_index_valuation,
																							CAaddrChooser=2 => le.avm.address_history_1.avm_price_index_valuation,
																							CAaddrChooser=3 => le.avm.address_history_2.avm_price_index_valuation,
																							0), capZero, capMax);
	self.version3.CurrAddrAVMHedonic := capU(map(CAaddrChooser=1 => le.avm.input_address_information.avm_hedonic_valuation,
																					CAaddrChooser=2 => le.avm.address_history_1.avm_hedonic_valuation,
																					CAaddrChooser=3 => le.avm.address_history_2.avm_hedonic_valuation,
																					0), capZero, capMax);
																					
	currAddrAVMValue := map(CAaddrChooser=1 => le.avm.input_address_information.avm_automated_valuation,
													CAaddrChooser=2 => le.avm.address_history_1.avm_automated_valuation,
													CAaddrChooser=3 => le.avm.address_history_2.avm_automated_valuation,
													0);																				
	self.version3.CurrAddrAVMValue := capU(currAddrAVMValue, capZero, capMax);
	self.version3.CurrAddrAVMConfidence := capU(map( CAaddrChooser=1 => le.avm.input_address_information.avm_confidence_score,
																							CAaddrChooser=2 => le.avm.address_history_1.avm_confidence_score,
																							CAaddrChooser=3 => le.avm.address_history_2.avm_confidence_score,
																							0), capZero, 99);
																							
	currAddrFips :=  map( CAaddrChooser=1 => le.avm.input_address_information.avm_median_fips_level,
												CAaddrChooser=2 => le.avm.address_history_1.avm_median_fips_level,
												CAaddrChooser=3 => le.avm.address_history_2.avm_median_fips_level,
												0);
	currAddrGeo12 :=  map(CAaddrChooser=1 => le.avm.input_address_information.avm_median_geo12_level,
												CAaddrChooser=2 => le.avm.address_history_1.avm_median_geo12_level,
												CAaddrChooser=3 => le.avm.address_history_2.avm_median_geo12_level,
												0);
	currAddrGeo11 :=  map(CAaddrChooser=1 => le.avm.input_address_information.avm_median_geo11_level,
												CAaddrChooser=2 => le.avm.address_history_1.avm_median_geo11_level,
												CAaddrChooser=3 => le.avm.address_history_2.avm_median_geo11_level,
												0);
	self.version3.CurrAddrCountyIndex := capR((currAddrAVMValue / currAddrFips), (REAL)capZero, 99.0);
	self.version3.CurrAddrTractIndex := capR((currAddrAVMValue / currAddrGeo12), (REAL)capZero, 99.0);
	self.version3.CurrAddrBlockIndex := capR((currAddrAVMValue / currAddrGeo11), (REAL)capZero, 99.0);
	
	self.version3.PrevAddrTaxYr := map( PAaddrChooser=1 => le.address_verification.input_address_information.assessed_value_year,
																			PAaddrChooser=2 => le.address_verification.address_history_1.assessed_value_year,
																			PAaddrChooser=3 => le.address_verification.address_history_2.assessed_value_year,
																			'');
	self.version3.PrevAddrTaxMarketValue := capU(map(PAaddrChooser=1 => (unsigned)le.avm.input_address_information.avm_market_total_value,
																							PAaddrChooser=2 => (unsigned)le.avm.address_history_1.avm_market_total_value,
																							PAaddrChooser=3 => (unsigned)le.avm.address_history_2.avm_market_total_value,
																							0), capZero, capMax);	// per Mike:  this value may not correspond to assessed value and assessed value year
	self.version3.PrevAddrAVMTax := capU(map(PAaddrChooser=1 => le.avm.input_address_information.avm_tax_assessment_valuation,
																			PAaddrChooser=2 => le.avm.address_history_1.avm_tax_assessment_valuation,
																			PAaddrChooser=3 => le.avm.address_history_2.avm_tax_assessment_valuation,
																			0), capZero, capMax);
	self.version3.PrevAddrAVMSalesPrice := capU(map( PAaddrChooser=1 => le.avm.input_address_information.avm_price_index_valuation,
																							PAaddrChooser=2 => le.avm.address_history_1.avm_price_index_valuation,
																							PAaddrChooser=3 => le.avm.address_history_2.avm_price_index_valuation,
																							0), capZero, capMax);
	self.version3.PrevAddrAVMHedonic := capU(map(PAaddrChooser=1 => le.avm.input_address_information.avm_hedonic_valuation,
																					PAaddrChooser=2 => le.avm.address_history_1.avm_hedonic_valuation,
																					PAaddrChooser=3 => le.avm.address_history_2.avm_hedonic_valuation,
																					0), capZero, capMax);
																					
	prevAddrAVMValue := map(PAaddrChooser=1 => le.avm.input_address_information.avm_automated_valuation,
													PAaddrChooser=2 => le.avm.address_history_1.avm_automated_valuation,
													PAaddrChooser=3 => le.avm.address_history_2.avm_automated_valuation,
													0);																				
	self.version3.PrevAddrAVMValue := capU(prevAddrAVMValue, capZero, capMax);
	self.version3.PrevAddrAVMConfidence := capU(map( PAaddrChooser=1 => le.avm.input_address_information.avm_confidence_score,
																							PAaddrChooser=2 => le.avm.address_history_1.avm_confidence_score,
																							PAaddrChooser=3 => le.avm.address_history_2.avm_confidence_score,
																							0), capZero, 99);
																							
	prevAddrFips :=  map( PAaddrChooser=1 => le.avm.input_address_information.avm_median_fips_level,
												PAaddrChooser=2 => le.avm.address_history_1.avm_median_fips_level,
												PAaddrChooser=3 => le.avm.address_history_2.avm_median_fips_level,
												0);
	prevAddrGeo12 :=  map(PAaddrChooser=1 => le.avm.input_address_information.avm_median_geo12_level,
												PAaddrChooser=2 => le.avm.address_history_1.avm_median_geo12_level,
												PAaddrChooser=3 => le.avm.address_history_2.avm_median_geo12_level,
												0);
	prevAddrGeo11 :=  map(PAaddrChooser=1 => le.avm.input_address_information.avm_median_geo11_level,
												PAaddrChooser=2 => le.avm.address_history_1.avm_median_geo11_level,
												PAaddrChooser=3 => le.avm.address_history_2.avm_median_geo11_level,
												0);																						
	self.version3.PrevAddrCountyIndex := capR((prevAddrAVMValue / prevAddrFips), (REAL)capZero, 99.0);
	self.version3.PrevAddrTractIndex := capR((prevAddrAVMValue / prevAddrGeo12), (REAL)capZero, 99.0);
	self.version3.PrevAddrBlockIndex := capR((prevAddrAVMValue / prevAddrGeo11), (REAL)capZero, 99.0);
	
	attendedCollege := map(	le.student.file_type='H' => '1', 
													le.student.file_type='C' => '1',
													le.student.file_type='M' and (le.student.college_code<>'' or le.student.college_type<>'' or
																												le.student.college_name<>'') => '1',
													'0');
	self.version3.EducationAttendedCollege := attendedCollege;
	self.version3.EducationProgram2Yr := map(le.student.file_type='' => '',
																					 le.student.college_code = '2' => '1',
																					'0');
	self.version3.EducationProgram4Yr := map(le.student.file_type='' => '',
																					 le.student.college_code = '4' => '1',
																					'0');
	self.version3.EducationProgramGraduate := map(le.student.file_type='' => '',
																								le.student.college_code = '1' => '1',
																								'0');
	self.version3.EducationInstitutionPrivate := map(le.student.file_type='' => '',
																										le.student.college_type = 'P' => '1',
																										le.student.college_type = 'R' => '1',
																										'0');
	self.version3.EducationInstitutionRating := if(attendedCollege='1', le.student.college_tier, '');		// if didn't attended college then null 
	
	self.version3.PredictedAnnualIncome := TRIM((string)le.estimated_income);
	
	self.version3.PropNewestSalePrice := capU(le.address_verification.recent_property_sales.sale_price1, capZero, capMax);
	self.version3.PropNewestSalePurchaseIndex := capR((le.address_verification.recent_property_sales.sale_price1 / le.address_verification.recent_property_sales.prev_purch_price1), (REAL)capZero, 99.0); // sale price / purchase price

	self.version3.SubPrimeSolicitedCount := capU(le.impulse.count, capZero, cap255); 
	self.version3.SubPrimeSolicitedCount01 := capU(le.impulse.count30, capZero, cap255);
	self.version3.SubprimeSolicitedCount03 := capU(le.impulse.count90, capZero, cap255);
	self.version3.SubprimeSolicitedCount06 := capU(le.impulse.count180, capZero, cap255);
	self.version3.SubPrimeSolicitedCount12 := capU(le.impulse.count12, capZero, cap255);
	self.version3.SubPrimeSolicitedCount24 := capU(le.impulse.count24, capZero, cap255);
	self.version3.SubPrimeSolicitedCount36 := capU(le.impulse.count36, capZero, cap255);
	self.version3.SubPrimeSolicitedCount60 := capU(le.impulse.count60, capZero, cap255);
	
	self.version3.LienFederalTaxFiledTotal := capU(le.liens.liens_unreleased_federal_tax.total_amount, capZero, capMax);
	self.version3.LienTaxOtherFiledTotal := capU(le.liens.liens_unreleased_other_tax.total_amount, capZero, capMax);
	self.version3.LienForeclosureFiledTotal := capU(le.liens.liens_unreleased_foreclosure.total_amount, capZero, capMax);
	self.version3.LienPreforeclosureFiledTotal := capU(le.liens.liens_unreleased_lispendens.total_amount, capZero, capMax);
	self.version3.LienLandlordTenantFiledTotal := capU(le.liens.liens_unreleased_landlord_tenant.total_amount, capZero, capMax);
	self.version3.LienJudgmentFiledTotal := capU(le.liens.liens_unreleased_civil_judgment.total_amount, capZero, capMax);
	self.version3.LienSmallClaimsFiledTotal := capU(le.liens.liens_unreleased_small_claims.total_amount, capZero, capMax);
	self.version3.LienOtherFiledTotal := capU(le.liens.liens_unreleased_other_lj.total_amount, capZero, capMax);
	
	self.version3.LienFederalTaxReleasedTotal := capU(le.liens.liens_released_federal_tax.total_amount, capZero, capMax);
	self.version3.LienTaxOtherReleasedTotal := capU(le.liens.liens_released_other_tax.total_amount, capZero, capMax);
	self.version3.LienForeclosureReleasedTotal := capU(le.liens.liens_released_foreclosure.total_amount, capZero, capMax);
	self.version3.LienPreforeclosureReleasedTotal := capU(le.liens.liens_released_lispendens.total_amount, capZero, capMax);
	self.version3.LienLandlordTenantReleasedTotal := capU(le.liens.liens_released_landlord_tenant.total_amount, capZero, capMax);
	self.version3.LienJudgmentReleasedTotal := capU(le.liens.liens_released_civil_judgment.total_amount, capZero, capMax);
	self.version3.LienSmallClaimsReleasedTotal := capU(le.liens.liens_released_small_claims.total_amount, capZero, capMax);
	self.version3.LienOtherReleasedTotal := capU(le.liens.liens_released_other_lj.total_amount, capZero, capMax);
	
	self.version3.LienFederalTaxFiledCount := capU(le.liens.liens_unreleased_federal_tax.count, capZero, cap255);
	self.version3.LienTaxOtherFiledCount := capU(le.liens.liens_unreleased_other_tax.count, capZero, cap255);
	self.version3.LienForeclosureFiledCount := capU(le.liens.liens_unreleased_foreclosure.count, capZero, cap255);
	self.version3.LienPreforeclosureFiledCount := capU(le.liens.liens_unreleased_lispendens.count, capZero, cap255);
	self.version3.LienLandlordTenantFiledCount := capU(le.liens.liens_unreleased_landlord_tenant.count, capZero, cap255);
	self.version3.LienJudgmentFiledCount := capU(le.liens.liens_unreleased_civil_judgment.count, capZero, cap255);
	self.version3.LienSmallClaimsFiledCount := capU(le.liens.liens_unreleased_small_claims.count, capZero, cap255);
	self.version3.LienOtherFiledCount := capU(le.liens.liens_unreleased_other_lj.count, capZero, cap255);
	
	self.version3.LienFederalTaxReleasedCount := capU(le.liens.liens_released_federal_tax.count, capZero, cap255);
	self.version3.LienTaxOtherReleasedCount := capU(le.liens.liens_released_other_tax.count, capZero, cap255);
	self.version3.LienForeclosureReleasedCount := capU(le.liens.liens_released_foreclosure.count, capZero, cap255);
	self.version3.LienPreforeclosureReleasedCount := capU(le.liens.liens_released_lispendens.count, capZero, cap255);
	self.version3.LienLandlordTenantReleasedCount := capU(le.liens.liens_released_landlord_tenant.count, capZero, cap255);
	self.version3.LienJudgmentReleasedCount := capU(le.liens.liens_released_civil_judgment.count, capZero, cap255);
	self.version3.LienSmallClaimsReleasedCount := capU(le.liens.liens_released_small_claims.count, capZero, cap255);
	self.version3.LienOtherReleasedCount := capU(le.liens.liens_released_other_lj.count, capZero, cap255);
	
	self.version3.ProfLicTypeCategory := if(le.professional_license.proflic_count=0, '', le.professional_license.plcategory);

	self.version3.PhoneEDAAgeOldestRecord := getMin(if(le.phone_verification.gong_did.gong_adl_dt_first_seen_full='', '', (string)round((ut.DaysApart((string)le.phone_verification.gong_did.gong_adl_dt_first_seen_full, ageDate)) / 30)), (STRING)capZero, cap960);
	self.version3.PhoneEDAAgeNewestRecord := getMin(if(le.phone_verification.gong_did.gong_adl_dt_last_seen_full='', '', (string)round((ut.DaysApart((string)le.phone_verification.gong_did.gong_adl_dt_last_seen_full, ageDate)) / 30)), (STRING)capZero, cap960);
	
	// this is using the infutor by DID and not the infutor by phone
	self.version3.PhoneOtherAgeOldestRecord := getMin(if(le.infutor.infutor_date_first_seen=0, '', (string)round((ut.DaysApart((string)le.infutor.infutor_date_first_seen, (string)sysdate)) / 30)), (STRING)capZero, cap960);
	self.version3.PhoneOtherAgeNewestRecord := getMin(if(le.infutor.infutor_date_last_seen=0, '', (string)round((ut.DaysApart((string)le.infutor.infutor_date_last_seen, (string)sysdate)) / 30)), (STRING)capZero, cap960);

	self.version3.PrescreenOptOut := map(~isPreScreen => '',
																			 opt_out_hit => '1',
																			 '0');
																			 
	// Address Append Attributes - only populate when DoAddressAppend is enabled in BSOptions
	SELF.version3.AddrAppendInputCurr := MAP(DoAddressAppend = TRUE AND 
										(INTEGER)le.Shell_Input.in_zipCode <= 0 AND // No address was found from the Address Hierarchy key - there is no address information on file
										le.ADL_Shell_Flags.adl_addr = Risk_Indicators.iid_constants.AddressAppendMatchLevel.AddressHierarchyResult	=> '0', // Address Append utilized, but no information on file
										DoAddressAppend = TRUE AND 
										le.ADL_Shell_Flags.adl_addr IN [Risk_Indicators.iid_constants.AddressAppendMatchLevel.StreetNumAndZip5, 
																										Risk_Indicators.iid_constants.AddressAppendMatchLevel.JustZip5]							=> '1', // Input partial address used for the calculation of the attributes
										DoAddressAppend = TRUE AND 
										le.ADL_Shell_Flags.adl_addr = Risk_Indicators.iid_constants.AddressAppendMatchLevel.AddressHierarchyResult	=> '2', // Most recent address used for the calculation of the attributes
																																																																	 ''); // Address not input (Zip5 required as absolute minimum for Address Append), or Address Append functionality not utilized
	SELF.version3.AddrAppendStreetAddress := IF(DoAddressAppend = FALSE, '', le.Shell_Input.in_streetAddress); // Since DoAddressAppend turns on the ADL Shell, whatever was found for address is in the Shell_Input section
	SELF.version3.AddrAppendCity := IF(DoAddressAppend = FALSE, '', le.Shell_Input.in_city);
	SELF.version3.AddrAppendState := IF(DoAddressAppend = FALSE, '', le.Shell_Input.in_state);
	SELF.version3.AddrAppendZip := IF(DoAddressAppend = FALSE, '', le.Shell_Input.in_zipCode[1..5]);

	self.v4_AgeOldestRecord                                 := attr.AgeOldestRecord_buildDate;
	self.v4_AgeNewestRecord                                 := attr.AgeNewestRecord_buildDate;
	self.v4_RecentUpdate                                    := attr.RecentUpdate_buildDate;
	self.v4_SrcsConfirmIDAddrCount                          := attr.SrcsConfirmIDAddrCount;
	self.v4_InvalidDL                                       := attr.InvalidDL;
	self.v4_VerificationFailure                             := attr.FCRAVerificationFailure;
	self.v4_SSNNotFound                                     := attr.SSNNotFound;
	self.v4_VerifiedName                                    := attr.VerifiedName;
	self.v4_VerifiedSSN                                     := attr.VerifiedSSN;
	self.v4_VerifiedPhone                                   := attr.VerifiedPhone;
	self.v4_VerifiedAddress                                 := attr.VerifiedAddress;
	self.v4_VerifiedDOB                                     := attr.VerifiedDOB;
	self.v4_InferredMinimumAge                              := attr.InferredMinimumAge(isPreScreen);
	self.v4_BestReportedAge                                 := attr.BestReportedAge(isPreScreen);
	self.v4_SubjectSSNCount                                 := attr.SubjectSSNCount;
	self.v4_SubjectAddrCount                                := attr.SubjectAddrCount;
	self.v4_SubjectPhoneCount                               := attr.SubjectPhoneCount;
	self.v4_SubjectSSNRecentCount                           := attr.SubjectSSNRecentCount;
	self.v4_SubjectAddrRecentCount                          := attr.SubjectAddrRecentCount;
	self.v4_SubjectPhoneRecentCount                         := attr.SubjectPhoneRecentCount;
	self.v4_SSNIdentitiesCount                              := attr.SSNIdentitiesCount;
	self.v4_SSNAddrCount                                    := attr.SSNAddrCount;
	self.v4_SSNIdentitiesRecentCount                        := attr.SSNIdentitiesRecentCount;
	self.v4_SSNAddrRecentCount                              := attr.SSNAddrRecentCount;
	self.v4_InputAddrPhoneCount                             := attr.InputAddrPhoneCount;
	self.v4_InputAddrPhoneRecentCount                       := attr.InputAddrPhoneRecentCount;
	self.v4_PhoneIdentitiesCount                            := attr.PhoneIdentitiesCount;
	self.v4_PhoneIdentitiesRecentCount                      := attr.PhoneIdentitiesRecentCount;
	self.v4_SSNAgeDeceased                                  := attr.SSNAgeDeceased;
	self.v4_SSNRecent                                       := attr.SSNRecent;
	self.v4_SSNLowIssueAge                                  := attr.SSNLowIssueAge;
	self.v4_SSNHighIssueAge                                 := attr.SSNHighIssueAge;
	self.v4_SSNIssueState                                   := attr.SSNIssueState;
	self.v4_SSNNonUS                                        := attr.SSNNonUS;
	self.v4_SSN3Years                                       := attr.SSN3Years;
	self.v4_SSNAfter5                                       := attr.SSNAfter5 ;
	self.v4_SSNProblems                                     := attr.SSNProblems;
	self.v4_InputAddrAgeOldestRecord                        := attr.InputAddrAgeOldestRecord_buildDate;
	self.v4_InputAddrAgeNewestRecord                        := attr.InputAddrAgeNewestRecord_buildDate;
	self.v4_InputAddrHistoricalMatch                        := attr.InputAddrHistoricalMatch;
	self.v4_InputAddrLenOfRes                               := attr.InputAddrLenOfRes_buildDate ;
	self.v4_InputAddrDwellType                              := attr.InputAddrDwellType ;
	self.v4_InputAddrDelivery                               := attr.InputAddrDelivery;
	self.v4_InputAddrApplicantOwned                         := attr.InputAddrApplicantOwned;
	self.v4_InputAddrFamilyOwned                            := attr.InputAddrFamilyOwned;
	self.v4_InputAddrOccupantOwned                          := attr.InputAddrOccupantOwned ;
	self.v4_InputAddrAgeLastSale                            := attr.InputAddrAgeLastSale;
	self.v4_InputAddrLastSalesPrice                         := attr.InputAddrLastSalesPrice;
	self.v4_InputAddrMortgageType                           := attr.InputAddrMortgageType;
	self.v4_InputAddrNotPrimaryRes                          := attr.InputAddrNotPrimaryRes ;
	self.v4_InputAddrActivePhoneList                        := attr.InputAddrActivePhoneList ;
	self.v4_InputAddrTaxValue                               := attr.InputAddrTaxValue ;
	self.v4_InputAddrTaxYr                                  := attr.InputAddrTaxYr;
	self.v4_InputAddrTaxMarketValue                         := attr.InputAddrTaxMarketValue;
	self.v4_InputAddrAVMValue                               := attr.InputAddrAVMValue;
	self.v4_InputAddrAVMValue12                             := attr.InputAddrAVMValue12;
	self.v4_InputAddrAVMValue60                             := attr.InputAddrAVMValue60;
	self.v4_InputAddrCountyIndex                            := attr.InputAddrCountyIndex;
	self.v4_InputAddrTractIndex                             := attr.InputAddrTractIndex;
	self.v4_InputAddrBlockIndex                             := attr.InputAddrBlockIndex;
	self.v4_CurrAddrAgeOldestRecord                         := attr.CurrAddrAgeOldestRecord_buildDate;
	self.v4_CurrAddrAgeNewestRecord                         := attr.CurrAddrAgeNewestRecord_buildDate;
	self.v4_CurrAddrLenOfRes                                := attr.CurrAddrLenOfRes_buildDate ;
	self.v4_CurrAddrDwellType                               := attr.CurrAddrDwellType ;
	self.v4_CurrAddrApplicantOwned                          := attr.CurrAddrApplicantOwned ;
	self.v4_CurrAddrFamilyOwned                             := attr.CurrAddrFamilyOwned ;
	self.v4_CurrAddrOccupantOwned                           := attr.CurrAddrOccupantOwned ;
	self.v4_CurrAddrAgeLastSale                             := attr.CurrAddrAgeLastSale;
	self.v4_CurrAddrLastSalesPrice                          := attr.CurrAddrLastSalesPrice;
	self.v4_CurrAddrMortgageType                            := attr.CurrAddrMortgageType;
	self.v4_CurrAddrActivePhoneList                         := attr.CurrAddrActivePhoneList ;
	self.v4_CurrAddrTaxValue                                := attr.CurrAddrTaxValue ;
	self.v4_CurrAddrTaxYr                                   := attr.CurrAddrTaxYr;
	self.v4_CurrAddrTaxMarketValue                          := attr.CurrAddrTaxMarketValue;
	self.v4_CurrAddrAVMValue                                := attr.CurrAddrAVMValue;
	self.v4_CurrAddrAVMValue12                              := attr.CurrAddrAVMValue12;
	self.v4_CurrAddrAVMValue60                              := attr.CurrAddrAVMValue60;
	self.v4_CurrAddrCountyIndex                             := attr.CurrAddrCountyIndex;
	self.v4_CurrAddrTractIndex                              := attr.CurrAddrTractIndex;
	self.v4_CurrAddrBlockIndex                              := attr.CurrAddrBlockIndex;
	self.v4_PrevAddrAgeOldestRecord                         := attr.PrevAddrAgeOldestRecord_buildDate;
	self.v4_PrevAddrAgeNewestRecord                         := attr.PrevAddrAgeNewestRecord_buildDate;
	self.v4_PrevAddrLenOfRes                                := attr.PrevAddrLenOfRes_buildDate ;
	self.v4_PrevAddrDwellType                               := attr.PrevAddrDwellType ;
	self.v4_PrevAddrApplicantOwned                          := attr.PrevAddrApplicantOwned ;
	self.v4_PrevAddrFamilyOwned                             := attr.PrevAddrFamilyOwned ;
	self.v4_PrevAddrOccupantOwned                           := attr.PrevAddrOccupantOwned;
	self.v4_PrevAddrAgeLastSale                             := attr.PrevAddrAgeLastSale;
	self.v4_PrevAddrLastSalesPrice                          := attr.PrevAddrLastSalesPrice;
	self.v4_PrevAddrTaxValue                                := attr.PrevAddrTaxValue;
	self.v4_PrevAddrTaxYr                                   := attr.PrevAddrTaxYr;
	self.v4_PrevAddrTaxMarketValue                          := attr.PrevAddrTaxMarketValue;
	self.v4_PrevAddrAVMValue                                := attr.PrevAddrAVMValue;
	self.v4_PrevAddrCountyIndex                             := attr.PrevAddrCountyIndex;
	self.v4_PrevAddrTractIndex                              := attr.PrevAddrTractIndex;
	self.v4_PrevAddrBlockIndex                              := attr.PrevAddrBlockIndex;
	self.v4_AddrMostRecentDistance                          := attr.AddrMostRecentDistance;
	self.v4_AddrMostRecentStateDiff                         := attr.AddrMostRecentStateDiff;
	self.v4_AddrMostRecentTaxDiff                           := attr.AddrMostRecentTaxDiff;
	self.v4_AddrMostRecentMoveAge                           := attr.AddrMostRecentMoveAge_buildDate;          
	self.v4_AddrRecentEconTrajectory                        := attr.AddrRecentEconTrajectory;
	self.v4_AddrRecentEconTrajectoryIndex                   := attr.AddrRecentEconTrajectoryIndex;
	self.v4_EducationAttendedCollege                        := attr.EducationAttendedCollege;
	self.v4_EducationProgram2Yr                             := attr.EducationProgram2Yr;
	self.v4_EducationProgram4Yr                             := attr.EducationProgram4Yr;
	self.v4_EducationProgramGraduate                        := attr.EducationProgramGraduate;
	self.v4_EducationInstitutionPrivate                     := attr.EducationInstitutionPrivate;
	self.v4_EducationFieldofStudyType                       := attr.EducationFieldofStudyType;
	self.v4_EducationInstitutionRating                      := attr.EducationInstitutionRating;
	self.v4_AddrStability                                   := attr.AddrStability ;
	self.v4_StatusMostRecent                                := attr.StatusMostRecent ;
	self.v4_StatusPrevious                                  := attr.StatusPrevious ;
	self.v4_StatusNextPrevious                              := attr.StatusNextPrevious;
	self.v4_AddrChangeCount01                               := attr.AddrChangeCount01;
	self.v4_AddrChangeCount03                               := attr.AddrChangeCount03;
	self.v4_AddrChangeCount06                               := attr.AddrChangeCount06;
	self.v4_AddrChangeCount12                               := attr.AddrChangeCount12;
	self.v4_AddrChangeCount24                               := attr.AddrChangeCount24 ;
	self.v4_AddrChangeCount60                               := attr.AddrChangeCount60 ;
	self.v4_EstimatedAnnualIncome                           := attr.EstimatedAnnualIncome;
	self.v4_PropertyOwner                                   := attr.PropertyOwner;
	self.v4_PropOwnedCount                                  := attr.PropOwnedCount;
	self.v4_PropOwnedTaxTotal                               := attr.PropOwnedTaxTotal;
	self.v4_PropOwnedHistoricalCount                        := attr.PropOwnedHistoricalCount;
	self.v4_PropAgeOldestPurchase                           := attr.PropAgeOldestPurchase;
	self.v4_PropAgeNewestPurchase                           := attr.PropAgeNewestPurchase;
	self.v4_PropAgeNewestSale                               := attr.PropAgeNewestSale;
	self.v4_PropNewestSalePrice                             := attr.PropNewestSalePrice;
	self.v4_PropNewestSalePurchaseIndex                     := attr.PropNewestSalePurchaseIndex;
	self.v4_PropPurchasedCount01                            := attr.PropPurchasedCount01;
	self.v4_PropPurchasedCount03                            := attr.PropPurchasedCount03;
	self.v4_PropPurchasedCount06                            := attr.PropPurchasedCount06;
	self.v4_PropPurchasedCount12                            := attr.PropPurchasedCount12;
	self.v4_PropPurchasedCount24                            := attr.PropPurchasedCount24;
	self.v4_PropPurchasedCount60                            := attr.PropPurchasedCount60;
	self.v4_PropSoldCount01                                 := attr.PropSoldCount01;
	self.v4_PropSoldCount03                                 := attr.PropSoldCount03;
	self.v4_PropSoldCount06                                 := attr.PropSoldCount06;
	self.v4_PropSoldCount12                                 := attr.PropSoldCount12;
	self.v4_PropSoldCount24                                 := attr.PropSoldCount24 ;
	self.v4_PropSoldCount60                                 := attr.PropSoldCount60 ;
	self.v4_AssetOwner                                      := attr.AssetOwner;
	self.v4_WatercraftOwner                                 := attr.WatercraftOwner;
	self.v4_WatercraftCount                                 := attr.WatercraftCount;
	self.v4_WatercraftCount01                               := attr.WatercraftCount01;
	self.v4_WatercraftCount03                               := attr.WatercraftCount03;
	self.v4_WatercraftCount06                               := attr.WatercraftCount06;
	self.v4_WatercraftCount12                               := attr.WatercraftCount12 ;
	self.v4_WatercraftCount24                               := attr.WatercraftCount24;
	self.v4_WatercraftCount60                               := attr.WatercraftCount60 ;
	self.v4_AircraftOwner                                   := attr.AircraftOwner;
	self.v4_AircraftCount                                   := attr.AircraftCount;
	self.v4_AircraftCount01                                 := attr.AircraftCount01;
	self.v4_AircraftCount03                                 := attr.AircraftCount03;
	self.v4_AircraftCount06                                 := attr.AircraftCount06;
	self.v4_AircraftCount12                                 := attr.AircraftCount12 ;
	self.v4_AircraftCount24                                 := attr.AircraftCount24;
	self.v4_AircraftCount60                                 := attr.AircraftCount60 ;
	self.v4_WealthIndex                                     := attr.WealthIndex ;
	self.v4_BusinessActiveAssociation                       := attr.BusinessActiveAssociation;
	self.v4_BusinessInactiveAssociation                     := attr.BusinessInactiveAssociation;
	self.v4_BusinessAssociationAge                          := attr.BusinessAssociationAge;
	self.v4_BusinessTitle                                   := attr.BusinessTitle;
	self.v4_DerogSeverityIndex                              := attr.DerogSeverityIndex;
	self.v4_DerogCount                                      := attr.DerogCount;
	self.v4_DerogRecentCount                                := attr.DerogRecentCount;
	self.v4_DerogAge                                        := attr.DerogAge;
	self.v4_FelonyCount                                     := attr.FelonyCount;
	self.v4_FelonyAge                                       := attr.FelonyAge;
	self.v4_FelonyCount01                                   := attr.FelonyCount01;
	self.v4_FelonyCount03                                   := attr.FelonyCount03;
	self.v4_FelonyCount06                                   := attr.FelonyCount06;
	self.v4_FelonyCount12                                   := attr.FelonyCount12;
	self.v4_FelonyCount24                                   := attr.FelonyCount24;
	self.v4_FelonyCount60                                   := attr.FelonyCount60;
	self.v4_LienCount                                       := attr.LienCount;
	self.v4_LienFiledCount                                  := attr.LienFiledCount;
	self.v4_LienFiledAge                                    := attr.LienFiledAge;
	self.v4_LienFiledCount01                                := attr.LienFiledCount01;
	self.v4_LienFiledCount03                                := attr.LienFiledCount03;
	self.v4_LienFiledCount06                                := attr.LienFiledCount06;
	self.v4_LienFiledCount12                                := attr.LienFiledCount12;
	self.v4_LienFiledCount24                                := attr.LienFiledCount24;
	self.v4_LienFiledCount60                                := attr.LienFiledCount60;
	self.v4_LienReleasedCount                               := attr.LienReleasedCount;
	self.v4_LienReleasedAge                                 := attr.LienReleasedAge;
	self.v4_LienReleasedCount01                             := attr.LienReleasedCount01;
	self.v4_LienReleasedCount03                             := attr.LienReleasedCount03;
	self.v4_LienReleasedCount06                             := attr.LienReleasedCount06;
	self.v4_LienReleasedCount12                             := attr.LienReleasedCount12;
	self.v4_LienReleasedCount24                             := attr.LienReleasedCount24;
	self.v4_LienReleasedCount60                             := attr.LienReleasedCount60;
	self.v4_LienFiledTotal                                  := attr.LienFiledTotal;
	self.v4_LienFederalTaxFiledTotal                        := attr.LienFederalTaxFiledTotal;
	self.v4_LienTaxOtherFiledTotal                          := attr.LienTaxOtherFiledTotal;
	self.v4_LienForeclosureFiledTotal                       := attr.LienForeclosureFiledTotal;
	self.v4_LienLandlordTenantFiledTotal                    := attr.LienLandlordTenantFiledTotal;
	self.v4_LienJudgmentFiledTotal                          := attr.LienJudgmentFiledTotal;
	self.v4_LienSmallClaimsFiledTotal                       := attr.LienSmallClaimsFiledTotal;
	self.v4_LienOtherFiledTotal                             := attr.LienOtherFiledTotal;
	self.v4_LienReleasedTotal                               := attr.LienReleasedTotal;
	self.v4_LienFederalTaxReleasedTotal                     := attr.LienFederalTaxReleasedTotal;
	self.v4_LienTaxOtherReleasedTotal                       := attr.LienTaxOtherReleasedTotal;
	self.v4_LienForeclosureReleasedTotal                    := attr.LienForeclosureReleasedTotal;
	self.v4_LienLandlordTenantReleasedTotal                 := attr.LienLandlordTenantReleasedTotal;
	self.v4_LienJudgmentReleasedTotal                       := attr.LienJudgmentReleasedTotal;
	self.v4_LienSmallClaimsReleasedTotal                    := attr.LienSmallClaimsReleasedTotal;
	self.v4_LienOtherReleasedTotal                          := attr.LienOtherReleasedTotal;
	self.v4_LienFederalTaxFiledCount                        := attr.LienFederalTaxFiledCount;
	self.v4_LienTaxOtherFiledCount                          := attr.LienTaxOtherFiledCount;
	self.v4_LienForeclosureFiledCount                       := attr.LienForeclosureFiledCount;
	self.v4_LienLandlordTenantFiledCount                    := attr.LienLandlordTenantFiledCount;
	self.v4_LienJudgmentFiledCount                          := attr.LienJudgmentFiledCount;
	self.v4_LienSmallClaimsFiledCount                       := attr.LienSmallClaimsFiledCount;
	self.v4_LienOtherFiledCount                             := attr.LienOtherFiledCount;
	self.v4_LienFederalTaxReleasedCount                     := attr.LienFederalTaxReleasedCount;
	self.v4_LienTaxOtherReleasedCount                       := attr.LienTaxOtherReleasedCount;
	self.v4_LienForeclosureReleasedCount                    := attr.LienForeclosureReleasedCount;
	self.v4_LienLandlordTenantReleasedCount                 := attr.LienLandlordTenantReleasedCount;
	self.v4_LienJudgmentReleasedCount                       := attr.LienJudgmentReleasedCount;
	self.v4_LienSmallClaimsReleasedCount                    := attr.LienSmallClaimsReleasedCount;
	self.v4_LienOtherReleasedCount                          := attr.LienOtherReleasedCount;
	self.v4_BankruptcyCount                                 := attr.BankruptcyCount;
	self.v4_BankruptcyAge                                   := attr.BankruptcyAge;
	self.v4_BankruptcyType                                  := attr.BankruptcyType;
	self.v4_BankruptcyStatus                                := attr.BankruptcyStatus;
	self.v4_BankruptcyCount01                               := attr.BankruptcyCount01;
	self.v4_BankruptcyCount03                               := attr.BankruptcyCount03;
	self.v4_BankruptcyCount06                               := attr.BankruptcyCount06;
	self.v4_BankruptcyCount12                               := attr.BankruptcyCount12;
	self.v4_BankruptcyCount24                               := attr.BankruptcyCount24;
	self.v4_BankruptcyCount60                               := attr.BankruptcyCount60;
	self.v4_EvictionCount                                   := attr.EvictionCount;
	self.v4_EvictionAge                                     := attr.EvictionAge;
	self.v4_EvictionCount01                                 := attr.EvictionCount01;
	self.v4_EvictionCount03                                 := attr.EvictionCount03;
	self.v4_EvictionCount06                                 := attr.EvictionCount06;
	self.v4_EvictionCount12                                 := attr.EvictionCount12 ;
	self.v4_EvictionCount24                                 := attr.EvictionCount24 ;
	self.v4_EvictionCount60                                 := attr.EvictionCount60 ;
	self.v4_RecentActivityIndex                             := attr.RecentActivityIndex;
	self.v4_NonDerogCount                                   := attr.NonDerogCount;
	self.v4_NonDerogCount01                                 := attr.NonDerogCount01;
	self.v4_NonDerogCount03                                 := attr.NonDerogCount03;
	self.v4_NonDerogCount06                                 := attr.NonDerogCount06;
	self.v4_NonDerogCount12                                 := attr.NonDerogCount12;
	self.v4_NonDerogCount24                                 := attr.NonDerogCount24;
	self.v4_NonDerogCount60                                 := attr.NonDerogCount60;
	self.v4_VoterRegistrationRecord                         := attr.VoterRegistrationRecord;
	self.v4_ProfLicCount                                    := attr.ProfLicCount;
	self.v4_ProfLicAge                                      := attr.ProfLicAge;
	self.v4_ProfLicType                                     := attr.ProfLicType;
	self.v4_ProfLicTypeCategory                             := attr.ProfLicTypeCategory;
	self.v4_ProfLicExpired                                  := attr.ProfLicExpired;
	self.v4_ProfLicCount01                                  := attr.ProfLicCount01;
	self.v4_ProfLicCount03                                  := attr.ProfLicCount03;
	self.v4_ProfLicCount06                                  := attr.ProfLicCount06;
	self.v4_ProfLicCount12                                  := attr.ProfLicCount12;
	self.v4_ProfLicCount24                                  := attr.ProfLicCount24;
	self.v4_ProfLicCount60                                  := attr.ProfLicCount60;
	self.v4_InquiryCollectionsRecent                        := attr.InquiryCollectionsRecent;
	self.v4_InquiryPersonalFinanceRecent                    := attr.InquiryPersonalFinanceRecent;
	self.v4_InquiryOtherRecent                              := attr.InquiryOtherRecent;
	self.v4_HighRiskCreditActivity                          := attr.HighRiskCreditActivity;
	self.v4_SubPrimeOfferRequestCount                       := attr.SubPrimeOfferRequestCount;
	self.v4_SubPrimeOfferRequestCount01                     := attr.SubPrimeOfferRequestCount01;
	self.v4_SubPrimeOfferRequestCount03                     := attr.SubPrimeOfferRequestCount03;
	self.v4_SubPrimeOfferRequestCount06                     := attr.SubPrimeOfferRequestCount06;
	self.v4_SubPrimeOfferRequestCount12                     := attr.SubPrimeOfferRequestCount12;
	self.v4_SubPrimeOfferRequestCount24                     := attr.SubPrimeOfferRequestCount24;
	self.v4_SubPrimeOfferRequestCount60                     := attr.SubPrimeOfferRequestCount60;
	self.v4_InputPhoneMobile                                := attr.InputPhoneMobile ;
	self.v4_PhoneEDAAgeOldestRecord                         := attr.PhoneEDAAgeOldestRecord;
	self.v4_PhoneEDAAgeNewestRecord                         := attr.PhoneEDAAgeNewestRecord;
	self.v4_PhoneOtherAgeOldestRecord                       := attr.PhoneOtherAgeOldestRecord;
	self.v4_PhoneOtherAgeNewestRecord                       := attr.PhoneOtherAgeNewestRecord;
	self.v4_InputPhoneHighRisk                              := attr.InputPhoneHighRisk;
	self.v4_InputPhoneProblems                              := attr.InputPhoneProblems;
	self.v4_EmailAddress                                    := attr.EmailAddress;
	self.v4_InputAddrHighRisk                               := attr.InputAddrHighRisk;
	self.v4_CurrAddrCorrectional                            := attr.CurrAddrCorrectional;
	self.v4_PrevAddrCorrectional                            := attr.PrevAddrCorrectional;
	self.v4_HistoricalAddrCorrectional                      := attr.HistoricalAddrCorrectional;
	self.v4_InputAddrProblems                               := attr.InputAddrProblems;
	self.v4_SecurityFreeze                                  := attr.SecurityFreeze;
	self.v4_SecurityAlert                                   := attr.SecurityAlert;
	self.v4_IDTheftFlag                                     := attr.IDTheftFlag;
	self.v4_ConsumerStatement                               := attr.ConsumerStatement;
	self.v4_PrescreenOptOut                                 := attr.PrescreenOptOut(isPreScreen, opt_out_hit);



END;
out := project(clam, intoAttributes(left));

return out;

END;