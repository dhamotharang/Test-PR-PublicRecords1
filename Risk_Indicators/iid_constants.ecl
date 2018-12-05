import ut, risk_indicators, header, mdr, suppress, did_add, doxie, fcra, riskwise, STD;

// line 4 and line 9 are 2 different constants.  one is the date as a string, the other is a date as unsigned value.  
// to toggle the system date, update both of them to the date you want the system to be.

todays_date := (string) STD.Date.Today();

export iid_constants := module

export TodayDate := Std.Date.Today();  // use a constant risk_indicators.iid_constants.TodayDate so we can easily toggle the system date for testing all in one attribute

/* This code was inserted as a temporary solution */
export integer monthsApart_YYYYMMDD_legacy(string8 d1, string8 d2, boolean roundUpPartial = false) := FUNCTION
	early := MIN(d1, d2);
	late := MAX(d1, d2);
  yrs := ((integer)late[1..4] - (integer)early[1..4]) * 12;
	months := (integer)late[5..6] - (integer)early[5..6];
  // round up partial month if requested
	partial := if(roundUpPartial and (integer) late[7..8] > (integer) early[7..8], 1, 0);
	
	return yrs + months + partial;
end;


export glb_ok(unsigned glb, boolean isFCRA) := glb > 0 and glb < 8 or glb=11 or glb=12 or isFCRA;
export dppa_ok(unsigned dppa, boolean isFCRA) := dppa > 0 and dppa < 8 or isFCRA;
export fares_ok(string50 DataRestrictionMask, boolean isFCRA) := DataRestrictionMask[1] <> '1' and ~isFCRA;
export min_score := 80;
export min_FCRA_did_score := 80;
export min_addrscore := 80;
export min_numscore := 90;
export min_cmpyscore := 65;
export default_empty_score := 255;
export default_history_date := 999999;
export g(UNSIGNED1 i) := i BETWEEN min_score AND 100;
export ga(UNSIGNED1 i) := i BETWEEN min_addrscore AND 100;
export gn(UNSIGNED1 I) := i BETWEEN min_numscore AND 100;
export gc(UNSIGNED1 I) := i BETWEEN min_cmpyscore AND 100;
export tscore(UNSIGNED1 i) := IF(i=default_empty_score,0,i);
export unsigned4 MAX_OVERRIDE_LIMIT := 1000;
export STRING1 good := 'G';

// convert ACE address type into dwelltype
export dwelltype(STRING1 addrtype) := MAP(addrtype='G' => 'S',
										addrtype='H' => 'A',
										addrtype='P' => 'E',
										addrtype='R' => 'R',
										addrtype='S' => ' ', 
										'');
					  		
export invalidSet := ['E101','E212','E213','E214','E216','E302','E412','E413','E420',
											'E421','E423','E500','E501','E502','E503','E600'];	// added E600 6/6/2005 per Jim C.
							 
export ambiguousSet := ['E422','E425','E427','E428','E429','E430','E431','E504'];
	
export addrvalflag(STRING4 stat) := MAP( stat IN invalidSet => 'N',  
																				 stat IN ambiguousSet => 'M',
																				 stat = '' => '',
																				 'V');	
																				 
export full_history_date(unsigned3 history_date) := (STRING6)history_date+'01';
export myGetDate(unsigned3 history_date) := IF(history_date=999999,todays_date,full_history_date(history_date));
export defaultTimeStamp := '01 12010100';

export myGetDateTimestamp(string historydateTimeStamp, unsigned3 history_date) := function
	historydateTimeStamp_trim := trim(historydateTimeStamp);
	
	ts := map(historydateTimeStamp_trim='' and history_date=999999 => todays_date + ' ' + ut.getTimeStamp()[1..8],
						historydateTimeStamp_trim='' and history_date<>999999 => (string)history_date + defaultTimeStamp  , // hard code 01 as the day, and hard code the time
						historydateTimeStamp_trim[1..6] = '999999' => todays_date + ' ' + ut.getTimeStamp()[1..8],	//even though this should be an 8 digit date, account for if only 6 nines are passed in to indicate current
					  historydateTimeStamp_trim<>'' and length(historydateTimeStamp_trim)=6 => historydatetimestamp[1..6] + defaultTimeStamp, // YYYYMM support for historydatetimestamp
						historydatetimestamp);  // otherwise, simply use the full timestamp the user sent in
	return ts;
end;

export fiveMonths := 153;
export sixmonths := 183;
export elevenMonths := 336;
export oneyear := 365;
export eighteenmonths := 540;
export twentythreeMonths := 702;
export twoyears := 731;
export thirtyfiveMonths := 1068;
export threeyears := 1096;
export fiftynineMonths := 1796;
export fiveyears := 1826;
export nineyears := 3287;
export tenyears := 3653;
export fifteenyears := 5479;
export max_unsigned3 := 16777215;
export randomSSN1Year := 201206;
export randomSSN3Years := 201406;

export myDaysApart(unsigned3 history_date, string8 d2, unsigned3 LastSeenThreshold = oneyear) := ut.DaysApart(myGetDate(history_date), d2) <= LastSeenThreshold OR (unsigned)d2 >= (unsigned)myGetDate(history_date);

// when in history mode, also double check that history_date greater than date being compared to.
export checkDays(string8 d1, string8 d2, unsigned2 days, unsigned3 history_date) := if(history_date=default_history_date, 
								ut.DaysApart(d1,d2) <= days,  
								ut.DaysApart(d1,d2) <= days and d1>=d2);

export checkingDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;
						
export layout_outx := RECORD
	risk_indicators.layout_output;
	header.layout_header h;
END;

export basic_shell_version := 1;

export adl_based_modeling_flags := record
	integer1 in_addrpop := 0;  // was address populated on input from consumer
	integer1 in_hphnpop := 0;	// was hphone populated on input from consumer
	integer1 in_ssnpop := 0;		// was ssn populated on input from consumer
	integer1 in_dobpop := 0;		// was dob populated on input from consumer
	integer1 adl_addr := 0;  	// what do we know from the ADL search
	integer1 adl_hphn := 0;		// what do we know from the ADL search
	integer1 adl_ssn := 0;			// what do we know from the ADL search
	integer1 adl_dob := 0;			// what do we know from the ADL search
	integer1 in_addrpop_found := 0;	// was ssn populated on input from consumer and matched one of our database addresses
	integer1 in_hphnpop_found := 0;	// was hphone populated on input from consumer and matched one of our database phones
end;

export adl_based_layout_output := record
	adl_based_modeling_flags;
	risk_indicators.Layout_Output;	
end;

// to be used in header filtering instead of having this logic in many different places
// don't use experian vehicles or mixed sources
// per bug 175600, bocashell version 50 and higher can now use experian vehicles and DL for header verification
export filtered_source(string2 src,  string2 st, integer bsversion=0) := (src in mdr.sourcetools.set_Experian_dl and bsversion < 50) or
																			 (src in mdr.sourcetools.set_Experian_vehicles and bsversion < 50) or 
																			 src in ['MI','MA'] or 
																			 mdr.Source_is_on_Probation(src) or
																			 (src = mdr.sourcetools.src_Voters_v2 and  st = 'AL') or 
																			 src = mdr.sourcetools.src_EMerge_CCW_NY;

																			 
export sTrue := '1';
export sFalse := '0';
export default_ExactMatchLevel := '00000000';  // default to using the scoring thresholds, nothing has to be exact unless specified otherwise
export posExactFirstNameMatch := 1;
export posExactLastNameMatch := 2;
export posExactAddrMatch :=  3;
export posExactPhoneMatch :=  4;
export posExactSSNMatch :=  5;
export posExactDOBMatch :=  6;
export posExactFirstNameMatchNicknameAllowed :=  7;
export posExactDLMatch := 8;
export posExactAddrZip5andPrimRange := 9;

