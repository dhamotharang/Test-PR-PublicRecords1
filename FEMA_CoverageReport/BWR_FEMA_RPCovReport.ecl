//FEMA report should be run twice a year. 
//per Julie Gardner, runs should occur beginning of May (in time for hurricane season) and then again beginning of November
//This code was initally created by Tony Kirk in 2010. Modified Jan 2015 to account for new PropertyFast base files.
//20150224 - code modified to incorporate the Fast Property Base file (Bug 173837).

IMPORT LN_PropertyV2_Fast, LN_PropertyV2, Property, ut, lib_FileServices, lib_Stringlib,_Control;

// #option('freezePersists',true);
#WORKUNIT('name','FEMA Coverage Reports');
BOOLEAN	gIncludeDebug	:=	TRUE;
BOOLEAN	gDebugOnly		:=	FALSE;

// rSearch - Source_Code values
// 	Include these (Source_Code[2] = 'P'):
// 		OP   Owner/Buyer Property Address
// 		BP   Buyer/Borrower Property Address
// 		SP   Seller Property Address
// 		CP   Care of Name and Property Address
// 	Exclude these:
// 		OO   Owner/Buyer Mailing Address
// 		BO   Buyer Mailing Address
// 		SS   Seller Mailing Address
// 		CS   Care of Name and Seller Address
// 		CO   Care of Name and Mailing Address
// 		BB   Borrower Mailing Address

// Specs received in pseudocode email on 02/19/10
// 	The FIPS Code cannot be null
// 	County name cannot be null
// 	City Name not like IRS% or I R S%
// 	All states except for 'AA','AE','AP','GU','FM','MH','MP','PR','PW','AS'. (I added 'VI')

SET OF STRING25	sOmitCities	:=	['IRS','I R S'];
SET OF STRING2	sOmitStates	:=	['AA','AE','AP','GU','FM','MH','MP','PR','PW','AS'];

gToday	:=	ut.getDate : GLOBAL;

// USPS data
rZipCityStateDetail :=
RECORD
	STRING	CPS_LOAD_DTTM {MAXLENGTH(19)};
	STRING	CPS_SIG_DTL {MAXLENGTH(32)};
	STRING	COPYRIGHT_DTL_CD {MAXLENGTH(1)}; 
	STRING	ZIP_CODE {MAXLENGTH(5)};
	STRING	CITY_ST_KEY {MAXLENGTH(6)};
	STRING	ZIP_CLASS_CD {MAXLENGTH(1)};
	STRING	CITY_NAME {MAXLENGTH(28)};
	STRING	CITY_ABBR {MAXLENGTH(13)};
	STRING	FACILITY_CD {MAXLENGTH(1)};
	STRING	MAIL_NAME_IND {MAXLENGTH(1)};
	STRING	PREF_LAST_LINE_CTYST_KEY {MAXLENGTH(6)}; 
	STRING	PREF_LAST_LINE_CTYST_NAME {MAXLENGTH(27)};
	STRING	CITY_DEL_IND {MAXLENGTH(1)};
	STRING	CARRIER_RTE_RATE_SORT_CD {MAXLENGTH(1)}; 
	STRING	UNIQUE_ZIP_NAME_FLG {MAXLENGTH(1)}; 
	STRING	FINANCE_NUM {MAXLENGTH(6)};
	STRING	STATE_ABBR {MAXLENGTH(2)};
	STRING	CNTY_FIPS_CODE {MAXLENGTH(3)};
	STRING	COUNTY_NAME {MAXLENGTH(25)};
	STRING	CPS_VENDOR_CD {MAXLENGTH(3)};
END;
dZipCityStateDetail	:=	DATASET('~thor::lookup::fema_property::zip_city_st_dtl',rZipCityStateDetail,CSV(SEPARATOR('|'),TERMINATOR('\r\n'),QUOTE('"'),HEADING(SINGLE)));

rZipCityStateSlim :=
RECORD
	STRING5		ZIP_CODE;
	STRING2		STATE_ABBR;
	STRING25	CITY_NAME;
	STRING25	PREF_LAST_LINE_CTYST_NAME;
	STRING3		CNTY_FIPS_CODE;
	STRING25	COUNTY_NAME;
END;
dZipCityStateDetailFiltered	:=	dZipCityStateDetail(CITY_NAME[1..LENGTH(TRIM(sOmitCities[1]))] <> sOmitCities[1]
																								AND CITY_NAME[1..LENGTH(TRIM(sOmitCities[2]))] <> sOmitCities[2]
																								AND STATE_ABBR NOT IN sOmitStates
																									 );
