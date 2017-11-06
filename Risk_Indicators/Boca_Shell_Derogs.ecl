/*2017-08-31T13:21:39Z (khuls)
C:\Users\hulske01\AppData\Roaming\HPCC Systems\eclide\khuls\dataland_dev\Risk_Indicators\Boca_Shell_Derogs\2017-08-31T13_21_39Z.ecl
*/

import doxie_files, property, riskwise, bankruptcyv3, liensv2, ut;

export Boca_Shell_Derogs (GROUPED DATASET(layouts.layout_derogs_input) ids, unsigned1 BSversion=1) := function

	layout_derog_process := RECORD
		layouts.layout_derogs_input;
		Layout_Derogs BJL;
		Layouts.Layout_Liens Liens;
	END;
	
layout_extended :=
RECORD
	layout_derog_process;
	string5  court_code; // bk extras
	string7  case_num; 
	string50 bk_tmsid;
	
	STRING50 rmsid; // liens extras
	string50 tmsid; // liens extras
	unsigned4 date_first_seen;	// liens extras
	unsigned4 date_last_seen;	// liens extras
	boolean evictionRec;
	STRING70 fid; // foreclosure extras
	unsigned4 bk_disp_date;
END;

bans_did := BankruptcyV3.key_bankruptcyV3_did();
bans_search := BankruptcyV3.key_bankruptcyv3_search_full_bip();

layout_extended add_bankrupt_keys(layouts.layout_derogs_input le, bans_did ri) := TRANSFORM
	self.bk_tmsid := ri.tmsid;
	SELF.court_code := ri.court_code;
	SELF.case_num := ri.case_number;

	SELF := le;
	SELF := [];
END;
bankrupt_added := JOIN(ids, bans_did ,LEFT.did=RIGHT.did, add_bankrupt_keys(LEFT,RIGHT), LEFT OUTER, atmost(riskwise.max_atmost), KEEP(100));

layout_extended get_bankrupt_search (layout_extended le, bans_search ri) := TRANSFORM
	myGetDate := iid_constants.myGetDate(le.historydate);
	SELF.BJL.bankrupt := ri.case_number<>'';
	date_last_seen :=  if(bsversion<50, MAX((INTEGER)ri.date_filed, if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0)),(INTEGER) ri.date_filed);// only use disposition date if it is not in the future
	SELF.BJL.date_last_seen := date_last_seen;//date_last_seen - which is really the date of the filing;
	SELF.BJL.filing_type := ri.filing_type;
	SELF.BJL.disposition := ri.disposition;
 	hit := ri.case_number<>'';
	SELF.BJL.filing_count := (INTEGER)hit;
	SELF.BJL.filing_count120 := if(hit, (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(10), le.historydate), 0);
	SELF.BJL.bk_recent_count := (INTEGER)(hit AND ri.disposition='');
	
	date_disp := if(bsversion<50, (INTEGER) ri.discharged, date_last_seen);
	SELF.BJL.bk_disposed_recent_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp,myGetDate)<365*2+1);// we are potentially counting some dispositions in the future but not others depending on the dates
	SELF.BJL.bk_disposed_historical_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp,myGetDate)>365*2);
	SELF.BJL.bk_disposed_historical_cnt120 := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp,myGetDate)>365*2 AND
																						 risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_disp,ut.DaysInNYears(10), le.historydate));
	SELF.BJL.bk_dismissed_recent_count := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string) date_disp,myGetDate)<365*2+1);// we are potentially counting some dispositions in the future but not others depending on the dates
	SELF.BJL.bk_dismissed_historical_count := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string) date_disp,myGetDate)>365*2);
	SELF.BJL.bk_dismissed_historical_cnt120 := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string) date_disp,myGetDate)>365*2 AND 
																							risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_disp,ut.DaysInNYears(10), le.historydate));
	
	SELF.BJL.bk_count30 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,30, le.historydate);
	SELF.BJL.bk_count90 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,90, le.historydate);
	SELF.BJL.bk_count180 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,180, le.historydate);
	SELF.BJL.bk_count12 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(1), le.historydate);
	SELF.BJL.bk_count24 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(2), le.historydate);
	SELF.BJL.bk_count36 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(3), le.historydate);
	SELF.BJL.bk_count60 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(5), le.historydate);
  SELF.BJL.bk_chapter := ri.chapter;	
	SELF.bk_disp_date := MAX((INTEGER)ri.date_filed, 
			if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0));
	SELF := le;
END;

bankrupt_full := JOIN (bankrupt_added, bans_search,
                       LEFT.bk_tmsid<>'' AND
                       keyed(LEFT.bk_tmsid = RIGHT.tmsid) AND
											 right.name_type='D' and
											 (unsigned)right.did=left.did and
                       (unsigned)(RIGHT.date_filed[1..6]) < left.historydate,
											 get_bankrupt_search(LEFT,RIGHT),
											 LEFT OUTER, KEEP(100),
				ATMOST(Riskwise.max_atmost));