// default to Experian and Transunion, bureau death records and Experian FCRA restricted, currently we're up to 14 restrictions now
export default_DataRestriction := '0000010001001100000000000'; 
export posFaresRestriction := 1;
export posExperianRestriction := 6;
export posCertegyRestriction := 7;
export posEquifaxRestriction := 8;
export posTransUnionRestriction := 10;
export posADVORestriction := 12;
export posBureauDeceasedRestriction := 13;
export posExperianFCRARestriction := 14;
export posExperianPhonesRestriction := 15;
export posInquiriesRestriction := 16;
export posRestrictPreGLB := 23; //this is high level check use other code not just this if checking in future
export posFDNvfRestriction := 25; //FDN Virtual Fraud data
export posLiensJudgRestriction := 41; //Liens/Judgments 

export FDNvf_ok(string DataRestriction) := DataRestriction[posFDNvfRestriction]=sFalse;

// default to no permission granted - this created for SSA Death Master file restrictions as of 3/26/14
export default_DataPermission := '0000000000000';  
export posSSADeathMasterPermission := 10;
export posFDNcftfPermission := 11;	//FDN Contributory Fraud and Test Fraud data
export InsuranceDLPermission := 13;
export deathSSA_ok(string DataPermission) := DataPermission[posSSADeathMasterPermission]=sTrue;
export FDNcftf_ok(string DataPermission) := DataPermission[posFDNcftfPermission]=sTrue;
export InsuranceDL_ok(string DataPermission) := DataPermission[InsuranceDLPermission]=sTrue;

export masked_header_sources(string DataRestriction, boolean isFCRA) := function
		en := if((~isFCRA and DataRestriction[posExperianRestriction]=sTrue) or (isFCRA and DataRestriction[posExperianFCRARestriction] in [sTrue,'']), ['EN'], []);
		eq := if(DataRestriction[posEquifaxRestriction]=sTrue, ['EQ'], []);
		cy := if(DataRestriction[posCertegyRestriction]=sTrue, ['CY'], []);
		tn := if(DataRestriction[posTransUnionRestriction]=sTrue, ['TN'], []);
		all_restrictions := ['MI','MA'] + en + eq + cy + tn;
		return all_restrictions;
end;

export masked_header_sources_all(string DataRestriction, boolean isFCRA) := function
		en := if((~isFCRA and DataRestriction[posExperianRestriction]=sTrue) or (isFCRA and DataRestriction[posExperianFCRARestriction] in [sTrue,'']), ['EN'], []);
		eq := if(DataRestriction[posEquifaxRestriction]=sTrue, ['EQ'], []);
		cy := if(DataRestriction[posCertegyRestriction]=sTrue, ['CY'], []);
		tn := if(DataRestriction[posTransUnionRestriction]=sTrue, ['TN'], []);
		fa := if(DataRestriction[posFaresRestriction]=sTrue, ['FA','FP'], []);
		all_restrictions := ['MI','MA'] + en + eq + cy + tn + fa;
		return all_restrictions;
end;

// this variable needs to be set to FALSE at all times, unless you're debugging for validation in your sandbox
export validation_debug := false;

export PhillipMorrisFilter := 'PM';
//DF-16817 Add new source code for new Experian vehicle states: AR-71,AZ-73,GA-M ,IA-74,KS75,NC-76,RI-77,SD-70,VT-79,WA-YH
export setPhillipMorrisAllowedHeaderSources := ['!E','#E','$E','&E','.E','?E','@E','+E','1X','2X','3X','4X','5X','6X','70','71','73','74','75','76','77','79','7X','8X',
'9X','AD','AE','AV','BE','BX','CD','CE','DD','DE','DS','ED','EE','EN','EQ','EV','FD','FV','GE','HE','ID','IE','IV',
'JE','KD','KE','KV','LE','LT','LV','M ','ME','MV','ND','NE','NV','OD','OE','OV','PD','PE','PV','QE','QV','RE','RV','SD',
'SE','TD','TE','TS','TU','TV','UE','VD','VE','WD','WE','WV','XE','XV','XX','YD','YH','YV','ZE','ZX'];

export ExperianFCRA_Batch := 'EB';
export setExperianBatchAllowedHeaderSources := mdr.sourcetools.set_scoring_FCRA_non_gov + 
																							mdr.sourcetools.set_scoring_FCRA_gov +
																							mdr.sourcetools.set_scoring_FCRA_retro_test;

export comp_nap(boolean firstmatch, boolean lastmatch, boolean addrmatch, boolean phonematch) := 
										map(~firstmatch and ~lastmatch and ~addrmatch and phonematch => 1,
												firstmatch and lastmatch and ~addrmatch and ~phonematch => 2,
												firstmatch and ~lastmatch and addrmatch and ~phonematch => 3,
												firstmatch and ~lastmatch and ~addrmatch and phonematch => 4,
												~firstmatch and lastmatch and addrmatch and ~phonematch => 5,
												~firstmatch and ~lastmatch and addrmatch and phonematch => 6,
												~firstmatch and lastmatch and ~addrmatch and phonematch => 7,
												firstmatch and lastmatch and addrmatch and ~phonematch => 8,
												firstmatch and lastmatch and ~addrmatch and phonematch => 9,
												firstmatch and ~lastmatch and addrmatch and phonematch => 10,
												~firstmatch and lastmatch and addrmatch and phonematch => 11,
												firstmatch and lastmatch and addrmatch and phonematch => 12,
												0);
															
export setCivilJudgment_standard := ['CIVIL JUDGMENT','CIVIL NEW FILING','CIVIL SPECIAL JUDGMENT','CIVIL SUIT','CIVIL SUMMONS','COURT ORDER','COURT ORDER NO CHANGE',
														'FEDERAL COURT CHANGE OF VENUE','FEDERAL COURT JUDGMENT','FEDERAL COURT NEW FILING','JUDGMENT',
														'JUDGMENT - CHAPTER 7','JUDGMENTS','JUDGMENTS DOCKET','SATISFACTION OF JUDGMENT','SUBSEQUENT JUDGMENT',
														'CIVIL DISMISSAL','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT DISMISSAL','SATISFIED JUDGMENT'];
//we are not sure if we should remove these 2 from RV - as Report is impacted if we don't use the setCivilJudgment bucket
//JUDGMENT LIEN was not listed in the original setCivilJudgment_standard bucket so that is why it's not listed in setCivilJudgment
export setCivilJudgment := setCivilJudgment_standard + ['JUDGEMENT LIEN','JUDGMENT LIEN RELEASE'];
//we are not sure if we should remove these 2 from RV - as Report is impacted if we don't use the setCivilJudgment bucket
export setCivilJudgment_50 := setCivilJudgment_standard + ['RENEW/REOPEN CIVIL JUDGMENT', 'RENEWED CIVIL JUDGMENT'];
export setFederalTax := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
export setForeclosure := ['FORECLOSURE (JUDGMENT)','FORECLOSURE NEW FILING','FORECLOSURE DISMISSED','FORECLOSURE SATISFIED','VACATED FORECLOSURE'];
//not sure if this is for RV
export setForeclosure_50 := setForeclosure + ['FORECLOSURE', 'FORECLOSURE PAID'];
export setLandlordTenant := ['FORCIBLE ENTRY/DETAINER','LANDLORD TENANT JUDGMENT','LANDLORD TENANT SUIT','FORCIBLE ENTRY/DETAINER RELEAS'];
//not sure if we want this added for RV
export setLandlordTenant_50 := setLandlordTenant + ['FORCIBLE ENTRY/DETAINER RELEASE'];
export setLisPendens := ['LIS PENDENS','LIS PENDENS NOTICE','LIS PENDENS RELEASE','LIS PENDENS WITHDRAWAL'];
export setOtherTax := [	'CITY TAX LIEN','COUNTY TAX LIEN','ILLINOIS TAX LIEN','JUDGMENT OR STATE TAX LIEN','PROPERTY TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RENEWAL',
												'STATE TAX WARRANT','STATE TAX WARRANT RENEWED','CITY TAX LIEN RELEASE','COUNTY TAX LIEN RELEASE','ILLINOIS TAX RELEASE',
												'PROPERTY TAX RELEASE','STATE TAX LIEN RELEASE','STATE TAX RELEASE','STATE TAX WARRANT RELEASE'];