dZipCityStateSlim	:=	PROJECT(dZipCityStateDetailFiltered,rZipCityStateSlim);

//Add Fast Property datasets to process -- can only run this in prod --
RP_Fast_Deed := LN_PropertyV2_Fast.Files.base.deed_mortg;
RP_Fast_Tax	:= LN_PropertyV2_Fast.Files.base.assessment;
RP_Fast_Srch := LN_PropertyV2_Fast.Files.base.search_prp;


// Prep Search dataset
rSearchSlimmed :=
RECORD
	STRING12	ln_fares_id;
	STRING25	p_city_name;
	STRING2		st;
	STRING5		zip;
END;
dSearchPropertyAddress	:=	LN_PropertyV2.File_Search_DID(source_code[2] = 'P', county <> '') + 
														RP_Fast_Srch(source_code[2] = 'P', county <> '');
// rSearch	tSearchSlimmed(dSearchPropertyAddress pSearch) :=
// TRANSFORM
	// SELF							:=	pSearch;
// END;
dSearchSlimmed				:=	PROJECT(dSearchPropertyAddress,rSearchSlimmed); // Slim it - tSearchSlimmed(LEFT));
dSearchSlimmedDist		:=	DISTRIBUTE(dSearchSlimmed,HASH(ln_fares_id));
dSearchSlimmedSort		:=	SORT(dSearchSlimmedDist,ln_fares_id,-zip,-st,LOCAL);
dSearchSlimmedDedup		:=	DEDUP(dSearchSlimmedSort,ln_fares_id,LOCAL);
//

// Prep Deed & Assessment data
dDeedCurrent						:=	LN_PropertyV2.File_Deed(current_record = 'Y' AND IF(contract_date <> '',
																										 ((UNSIGNED8)contract_date > 19000000 AND ut.DaysApart(contract_date,gToday) <= 365),
																										 ((UNSIGNED8)recording_date > 19000000 AND ut.DaysApart(recording_date,gToday) <= 365))) + 
														RP_Fast_Deed(current_record = 'Y' AND IF(contract_date <> '',
																					((UNSIGNED8)contract_date > 19000000 AND ut.DaysApart(contract_date,gToday) <= 365),
																					((UNSIGNED8)recording_date > 19000000 AND ut.DaysApart(recording_date,gToday) <= 365)));

dAssessmentCurrent			:=	LN_PropertyV2.File_Assessment(current_record = 'Y') + RP_Fast_Tax(current_record = 'Y');

// Slim them down to ln_fares_id only, combine
rCommon
 :=
	RECORD
		STRING12	ln_fares_id;
	END
 ;
dDeedCommon				:=	PROJECT(dDeedCurrent,rCommon);
dAssessmentCommon	:=	PROJECT(dAssessmentCurrent,rCommon);
dCommon						:=	dDeedCommon + dAssessmentCommon;
dCommonDist				:=	DISTRIBUTE(dCommon,hash(ln_fares_id));
dCommonSort				:=	SORT(dCommonDist,ln_fares_id,LOCAL);
//

// Join the Common Deeds/Assessments to Slimmed Search data
rCommonSearch :=
RECORD
	rCommon;
	rSearchSlimmed AND NOT ln_fares_id;			// Second ln_fares_id not needed or allowed
END;
rCommonSearch	tCommonSearch(dCommonSort pCommon, dSearchSlimmedDedup pSearch) :=
TRANSFORM
	SELF.ln_fares_id	:=	pCommon.ln_fares_id;
	SELF							:=	pSearch;
END;
dCommonSearch		:=	JOIN(dCommonSort, dSearchSlimmedDedup,
												 LEFT.ln_fares_id = RIGHT.ln_fares_id,
												 tCommonSearch(LEFT,RIGHT),
												 LEFT OUTER,
												 NOSORT,			// Already sorted Search for dedup, so pre-sorted Common too
												 LOCAL
												) : PERSIST('~thor::persist::fema_property::common_plus_search'); //,'thor400_84');
//

// Produce a table of every unique combination of st, city, zip
rCommonUniqueValues :=
RECORD
	dCommonSearch.st;
	dCommonSearch.p_city_name;
	dCommonSearch.zip;
	UNSIGNED8	Total	:=	COUNT(GROUP);
END;
dCommonUniqueValues					:=	TABLE(dCommonSearch(st<>'' AND p_city_name<>'' AND zip<>''),rCommonUniqueValues,st,p_city_name, zip, FEW);
//