layout_extended roll_bankrupt(layout_extended le, layout_extended ri) := TRANSFORM
	sameBankruptcy := le.case_num=ri.case_num AND le.court_code=ri.court_code;
	SELF.BJL.bankrupt := le.BJL.bankrupt OR ri.BJL.bankrupt;
	
	// keep the filing type and disposition together with the date that is selected 
	// instead of always selecting the left filing type and left disposition
	use_right := ri.BJL.date_last_seen > le.BJL.date_last_seen;
	SELF.BJL.date_last_seen := if(use_right, ri.BJL.date_last_seen, le.BJL.date_last_seen);
	SELF.BJL.filing_type := if(use_right, ri.BJL.filing_type, le.BJL.filing_type);
	SELF.BJL.disposition := if(use_right, ri.BJL.disposition, le.BJL.disposition);
	
	SELF.BJL.filing_count := le.BJL.filing_count + IF(sameBankruptcy, 0, ri.BJL.filing_count);
	SELF.BJL.filing_count120 := le.BJL.filing_count120 + IF(sameBankruptcy, 0, ri.BJL.filing_count120);
	SELF.BJL.bk_recent_count := le.BJL.bk_recent_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_recent_count);
	SELF.BJL.bk_disposed_recent_count := le.BJL.bk_disposed_recent_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_disposed_recent_count);
	SELF.BJL.bk_disposed_historical_count := le.BJL.bk_disposed_historical_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_disposed_historical_count);
	SELF.BJL.bk_disposed_historical_cnt120 := le.BJL.bk_disposed_historical_cnt120 + 
								IF(sameBankruptcy, 0, ri.BJL.bk_disposed_historical_cnt120);
	SELF.BJL.bk_dismissed_recent_count := le.BJL.bk_dismissed_recent_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_dismissed_recent_count);
	SELF.BJL.bk_dismissed_historical_count := le.BJL.bk_dismissed_historical_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_dismissed_historical_count);
	SELF.BJL.bk_dismissed_historical_cnt120 := le.BJL.bk_dismissed_historical_cnt120 + 
								IF(sameBankruptcy, 0, ri.BJL.bk_dismissed_historical_cnt120);
								
	SELF.BJL.bk_count30 := le.BJL.bk_count30 + IF(sameBankruptcy,0,ri.BJL.bk_count30);
	SELF.BJL.bk_count90 := le.BJL.bk_count90 + IF(sameBankruptcy,0,ri.BJL.bk_count90);
	SELF.BJL.bk_count180 := le.BJL.bk_count180 + IF(sameBankruptcy,0,ri.BJL.bk_count180);
	SELF.BJL.bk_count12 := le.BJL.bk_count12 + IF(sameBankruptcy,0,ri.BJL.bk_count12);
	SELF.BJL.bk_count24 := le.BJL.bk_count24 + IF(sameBankruptcy,0,ri.BJL.bk_count24);
	SELF.BJL.bk_count36 := le.BJL.bk_count36 + IF(sameBankruptcy,0,ri.BJL.bk_count36);
	SELF.BJL.bk_count60 := le.BJL.bk_count60 + IF(sameBankruptcy,0,ri.BJL.bk_count60);
	SELF.BJL.bk_chapter    := if(use_right, ri.BJL.bk_chapter, le.BJL.bk_chapter);
	self.case_num := ri.case_num;
	self.court_code := ri.court_code;
	SELF := le;
END;

bankrupt_rolled_tmp := ROLLUP(SORT(bankrupt_full,seq,did,court_code,case_num,-BJL.date_last_seen), LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT));

//have to sort by desc disp_date so can keep track of the most recent disp
//disp_dates := if(bankrupt_full.bk_disp_date = 0, bankrupt_full.date_last_seen, bankrupt_full.bk_disp_date);
bankrupt_disp := DEDUP(SORT(bankrupt_full, seq, did,-bk_disp_date, -BJL.date_last_seen), seq, did);
bankrupt_rolled_disp := JOIN(bankrupt_rolled_tmp, bankrupt_disp,
	LEFT.seq = RIGHT.seq and LEFT.did = RIGHT.did,
	TRANSFORM(layout_extended, 
		SELF.BJL.date_last_seen := RIGHT.BJL.date_last_seen;
		SELF.BJL.filing_type := RIGHT.BJL.filing_type;
		SELF.BJL.disposition := RIGHT.BJL.disposition;
		SELF.case_num := RIGHT.case_num;
		SELF.court_code := RIGHT.court_code;
		SELF.BJL.bk_chapter := RIGHT.BJL.bk_chapter;
		SELF := LEFT),
	LEFT OUTER);
bankrupt_rolled := if(bsVersion < 50, bankrupt_rolled_tmp, group(bankrupt_rolled_disp, seq));
	
kld			:= liensv2.key_liens_DID;
klr_nonFCRA	:= liensv2.key_liens_party_id;
	
layout_extended add_liens(layout_extended le, kld ri) := TRANSFORM
	self.tmsid := ri.tmsid;
	SELF.rmsid := ri.rmsid;
	SELF := le;
	self := []; 
END;

liens_added := JOIN(bankrupt_rolled, kld, keyed(LEFT.did=RIGHT.did), add_liens(LEFT,RIGHT), LEFT OUTER, KEEP(100),
					ATMOST(keyed(left.did=right.did), Riskwise.max_atmost));


layout_extended get_liens_nonFCRA(layout_extended le, klr_nonFCRA ri) := TRANSFORM
	myGetDate := iid_constants.myGetDate(le.historydate);
	isRecent := ut.DaysApart(ri.date_first_seen,myGetDate)<365*2+1;
	
	// Unreleased Liens--------------------------------
	SELF.BJL.last_liens_unreleased_date := if((INTEGER)ri.date_last_seen=0, ri.date_first_seen, '');		
	SELF.BJL.liens_last_unrel_date84 := if((INTEGER)ri.date_last_seen=0 and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7),le.historydate), ri.date_first_seen, '');		
	SELF.BJL.liens_recent_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																				 (INTEGER)ri.date_last_seen=0 AND
																					isRecent );
	SELF.BJL.liens_historical_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																						(INTEGER)ri.date_last_seen=0 AND
																						~isRecent );
																						
	SELF.BJL.liens_unreleased_count30 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and  
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,30,le.historydate));
	SELF.BJL.liens_unreleased_count90 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,90,le.historydate));
	SELF.BJL.liens_unreleased_count180 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and  
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,180,le.historydate));
	SELF.BJL.liens_unreleased_count12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(1),le.historydate));
	SELF.BJL.liens_unreleased_count24 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(2),le.historydate));
	SELF.BJL.liens_unreleased_count36 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(3),le.historydate));
	SELF.BJL.liens_unreleased_count60 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and  
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(5),le.historydate));																			
	SELF.BJL.liens_unreleased_count84 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and  
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7),le.historydate));																			
																																									
	// Released Liens	-----------------------------------		
	SELF.BJL.last_liens_released_date := if((INTEGER)ri.date_last_seen<>0, (unsigned)ri.date_first_seen, 0);
	SELF.BJL.liens_last_rel_date84	:= if((INTEGER)ri.date_last_seen<>0 and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7),le.historydate), (unsigned)ri.date_last_seen, 0);
	SELF.BJL.liens_recent_released_count := (INTEGER)(ri.rmsid<>'' AND 
																			(INTEGER)ri.date_last_seen<>0 AND
																			isRecent);
	SELF.BJL.liens_historical_released_count := (INTEGER)(ri.rmsid<>'' AND 
																					(INTEGER)ri.date_last_seen<>0 AND
																					~isRecent);
																					
	SELF.BJL.liens_released_count30 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,30,le.historydate));
	SELF.BJL.liens_released_count90 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,90,le.historydate));
	SELF.BJL.liens_released_count180 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,180,le.historydate));
	SELF.BJL.liens_released_count12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(1),le.historydate));
	SELF.BJL.liens_released_count24 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(2),le.historydate));
	SELF.BJL.liens_released_count36 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(3),le.historydate));
	SELF.BJL.liens_released_count60 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(5),le.historydate));																				
	SELF.BJL.liens_released_count84 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7),le.historydate));																				
																																		
	SELF.date_first_seen := (unsigned)ri.date_first_seen;// to be used in evictions
	SELF.date_last_seen := (unsigned)ri.date_last_seen;// to be used in evictions
	
	self.tmsid := if(ri.tmsid='', '', le.tmsid);	// set these to blank so that we miss on the evictions search below
  self.rmsid := if(ri.rmsid='', '', le.rmsid);
	
	SELF := le;