export setSmallClaims := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
//not sure if we want this added to RV
export setSmallClaims_50 := setSmallClaims + ['RENEWED SMALL CLAIM JUDGMENT'];
export setMechanicsLiens := ['MECHANICS LIEN','MECHANICS LIEN RELEASE','MECHANICS LIEN WITHDRAWAL'];
export setOtherLJ := setCivilJudgment + setFederalTax + setLandlordTenant + setOtherTax + setSmallClaims + setForeclosure + setLisPendens;
export setOtherLJ_50 := setCivilJudgment_50 + setFederalTax + setLandlordTenant_50 + setOtherTax + setSmallClaims_50 + setForeclosure_50;

export setStateTax := ['JUDGMENT OR STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RENEWAL', 'STATE TAX WARRANT',
											'STATE TAX WARRANT RENEWED', 'STATE TAX LIEN RELEASE', 'STATE TAX RELEASE', 'STATE TAX WARRANT RELEASE'];
export setAllTax := setFederalTax + setOtherTax;
// export setLJLisPendens := ['LIS PENDENS','LIS PENDENS RELEASE'];

// new for shell 5.0 - Juli and RV use these
export setSuits := ['CIVIL NEW FILING','CIVIL SUIT','FEDERAL COURT NEW FILING','LIS PENDENS NOTICE','LANDLORD TENANT SUIT',
	'CIVIL SUMMONS'];
export setSuitsFCRA_exceptions := ['COURT ORDER', 'FORECLOSURE NEW FILING', 'JUDGMENT- CHAPTER 7','LIS PENDENS','LIS PENDENS RELEASE'];
export setSuitsFCRA := setSuits + setSuitsFCRA_exceptions;

export set_Invalid_Liens_50 := ['CITY TAX LIEN FILED IN ERROR','CIVIL DISMISSAL','COURT ORDER NO CHANGE','DISMISSED JUDGMENT','FEDERAL COURT CHANGE OF VENUE','ERRONEOUS TERMINATION',
'FEDERAL COURT DISMISSAL','FILED IN ERROR-COUNTY TAX LIEN','FILED IN ERROR-FED TAX LIEN','FILED IN ERROR-ST TAX LIEN','FILED IN ERROR-ST TAX WARRANT','FORECLOSURE DISMISSED',
'LIS PENDENS WITHDRAWAL','TERMINATION','VACATED FORECLOSURE','VACATED JUDGMENT'];

//new for Juli: Liens and Judgments for Public Records 
export setValidEviction := ['Y'];
export setPRJudgment := setCivilJudgment_50 + setForeclosure_50 + setSmallClaims_50;// + setLisPendens;
export setPREviction := setLandlordTenant_50 + setValidEviction;
export setOtherLien := ['BUILDING LIEN', 'BUILDING RELEASE', 'BUILDING WITHDRAWAL',
 'CHILD SUPPORT LIEN', 'SIDEWALK LIEN', 'SIDEWALK RELEASE', 'SIDEWALK WITHDRAWAL']; 
export setPRLien := setFederalTax + setOtherTax + setOtherLien + ['JUDGEMENT LIEN','JUDGMENT LIEN RELEASE', 'WELFARE LIEN', 'JUDGMENT LIEN'];
export setPROther := setOtherLJ_50 + setValidEviction + setMechanicsLiens; //we say is NOT in this category

export JudgmentText := 'Judgment';
export EvictionText := 'Eviction';
export LienText := 'Lien';	
export OtherText:= 'Other';

export LienBucket := [LienText];
export JudgmentBucket := [JudgmentText,	EvictionText, OtherText];

export CityLienFltrs := ['CITY TAX LIEN', 'CITY TAX LIEN RELEASE'];
export CountyLienFltrs := ['COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE'];
export StateWarrentFltrs := ['STATE TAX WARRANT','STATE TAX WARRANT RELEASE', 'STATE TAX WARRANT RENEWED'];
export StateTaxLienFltrs := ['STATE TAX LIEN', 'STATE TAX LIEN RELEASE', 'STATE TAX LIEN RENEWAL'];
export FedLienFltrs := ['FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','CORRECTED FEDERAL TAX LIEN'];
export OtherLienFltrs := ['BUILDING LIEN','BUILDING RELEASE','CHILD SUPPORT LIEN',
									'HOSPITAL LIEN','HOSPITAL RELEASE',
									/*'MECHANICS LIEN','MECHANICS LIEN RELEASE',*/'SIDEWALK LIEN',
									'SIDEWALK RELEASE', 
									'JUDGMENT LIEN', 'JUDGEMENT LIEN', 'JUDGMENT LIEN RELEASE',
									//'LIS PENDENS','LIS PENDENS RELEASE'
									'WELFARE LIEN'];
export JudgmentFltrs := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE',
									'CIVIL SPECIAL JUDGMENT', 'CIVIL SPECIAL JUDGMENT RELEASE', 
									'SMALL CLAIMS JUDGMENT', 'SMALL CLAIMS JUDGMENT RELEASE',
									'FEDERAL COURT JUDGMENT','FEDERAL COURT NEW FILING',
									'CIVIL NEW FILING','CIVIL SUIT',
									'CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE',
									'ABSTRACT OF JUDGMENT','GARNISHMENT',
									'GARNISHMENT COLLECT','RENEW/REOPEN CIVIL JUDGMENT',
									'RENEW/REOPEN SMALL CLAIM JUDGM',
									'RENEWED CIVIL JUDGMENT','RENEWED SMALL CLAIM JUDGMENT',
									'WRIT OF ATTACHMENT'];

export EvictionFltrs := ['FORCIBLE ENTRY/DETAINER', 'FORCIBLE ENTRY/DETAINER RELEASE',
									'FORECLOSURE (JUDGMENT)', 'FORECLOSURE NEW FILING',
									'FORECLOSURE SATISFIED','DISMISSED FORECLOSURE','FORECLOSURE',
									'FORCIBLE ENTRY/DETAINER RELEAS','FORECLOSURE PAID'];

export LnJDefault := '11111111';		

export CreateFullName(string title, string fname, string mname, string lname, string name_suffix) := function
 return (if(trim(title) != '', trim(title) + ' ','') +
			if(trim(fname) != '', trim(fname) + ' ','') +
			if(trim(mname) != '', trim(mname) + ' ','') +
			if(trim(lname) != '', trim(lname) + ' ','') +
			if(trim(name_suffix) != '', trim(name_suffix) + ' ',''));
end;

export override_addr_type(string street_addr, string addr_type, string carr_rte) := function
	s := stringlib.stringtouppercase(street_addr);
	checked_rare_PO := if(
		REGEXFIND( '^(P[\\s\\.]*[O0BM]?[\\.\\s]*)?((B([O0]X)?)|X)[\\s\\d\\.#]*', s )  // po boxes (abbreviated)
		OR REGEXFIND( '^POST[\\s\\.]*OFFICE[\\.\\s]*BOX[\\s\\d\\.#]*', s ) // po boxes (spelled out)
		OR carr_rte in ['C770','C771','C772','C773','C774','C775','C776','C777','C778','C779'] ,    // street style addresses flagged by the carrier route       
		'P', addr_type);
	return checked_rare_PO;