// Gathering city count from Property totals into master (zipcitystate)
rBasisCounts :=
RECORD
	rZipCityStateSlim;
	UNSIGNED8								COUNTY_Count := 0;
	UNSIGNED8								PREF_CITY_Count := 0;
	UNSIGNED8								CITY_Count;
	UNSIGNED8								ZIP_Count := 0;
END;

rBasisCounts	tJoinMasterToCityCounts(dZipCityStateSlim pMaster, dCommonUniqueValues pCounts) :=
TRANSFORM
	SELF.CITY_Count		:=	pCounts.Total;
	SELF							:=	pMaster;
END;

dJoinMasterToCityCounts	:=	JOIN(dZipCityStateSlim, dCommonUniqueValues,
																 LEFT.STATE_ABBR = RIGHT.st
														 AND LEFT.CITY_NAME = RIGHT.p_city_name
														 AND LEFT.ZIP_CODE = RIGHT.zip,
																 tJoinMasterToCityCounts(LEFT,RIGHT),
																 LEFT OUTER
																);

// Aggregate zip, county, and preferred city counts from counts of city
rZipCounts :=
RECORD
	dJoinMasterToCityCounts.ZIP_CODE;
	UNSIGNED8	Total	:=	SUM(GROUP,dJoinMasterToCityCounts.CITY_COUNT);
END;
dZipCounts	:=	TABLE(dJoinMasterToCityCounts,rZipCounts,ZIP_CODE,FEW);

rCountyCounts :=
RECORD
	dJoinMasterToCityCounts.STATE_ABBR;
	dJoinMasterToCityCounts.CNTY_FIPS_CODE;
	UNSIGNED8	Total	:=	SUM(GROUP,dJoinMasterToCityCounts.CITY_COUNT);
END;
dCountyCounts	:=	TABLE(dJoinMasterToCityCounts,rCountyCounts,STATE_ABBR,CNTY_FIPS_CODE,FEW);

rPrefCityCounts :=
RECORD
	dJoinMasterToCityCounts.STATE_ABBR;
	dJoinMasterToCityCounts.PREF_LAST_LINE_CTYST_NAME;
	UNSIGNED8	Total	:=	SUM(GROUP,dJoinMasterToCityCounts.CITY_COUNT);
END;
dPrefCityCounts	:=	TABLE(dJoinMasterToCityCounts,rPrefCityCounts,STATE_ABBR,PREF_LAST_LINE_CTYST_NAME,FEW);
//

// Join the zip, county, and pref-city counts to just-joined counts of city
rBasisCounts	tJoinBasisToZipCounts(dJoinMasterToCityCounts pMaster, dZipCounts pCounts) :=
TRANSFORM
	SELF.ZIP_Count		:=	pCounts.Total;  // will be ZERO if no RIGHT record
	SELF							:=	pMaster;
END;
dJoinBasisToZipCounts	:=	JOIN(dJoinMasterToCityCounts, dZipCounts,
															 LEFT.ZIP_CODE = RIGHT.ZIP_CODE,
															 tJoinBasisToZipCounts(LEFT,RIGHT),
															 LEFT OUTER
															);

rBasisCounts	tJoinBasisToCountyCounts(dJoinBasisToZipCounts pMaster, dCountyCounts pCounts) :=
TRANSFORM
	SELF.COUNTY_Count	:=	pCounts.Total;  // will be ZERO if no RIGHT record
	SELF							:=	pMaster;
END;
dJoinBasisToCountyCounts	:=	JOIN(dJoinBasisToZipCounts, dCountyCounts,
																	 LEFT.STATE_ABBR = RIGHT.STATE_ABBR
															 AND LEFT.CNTY_FIPS_CODE = RIGHT.CNTY_FIPS_CODE,
																	 tJoinBasisToCountyCounts(LEFT,RIGHT),
																	 LEFT OUTER
																	);

rBasisCounts	tJoinBasisToPrefCityCounts(dJoinBasisToCountyCounts pMaster, dPrefCityCounts pCounts) :=
TRANSFORM
	SELF.PREF_CITY_Count	:=	pCounts.Total;  // will be ZERO if no RIGHT record
	SELF									:=	pMaster;