END;

liens_full := JOIN (liens_added, klr_nonFCRA, 
                    LEFT.rmsid<>'' AND
                    keyed(left.tmsid=right.tmsid) and keyed(LEFT.rmsid=RIGHT.rmsid) AND 
										right.name_type='D' and 
										(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate,
                    get_liens_nonFCRA(LEFT,RIGHT),
										LEFT OUTER, KEEP(100),
				ATMOST(keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid), Riskwise.max_atmost));


layout_extended get_evictions(liens_full le, liensV2.key_liens_main_ID ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	isRecent := ut.DaysApart((string8)le.date_first_seen,myGetDate)<365*2+1;
	
	isEviction := ri.eviction='Y';
  self.evictionRec  := isEviction;
	// evictions
	SELF.BJL.eviction_recent_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND isRecent);
	SELF.BJL.eviction_historical_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND ~isRecent);
	SELF.BJL.eviction_recent_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND isRecent);
	SELF.BJL.eviction_historical_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND ~isRecent);
	
	SELF.BJL.eviction_count := (integer)(isEviction);
	SELF.BJL.eviction_count30 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,le.historydate));
	SELF.BJL.eviction_count90 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,le.historydate));
	SELF.BJL.eviction_count180 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,le.historydate));
	SELF.BJL.eviction_count12 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),le.historydate));
	SELF.BJL.eviction_count24 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),le.historydate));
	SELF.BJL.eviction_count36 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),le.historydate));
	SELF.BJL.eviction_count60 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),le.historydate));
	SELF.BJL.eviction_count84 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(7),le.historydate));

	SELF.BJL.last_eviction_date := if(isEviction, (unsigned)le.date_first_seen, 0);

	// they want liens seperated by type and released or unreleased for boca shell 3.0
	ftd := trim(stringlib.stringtouppercase(ri.filing_type_desc));
	goodResult := ri.rmsid<>'';
	unreleased := le.date_last_seen=0;
	released := le.date_last_seen<>0;
	
	// only count evictions in the liens buckets if you are running version prior to 50
	isCivilJudgment := ftd in iid_constants.setCivilJudgment and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits) );
	isCivilJudgmentReleased := ftd in iid_constants.setCivilJudgment and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isFederalTax := ftd in iid_constants.setFederalTax and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isFederalTaxReleased := ftd in iid_constants.setFederalTax and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isForeclosure := ftd in iid_constants.setForeclosure and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isForeclosureReleased := ftd in iid_constants.setForeclosure and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isLandlordTenant := ftd in iid_constants.setLandlordTenant and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isLandlordTenantReleased := ftd in iid_constants.setLandlordTenant and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isLisPendens := ftd in iid_constants.setLisPendens and goodResult and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isLisPendensReleased := ftd in iid_constants.setLisPendens and goodResult and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isOtherLJ := ftd not in iid_constants.setOtherLJ and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isOtherLJReleased := ftd not in iid_constants.setOtherLJ and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isOtherTax := ftd in iid_constants.setOtherTax and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isOtherTaxReleased := ftd in iid_constants.setOtherTax and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isSmallClaims := ftd in iid_constants.setSmallClaims and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isSmallClaimsReleased := ftd in iid_constants.setSmallClaims and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuits));
	isSuits := ftd in iid_constants.setSuits and goodResult and unreleased and (bsversion<50 or (~isEviction));
	isSuitsReleased := ftd in iid_constants.setSuits and goodResult and released and (bsversion<50 or (~isEviction));
	
	isWithin84 := risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(7),le.historydate);
	isAnyUnreleased := isCivilJudgment or isFederalTax or isForeclosure or isLandlordTenant or isLisPendens or isOtherLJ or isOtherTax or isSmallClaims or isSuits;
	isAnyReleased 	:= isCivilJudgmentReleased or isFederalTaxReleased or isForeclosureReleased or isLandlordTenantReleased or isLisPendensReleased or isOtherLJReleased or isOtherTaxReleased or isSmallClaimsReleased or isSuitsReleased;

	self.liens.liens_unrel_total_amount84 := if(isWithin84 and isAnyUnreleased, (real)ri.amount, 0);
	self.liens.liens_rel_total_amount84 	:= if(isWithin84 and isAnyReleased, (real)ri.amount, 0);
	self.liens.liens_unrel_total_amount 	:= if(isAnyUnreleased, (real)ri.amount, 0);
	self.liens.liens_rel_total_amount 		:= if(isAnyReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_civil_judgment.count := (integer)isCivilJudgment;
	self.liens.liens_unreleased_civil_judgment.earliest_filing_date := if(isCivilJudgment, le.date_first_seen, 0);
	self.liens.liens_unreleased_civil_judgment.most_recent_filing_date := if(isCivilJudgment, le.date_first_seen, 0);
	self.liens.liens_unreleased_civil_judgment.total_amount := if(isCivilJudgment, (real)ri.amount, 0);
	
	self.liens.liens_released_civil_judgment.count := (integer)isCivilJudgmentReleased;
	self.liens.liens_released_civil_judgment.earliest_filing_date := if(isCivilJudgmentReleased, le.date_first_seen, 0);
	self.liens.liens_released_civil_judgment.most_recent_filing_date := if(isCivilJudgmentReleased, le.date_first_seen, 0);
	self.liens.liens_released_civil_judgment.total_amount := if(isCivilJudgmentReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_federal_tax.count := (integer)isFederalTax;
	self.liens.liens_unreleased_federal_tax.earliest_filing_date := if(isFederalTax, le.date_first_seen, 0);
	self.liens.liens_unreleased_federal_tax.most_recent_filing_date := if(isFederalTax, le.date_first_seen, 0);
	self.liens.liens_unreleased_federal_tax.total_amount := if(isFederalTax, (real)ri.amount, 0);
	
	self.liens.liens_released_federal_tax.count := (integer)isFederalTaxReleased;
	self.liens.liens_released_federal_tax.earliest_filing_date := if(isFederalTaxReleased, le.date_first_seen, 0);
	self.liens.liens_released_federal_tax.most_recent_filing_date := if(isFederalTaxReleased, le.date_first_seen, 0);
	self.liens.liens_released_federal_tax.total_amount := if(isFederalTaxReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_foreclosure.count := (integer)isForeclosure;
	self.liens.liens_unreleased_foreclosure.earliest_filing_date := if(isForeclosure, le.date_first_seen, 0);
	self.liens.liens_unreleased_foreclosure.most_recent_filing_date := if(isForeclosure, le.date_first_seen, 0);
	self.liens.liens_unreleased_foreclosure.total_amount := if(isForeclosure, (real)ri.amount, 0);
	
	self.liens.liens_released_foreclosure.count := (integer)isForeclosureReleased;
	self.liens.liens_released_foreclosure.earliest_filing_date := if(isForeclosureReleased, le.date_first_seen, 0);
	self.liens.liens_released_foreclosure.most_recent_filing_date := if(isForeclosureReleased, le.date_first_seen, 0);
	self.liens.liens_released_foreclosure.total_amount := if(isForeclosureReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_landlord_tenant.count := (integer)isLandlordTenant;
	self.liens.liens_unreleased_landlord_tenant.earliest_filing_date := if(isLandlordTenant, le.date_first_seen, 0);
	self.liens.liens_unreleased_landlord_tenant.most_recent_filing_date := if(isLandlordTenant, le.date_first_seen, 0);
	self.liens.liens_unreleased_landlord_tenant.total_amount := if(isLandlordTenant, (real)ri.amount, 0);
	
	self.liens.liens_released_landlord_tenant.count := (integer)isLandlordTenantReleased;
	self.liens.liens_released_landlord_tenant.earliest_filing_date := if(isLandlordTenantReleased, le.date_first_seen, 0);
	self.liens.liens_released_landlord_tenant.most_recent_filing_date := if(isLandlordTenantReleased, le.date_first_seen, 0);
	self.liens.liens_released_landlord_tenant.total_amount := if(isLandlordTenantReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_lispendens.count := (integer)isLisPendens;
	self.liens.liens_unreleased_lispendens.earliest_filing_date := if(isLisPendens, le.date_first_seen, 0);
	self.liens.liens_unreleased_lispendens.most_recent_filing_date := if(isLisPendens, le.date_first_seen, 0);
	self.liens.liens_unreleased_lispendens.total_amount := if(isLisPendens, (real)ri.amount, 0);
	
	self.liens.liens_released_lispendens.count := (integer)isLisPendensReleased;
	self.liens.liens_released_lispendens.earliest_filing_date := if(isLisPendensReleased, le.date_first_seen, 0);
	self.liens.liens_released_lispendens.most_recent_filing_date := if(isLisPendensReleased, le.date_first_seen, 0);
	self.liens.liens_released_lispendens.total_amount := if(isLisPendensReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_other_lj.count := (integer)isOtherLJ;
	self.liens.liens_unreleased_other_lj.earliest_filing_date := if(isOtherLJ, le.date_first_seen, 0);
	self.liens.liens_unreleased_other_lj.most_recent_filing_date := if(isOtherLJ, le.date_first_seen, 0);
	self.liens.liens_unreleased_other_lj.total_amount := if(isOtherLJ, (real)ri.amount, 0);
	
	self.liens.liens_released_other_lj.count := (integer)isOtherLJReleased;
	self.liens.liens_released_other_lj.earliest_filing_date := if(isOtherLJReleased, le.date_first_seen, 0);
	self.liens.liens_released_other_lj.most_recent_filing_date := if(isOtherLJReleased, le.date_first_seen, 0);
	self.liens.liens_released_other_lj.total_amount := if(isOtherLJReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_other_tax.count := (integer)isOtherTax;
	self.liens.liens_unreleased_other_tax.earliest_filing_date := if(isOtherTax, le.date_first_seen, 0);
	self.liens.liens_unreleased_other_tax.most_recent_filing_date := if(isOtherTax, le.date_first_seen, 0);
	self.liens.liens_unreleased_other_tax.total_amount := if(isOtherTax, (real)ri.amount, 0);
	
	self.liens.liens_released_other_tax.count := (integer)isOtherTaxReleased;
	self.liens.liens_released_other_tax.earliest_filing_date := if(isOtherTaxReleased, le.date_first_seen, 0);
	self.liens.liens_released_other_tax.most_recent_filing_date := if(isOtherTaxReleased, le.date_first_seen, 0);
	self.liens.liens_released_other_tax.total_amount := if(isOtherTaxReleased, (real)ri.amount, 0);
	
	self.liens.liens_unreleased_small_claims.count := (integer)isSmallClaims;
	self.liens.liens_unreleased_small_claims.earliest_filing_date := if(isSmallClaims, le.date_first_seen, 0);
	self.liens.liens_unreleased_small_claims.most_recent_filing_date := if(isSmallClaims, le.date_first_seen, 0);
	self.liens.liens_unreleased_small_claims.total_amount := if(isSmallClaims, (real)ri.amount, 0);
	
	self.liens.liens_released_small_claims.count := (integer)isSmallClaimsReleased;
	self.liens.liens_released_small_claims.earliest_filing_date := if(isSmallClaimsReleased, le.date_first_seen, 0);
	self.liens.liens_released_small_claims.most_recent_filing_date := if(isSmallClaimsReleased, le.date_first_seen, 0);
	self.liens.liens_released_small_claims.total_amount := if(isSmallClaimsReleased, (real)ri.amount, 0);

	self.liens.liens_unreleased_suits.count := (integer)isSuits;
	self.liens.liens_unreleased_suits.earliest_filing_date := if(isSuits, le.date_first_seen, 0);
	self.liens.liens_unreleased_suits.most_recent_filing_date := if(isSuits, le.date_first_seen, 0);
	self.liens.liens_unreleased_suits.total_amount := if(isSuits, (real)ri.amount, 0);
	
	self.liens.liens_released_suits.count := (integer)isSuitsReleased;
	self.liens.liens_released_suits.earliest_filing_date := if(isSuitsReleased, le.date_first_seen, 0);
	self.liens.liens_released_suits.most_recent_filing_date := if(isSuitsReleased, le.date_first_seen, 0);
	self.liens.liens_released_suits.total_amount := if(isSuitsReleased, (real)ri.amount, 0);
	
	isSuit := isSuits or isSuitsReleased;
	SELF.BJL.last_liens_unreleased_date := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), '', le.bjl.last_liens_unreleased_date);
	SELF.BJL.liens_last_unrel_date84 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), '', le.bjl.liens_last_unrel_date84);
	SELF.BJL.liens_recent_unreleased_count := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_recent_unreleased_count);
	SELF.BJL.liens_historical_unreleased_count := 	if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_historical_unreleased_count);																					
	SELF.BJL.liens_unreleased_count30 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count30);
	SELF.BJL.liens_unreleased_count90 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count90);
	SELF.BJL.liens_unreleased_count180 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count180);
	SELF.BJL.liens_unreleased_count12 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count12);
	SELF.BJL.liens_unreleased_count24 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count24);
	SELF.BJL.liens_unreleased_count36 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count36);
	SELF.BJL.liens_unreleased_count60 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count60);													
	SELF.BJL.liens_unreleased_count84 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_unreleased_count84);													
	SELF.BJL.last_liens_released_date := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.last_liens_released_date);
	SELF.BJL.liens_last_rel_date84 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_last_rel_date84);
	SELF.BJL.liens_recent_released_count := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_recent_released_count);
	SELF.BJL.liens_historical_released_count := 	if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_historical_released_count);																		
	SELF.BJL.liens_released_count30 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count30);
	SELF.BJL.liens_released_count90 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count90);
	SELF.BJL.liens_released_count180 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count180);
	SELF.BJL.liens_released_count12 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count12);
	SELF.BJL.liens_released_count24 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count24);
	SELF.BJL.liens_released_count36 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count36);
	SELF.BJL.liens_released_count60 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count60);	
	SELF.BJL.liens_released_count84 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_released_count84);	

	SELF := le;