end;
//iid logic with chase pio2 logic
export override_addr_type_chase(string street_addr_chase, string addr_type_chase) := function
	s_chase := stringlib.stringtouppercase(street_addr_chase);
	checked_rare_PO_chase := if(
		REGEXFIND( '^(P[\\s\\.]*[O0BM]?[\\.\\s]*)?((B([O0]X)?)|X)[\\s\\d\\.#]*', s_chase )  // po boxes (abbreviated)
		OR REGEXFIND( '^POST[\\s\\.]*OFFICE[\\.\\s]*BOX[\\s\\d\\.#]*', s_chase ) // po boxes (spelled out)
		OR REGEXFIND('((P[\\s\\.]*O[\\.\\s]*)|(POST[\\s]*OFFICE[\\s]*))+BOX',s_chase),
		'P', addr_type_chase);
	return checked_rare_PO_chase;
end;

export ssn_name_match := [4,7,9,10,11,12];

export mortgage_type(boolean fidelity, boolean fares, string mt) := 
												map(fidelity and mt = 'B' => 'CNS',	// map fidelity B to CNS
														fares and mt in ['CNV','C','CON','.NV'] => 'CNV',	// map all these fares codes into CNV
														(fares and mt in ['FHA','F','HFA','=HA']) OR (fidelity and mt = 'F') => 'FHA',	// map all these fares plus fidelity F to FHA
														fares and mt in ['LHM','LH','L'] => 'LHM',	// map these fares to LHM
														fares and mt in ['PMM','PM'] => 'PMM',	// map these fares to PMM
														(fares and mt in ['VA','V','VHA','=A']) OR (fidelity and mt = 'V') => 'VA',	// map these fares and fidelity V to VA
														fares and mt in ['WRP','W'] => 'WRP',	// map these fares to WRP
														mt);
														
export type_financing(boolean fidelity, boolean fares, string ft) := 
												map((fidelity and ft in ['VAR','ADJ','XXX']) OR (fares and ft in ['A','VAR','ADJ']) => 'ADJ',	// map these to adjustable
														(fidelity and ft in ['FIX']) or (fares and ft in ['FIX','F']) => 'CNV',	// map these to conventional
														ft <> '' => 'OTH',	// map all others to OTHER
														'');	// if blank, leave blank
														
export adlCategory(string cat) := map(cat = 'DEAD' => '1 DEAD',
																			cat = 'NOISE' => '2 NOISE',
																			cat = 'H_MERGE' => '3 H_MERGE',
																			cat = 'C_MERGE' => '4 C_MERGE',
																			cat = 'INACTIVE' => '5 INACTIVE',
																			cat = 'AMBIG' => '6 AMBIG',
																			cat = 'NO_SSN' => '7 NO_SSN',
																			cat = 'CORE' => '8 CORE',
																			cat <> '' => '0 OTHER',
																			'0 NONE');	// this should never happen when populated		
																			
export Mask_DOB(string dob, unsigned1 dob_mask_value = suppress.Constants.dateMask.NONE) := function
	masked_date := Suppress.date_mask((unsigned4)DOB, dob_mask_value);

	// if the dob doesn't need to be masked, simply return the input dob
	sDOBmasked := if(dob_mask_value=0 or trim(dob)='', dob, (string)masked_date.year + (string)masked_date.month + (string)masked_date.day);
	
	return sDOBmasked;
end;

export invalid_dobs := ['19000101','19000000','19010101','18990101'];

export dobmatch_score_fuzzy6(boolean indobpop, boolean founddobpop, string8 indob, string8 founddob) := 
																	map(~indobpop or ~founddobpop => 255,
																			'00' = indob[5..6]  or '00' = founddob[5..6] => 255,
																			did_add.SSN_Match_Score(indob[1..6]+'00',founddob[1..6]+'00'));	// score with dobmatchoption set to FuzzyCCYYMM
																
export dobmatch_score_radius(boolean indobpop, boolean founddobpop, string8 indob, string8 founddob, unsigned1 radius) := 
																	map(~indobpop or ~founddobpop => 255,
																			indob[1..4]=founddob[1..4] => 100,
																			abs((integer)(indob[1..4])-(integer)(founddob[1..4])) <= Radius => 91,
																			15);	// score with dobmatchoption set to RadiusCCYY
																
export dobmatch_score_exact8(boolean indobpop, boolean founddobpop, string8 indob, string8 founddob) := 
																	map(~indobpop or ~founddobpop => 255,
																			indob[1..8]=founddob[1..8] => 100,
																			13);	// score with dobmatchoption set to ExactCCYYMMDD
																
export dobmatch_score_exact6(boolean indobpop, boolean founddobpop, string8 indob, string8 founddob) := 
																	map(~indobpop or ~founddobpop => 255,
																			indob[1..6]=founddob[1..6] => 100,
																			14);	// score with dobmatchoption set to ExactCCYYMM


export SIC_Prison := '2225';

//for MS-160
export age_bucket(string logdate, unsigned3 historydate, string historyDateTimeStamp = '') := function
	today := if(historyDateTimeStamp <> '', historyDateTimeStamp[1..8], mygetdate(historydate));
	days := ut.DaysApart( logdate, today );
	ageBucket := map(logdate='' => 0,
		days <= 30  => 1,
		days <= 90  => 3,
		days <= 180 => 6,
		days <= oneyear    => 12,
		days <= twoyears   => 24,
		days <= threeyears => 36,
		days <= fiveyears  => 60,
		255 // anything older than five years
	);
	return agebucket;
end;


export DefaultNumCodes := 6;

export SetDLValidationStates := ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS',
											'KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC',
											'ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WI','WV','WY',
											'AB','BC','MB','NB','NL','NS','ON','PE','QC','SK','NT','YT','NU','PR','GU','MP','VI'];
																				
export SetValidStateSrcs := ['AD','AX']; 

export bureau_sources := ['EQ', 'EN', 'TN'];

	export unsigned3 MonthRollback( string indate, unsigned1 months ) := FUNCTION
		dt := if( indate='999999', todays_date, indate );
		yyyy := (unsigned2)dt[1..4];
		mm   := (unsigned2)dt[5..6];
		
		return map(
			length(indate) not in [6,8] => 0,
			mm - months >= 1 => yyyy*100 + mm - months, // 201012 minus three months -> 201009
			100*(yyyy-1) + mm+12-months // 201102 gets rolled back to 201011
		);
	END;
	
	export AddressAppendMatchLevel := ENUM(
		NoMatch = 0,
		JustZip5 = 1,
		StreetNumAndZip5 = 2,
		AddressHierarchyResult = 3
	);
	
	// these flags specify the bit location in Layout_Output.IID_Flags of the return value
	export IIDFlag := enum(
		CurrentOccupant = 0,
		EverOccupant,				// 1
		Chrono1_isPrison, 	// 2
		Chrono2_isPrison, 	// 3
		Chrono3_isPrison, 		// 4
		IsPreScreen,        // 5 -- is on the pre-screen opt-out list
		IsDoNotMail         // 6 -- is on the direct marketing association's do-not-mail list
		// ...
		// 63
	);
	export unsigned8 SetFlag( IIDFlag flagnum, boolean SetValue ) := if( SetValue, 1 << flagnum, 0 );
	export boolean CheckFlag( IIDFlag flagnum, unsigned8 flags ) := (flags & (1<<flagnum) ) > 0;
	export unsigned8 AppendFlags (IIDFlag leftFlags, IIDFlag rightFlags) := (leftFlags) + (rightFlags);

	// options to turn on/off in the boca shell
	export BSOptions := enum(
		IncludePreScreen = 1 << 0,
		IncludeDoNotmail = 1 << 1,
		IsCapOneBatch    = 1 << 2,
		InsuranceMode    = 1 << 3,
		IncludeFraudVelocity 	= 1 << 4,
		DIDRIDSearchOnly = 1 << 5,  // search by did or match did to rid only...skip Mac_DIDAppend
		IsAML            =1 << 6,
		IncludeInquiries = 1 << 7,	// this is to allow the use of inquiries data in our NAP verification logic
		IsInstantIDv1      = 1 << 8,		// this is to state it is coming from CIID/FlexID and is version 1
		Collections_Neutral_Service =1 << 9,
		Include_nonFCRA_Collections_Inquiries =1 << 10,  // to be turned on in FCRA retro mode
		IncludeInsNAP		= 1 << 11,	// this is to allow the Insurance NAP gateway call
		IncludeAddressAppend = 1 << 12, // This turns on address append functionality specific for RiskView V3 Attributes for Experian - currently no other product or company should be using this
		RetainInputDID = 1 << 13,
		AllowInsuranceDLInfo = 1 << 14, //This will allow searching Insurance DL keys
		AlwaysCheckInsurance = 1 << 15,
		EnableEmergingID = 1 << 16,	//this will do additional DID search logic for AmEx or other customers who may request it
		InsuranceFCRAMode = 1 << 17,		//ISS FCRA query to use this to filter of data
		IncludeHHIDSummary = 1 << 18,
		FilterLiens = 1 << 19,   // option to be able to filter out liens from derogs data and from header searching
		CityTaxLien = 1 								<< 20,
		CountyTaxLien = 1 						  << 21,
		StateTaxWarrant = 1							<< 22,
		StateTaxLien  =1		 	          << 23,
		FederalTaxLien = 1 				      << 24,	
		OtherLien = 1										<< 25,
		Judgment = 1 										<< 26,
		Eviction = 1										<< 27,
		SSNLienFtlr = 1									<< 28,
		BCBLienFtlr = 1									<< 29,
		InsuranceFCRABankruptcyException = 1 << 30
		);