END;
dJoinBasisToPrefCityCounts	:=	JOIN(dJoinBasisToCountyCounts, dPrefCityCounts,
																		 LEFT.STATE_ABBR = RIGHT.STATE_ABBR
																 AND LEFT.PREF_LAST_LINE_CTYST_NAME = RIGHT.PREF_LAST_LINE_CTYST_NAME,
																		 tJoinBasisToPrefCityCounts(LEFT,RIGHT),
																		 LEFT OUTER
																		);
dJoinBasisSorted						:=	SORT(dJoinBasisToPrefCityCounts,STATE_ABBR,ZIP_CODE,PREF_LAST_LINE_CTYST_NAME,CITY_NAME);

//

// To produce the report output
rReport :=
RECORD
  STRING 	STATE {MAXLENGTH(2)};
  STRING	ZIP_CODE {MAXLENGTH(5)};
  STRING	CITY {MAXLENGTH(28)};
  STRING	PREFERRED_CITY {MAXLENGTH(27)};
  STRING	COUNTY_NAME {MAXLENGTH(25)};
  STRING	COUNTY_COVERED {MAXLENGTH(1)};
  STRING	PREF_CITY_COVERED {MAXLENGTH(1)};
  STRING	CITY_COVERED {MAXLENGTH(1)};
  STRING	ZIP_COVERED {MAXLENGTH(1)};
END;

rReport	tReport(dJoinBasisSorted pInput) :=
TRANSFORM
	SELF.STATE									:=	pInput.STATE_ABBR;
	SELF.ZIP_CODE								:=	pInput.ZIP_CODE;
	SELF.CITY										:=	pInput.CITY_NAME;
	SELF.PREFERRED_CITY					:=	pInput.PREF_LAST_LINE_CTYST_NAME;
	SELF.COUNTY_NAME						:=	pInput.COUNTY_NAME;
	SELF.COUNTY_COVERED					:=	if(pInput.COUNTY_Count > 0, 'Y', 'N');
	SELF.PREF_CITY_COVERED			:=	if(pInput.PREF_CITY_Count > 0, 'Y', 'N');;
	SELF.CITY_COVERED						:=	if(pInput.CITY_Count > 0, 'Y', 'N');;
	SELF.ZIP_COVERED						:=	IF(pInput.ZIP_Count > 4,'Y','N');
END;
dReport				:=	PROJECT(dJoinBasisSorted,tReport(LEFT));
// dReportSorted	:=	SORT(dReport,STATE,ZIP_CODE,PREFERRED_CITY,CITY);

//
MAC_OutputState(pState, pOutRef) :=
MACRO
	pOutRef	:=	OUTPUT(dReport(STATE = pState),,'~thor::out::fema_property::results::' + TRIM(pState,LEFT,RIGHT) + '::' + WORKUNIT + '.csv',CSV(HEADING(SINGLE),TERMINATOR('\r\n'),SEPARATOR('\t'),QUOTE('')),__COMPRESSED__);
ENDMACRO;
//

//
MAC_DesprayState(pState, pOutRef) :=
MACRO
	pOutRef	:=	lib_FileServices.FileServices.Despray('~thor::out::fema_property::results::' + TRIM(pState,LEFT,RIGHT) + '::' + WORKUNIT + '.csv',_Control.IPAddress.bctlpedata11,'/data/load01/fema_property_despray/' + WORKUNIT[2..9] + '/' + lib_StringLib.StringLib.StringToLowerCase(TRIM(pState,LEFT,RIGHT)) + '_' + WORKUNIT[2..9] + '.csv');
ENDMACRO;
//

//
MAC_OutputDebugCounts(pState, pOutRef) :=
MACRO
	pOutRef	:=	PARALLEL(OUTPUT(dJoinBasisSorted(STATE_ABBR = pState),ALL,NAMED('Debug_Counts_' + pState)),
												OUTPUT(dJoinBasisSorted(STATE_ABBR = pState),,'~thor::out::fema_property::debug_counts::' + TRIM(pState,LEFT,RIGHT) + '::' + WORKUNIT + '.csv',CSV(HEADING(SINGLE),TERMINATOR('\r\n'),SEPARATOR('\t'),QUOTE('')),__COMPRESSED__)
											 );
ENDMACRO;
//

//
MAC_DesprayDebugState(pState, pOutRef) :=
MACRO
	pOutRef	:=	lib_FileServices.FileServices.Despray('~thor::out::fema_property::debug_counts::' + TRIM(pState,LEFT,RIGHT) + '::' + WORKUNIT + '.csv',_Control.IPAddress.bctlpedata11,'/data/load01/fema_property_despray/' + WORKUNIT[2..9] + '/' + lib_StringLib.StringLib.StringToLowerCase(TRIM(pState,LEFT,RIGHT)) + '_debug_counts_' + WORKUNIT[2..9] + '.csv');