end;
liens_main := JOIN(liens_full, liensV2.key_liens_main_ID,
											left.rmsid<>'' and left.tmsid<>'' and 
											keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid)	and
											(bsversion < 50 or trim(stringlib.stringtouppercase(right.filing_type_desc)) not in risk_indicators.iid_constants.set_Invalid_Liens_50), // ignore certain lien types completely if running shell version 5.0 or higher, 
											get_evictions(LEFT,RIGHT), left outer, 
											ATMOST(keyed(LEFT.tmsid=RIGHT.tmsid) and keyed(left.rmsid=right.rmsid), riskwise.max_atmost));
	
layout_extended roll_liens(layout_extended le, layout_extended ri) := TRANSFORM
	sameLien := le.tmsid=ri.tmsid and le.rmsid=ri.rmsid;

	SELF.BJL.liens_recent_unreleased_count := le.BJL.liens_recent_unreleased_count + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_recent_unreleased_count);
	SELF.BJL.liens_historical_unreleased_count := le.BJL.liens_historical_unreleased_count + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_historical_unreleased_count);
	SELF.BJL.liens_unreleased_count30 := le.BJL.liens_unreleased_count30 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count30);
	SELF.BJL.liens_unreleased_count90 := le.BJL.liens_unreleased_count90 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count90);
	SELF.BJL.liens_unreleased_count180 := le.BJL.liens_unreleased_count180 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count180);
	SELF.BJL.liens_unreleased_count12 := le.BJL.liens_unreleased_count12 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count12);
	SELF.BJL.liens_unreleased_count24 := le.BJL.liens_unreleased_count24 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count24);
	SELF.BJL.liens_unreleased_count36 := le.BJL.liens_unreleased_count36 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count36);
	SELF.BJL.liens_unreleased_count60 := le.BJL.liens_unreleased_count60 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count60);
	SELF.BJL.liens_unreleased_count84 := le.BJL.liens_unreleased_count84 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_unreleased_count84);
	
	SELF.BJL.liens_recent_released_count := le.BJL.liens_recent_released_count + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_recent_released_count);
	SELF.BJL.liens_historical_released_count := le.BJL.liens_historical_released_count + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_historical_released_count);
	SELF.BJL.liens_released_count30 := le.BJL.liens_released_count30 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count30);
	SELF.BJL.liens_released_count90 := le.BJL.liens_released_count90 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count90);
	SELF.BJL.liens_released_count180 := le.BJL.liens_released_count180 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count180);
	SELF.BJL.liens_released_count12 := le.BJL.liens_released_count12 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count12);
	SELF.BJL.liens_released_count24 := le.BJL.liens_released_count24 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count24);
	SELF.BJL.liens_released_count36 := le.BJL.liens_released_count36 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count36);
	SELF.BJL.liens_released_count60 := le.BJL.liens_released_count60 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count60);
	SELF.BJL.liens_released_count84 := le.BJL.liens_released_count84 + IF(sameLien or (ri.evictionRec and bsVersion >=50),0,ri.BJL.liens_released_count84);
	
	SELF.BJL.last_liens_unreleased_date := if((integer)le.BJL.last_liens_unreleased_date > (integer)ri.BJL.last_liens_unreleased_date, le.BJL.last_liens_unreleased_date, ri.BJL.last_liens_unreleased_date);
	SELF.BJL.liens_last_unrel_date84 := if((integer)le.BJL.liens_last_unrel_date84 > (integer)ri.BJL.liens_last_unrel_date84, le.BJL.liens_last_unrel_date84, ri.BJL.liens_last_unrel_date84);
	SELF.BJL.last_liens_released_date := if((integer)le.BJL.last_liens_released_date > (integer)ri.BJL.last_liens_released_date, le.BJL.last_liens_released_date, ri.BJL.last_liens_released_date);
	SELF.BJL.liens_last_rel_date84 := if((integer)le.BJL.liens_last_rel_date84 > (integer)ri.BJL.liens_last_rel_date84, le.BJL.liens_last_rel_date84, ri.BJL.liens_last_rel_date84);
	
	SELF.BJL.eviction_recent_unreleased_count := le.BJL.eviction_recent_unreleased_count + IF(sameLien,0,ri.BJL.eviction_recent_unreleased_count);
	SELF.BJL.eviction_historical_unreleased_count := le.BJL.eviction_historical_unreleased_count + IF(sameLien,0,ri.BJL.eviction_historical_unreleased_count);
	SELF.BJL.eviction_recent_released_count := le.BJL.eviction_recent_released_count + IF(sameLien,0,ri.BJL.eviction_recent_released_count);
	SELF.BJL.eviction_historical_released_count := le.BJL.eviction_historical_released_count + IF(sameLien,0,ri.BJL.eviction_historical_released_count);
	
	SELF.BJL.eviction_count := le.BJL.eviction_count + IF(sameLien,0,ri.BJL.eviction_count);
	SELF.BJL.eviction_count30 := le.BJL.eviction_count30 + IF(sameLien,0,ri.BJL.eviction_count30);
	SELF.BJL.eviction_count90 := le.BJL.eviction_count90 + IF(sameLien,0,ri.BJL.eviction_count90);
	SELF.BJL.eviction_count180 := le.BJL.eviction_count180 + IF(sameLien,0,ri.BJL.eviction_count180);
	SELF.BJL.eviction_count12 := le.BJL.eviction_count12 + IF(sameLien,0,ri.BJL.eviction_count12);
	SELF.BJL.eviction_count24 := le.BJL.eviction_count24 + IF(sameLien,0,ri.BJL.eviction_count24);
	SELF.BJL.eviction_count36 := le.BJL.eviction_count36 + IF(sameLien,0,ri.BJL.eviction_count36);
	SELF.BJL.eviction_count60 := le.BJL.eviction_count60 + IF(sameLien,0,ri.BJL.eviction_count60);
	SELF.BJL.eviction_count84 := le.BJL.eviction_count84 + IF(sameLien,0,ri.BJL.eviction_count84);
	
	SELF.BJL.last_eviction_date := MAX(le.BJL.last_eviction_date,ri.BJL.last_eviction_date);
	
	self.liens.liens_unreleased_civil_judgment.count := le.liens.liens_unreleased_civil_judgment.count + IF(sameLien and le.liens.liens_unreleased_civil_judgment.count>0,0,ri.liens.liens_unreleased_civil_judgment.count);
	self.liens.liens_unreleased_civil_judgment.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_civil_judgment.earliest_filing_date,ri.liens.liens_unreleased_civil_judgment.earliest_filing_date);
	self.liens.liens_unreleased_civil_judgment.most_recent_filing_date := MAX(le.liens.liens_unreleased_civil_judgment.most_recent_filing_date,ri.liens.liens_unreleased_civil_judgment.most_recent_filing_date);
	self.liens.liens_unreleased_civil_judgment.total_amount := le.liens.liens_unreleased_civil_judgment.total_amount + IF(sameLien and le.liens.liens_unreleased_civil_judgment.total_amount>0,0,ri.liens.liens_unreleased_civil_judgment.total_amount);
	
	self.liens.liens_released_civil_judgment.count := le.liens.liens_released_civil_judgment.count + IF(sameLien and le.liens.liens_released_civil_judgment.count>0,0,ri.liens.liens_released_civil_judgment.count);
	self.liens.liens_released_civil_judgment.earliest_filing_date := ut.Min2(le.liens.liens_released_civil_judgment.earliest_filing_date,ri.liens.liens_released_civil_judgment.earliest_filing_date);
	self.liens.liens_released_civil_judgment.most_recent_filing_date := MAX(le.liens.liens_released_civil_judgment.most_recent_filing_date,ri.liens.liens_released_civil_judgment.most_recent_filing_date);
	self.liens.liens_released_civil_judgment.total_amount := le.liens.liens_released_civil_judgment.total_amount + IF(sameLien and le.liens.liens_released_civil_judgment.total_amount>0,0,ri.liens.liens_released_civil_judgment.total_amount);
	
	self.liens.liens_unreleased_federal_tax.count := le.liens.liens_unreleased_federal_tax.count + IF(sameLien and le.liens.liens_unreleased_federal_tax.count>0,0,ri.liens.liens_unreleased_federal_tax.count);
	self.liens.liens_unreleased_federal_tax.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_federal_tax.earliest_filing_date,ri.liens.liens_unreleased_federal_tax.earliest_filing_date);
	self.liens.liens_unreleased_federal_tax.most_recent_filing_date := MAX(le.liens.liens_unreleased_federal_tax.most_recent_filing_date,ri.liens.liens_unreleased_federal_tax.most_recent_filing_date);
	self.liens.liens_unreleased_federal_tax.total_amount := le.liens.liens_unreleased_federal_tax.total_amount + IF(sameLien and le.liens.liens_unreleased_federal_tax.total_amount>0,0,ri.liens.liens_unreleased_federal_tax.total_amount);
	
	self.liens.liens_released_federal_tax.count := le.liens.liens_released_federal_tax.count + IF(sameLien and le.liens.liens_released_federal_tax.count>0,0,ri.liens.liens_released_federal_tax.count);
	self.liens.liens_released_federal_tax.earliest_filing_date := ut.Min2(le.liens.liens_released_federal_tax.earliest_filing_date,ri.liens.liens_released_federal_tax.earliest_filing_date);
	self.liens.liens_released_federal_tax.most_recent_filing_date := MAX(le.liens.liens_released_federal_tax.most_recent_filing_date,ri.liens.liens_released_federal_tax.most_recent_filing_date);
	self.liens.liens_released_federal_tax.total_amount := le.liens.liens_released_federal_tax.total_amount + IF(sameLien and le.liens.liens_released_federal_tax.total_amount>0,0,ri.liens.liens_released_federal_tax.total_amount);
	
	self.liens.liens_unreleased_foreclosure.count := le.liens.liens_unreleased_foreclosure.count + IF(sameLien and le.liens.liens_unreleased_foreclosure.count>0,0,ri.liens.liens_unreleased_foreclosure.count);
	self.liens.liens_unreleased_foreclosure.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_foreclosure.earliest_filing_date,ri.liens.liens_unreleased_foreclosure.earliest_filing_date);
	self.liens.liens_unreleased_foreclosure.most_recent_filing_date := MAX(le.liens.liens_unreleased_foreclosure.most_recent_filing_date,ri.liens.liens_unreleased_foreclosure.most_recent_filing_date);
	self.liens.liens_unreleased_foreclosure.total_amount := le.liens.liens_unreleased_foreclosure.total_amount + IF(sameLien and le.liens.liens_unreleased_foreclosure.total_amount>0,0,ri.liens.liens_unreleased_foreclosure.total_amount);
	
	self.liens.liens_released_foreclosure.count := le.liens.liens_released_foreclosure.count + IF(sameLien and le.liens.liens_released_foreclosure.count>0,0,ri.liens.liens_released_foreclosure.count);
	self.liens.liens_released_foreclosure.earliest_filing_date := ut.Min2(le.liens.liens_released_foreclosure.earliest_filing_date,ri.liens.liens_released_foreclosure.earliest_filing_date);
	self.liens.liens_released_foreclosure.most_recent_filing_date := MAX(le.liens.liens_released_foreclosure.most_recent_filing_date,ri.liens.liens_released_foreclosure.most_recent_filing_date);
	self.liens.liens_released_foreclosure.total_amount := le.liens.liens_released_foreclosure.total_amount + IF(sameLien and le.liens.liens_released_foreclosure.total_amount>0,0,ri.liens.liens_released_foreclosure.total_amount);
	
	self.liens.liens_unreleased_landlord_tenant.count := le.liens.liens_unreleased_landlord_tenant.count + IF(sameLien and le.liens.liens_unreleased_landlord_tenant.count>0,0,ri.liens.liens_unreleased_landlord_tenant.count);
	self.liens.liens_unreleased_landlord_tenant.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_landlord_tenant.earliest_filing_date,ri.liens.liens_unreleased_landlord_tenant.earliest_filing_date);
	self.liens.liens_unreleased_landlord_tenant.most_recent_filing_date := MAX(le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date,ri.liens.liens_unreleased_landlord_tenant.most_recent_filing_date);
	self.liens.liens_unreleased_landlord_tenant.total_amount := le.liens.liens_unreleased_landlord_tenant.total_amount + IF(sameLien and le.liens.liens_unreleased_landlord_tenant.total_amount>0,0,ri.liens.liens_unreleased_landlord_tenant.total_amount);
	
	self.liens.liens_released_landlord_tenant.count := le.liens.liens_released_landlord_tenant.count + IF(sameLien and le.liens.liens_released_landlord_tenant.count>0,0,ri.liens.liens_released_landlord_tenant.count);
	self.liens.liens_released_landlord_tenant.earliest_filing_date := ut.Min2(le.liens.liens_released_landlord_tenant.earliest_filing_date,ri.liens.liens_released_landlord_tenant.earliest_filing_date);
	self.liens.liens_released_landlord_tenant.most_recent_filing_date := MAX(le.liens.liens_released_landlord_tenant.most_recent_filing_date,ri.liens.liens_released_landlord_tenant.most_recent_filing_date);
	self.liens.liens_released_landlord_tenant.total_amount := le.liens.liens_released_landlord_tenant.total_amount + IF(sameLien and le.liens.liens_released_landlord_tenant.total_amount>0,0,ri.liens.liens_released_landlord_tenant.total_amount);
	
	self.liens.liens_unreleased_lispendens.count := le.liens.liens_unreleased_lispendens.count + IF(sameLien and le.liens.liens_unreleased_lispendens.count>0,0,ri.liens.liens_unreleased_lispendens.count);
	self.liens.liens_unreleased_lispendens.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_lispendens.earliest_filing_date,ri.liens.liens_unreleased_lispendens.earliest_filing_date);
	self.liens.liens_unreleased_lispendens.most_recent_filing_date := MAX(le.liens.liens_unreleased_lispendens.most_recent_filing_date,ri.liens.liens_unreleased_lispendens.most_recent_filing_date);
	self.liens.liens_unreleased_lispendens.total_amount := le.liens.liens_unreleased_lispendens.total_amount + IF(sameLien and le.liens.liens_unreleased_lispendens.total_amount>0,0,ri.liens.liens_unreleased_lispendens.total_amount);
	
	self.liens.liens_released_lispendens.count := le.liens.liens_released_lispendens.count + IF(sameLien and le.liens.liens_released_lispendens.count>0,0,ri.liens.liens_released_lispendens.count);
	self.liens.liens_released_lispendens.earliest_filing_date := ut.Min2(le.liens.liens_released_lispendens.earliest_filing_date,ri.liens.liens_released_lispendens.earliest_filing_date);
	self.liens.liens_released_lispendens.most_recent_filing_date := MAX(le.liens.liens_released_lispendens.most_recent_filing_date,ri.liens.liens_released_lispendens.most_recent_filing_date);
	self.liens.liens_released_lispendens.total_amount := le.liens.liens_released_lispendens.total_amount + IF(sameLien and le.liens.liens_released_lispendens.total_amount>0,0,ri.liens.liens_released_lispendens.total_amount);
	
	self.liens.liens_unreleased_other_lj.count := le.liens.liens_unreleased_other_lj.count + IF(sameLien and le.liens.liens_unreleased_other_lj.count>0,0,ri.liens.liens_unreleased_other_lj.count);
	self.liens.liens_unreleased_other_lj.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_other_lj.earliest_filing_date,ri.liens.liens_unreleased_other_lj.earliest_filing_date);
	self.liens.liens_unreleased_other_lj.most_recent_filing_date := MAX(le.liens.liens_unreleased_other_lj.most_recent_filing_date,ri.liens.liens_unreleased_other_lj.most_recent_filing_date);
	self.liens.liens_unreleased_other_lj.total_amount := le.liens.liens_unreleased_other_lj.total_amount + IF(sameLien and le.liens.liens_unreleased_other_lj.total_amount>0,0,ri.liens.liens_unreleased_other_lj.total_amount);
	
	self.liens.liens_released_other_lj.count := le.liens.liens_released_other_lj.count + IF(sameLien and le.liens.liens_released_other_lj.count>0,0,ri.liens.liens_released_other_lj.count);
	self.liens.liens_released_other_lj.earliest_filing_date := ut.Min2(le.liens.liens_released_other_lj.earliest_filing_date,ri.liens.liens_released_other_lj.earliest_filing_date);
	self.liens.liens_released_other_lj.most_recent_filing_date := MAX(le.liens.liens_released_other_lj.most_recent_filing_date,ri.liens.liens_released_other_lj.most_recent_filing_date);
	self.liens.liens_released_other_lj.total_amount := le.liens.liens_released_other_lj.total_amount + IF(sameLien and le.liens.liens_released_other_lj.total_amount>0,0,ri.liens.liens_released_other_lj.total_amount);
	
	self.liens.liens_unreleased_other_tax.count := le.liens.liens_unreleased_other_tax.count + IF(sameLien and le.liens.liens_unreleased_other_tax.count>0,0,ri.liens.liens_unreleased_other_tax.count);
	self.liens.liens_unreleased_other_tax.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_other_tax.earliest_filing_date,ri.liens.liens_unreleased_other_tax.earliest_filing_date);
	self.liens.liens_unreleased_other_tax.most_recent_filing_date := MAX(le.liens.liens_unreleased_other_tax.most_recent_filing_date,ri.liens.liens_unreleased_other_tax.most_recent_filing_date);
	self.liens.liens_unreleased_other_tax.total_amount := le.liens.liens_unreleased_other_tax.total_amount + IF(sameLien and le.liens.liens_unreleased_other_tax.total_amount>0,0,ri.liens.liens_unreleased_other_tax.total_amount);
	
	self.liens.liens_released_other_tax.count := le.liens.liens_released_other_tax.count + IF(sameLien and le.liens.liens_released_other_tax.count>0,0,ri.liens.liens_released_other_tax.count);
	self.liens.liens_released_other_tax.earliest_filing_date := ut.Min2(le.liens.liens_released_other_tax.earliest_filing_date,ri.liens.liens_released_other_tax.earliest_filing_date);
	self.liens.liens_released_other_tax.most_recent_filing_date := MAX(le.liens.liens_released_other_tax.most_recent_filing_date,ri.liens.liens_released_other_tax.most_recent_filing_date);
	self.liens.liens_released_other_tax.total_amount := le.liens.liens_released_other_tax.total_amount + IF(sameLien and le.liens.liens_released_other_tax.total_amount>0,0,ri.liens.liens_released_other_tax.total_amount);
	
	self.liens.liens_unreleased_small_claims.count := le.liens.liens_unreleased_small_claims.count + IF(sameLien and le.liens.liens_unreleased_small_claims.count>0,0,ri.liens.liens_unreleased_small_claims.count);
	self.liens.liens_unreleased_small_claims.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_small_claims.earliest_filing_date,ri.liens.liens_unreleased_small_claims.earliest_filing_date);
	self.liens.liens_unreleased_small_claims.most_recent_filing_date := MAX(le.liens.liens_unreleased_small_claims.most_recent_filing_date,ri.liens.liens_unreleased_small_claims.most_recent_filing_date);
	self.liens.liens_unreleased_small_claims.total_amount := le.liens.liens_unreleased_small_claims.total_amount + IF(sameLien and le.liens.liens_unreleased_small_claims.total_amount>0,0,ri.liens.liens_unreleased_small_claims.total_amount);
	
	self.liens.liens_released_small_claims.count := le.liens.liens_released_small_claims.count + IF(sameLien and le.liens.liens_released_small_claims.count>0,0,ri.liens.liens_released_small_claims.count);
	self.liens.liens_released_small_claims.earliest_filing_date := ut.Min2(le.liens.liens_released_small_claims.earliest_filing_date,ri.liens.liens_released_small_claims.earliest_filing_date);
	self.liens.liens_released_small_claims.most_recent_filing_date := MAX(le.liens.liens_released_small_claims.most_recent_filing_date,ri.liens.liens_released_small_claims.most_recent_filing_date);
	self.liens.liens_released_small_claims.total_amount := le.liens.liens_released_small_claims.total_amount + IF(sameLien and le.liens.liens_released_small_claims.total_amount>0,0,ri.liens.liens_released_small_claims.total_amount);
	
	self.liens.liens_unreleased_suits.count := le.liens.liens_unreleased_suits.count + IF(sameLien and le.liens.liens_unreleased_suits.count>0,0,ri.liens.liens_unreleased_suits.count);
	self.liens.liens_unreleased_suits.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_suits.earliest_filing_date,ri.liens.liens_unreleased_suits.earliest_filing_date);
	self.liens.liens_unreleased_suits.most_recent_filing_date := MAX(le.liens.liens_unreleased_suits.most_recent_filing_date,ri.liens.liens_unreleased_suits.most_recent_filing_date);
	self.liens.liens_unreleased_suits.total_amount := le.liens.liens_unreleased_suits.total_amount + IF(sameLien and le.liens.liens_unreleased_suits.total_amount>0,0,ri.liens.liens_unreleased_suits.total_amount);
	
	self.liens.liens_released_suits.count := le.liens.liens_released_suits.count + IF(sameLien and le.liens.liens_released_suits.count>0,0,ri.liens.liens_released_suits.count);
	self.liens.liens_released_suits.earliest_filing_date := ut.Min2(le.liens.liens_released_suits.earliest_filing_date,ri.liens.liens_released_suits.earliest_filing_date);
	self.liens.liens_released_suits.most_recent_filing_date := MAX(le.liens.liens_released_suits.most_recent_filing_date,ri.liens.liens_released_suits.most_recent_filing_date);
	self.liens.liens_released_suits.total_amount := le.liens.liens_released_suits.total_amount + IF(sameLien and le.liens.liens_released_suits.total_amount>0,0,ri.liens.liens_released_suits.total_amount);
	
	self.liens.liens_unrel_total_amount84 := le.liens.liens_unrel_total_amount84 + IF(sameLien and le.liens.liens_unrel_total_amount84>0,0,ri.liens.liens_unrel_total_amount84);
	self.liens.liens_rel_total_amount84 	:= le.liens.liens_rel_total_amount84 + IF(sameLien and le.liens.liens_rel_total_amount84>0,0,ri.liens.liens_rel_total_amount84);
	self.liens.liens_unrel_total_amount   := le.liens.liens_unrel_total_amount + IF(sameLien and le.liens.liens_unrel_total_amount>0,0,ri.liens.liens_unrel_total_amount);
	self.liens.liens_rel_total_amount   	:= le.liens.liens_rel_total_amount + IF(sameLien and le.liens.liens_rel_total_amount>0,0,ri.liens.liens_rel_total_amount);
	
	SELF := ri;