export CheckifFlagged(string inString, integer Position) :=  if(inString[Position] = '0', true, false);

export FlagLiensOptions(string FilterLienTypes) := function
	LiensInput := trim(FilterLienTypes);
	
	CityTaxLiens := CheckifFlagged(LiensInput, 1);
	CountyTaxLiens := CheckifFlagged(LiensInput, 2);
	StateTaxWarrants := CheckifFlagged(LiensInput, 3);
	StateTaxLiens := CheckifFlagged(LiensInput, 4);
	FederalTaxLiens := CheckifFlagged(LiensInput, 5);
	OtherLiens := CheckifFlagged(LiensInput, 6);
	Judgments := CheckifFlagged(LiensInput, 7);
	Evictions := CheckifFlagged(LiensInput, 8);
	return (if(CityTaxLiens, BSOptions.CityTaxLien, 0) +
		if(CountyTaxLiens, BSOptions.CountyTaxLien, 0) +
		if(StateTaxWarrants, BSOptions.StateTaxWarrant, 0) +
		if(StateTaxLiens, BSOptions.StateTaxLien, 0) +
		if(FederalTaxLiens, BSOptions.FederalTaxLien, 0) +
		if(OtherLiens, BSOptions.OtherLien, 0) +
		if(Judgments, BSOptions.Judgment, 0) +
		if(Evictions, BSOptions.Eviction, 0)) ;
end;

export GoodSSNLength(string9 inSSN) :=  inSSN != '' and 
		((length(trim(inSSN)) = 9 and inSSN != '000000000') or
		(length(trim(inSSN)) = 4 and inSSN != '0000'));
		
	// Check to see if a particular BSOption is turned on
	export boolean CheckBSOptionFlag (BSOptions Flag, UNSIGNED8 Options) := (Options & Flag) > 0;
	
	export boolean IsEligibleHeaderRec (doxie.key_fcra_header KeyHeader, boolean dppa_ok) := 
																		~mdr.Source_is_Utility (KeyHeader.src) AND // rm Utility from NAS
																		~mdr.Source_is_on_Probation (KeyHeader.src) AND // we won't use probation data 
																		~(dppa_ok AND KeyHeader.src[2] IN ['E','X']) AND // we won't use experian dl's/vehicles (requires LN branding)
																		~FCRA.Restricted_Header_Src (KeyHeader.src, KeyHeader.vendor_id[1]); //always FCRA
																		
	export GetVRUDataset (unsigned1 code, string64 message, 
                        DATASET (RiskWise.layouts_vru.layout_verified) verified = DATASET ([], RiskWise.layouts_vru.layout_verified),
                        DATASET (RiskWise.layouts_vru.layout_person) did_person = DATASET ([], RiskWise.layouts_vru.layout_person)) := FUNCTION
								ds := DATASET ([{code, message, verified, did_person}], RiskWise.layouts_vru.layout_output); 
								RETURN ds;
	END;

	export GetVerified (string9 ssnval, string2 yobval, string5 hnumberval, string10 phoneval, string5 zipval) := FUNCTION
								RETURN DATASET ([{ssnval, yobval, hnumberval, phoneval, zipval}], RiskWise.layouts_vru.layout_verified);
	END;
	
	// add constants for the blankout header correction fields
	export suppress := enum(
													fname = 1, 	// 1
													mname, 			// 2
													lname, 			// 3
													namesuffix, // 4
													primrange, 	// 5
													predir, 		// 6
													primname, 	// 7
													suffix, 		// 8
													postdir, 		// 9
													unitdesig, 	// 10
													secrange, 	// 11
													cityname, 	// 12
													st, 				// 13
													zip, 				// 14
													zip4, 			// 15
													ssn, 				// 16
													dob, 				// 17
													DwellType, 			// 18
													Valid, 					// 19
													PrisonAddr, 		// 20
													HighRisk, 			// 21
													CorpMil, 				// 22
													DoNotDeliver, 	// 23
													DeliveryStatus, // 24
													AddressType, 		// 25
													DropIndicator,	// 26
													Unit_count,			// 27
													Mail_usage);		// 28
	
	export unsigned1 capVelocity(unsigned vcounter) := min(255, vcounter);
											
	export setCRMA := ['2310','2300','2220','2280','2320'];	// set of sic codes to define CMRA
	
	// map the internal sic codes to the description for disclosure purposes
export hri_sic_code_description(string4 internal_sic) := function
	desc := map(
			internal_sic='2330' => 'HUNTING, TRAPPING, GAME PROPAGATION',
			internal_sic='2335' => 'NEWSPAPERS',
			internal_sic='2335' => 'NEWSPAPERS',
			internal_sic='2265' => 'U.S. POSTAL SERVICE',
			internal_sic='2325' => 'WATER TRANSPORTATION OF FREIGHT, NEC',
			internal_sic='2310' => 'PACKING AND CRATING',
			internal_sic='2300' => 'TELEGRAPH & OTHER COMMUNICATIONS',
			internal_sic='2285' => 'MOBILE HOME SITE OPERATORS',
			internal_sic='2210' => 'HOTELS AND MOTELS',
			internal_sic='2230' => 'ROOMING AND BOARDING HOUSES',
			internal_sic='2290' => 'SPORTING AND RECREATIONAL CAMPS',
			internal_sic='2215' => 'TRAILER PARKS AND CAMPSITES',
			internal_sic='2340' => 'TAX RETURN PREPARATION SERVICES',
			internal_sic='2305' => 'CREDIT REPORTING SERVICES',
			internal_sic='2220' => 'DIRECT MAIL ADVERTISING SERVICES',
			internal_sic='2280' => 'PHOTOCOPYING & DUPLICATING SERVICES',
			internal_sic='2320' => 'BUSINESS SERVICES, NEC',
			internal_sic='2275' => 'SKILLED NURSING CARE FACILITIES',
			internal_sic='2384' => 'INTERMEDIATE CARE FACILITIES',
			internal_sic='2381' => 'NURSING AND PERSONAL CARE, NEC',
			internal_sic='2260' => 'GENERAL MEDICAL & SURGICAL HOSPITALS',
			internal_sic='2315' => 'PSYCHIATRIC HOSPITALS',
			internal_sic='2382' => 'HOME HEALTH CARE SERVICES',
			internal_sic='2345' => 'ELEMENTARY AND SECONDARY SCHOOLS',
			internal_sic='2270' => 'COLLEGES AND UNIVERSITIES',
			internal_sic='2350' => 'JUNIOR COLLEGES',
			internal_sic='2355' => 'LIBRARIES',
			internal_sic='2383' => 'INDIVIDUAL AND FAMILY SERVICES',
			internal_sic='2380' => 'RESIDENTIAL CARE',
			internal_sic='2225' => 'PRISON OR CORRECTIONAL INSTITUTION',
			internal_sic='2295' => 'NATIONAL SECURITY',
			internal_sic='2265' => 'PO BOX STREET STYLE ADDRESS',
			'');
	return desc;