ENDMACRO;
//

MAC_OutputState('AK',zOutputAK);	MAC_OutputState('AL',zOutputAL);	MAC_OutputState('AR',zOutputAR);	MAC_OutputState('AZ',zOutputAZ);
MAC_OutputState('CA',zOutputCA);	MAC_OutputState('CO',zOutputCO);	MAC_OutputState('CT',zOutputCT);	MAC_OutputState('DC',zOutputDC);
MAC_OutputState('DE',zOutputDE);	MAC_OutputState('FL',zOutputFL);	MAC_OutputState('GA',zOutputGA);	MAC_OutputState('HI',zOutputHI);
MAC_OutputState('IA',zOutputIA);	MAC_OutputState('ID',zOutputID);	MAC_OutputState('IL',zOutputIL);	MAC_OutputState('IN',zOutputIN);
MAC_OutputState('KS',zOutputKS);	MAC_OutputState('KY',zOutputKY);	MAC_OutputState('LA',zOutputLA);	MAC_OutputState('MA',zOutputMA);
MAC_OutputState('MD',zOutputMD);	MAC_OutputState('ME',zOutputME);	MAC_OutputState('MI',zOutputMI);	MAC_OutputState('MN',zOutputMN);
MAC_OutputState('MO',zOutputMO);	MAC_OutputState('MS',zOutputMS);	MAC_OutputState('MT',zOutputMT);	MAC_OutputState('NC',zOutputNC);
MAC_OutputState('ND',zOutputND);	MAC_OutputState('NE',zOutputNE);	MAC_OutputState('NH',zOutputNH);	MAC_OutputState('NJ',zOutputNJ);
MAC_OutputState('NM',zOutputNM);	MAC_OutputState('NV',zOutputNV);	MAC_OutputState('NY',zOutputNY);	MAC_OutputState('OH',zOutputOH);
MAC_OutputState('OK',zOutputOK);	MAC_OutputState('OR',zOutputOR);	MAC_OutputState('PA',zOutputPA);	MAC_OutputState('RI',zOutputRI);
MAC_OutputState('SC',zOutputSC);	MAC_OutputState('SD',zOutputSD);	MAC_OutputState('TN',zOutputTN);	MAC_OutputState('TX',zOutputTX);
MAC_OutputState('UT',zOutputUT);	MAC_OutputState('VA',zOutputVA);	MAC_OutputState('VI',zOutputVI); MAC_OutputState('VT',zOutputVT);	MAC_OutputState('WA',zOutputWA);
MAC_OutputState('WI',zOutputWI);	MAC_OutputState('WV',zOutputWV);	MAC_OutputState('WY',zOutputWY);

MAC_DesprayState('AK',zDesprayAK);	MAC_DesprayState('AL',zDesprayAL);	MAC_DesprayState('AR',zDesprayAR);	MAC_DesprayState('AZ',zDesprayAZ);
MAC_DesprayState('CA',zDesprayCA);	MAC_DesprayState('CO',zDesprayCO);	MAC_DesprayState('CT',zDesprayCT);	MAC_DesprayState('DC',zDesprayDC);
MAC_DesprayState('DE',zDesprayDE);	MAC_DesprayState('FL',zDesprayFL);	MAC_DesprayState('GA',zDesprayGA);	MAC_DesprayState('HI',zDesprayHI);
MAC_DesprayState('IA',zDesprayIA);	MAC_DesprayState('ID',zDesprayID);	MAC_DesprayState('IL',zDesprayIL);	MAC_DesprayState('IN',zDesprayIN);
MAC_DesprayState('KS',zDesprayKS);	MAC_DesprayState('KY',zDesprayKY);	MAC_DesprayState('LA',zDesprayLA);	MAC_DesprayState('MA',zDesprayMA);
MAC_DesprayState('MD',zDesprayMD);	MAC_DesprayState('ME',zDesprayME);	MAC_DesprayState('MI',zDesprayMI);	MAC_DesprayState('MN',zDesprayMN);
MAC_DesprayState('MO',zDesprayMO);	MAC_DesprayState('MS',zDesprayMS);	MAC_DesprayState('MT',zDesprayMT);	MAC_DesprayState('NC',zDesprayNC);
MAC_DesprayState('ND',zDesprayND);	MAC_DesprayState('NE',zDesprayNE);	MAC_DesprayState('NH',zDesprayNH);	MAC_DesprayState('NJ',zDesprayNJ);
MAC_DesprayState('NM',zDesprayNM);	MAC_DesprayState('NV',zDesprayNV);	MAC_DesprayState('NY',zDesprayNY);	MAC_DesprayState('OH',zDesprayOH);
MAC_DesprayState('OK',zDesprayOK);	MAC_DesprayState('OR',zDesprayOR);	MAC_DesprayState('PA',zDesprayPA);	MAC_DesprayState('RI',zDesprayRI);
MAC_DesprayState('SC',zDespraySC);	MAC_DesprayState('SD',zDespraySD);	MAC_DesprayState('TN',zDesprayTN);	MAC_DesprayState('TX',zDesprayTX);
MAC_DesprayState('UT',zDesprayUT);	MAC_DesprayState('VA',zDesprayVA);	MAC_DesprayState('VI',zDesprayVI); MAC_DesprayState('VT',zDesprayVT);	MAC_DesprayState('WA',zDesprayWA);
MAC_DesprayState('WI',zDesprayWI);	MAC_DesprayState('WV',zDesprayWV);	MAC_DesprayState('WY',zDesprayWY);	