END;

liens_sorted := SORT(liens_main,did,tmsid,rmsid,-bjl.last_liens_unreleased_date,-bjl.last_eviction_date);
liens_rolled := ROLLUP(liens_sorted,LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT)); 

	layout_derog_process get_crim(layout_extended L, doxie_files.Key_BocaShell_Crim2 R) := transform
		self.BJL := R;
		self := L;
	end;
	
	w_crim := JOIN(liens_rolled, doxie_files.Key_BocaShell_Crim2,
								keyed(LEFT.did=RIGHT.did),
								get_crim(LEFT,RIGHT), LEFT OUTER, KEEP(1));
								

wFID := join(w_crim, property.key_foreclosure_did, 
						left.did!=0 and keyed(left.did=right.did), 
						transform(layout_extended, self.fid := right.fid, self.BJL.foreclosure_flag := right.did!=0, self := left, self := []), 
						left outer, atmost(keyed(left.did=right.did), riskwise.max_atmost), keep(50));


all_foreclosures := join(wFID, property.key_foreclosures_fid,
						left.fid!='' and 
						keyed(left.fid=right.fid),
						transform(layout_derog_process, 
								self.BJL.last_foreclosure_date := right.recording_date,
								self.BJL.foreclosure_flag := right.fid!='',
								self := left),
						left outer, atmost(keyed(left.fid=right.fid), riskwise.max_atmost), keep(50));

wForeclosures := dedup(sort(all_foreclosures, seq, did, -BJL.last_foreclosure_date), seq, did);

// output(liens_added, named('liens_added'));
// output(liens_full, named('liens_full'));
// output(liens_sorted, named('liens_sorted'));
// output(liens_rolled, named('liens_rolled'));
final := if(BSversion>1, wForeclosures, w_crim);
 
return project(final, 
							transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LnJ, 
								self := left, self := []));
end;