end;

// can't use new mexico or pennsylvania real estate in the shell
export restricted_Mari_vendor_set := ['S0822',
'S0843',
'S0900',
'S0868'
];

export error_con := 'ERROR';

//Types of Order
export PhysicalOrder := 'PHYSICAL';
export DigitalOrder := 'DIGITAL';
export DeviceProvider1Score (string20 DeviceProvider1_value) := map( //kountscore
		DeviceProvider1_value = '' => '',
		(integer) DeviceProvider1_value >= 0 and (integer) DeviceProvider1_value <= 30 => 'LOW RISK',
		(integer) DeviceProvider1_value >= 31 and (integer) DeviceProvider1_value <= 54 => 'MEDIUM-LOW RISK',
		(integer) DeviceProvider1_value >= 55 and (integer) DeviceProvider1_value <= 69 => 'MEDIUM RISK',
		(integer) DeviceProvider1_value >=70 and (integer) DeviceProvider1_value <= 98 => 'MEDIUM-HIGH RISK',
		(integer) DeviceProvider1_value > 98 => 'HIGH RISK', 
		'LOW RISK');
export DeviceProvider2Score (string20 DeviceProvider2_value) := map( //threat metrix score
		DeviceProvider2_value = '' => '',
		(integer) DeviceProvider2_value >= -60 and (integer) DeviceProvider2_value <= -21 => 'MEDIUM-HIGH RISK',
		(integer) DeviceProvider2_value >= -20 and (integer) DeviceProvider2_value <= 20 => 'MEDIUM RISK',
		(integer) DeviceProvider2_value >= 21 and (integer) DeviceProvider2_value <= 60 => 'MEDIUM-LOW RISK',
		(integer) DeviceProvider2_value >= 61 and (integer) DeviceProvider2_value <= 100 => 'LOW RISK',
		(integer) DeviceProvider2_value > 100 => 'LOW RISK',
		(integer) DeviceProvider2_value >= -61 => 'HIGH RISK',
		'HIGH RISK');
export DeviceProvider3Score (string20 DeviceProvider3_value) := map( //lovationscore
			DeviceProvider3_value = '' => '',
			'LOW RISK'); //NOTHING DEFINED FOR THIS SO FAR		
export DeviceProvider4Score(string20 DeviceProvider4_value) := map( //para41score
			DeviceProvider4_value = '' => '',
			'LOW RISK'); //NOTHING DEFINED FOR THIS SO FAR	

export EmailFakeIds := 15000000000000;

export SetEmailSources := [mdr.sourceTools.src_Acquiredweb,
		mdr.sourceTools.src_Entiera,  
		mdr.sourceTools.src_Wired_Assets_Email,
		mdr.sourceTools.src_MediaOne, 
		mdr.sourceTools.src_Ibehavior,
		mdr.sourceTools.src_SalesChannel,
		mdr.sourceTools.src_Datagence];  

export MAC_IsBusinessRestricted(inDS,outDS,source_field,vl_id,dt_first_seen, dppa, glb, drm, isFCRA) := MACRO

  #uniquename(outrec)
	
	%outrec% :=  record
		recordof(inDS);
  end;
								
  tmpOutDS := project(inDS, transform(%outrec%,
	                    	                           
	rowIsRestrictedTmp := false;
	// now deal with GLB access
	glb_ok := Risk_Indicators.iid_constants.glb_ok(glb, isFCRA);
	dppa_ok := Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);

   rowIsRestrictedGLB :=  MDR.SourceTools.SourceIsGLB(left.source_field) AND 
			                        (glb_ok OR
																//AutoStandardI.PermissionI_Tools.GLB.HeaderIsPreGLB(0,left.dt_first_seen,left.source_field)); 
																Header.IsPreGLB_LIB(0, 
																								left.dt_first_seen, 
																								left.source_field, 
																								drm));
    // have to keep GLB and DPPA separate ....and separate the GLB logic outside map statement
		// so that both restrictions can be made if necessary.
		// thus the additional RowIsRestrictedGLB Boolean
		// if either of these is true then we want to leave that row out
		// of the result set.
    rowIsRestricted := rowIsRestrictedTmp  OR rowIsRestrictedGLB;
		
		self := if (~(rowIsRestricted), left);
		)
		);				
	 outDS := tmpOutDS(source_field != '');
 
ENDMACRO;

export ActiveText := 'ACTIVE';

export set_valid_offense_scores := ['F', 'M'];

export set_valid_ssn_codes := ['G','Z','R','O'];

export EI_set_valid_ssn_codes := ['G','Z','R','O','U'];

export boolean isFakeDID (UNSIGNED8 DID) := DID > EmailFakeIds;

export ds_Record := dataset([{1}], {unsigned a});


export stripLeadingZeros(string ZeroedNumber) := function
	strip_leadingzeroes(string number) := REGEXREPLACE('^[ |0]*', trim(number, left, right), '');
	
	ExceptLeadingZeros  := strip_leadingzeroes(ZeroedNumber); 
	//we have leading zero's and now remove the left over dash - only remove dash if preceeding 0s were found
	RemoveDash := if(ExceptLeadingZeros != ZeroedNumber and ExceptLeadingZeros[1..1] = '-', 
		ExceptLeadingZeros[2..], ExceptLeadingZeros);

	return RemoveDash;	
	
end;

export SetFICOScoreXDRejectCodes := ['A1','B0','C1','C6','C7','C8','C9','CC','CD','CE',
																		 'CF','CG','CH','CJ','CK','CL','CQ','CS','CT','CX',
																		 'CZ','L0','N1','R0','X1','X3','X4','X5','X6','X7',
																		 'A1','C1','C2','C3','C4','C6','L0','L1','L2','L3',
																		 'L4','L5','L6','L7','R0','X5'];

//MS-104
export subsLayout := record
	unsigned4 seq;
	string30	subsString;
	unsigned4 subsCount;
end;

// accepts a record set of unique string values and a single string and compares the single string to those in the record set using the editDistance function to count how many are off by 1 char
export countSubs(GROUPED DATASET(subsLayout) subsFile, string30 currString) := function
	subsLayout projNames(subsLayout le) := transform
		self.seq							:= le.seq;
		self.subsString				:= le.subsString;
		editDistance			 		:= STD.Str.EditDistance(currString,le.subsString);
		self.subsCount				:= if(editDistance = 1, 1, 0);
	end;
	projSubs 	:= project(subsFile, projNames(left));
	countSubs	:= exists(projSubs(subsCount = 1));
	return (integer)countSubs;
end;


// accepts a record set of unique DOB values and a single DOB value and compares to see if any in the record set have same year and month but different day and counts those that do
export countSubDOBDay(GROUPED DATASET(subsLayout) subsFile, string30 currString) := function
	subsLayout projDOBDay(subsLayout le) := transform
		self.seq							:= le.seq;
		self.subsString				:= le.subsString;
		dayIsDiff							:= currString[1..6] = le.subsString[1..6] and currString[7..8] <> le.subsString[7..8];  
		self.subsCount				:= if(dayIsDiff, 1, 0);
	end;
	projSubsDOBDay	:= project(subsFile, projDOBDay(left));
	countSubsDOBDay	:= exists(projSubsDOBDay(subsCount = 1));
	return (integer)countSubsDOBDay;