MAC_OutputDebugCounts('AK',zDebugAK);	MAC_OutputDebugCounts('AL',zDebugAL);	MAC_OutputDebugCounts('AR',zDebugAR);	MAC_OutputDebugCounts('AZ',zDebugAZ);
MAC_OutputDebugCounts('CA',zDebugCA);	MAC_OutputDebugCounts('CO',zDebugCO);	MAC_OutputDebugCounts('CT',zDebugCT);	MAC_OutputDebugCounts('DC',zDebugDC);
MAC_OutputDebugCounts('DE',zDebugDE);	MAC_OutputDebugCounts('FL',zDebugFL);	MAC_OutputDebugCounts('GA',zDebugGA);	MAC_OutputDebugCounts('HI',zDebugHI);
MAC_OutputDebugCounts('IA',zDebugIA);	MAC_OutputDebugCounts('ID',zDebugID);	MAC_OutputDebugCounts('IL',zDebugIL);	MAC_OutputDebugCounts('IN',zDebugIN);
MAC_OutputDebugCounts('KS',zDebugKS);	MAC_OutputDebugCounts('KY',zDebugKY);	MAC_OutputDebugCounts('LA',zDebugLA);	MAC_OutputDebugCounts('MA',zDebugMA);
MAC_OutputDebugCounts('MD',zDebugMD);	MAC_OutputDebugCounts('ME',zDebugME);	MAC_OutputDebugCounts('MI',zDebugMI);	MAC_OutputDebugCounts('MN',zDebugMN);
MAC_OutputDebugCounts('MO',zDebugMO);	MAC_OutputDebugCounts('MS',zDebugMS);	MAC_OutputDebugCounts('MT',zDebugMT);	MAC_OutputDebugCounts('NC',zDebugNC);
MAC_OutputDebugCounts('ND',zDebugND);	MAC_OutputDebugCounts('NE',zDebugNE);	MAC_OutputDebugCounts('NH',zDebugNH);	MAC_OutputDebugCounts('NJ',zDebugNJ);
MAC_OutputDebugCounts('NM',zDebugNM);	MAC_OutputDebugCounts('NV',zDebugNV);	MAC_OutputDebugCounts('NY',zDebugNY);	MAC_OutputDebugCounts('OH',zDebugOH);
MAC_OutputDebugCounts('OK',zDebugOK);	MAC_OutputDebugCounts('OR',zDebugOR);	MAC_OutputDebugCounts('PA',zDebugPA);	MAC_OutputDebugCounts('RI',zDebugRI);
MAC_OutputDebugCounts('SC',zDebugSC);	MAC_OutputDebugCounts('SD',zDebugSD);	MAC_OutputDebugCounts('TN',zDebugTN);	MAC_OutputDebugCounts('TX',zDebugTX);
MAC_OutputDebugCounts('UT',zDebugUT);	MAC_OutputDebugCounts('VA',zDebugVA);	MAC_OutputDebugCounts('VI',zDebugVI); MAC_OutputDebugCounts('VT',zDebugVT);	MAC_OutputDebugCounts('WA',zDebugWA);
MAC_OutputDebugCounts('WI',zDebugWI);	MAC_OutputDebugCounts('WV',zDebugWV);	MAC_OutputDebugCounts('WY',zDebugWY);

MAC_DesprayDebugState('AK',zDesprayDebugAK);	MAC_DesprayDebugState('AL',zDesprayDebugAL);	MAC_DesprayDebugState('AR',zDesprayDebugAR);	MAC_DesprayDebugState('AZ',zDesprayDebugAZ);
MAC_DesprayDebugState('CA',zDesprayDebugCA);	MAC_DesprayDebugState('CO',zDesprayDebugCO);	MAC_DesprayDebugState('CT',zDesprayDebugCT);	MAC_DesprayDebugState('DC',zDesprayDebugDC);
MAC_DesprayDebugState('DE',zDesprayDebugDE);	MAC_DesprayDebugState('FL',zDesprayDebugFL);	MAC_DesprayDebugState('GA',zDesprayDebugGA);	MAC_DesprayDebugState('HI',zDesprayDebugHI);
MAC_DesprayDebugState('IA',zDesprayDebugIA);	MAC_DesprayDebugState('ID',zDesprayDebugID);	MAC_DesprayDebugState('IL',zDesprayDebugIL);	MAC_DesprayDebugState('IN',zDesprayDebugIN);
MAC_DesprayDebugState('KS',zDesprayDebugKS);	MAC_DesprayDebugState('KY',zDesprayDebugKY);	MAC_DesprayDebugState('LA',zDesprayDebugLA);	MAC_DesprayDebugState('MA',zDesprayDebugMA);
MAC_DesprayDebugState('MD',zDesprayDebugMD);	MAC_DesprayDebugState('ME',zDesprayDebugME);	MAC_DesprayDebugState('MI',zDesprayDebugMI);	MAC_DesprayDebugState('MN',zDesprayDebugMN);
MAC_DesprayDebugState('MO',zDesprayDebugMO);	MAC_DesprayDebugState('MS',zDesprayDebugMS);	MAC_DesprayDebugState('MT',zDesprayDebugMT);	MAC_DesprayDebugState('NC',zDesprayDebugNC);
MAC_DesprayDebugState('ND',zDesprayDebugND);	MAC_DesprayDebugState('NE',zDesprayDebugNE);	MAC_DesprayDebugState('NH',zDesprayDebugNH);	MAC_DesprayDebugState('NJ',zDesprayDebugNJ);
MAC_DesprayDebugState('NM',zDesprayDebugNM);	MAC_DesprayDebugState('NV',zDesprayDebugNV);	MAC_DesprayDebugState('NY',zDesprayDebugNY);	MAC_DesprayDebugState('OH',zDesprayDebugOH);
MAC_DesprayDebugState('OK',zDesprayDebugOK);	MAC_DesprayDebugState('OR',zDesprayDebugOR);	MAC_DesprayDebugState('PA',zDesprayDebugPA);	MAC_DesprayDebugState('RI',zDesprayDebugRI);
MAC_DesprayDebugState('SC',zDesprayDebugSC);	MAC_DesprayDebugState('SD',zDesprayDebugSD);	MAC_DesprayDebugState('TN',zDesprayDebugTN);	MAC_DesprayDebugState('TX',zDesprayDebugTX);
MAC_DesprayDebugState('UT',zDesprayDebugUT);	MAC_DesprayDebugState('VA',zDesprayDebugVA);	MAC_DesprayDebugState('VI',zDesprayDebugVI); MAC_DesprayDebugState('VT',zDesprayDebugVT);	MAC_DesprayDebugState('WA',zDesprayDebugWA);
MAC_DesprayDebugState('WI',zDesprayDebugWI);	MAC_DesprayDebugState('WV',zDesprayDebugWV);	MAC_DesprayDebugState('WY',zDesprayDebugWY);	