end;

// accepts a record set of unique DOB values and a single DOB value and compares to see if any in the record set have same year and day but different month and counts those that do
export countSubDOBMonth(GROUPED DATASET(subsLayout) subsFile, string30 currString) := function
	subsLayout projDOBMonth(subsLayout le) := transform
		self.seq							:= le.seq;
		self.subsString				:= le.subsString;
		MonthIsDiff						:= currString[1..4] = le.subsString[1..4] and currString[7..8] = le.subsString[7..8] and currString[5..6] <> le.subsString[5..6]; 
		self.subsCount				:= if(MonthIsDiff, 1, 0);
	end;
	projSubsDOBMonth	:= project(subsFile, projDOBMonth(left));
	countSubsDOBMonth	:= exists(projSubsDOBMonth(subsCount = 1));
	return (integer)countSubsDOBMonth;
end;

// accepts a record set of unique DOB values and a single DOB value and compares to see if any in the record set have same month and day but different year and counts those that do
export countSubDOBYear(GROUPED DATASET(subsLayout) subsFile, string30 currString) := function
	subsLayout projDOBYear(subsLayout le) := transform
		self.seq							:= le.seq;
		self.subsString				:= le.subsString;
		YearIsDiff						:= currString[5..8] = le.subsString[5..8] and currString[1..4] <> le.subsString[1..4]; 
		self.subsCount				:= if(YearIsDiff, 1, 0);
	end;
	projSubsDOBYear	:= project(subsFile, projDOBYear(left));
	countSubsDOBYear	:= exists(projSubsDOBYear(subsCount = 1));
	return (integer)countSubsDOBYear;
end;

//MS-105
export diffValues1Dig := [1,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000];

// accepts a record set of unique numeric values and a single value and compares to see if any in the record set have 1 digit that is different by 1 and counts those that are
export countDiff1Dig(GROUPED DATASET(subsLayout) subsFile, string30 currString) := function
	subsLayout proj1dig(subsLayout le) := transform
		self.seq							:= le.seq;
		self.subsString				:= le.subsString;
		diffValue							:= abs((integer)currString - (integer)le.subsString); 
		diff1dig							:= diffValue in diffValues1Dig;  //if the difference in the two values is any of the numbers in the set, than only 1 digit is off by 1
		self.subsCount				:= if(diff1dig, 1, 0);
	end;
	projDiff1Dig	:= project(subsFile, proj1dig(left));
	countDiffs1Dig	:= exists(projDiff1Dig(subsCount = 1));
	// countDiffs1Dig	:= count(projDiff1Dig(subsCount = 1) > 0);
	return (integer)countDiffs1Dig;
	
end;

export Set_Restricted_States_For_Marketing := ['ID', 'IL', 'KS', 'NM', 'SC', 'WA', 'NY'];
export Set_Restricted_Colleges_For_Marketing := [
'15322',
'15323',
'15324',
'15325',
'15326',
'15327',
'15328',
'15329',
'15330',
'15331',
'15334',
'15335',
'15336',
'15337',
'15338',
'15340',
'15341',
'15343',
'15344',
'15345',
'15346',
'15347',
'15348',
'15349',
'15350',
'15351',
'15352',
'15353',
'15354',
'15355',
'15356',
'15357',
'15360',
'15362',
'15363',
'15364',
'15366',
'15368',
'15371',
'15372',
'15373',
'15378',
'15417',
'15418',
'15419',
'15421',
'15423',
'15425',
'15426',
'15431',
'15432',
'15434',
'15436',
'15438',
'15439',
'15441',
'15443',
'15444',
'15446',
'15856',
'15858',
'15873',
'15877',
'15896',
'15901',
'15904',
'16172',
'16174',
'16176',
'16178',
'16179',
'16181',
'16182',
'16189',
'16196',
'16198',
'16201',
//--new restrictions codes added per RQ-13858
'15313',
'15314',
'15315',
'15316',
'15317',
'15318',
'15319',
'15320',
'15824',
'15830',
'15829',
'15831',
'15828',
'15827',
'15826',
'15825',
'15817',
'15823',
'15822',
'15821',
'15820',
'15819',
'15811',
'15815',
'15814',
'15812',
'15816',
'15810',
'15809',
'15808',
'15807',
'15806',
'15805',
'15804',
'15818',
'15813',
'16436',
'16418',
'16442',
'16441',
'16440',
'16439',
'16438',
'16437',
'16435',
'16434',
'16433',
'16432',
'16431',
'16428',
'16429',
'16411',
'16419',
'16430',
'16404',
'16417',
'16416',
'16415',
'16414',
'16413',
'16412',
'16410',
'16427',
'16408',
'16407',
'16409',
'16405',
'16420',
'16403',
'16402',
'16401',
'16400',
'16426',
'16425',
'16424',
'16423',
'16422',
'16421',
'16406'];

export Set_Equifax_Active_Duty_Alert_Codes := ['W','Q','N'];
export Set_Equifax_Fraud_Alert_Codes := ['W','Q','X','V'];

export OFAC4_NoGateway := 'watchlist server error';
export FABatch_WatchlistModels := ['fp1109_0', 'fp31105_1', 'fp3710_0']; 
export FAXML_WatchlistModels := ['fp1109_0', 'fp31105_1', 'fp3710_0', 'fp3904_1'];
export RecoverScoreBatchWatchlistModels :=  ['RSN807_0_0'];
export set_validOFACVersions := [1,2,3,4];   

export fn_CreateFakeDID( STRING fname, STRING lname ) := 
    (UNSIGNED6)(STD.Str.Filter( (STRING)(HASH(fname,lname)), '0123456789' )[1..12]);

// for dempsey riskview project, change the bankruptcy filter to only include these specific chapters
export set_permitted_bk_chapters(integer bsversion, boolean insurancemode) := if(bsversion < 50 and ~insurancemode, ['7'], ['7', '9', '11', '12', '13', '15', '304']);

//chase custom verification RQ-14821 to mirror RQ-13523
export poAddress_expression := '((P[\\s\\.]*O[\\.\\s]*)|(POST[\\s]*OFFICE[\\s]*))+BOX';  //find reference to po box or post office box
export onlyContains_express := '^(([\\s]*CO[\\.]?)|([\\s]*ASSOCIATES))$';
export endingInc_expression := '(INC[.]*)$';
export endsWith_expression := '([\\s]*ASSOC|[\\s]*ASSOCIATES|(AND)?[\\s\\&]*COMPANY|[\\.\\s\\&]*CO[\\.]?|[\\s]*ACCT|[\\s\\&]*LLP[\\.]?|[\\s\\&]*LLC[\\.]?)$';
export lastEndsWith_expression := '([\\s]*DDS[\\.]?)$';
export contains_expression := '(ACCOUNT|BUSINESS|\\&)';