SEQUENTIAL(OUTPUT(gDebugOnly,NAMED('Debug_Only_Flag')),
						OUTPUT(gIncludeDebug,NAMED('Include_Debug_Flag')),
						PARALLEL(	// PARALLEL for all outputs at the same time
#IF(NOT gDebugOnly)
											PARALLEL( zOutputAK,zOutputAL,zOutputAR,zOutputAZ,zOutputCA,zOutputCO,zOutputCT
																,zOutputDC,zOutputDE,zOutputFL,zOutputGA,zOutputHI,zOutputIA,zOutputID
																,zOutputIL,zOutputIN,zOutputKS,zOutputKY,zOutputLA,zOutputMA,zOutputMD
																,zOutputME,zOutputMI,zOutputMN,zOutputMO,zOutputMS,zOutputMT,zOutputNC
																,zOutputND,zOutputNE,zOutputNH,zOutputNJ,zOutputNM,zOutputNV,zOutputNY
																,zOutputOH,zOutputOK,zOutputOR,zOutputPA,zOutputRI,zOutputSC,zOutputSD
																,zOutputTN,zOutputTX,zOutputUT,zOutputVA,zOutputVI,zOutputVT,zOutputWA,zOutputWI
																,zOutputWV,zOutputWY
																),
#END // #IF(NOT gDebugOnly)
#IF(gIncludeDebug)
						PARALLEL( zDebugAK,zDebugAL,zDebugAR,zDebugAZ,zDebugCA,zDebugCO,zDebugCT
											,zDebugDC,zDebugDE,zDebugFL,zDebugGA,zDebugHI,zDebugIA,zDebugID
											,zDebugIL,zDebugIN,zDebugKS,zDebugKY,zDebugLA,zDebugMA,zDebugMD
											,zDebugME,zDebugMI,zDebugMN,zDebugMO,zDebugMS,zDebugMT,zDebugNC
											,zDebugND,zDebugNE,zDebugNH,zDebugNJ,zDebugNM,zDebugNV,zDebugNY
											,zDebugOH,zDebugOK,zDebugOR,zDebugPA,zDebugRI,zDebugSC,zDebugSD
											,zDebugTN,zDebugTX,zDebugUT,zDebugVA,zDebugVI,zDebugVT,zDebugWA,zDebugWI
											,zDebugWV,zDebugWY
											),
#END // #IF(gIncludeDebug)
						OUTPUT('')
											),	// PARALLEL for all outputs at the same time
#IF(NOT gDebugOnly)
						PARALLEL( zDesprayAK,zDesprayAL,zDesprayAR,zDesprayAZ,zDesprayCA,zDesprayCO,zDesprayCT
											,zDesprayDC,zDesprayDE,zDesprayFL,zDesprayGA,zDesprayHI,zDesprayIA,zDesprayID
											,zDesprayIL,zDesprayIN,zDesprayKS,zDesprayKY,zDesprayLA,zDesprayMA,zDesprayMD
											,zDesprayME,zDesprayMI,zDesprayMN,zDesprayMO,zDesprayMS,zDesprayMT,zDesprayNC
											,zDesprayND,zDesprayNE,zDesprayNH,zDesprayNJ,zDesprayNM,zDesprayNV,zDesprayNY
											,zDesprayOH,zDesprayOK,zDesprayOR,zDesprayPA,zDesprayRI,zDespraySC,zDespraySD
											,zDesprayTN,zDesprayTX,zDesprayUT,zDesprayVA,zDesprayVI,zDesprayVT,zDesprayWA,zDesprayWI
											,zDesprayWV,zDesprayWY
											),
#END // #IF(NOT gDebugOnly)
#IF(gIncludeDebug)
						PARALLEL( zDesprayDebugAK,zDesprayDebugAL,zDesprayDebugAR,zDesprayDebugAZ,zDesprayDebugCA,zDesprayDebugCO,zDesprayDebugCT
											,zDesprayDebugDC,zDesprayDebugDE,zDesprayDebugFL,zDesprayDebugGA,zDesprayDebugHI,zDesprayDebugIA,zDesprayDebugID
											,zDesprayDebugIL,zDesprayDebugIN,zDesprayDebugKS,zDesprayDebugKY,zDesprayDebugLA,zDesprayDebugMA,zDesprayDebugMD
											,zDesprayDebugME,zDesprayDebugMI,zDesprayDebugMN,zDesprayDebugMO,zDesprayDebugMS,zDesprayDebugMT,zDesprayDebugNC
											,zDesprayDebugND,zDesprayDebugNE,zDesprayDebugNH,zDesprayDebugNJ,zDesprayDebugNM,zDesprayDebugNV,zDesprayDebugNY
											,zDesprayDebugOH,zDesprayDebugOK,zDesprayDebugOR,zDesprayDebugPA,zDesprayDebugRI,zDesprayDebugSC,zDesprayDebugSD
											,zDesprayDebugTN,zDesprayDebugTX,zDesprayDebugUT,zDesprayDebugVA,zDesprayDebugVI,zDesprayDebugVT,zDesprayDebugWA,zDesprayDebugWI
											,zDesprayDebugWV,zDesprayDebugWY
											),
#END // #IF(gIncludeDebug)
						OUTPUT('')	// Included only to allow all above to have ending comma in SEQUENTIAL structure :-)
					 );