export Get_chase_NAS_NAP( string chase_f, string chase_l, string chase_addr,  integer curr_NAS_NAP) := function
	Chase_nas_nap := Map(curr_NAS_NAP = 0 => curr_NAS_NAP,
									 curr_NAS_NAP = 1 => curr_NAS_NAP,
									 //NAS 2
									 curr_NAS_NAP = 2 and (chase_f = '' or chase_l = '') => 0,
									 //NAS 3
									 curr_NAS_NAP = 3 and (chase_f = '' or chase_addr = '') => 0,
									 //NAS 4
									 curr_NAS_NAP = 4 and chase_f = '' => 1,
									 //NAS 5
									 curr_NAS_NAP = 5 and (chase_l = '' or chase_addr = '') => 0,
									 //NAS 6
									 curr_NAS_NAP = 6 and chase_addr = '' => 1,
									 //NAS 7
									 curr_NAS_NAP = 7 and chase_l = '' => 1,
									 //NAS 8
									 curr_NAS_NAP = 8 and chase_f = '' and chase_l = '' and chase_addr = '' => 0, 
									 curr_NAS_NAP = 8 and chase_f = '' and chase_l = '' => 0,
									 curr_NAS_NAP = 8 and chase_f = '' and chase_addr = '' => 0,
									 curr_NAS_NAP = 8 and chase_l = '' and chase_addr = '' => 0,
									 curr_NAS_NAP = 8 and chase_f = '' => 5,
									 curr_NAS_NAP = 8 and chase_l = '' => 3,
									 curr_NAS_NAP = 8 and chase_addr = '' => 2,
									 //NAS 9
									 curr_NAS_NAP = 9 and chase_f = '' and chase_l = '' => 1,
									 curr_NAS_NAP = 9	and chase_f = '' => 7,
									 curr_NAS_NAP = 9	and chase_l = '' => 4,
									 //NAS 10
									 curr_NAS_NAP = 10 and chase_f = '' and chase_addr = '' => 1,
									 curr_NAS_NAP = 10 and chase_f = '' => 6,
									 curr_NAS_NAP = 10 and chase_addr = '' => 4,
									 //NAS 11
									 curr_NAS_NAP = 11 and chase_l = '' and chase_addr = '' => 1,
									 curr_NAS_NAP = 11	and	chase_l = '' => 6,
									 curr_NAS_NAP = 11	and	chase_addr = '' => 7,
									 //NAS 12
									 curr_NAS_NAP = 12 and (chase_f = '' and chase_l = '' and chase_addr = '') => 1,
									 curr_NAS_NAP = 12	and	(chase_f = '' and chase_l = '') => 6,
									 curr_NAS_NAP = 12	and	(chase_f = '' and chase_addr = '') => 7,
									 curr_NAS_NAP = 12	and	(chase_l = '' and chase_addr = '') => 4,
									 curr_NAS_NAP = 12	and	chase_f = '' => 11,
									 curr_NAS_NAP = 12	and	chase_l = '' => 10,//
									 curr_NAS_NAP = 12	and	chase_addr = '' => 9,//
									 curr_NAS_NAP);  //NAS 0 and NAS 1 no change
	return Chase_nas_nap;
end;

export IntendedPurposeCodes(string IntendedPurpose) := case( stringlib.stringtouppercase(IntendedPurpose),
'APPLICATION' => ['110'],
'CREDIT TRANSACTION' => ['110'],
'CREDIT MORTGAGE' => ['110'],
'CREDIT TRANSACTION (NON-SPECIFIC)' => ['110'],
'CREDIT TRANSACTION (MORTGAGE)' => ['110'],
'CREDIT TRANSATION' => ['110'],
'CREDIT TRANSACTION (AUTO)' => ['110'],
'CREDIT TRANSACTION (HOME EQUITY)' => ['110'],
'CREDIT TRANSACTION (PERSONAL LOAN)' => ['110'],
'CREDIT TRANSACTION (CREDIT CARD)' => ['110'],
'CREDIT APPLICATION' => ['110'],
'CHILD SUPPORT' => ['112', '212'],
'COLLECTIONS' => ['113'],
'COURT ORDER' => ['114'],
'COURT ORDER OR SUBPOENA' => ['114', '214'],
'DEMAND DEPOSIT' => ['115'],
'GOVERNMENT' => ['118', '218'],
'GOVERNMENT LICENSE OR BENEFIT' => ['118', '218'],
'HOUSING COUNSELING' => ['121'],
'HOUSING COUNSELING AGENCY' => ['121', '221'],
'LEGITIMATE BUSINESS NEED' => ['127', '227'],
'POTENTIAL INVESTOR' => ['129'],
'TENANT SCREENING' => ['132'],
'BENEFIT GRANTING' => ['211'],
// 'CHILD SUPPORT' => ['212'],
'COURT ORDER / SUBPOENA' => ['214'],
// 'COURT ORDER OR SUBPOENA' => ['214'],
'EMPLOYER OR VOLUNTEER SCREENING' => ['216'],
'EMPLOYMENT' => ['216'],
'EMPLOYMENT SCREENING' => ['216'],
// 'GOVERNMENT' => ['218'],
// 'GOVERNMENT LICENSE OR BENEFIT' => ['218'],
'HEALTHCARE CREDIT' => ['219'],
'HEALTHCARE CREDIT TRANSACTION' => ['219'],
'HEALTHCARE CREDIT APPLICATION' => ['219'],
'HEALTHCARE LEGITIMATEBUSINESSNEED' => ['220'],
'HEALTHCARE LEGITIMATE BUSINESS NEED' => ['220'],
// 'HOUSING COUNSELING AGENCY' => ['221'],
'INSURANCE APPLICATION' => ['222'],
'INSURANCE CREDIT APPLICATION' => ['222'],
'INSURANCE PORTFOLIOREVIEW' => ['223'],
'INSURANCE PORTFOLIO REVIEW' => ['223'],
'INSURANCE RENEWALS' => ['224'],
'INSURANCE UNDERWRITING' => ['225'],
'INVESTIGATION' => ['226'],
'LEGITIMATE BUSINESS NEED - ACCOUNT OPENING' => ['227'],
'LEGITIMATE BUSINESS NEED - CHECKING' => ['227'],
'LEGITIMATE BUSINESS NEED - ACCOUNT REVIEW' => ['227'],
// 'LEGITIMATE BUSINESS NEED' => ['227'],
'PORTFOLIO REVIEW' => ['228'],
'ACCOUNT REVIEW' => ['228'],
'PRESCREENING' => ['230'],
'FIRM OFFER OF INSURANCE (PRE-SCREEN)' => ['230'],
'PRESCREEN  ' => ['230'],
'INSURANCE PRESCREEN' => ['230'],
'RENTAL CAR' => ['231'],
'WRITTEN CONSENT' => ['233'],
'INSTRUCTED BY CONSUMER' => ['233'],
'WRITTEN CONSENT - DIRECT TO CONSUMER' => ['234'],
'WRITTEN CONSENT - PREQUALIFICATION' => ['235'],
['']);


// create a dataset of codes from the content
// create a dataset of codes from the IntendedPurpose
// check if there are any of them that overlap
// if you have a match between content and input IntendedPurpose, apply the security freeze
EXPORT doesFreezeApply(string personContext_content, string100 IntendedPurpose) := function

  myContentSet := STD.Str.SplitWords(personContext_content, ',');
  codes_count := COUNT(myContentSet);
  content_codes_ds := DATASET(codes_count, TRANSFORM({string code_value}, SELF.code_value := STD.Str.CleanSpaces(myContentSet[COUNTER])));

  intended_codes_set := IntendedPurposeCodes(IntendedPurpose);
  ipc_count := COUNT(intended_codes_set);
  IntendedPurpose_codes_ds := DATASET(ipc_count, TRANSFORM({string code_value}, SELF.code_value := STD.Str.CleanSpaces(intended_codes_set[COUNTER])));

  matched_codes := join(IntendedPurpose_codes_ds, content_codes_ds, left.code_value=right.code_value);
  // output(myContentSet, named('myContentSet'));
  // output(codes_count, named('codes_count'));
  // output(content_codes_ds, named('content_codes_ds'));
  // output(intended_codes_set, named('intended_codes_set'));
  // output(ipc_count, named('ipc_count'));
  // output(IntendedPurpose_codes_ds, named('intendedPurpose_codes_ds'));
  // output(matched_codes, named('matched_codes'));

  return count(matched_codes) > 0;

end;

end;