import _Control, doxie_files,ut,doxie, liensv2, riskwise, property, bankruptcyv3, ProfileBooster, Risk_Indicators;
onThor := _Control.Environment.OnThor;

//Note - this function mimics Bocashell derogs function with mods made specific to Profile Booster. 
//			 Only a portion of fields returned here are actually used in PB and the others could be removed at some point.
export getDerogs_Hist (GROUPED DATASET(Risk_Indicators.layouts.layout_derogs_input) ids) := FUNCTION
															 
bans_did := BankruptcyV3.key_bankruptcyV3_did();
bans_search := BankruptcyV3.key_bankruptcyv3_search_full_bip();

kld			:= liensv2.key_liens_DID;
klr_nonFCRA	:= liensv2.key_liens_party_id;
koff_nonFCRA	:= doxie_files.key_offenders_risk;
kford 		:= property.key_foreclosure_did;
kforf		:= property.key_foreclosures_fid;

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

layout_derog_process := RECORD
		Risk_Indicators.layouts.layout_derogs_input;
		ProfileBooster.Layouts.Layout_Derogs BJL;
		Risk_Indicators.Layouts.Layout_Liens Liens;

END;

layout_extended :=
RECORD
	layout_derog_process;
	string5  court_code; // bk extras
	string7  case_num; 
	string50 bk_tmsid;
	string35 crim_case_num; // criminal extras
	STRING50 rmsid; // liens extras
	string50 tmsid; // liens extras
	unsigned4 date_first_seen;	// liens extras
	unsigned4 date_last_seen;	// liens extras
	STRING70 fid; // foreclosure extras
	boolean evictionRec;
	unsigned4 bk_disp_date;
END;

layout_extended add_bankrupt_keys(Risk_Indicators.layouts.layout_derogs_input le, bans_did ri) := TRANSFORM
	self.bk_tmsid := ri.tmsid;
	SELF.court_code := ri.court_code;
	SELF.case_num := ri.case_number;

	SELF := le;
	SELF := [];
END;
bankrupt_added_roxie := JOIN(ids, bans_did ,keyed(LEFT.did=RIGHT.did), add_bankrupt_keys(LEFT,RIGHT), LEFT OUTER, atmost(riskwise.max_atmost), KEEP(100));
bankrupt_added_thor := JOIN(distribute(ids, did), 
														distribute(pull(bans_did), did) ,LEFT.did=RIGHT.did, add_bankrupt_keys(LEFT,RIGHT), LEFT OUTER, atmost(riskwise.max_atmost), KEEP(100), 
														local);

#IF(onThor)
	bankrupt_added := bankrupt_added_thor;
#ELSE
	bankrupt_added := ungroup(bankrupt_added_roxie);
#END

layout_extended get_bankrupt_search (layout_extended le, bans_search ri) := TRANSFORM
	myGetDate := Risk_Indicators.iid_constants.myGetDate(le.historydate);
	SELF.BJL.bankrupt := ri.case_number<>'';
	date_last_seen := max((INTEGER)ri.date_filed, if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0));// only use disposition date if it is not in the future
	SELF.BJL.date_last_seen := date_last_seen;
	SELF.BJL.filing_type := ri.filing_type;
	SELF.BJL.disposition := ri.disposition;
 	hit := ri.case_number<>'';
	SELF.BJL.filing_count := (INTEGER)hit;
	SELF.BJL.bk_recent_count := (INTEGER)(hit AND ri.disposition='');
	date_disp := date_last_seen;
	SELF.BJL.bk_disposed_recent_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string)date_disp,myGetDate)<365*2+1);// we are potentially counting some dispositions in the future but not others depending on the dates
	SELF.BJL.bk_disposed_historical_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string)date_disp,myGetDate)>365*2);
	SELF.BJL.bk_dismissed_recent_count := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string)date_disp,myGetDate)<365*2+1);// we are potentially counting some dispositions in the future but not others depending on the dates
	SELF.BJL.bk_dismissed_historical_count := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string)date_disp,myGetDate)>365*2);
	SELF.BJL.bk_count30 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,30, le.historydate);
	SELF.BJL.bk_count90 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,90, le.historydate);
	SELF.BJL.bk_count180 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,180, le.historydate);
	SELF.BJL.bk_count12 := (integer)(ProfileBooster.Common.MonthsApart_YYYYMMDD(myGetDate,(STRING8)date_last_seen,true) < 13); 
	SELF.BJL.bk_count24 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(2), le.historydate);
	SELF.BJL.bk_count36 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(3), le.historydate);
	SELF.BJL.bk_count60 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(5), le.historydate);
  SELF.BJL.bk_chapter := ri.chapter;
	SELF.bk_disp_date := max((INTEGER)ri.date_filed, 
			if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0));
	SELF := le;
END;

bankrupt_full_roxie := JOIN (bankrupt_added, bans_search,
                       LEFT.bk_tmsid<>'' AND
                       keyed(LEFT.bk_tmsid = RIGHT.tmsid) AND
											 right.name_type='D' and
											 (unsigned)right.did=left.did and
                       (unsigned)(RIGHT.date_filed[1..6]) < left.historydate,
											 get_bankrupt_search(LEFT,RIGHT),
											 LEFT OUTER, KEEP(100),
				ATMOST(Riskwise.max_atmost));
				
bankrupt_full_thor1 := JOIN (distribute(bankrupt_added(bk_tmsid<>''), hash64(bk_tmsid)), 
														distribute(pull(bans_search(name_type='D')), hash64(tmsid)),
                       LEFT.bk_tmsid = RIGHT.tmsid AND
											 (unsigned)right.did=left.did and
                       (unsigned)(RIGHT.date_filed[1..6]) < left.historydate,
											 get_bankrupt_search(LEFT,RIGHT),
											 LEFT OUTER, KEEP(100), 
				local);
bankrupt_full_thor2 := bankrupt_added(bk_tmsid='');
bankrupt_full_thor := bankrupt_full_thor1 + bankrupt_full_thor2; // put all the records missing tmsid back together with the records with tmsid populated
				
#IF(onThor)
	bankrupt_full := bankrupt_full_thor;
#ELSE
	bankrupt_full := bankrupt_full_roxie;
#END

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
	SELF.BJL.bk_recent_count := le.BJL.bk_recent_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_recent_count);
	SELF.BJL.bk_disposed_recent_count := le.BJL.bk_disposed_recent_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_disposed_recent_count);
	SELF.BJL.bk_disposed_historical_count := le.BJL.bk_disposed_historical_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_disposed_historical_count);
	SELF.BJL.bk_dismissed_recent_count := le.BJL.bk_dismissed_recent_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_dismissed_recent_count);
	SELF.BJL.bk_dismissed_historical_count := le.BJL.bk_dismissed_historical_count + 
								IF(sameBankruptcy, 0, ri.BJL.bk_dismissed_historical_count);
								
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
disp_dates := if(bankrupt_full.bk_disp_date = 0, bankrupt_full.date_last_seen, bankrupt_full.bk_disp_date);
bankrupt_disp := DEDUP(SORT(bankrupt_full, seq, did,-bk_disp_date,  -BJL.date_last_seen), seq, did);
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
	
bankrupt_rolled := bankrupt_rolled_disp;

layout_extended add_liens(layout_extended le, kld ri) := TRANSFORM
	self.tmsid := ri.tmsid;
	SELF.rmsid := ri.rmsid;
	SELF := le;
END;

liens_added_roxie := JOIN(bankrupt_rolled, kld, keyed(LEFT.did=RIGHT.did), add_liens(LEFT,RIGHT), LEFT OUTER, KEEP(100),
					ATMOST(keyed(left.did=right.did), Riskwise.max_atmost));
liens_added_thor := JOIN(
			distribute(bankrupt_rolled, did), 
			distribute(pull(kld), did), LEFT.did=RIGHT.did, add_liens(LEFT,RIGHT), LEFT OUTER, KEEP(100),
					ATMOST(Riskwise.max_atmost), 
					local);

#IF(onThor)
	liens_added := liens_added_thor;
#ELSE
	liens_added := liens_added_roxie;
#END

layout_extended get_liens_nonFCRA(layout_extended le, klr_nonFCRA ri) := TRANSFORM
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
	isRecent := ut.DaysApart(ri.date_first_seen,myGetDate)<365*2+1;
	
	// Unreleased Liens--------------------------------
	SELF.BJL.last_liens_unreleased_date := if((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate, ri.date_first_seen, '');		
	SELF.BJL.liens_recent_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																				 ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) AND
																					isRecent );
	SELF.BJL.liens_historical_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																						((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) AND
																						~isRecent );
																					
	SELF.BJL.liens_unreleased_count30 := (INTEGER)(ri.rmsid<>'' AND ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) and  
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,30,le.historydate));
	SELF.BJL.liens_unreleased_count90 := (INTEGER)(ri.rmsid<>'' AND ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,90,le.historydate));
	SELF.BJL.liens_unreleased_count180 := (INTEGER)(ri.rmsid<>'' AND ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) and  
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,180,le.historydate));
	SELF.BJL.liens_unreleased_count12 := (INTEGER)(ri.rmsid<>'' AND ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) and
																				ProfileBooster.Common.MonthsApart_YYYYMMDD(myGetDate,(STRING8)ri.date_first_seen,true) < 13);
	SELF.BJL.liens_unreleased_count24 := (INTEGER)(ri.rmsid<>'' AND ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(2),le.historydate));
	SELF.BJL.liens_unreleased_count36 := (INTEGER)(ri.rmsid<>'' AND ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(3),le.historydate));
	SELF.BJL.liens_unreleased_count60 := (INTEGER)(ri.rmsid<>'' AND ((INTEGER)ri.date_last_seen=0 OR ri.date_last_seen > myGetDate) and  
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(5),le.historydate));																			
																																									
	// Released Liens	-----------------------------------		
	SELF.BJL.last_liens_released_date := if((INTEGER)ri.date_last_seen<>0 and ri.date_last_seen <= myGetDate, (unsigned)ri.date_first_seen, 0);
	SELF.BJL.liens_recent_released_count := (INTEGER)(ri.rmsid<>'' AND 
																			(INTEGER)ri.date_last_seen<>0 and ri.date_last_seen <= myGetDate AND
																			isRecent);
	SELF.BJL.liens_historical_released_count := (INTEGER)(ri.rmsid<>'' AND 

																					(INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate AND 
																					~isRecent);
																	
	SELF.BJL.liens_released_count30 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,30,le.historydate));

	SELF.BJL.liens_released_count90 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate and  
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,90,le.historydate));

	SELF.BJL.liens_released_count180 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate and    
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,180,le.historydate));

	SELF.BJL.liens_released_count12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate and   
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(1),le.historydate));

	SELF.BJL.liens_released_count24 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate and    
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(2),le.historydate));

	SELF.BJL.liens_released_count36 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate and    
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(3),le.historydate));

	SELF.BJL.liens_released_count60 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 AND ri.date_last_seen <= myGetDate and    
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(5),le.historydate));																				
																					
																		
	SELF.date_first_seen := (unsigned)ri.date_first_seen;// to be used in evictions
	SELF.date_last_seen := (unsigned)ri.date_last_seen;// to be used in evictions
	
	self.tmsid := if(ri.tmsid='', '', le.tmsid);	// set these to blank so that we miss on the evictions search below
  self.rmsid := if(ri.rmsid='', '', le.rmsid);
	
	SELF := le;
END;

liens_full_roxie := JOIN (liens_added, klr_nonFCRA, 
                    LEFT.rmsid<>'' AND
                    keyed(left.tmsid=right.tmsid) and keyed(LEFT.rmsid=RIGHT.rmsid) AND 
										right.name_type='D' and 
										(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate,
                    get_liens_nonFCRA(LEFT,RIGHT),
										LEFT OUTER, KEEP(100),
				ATMOST(keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid), Riskwise.max_atmost));


liens_full_thor1 := JOIN (
	distribute(liens_added(rmsid<>''), hash64(tmsid, rmsid)), 
	distribute(pull(klr_nonFCRA(name_type='D')), hash64(tmsid, rmsid)), 
                    left.tmsid=right.tmsid and LEFT.rmsid=RIGHT.rmsid AND 
										(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate,
                    get_liens_nonFCRA(LEFT,RIGHT),
										LEFT OUTER, KEEP(100),
				ATMOST(left.tmsid=right.tmsid and left.rmsid=right.rmsid, Riskwise.max_atmost),
	local);
liens_full_thor2 := liens_added(rmsid='');
liens_full_thor := liens_full_thor1 + liens_full_thor2; // put the records with missing rmsid back together with those that have rmsid populated

#IF(onThor)
	liens_full := liens_full_thor;
#ELSE
	liens_full := liens_full_roxie;
#END

layout_extended get_evictions(liens_full le, liensV2.key_liens_main_ID ri) := transform
	myGetDate := Risk_Indicators.iid_constants.myGetDate(le.historydate);
	isRecent := ut.DaysApart((string8)le.date_first_seen,myGetDate)<365*2+1;

	isEviction := ri.eviction='Y';
  self.evictionRec  := isEviction;
	// evictions 
	SELF.BJL.eviction_recent_unreleased_count := (INTEGER)(isEviction and ((INTEGER)le.date_last_seen=0 OR (string)le.date_last_seen > myGetDate) AND isRecent);
	SELF.BJL.eviction_historical_unreleased_count := (INTEGER)(isEviction and ((INTEGER)le.date_last_seen=0 OR (string)le.date_last_seen > myGetDate) AND ~isRecent);
	SELF.BJL.eviction_recent_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND (string)le.date_last_seen <= myGetDate AND isRecent);
	SELF.BJL.eviction_historical_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND (string)le.date_last_seen <= myGetDate AND ~isRecent);
	
	SELF.BJL.eviction_count := (integer)(isEviction);
	SELF.BJL.eviction_count30 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,le.historydate));
	SELF.BJL.eviction_count90 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,le.historydate));
	SELF.BJL.eviction_count180 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,le.historydate));
	SELF.BJL.eviction_count12 := (integer)(isEviction and ProfileBooster.Common.MonthsApart_YYYYMMDD(myGetDate,(STRING8)le.date_first_seen,true) < 13);
	SELF.BJL.eviction_count24 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),le.historydate));
	SELF.BJL.eviction_count36 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),le.historydate));
	SELF.BJL.eviction_count60 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),le.historydate));

	SELF.BJL.last_eviction_date := if(isEviction, (unsigned)le.date_first_seen, 0);

	// they want liens seperated by type and released or unreleased for boca shell 3.0
	ftd := trim(stringlib.stringtouppercase(ri.filing_type_desc));
	goodResult := ri.rmsid<>'';
	unreleased := (string)le.date_last_seen > myGetDate or le.date_last_seen=0;
	released := (string)le.date_last_seen <= myGetDate and le.date_last_seen <>0;
	
	// only count evictions in the liens buckets if you are running version prior to 50
	isCivilJudgment := ftd in risk_indicators.iid_constants.setCivilJudgment and goodResult and unreleased and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isCivilJudgmentReleased := ftd in risk_indicators.iid_constants.setCivilJudgment and goodResult and released and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isFederalTax := ftd in risk_indicators.iid_constants.setFederalTax and goodResult and unreleased and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isFederalTaxReleased := ftd in risk_indicators.iid_constants.setFederalTax and goodResult and released and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isForeclosure := ftd in risk_indicators.iid_constants.setForeclosure and goodResult and unreleased and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isForeclosureReleased := ftd in risk_indicators.iid_constants.setForeclosure and goodResult and released and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isLandlordTenant := ftd in risk_indicators.iid_constants.setLandlordTenant and goodResult and unreleased and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isLandlordTenantReleased := ftd in risk_indicators.iid_constants.setLandlordTenant and goodResult and released and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isLisPendens := ftd in risk_indicators.iid_constants.setLisPendens and goodResult and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isLisPendensReleased := ftd in risk_indicators.iid_constants.setLisPendens and goodResult and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isOtherLJ := ftd not in risk_indicators.iid_constants.setOtherLJ and goodResult and unreleased and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits and ftd<>'');
	isOtherLJReleased := ftd not in risk_indicators.iid_constants.setOtherLJ and goodResult and released and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isOtherTax := ftd in risk_indicators.iid_constants.setOtherTax and goodResult and unreleased and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isOtherTaxReleased := ftd in risk_indicators.iid_constants.setOtherTax and goodResult and released and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isSmallClaims := ftd in risk_indicators.iid_constants.setSmallClaims and goodResult and unreleased and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isSmallClaimsReleased := ftd in risk_indicators.iid_constants.setSmallClaims and goodResult and released and (~isEviction and ftd not in risk_indicators.iid_constants.setSuits);
	isSuits := ftd in risk_indicators.iid_constants.setSuits and goodResult and unreleased and (~isEviction);
	isSuitsReleased := ftd in risk_indicators.iid_constants.setSuits and goodResult and released and (~isEviction);
		
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
	//for Profile Booster changed lien counts to exclude just evictions (Boca shell excludes suits as well)
	SELF.BJL.last_liens_unreleased_date := if(isEviction, '', le.bjl.last_liens_unreleased_date);
	SELF.BJL.liens_recent_unreleased_count := if(isEviction, 0, le.bjl.liens_recent_unreleased_count);
	SELF.BJL.liens_historical_unreleased_count := 	if(isEviction, 0, le.bjl.liens_historical_unreleased_count);																					
	SELF.BJL.liens_unreleased_count30 := if(isEviction, 0, le.bjl.liens_unreleased_count30);
	SELF.BJL.liens_unreleased_count90 := if(isEviction, 0, le.bjl.liens_unreleased_count90);
	SELF.BJL.liens_unreleased_count180 := if(isEviction, 0, le.bjl.liens_unreleased_count180);
	SELF.BJL.liens_unreleased_count12 := if(isEviction, 0, le.bjl.liens_unreleased_count12);
	SELF.BJL.liens_unreleased_count24 := if(isEviction, 0, le.bjl.liens_unreleased_count24);
	SELF.BJL.liens_unreleased_count36 := if(isEviction, 0, le.bjl.liens_unreleased_count36);
	SELF.BJL.liens_unreleased_count60 := if(isEviction, 0, le.bjl.liens_unreleased_count60);													
	SELF.BJL.last_liens_released_date := if(isEviction, 0, le.bjl.last_liens_released_date);
	SELF.BJL.liens_recent_released_count := if(isEviction, 0, le.bjl.liens_recent_released_count);
	SELF.BJL.liens_historical_released_count := 	if(isEviction, 0, le.bjl.liens_historical_released_count);																		
	SELF.BJL.liens_released_count30 := if(isEviction, 0, le.bjl.liens_released_count30);
	SELF.BJL.liens_released_count90 := if(isEviction, 0, le.bjl.liens_released_count90);
	SELF.BJL.liens_released_count180 := if(isEviction, 0, le.bjl.liens_released_count180);
	SELF.BJL.liens_released_count12 := if(isEviction, 0, le.bjl.liens_released_count12);
	SELF.BJL.liens_released_count24 := if(isEviction, 0, le.bjl.liens_released_count24);
	SELF.BJL.liens_released_count36 := if(isEviction, 0, le.bjl.liens_released_count36);
	SELF.BJL.liens_released_count60 := if(isEviction, 0, le.bjl.liens_released_count60);	

	SELF := le;
end;

liens_main_roxie := JOIN(liens_full, liensV2.key_liens_main_ID,
		left.rmsid<>'' and left.tmsid<>'' and 
		keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid) and
		trim(stringlib.stringtouppercase(right.filing_type_desc)) not in risk_indicators.iid_constants.set_Invalid_Liens_50, // ignore certain lien types completely if running shell version 5.0 or higher
		get_evictions(LEFT,RIGHT), left outer, 
		ATMOST(keyed(LEFT.tmsid=RIGHT.tmsid) and keyed(left.rmsid=right.rmsid), riskwise.max_atmost));

liens_main_thor1 := JOIN(
	distribute(liens_full(rmsid<>'' and tmsid<>''), hash64(tmsid, rmsid)), 
	distribute(pull(liensV2.key_liens_main_ID(trim(stringlib.stringtouppercase(filing_type_desc)) not in risk_indicators.iid_constants.set_Invalid_Liens_50)), hash64(tmsid, rmsid)),
		left.tmsid=right.tmsid and left.rmsid=right.rmsid, 
		get_evictions(LEFT,RIGHT), left outer, 
		ATMOST(riskwise.max_atmost), local);
liens_main_thor2 := liens_full(rmsid='' and tmsid='');
liens_main_thor := liens_main_thor1 + liens_main_thor2;

#IF(onThor)
	liens_main := liens_main_thor;
#ELSE
	liens_main := liens_main_roxie;
#END

layout_extended roll_liens(layout_extended le, layout_extended ri) := TRANSFORM
	sameLien := le.tmsid=ri.tmsid and le.rmsid=ri.rmsid;

	SELF.BJL.liens_recent_unreleased_count := le.BJL.liens_recent_unreleased_count + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_recent_unreleased_count);
	SELF.BJL.liens_historical_unreleased_count := le.BJL.liens_historical_unreleased_count + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_historical_unreleased_count);
	SELF.BJL.liens_unreleased_count30 := le.BJL.liens_unreleased_count30 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_unreleased_count30);
	SELF.BJL.liens_unreleased_count90 := le.BJL.liens_unreleased_count90 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_unreleased_count90);
	SELF.BJL.liens_unreleased_count180 := le.BJL.liens_unreleased_count180 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_unreleased_count180);
	SELF.BJL.liens_unreleased_count12 := le.BJL.liens_unreleased_count12 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_unreleased_count12);
	SELF.BJL.liens_unreleased_count24 := le.BJL.liens_unreleased_count24 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_unreleased_count24);
	SELF.BJL.liens_unreleased_count36 := le.BJL.liens_unreleased_count36 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_unreleased_count36);
	SELF.BJL.liens_unreleased_count60 := le.BJL.liens_unreleased_count60 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_unreleased_count60);
	
	SELF.BJL.liens_recent_released_count := le.BJL.liens_recent_released_count + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_recent_released_count);
	SELF.BJL.liens_historical_released_count := le.BJL.liens_historical_released_count + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_historical_released_count);
	SELF.BJL.liens_released_count30 := le.BJL.liens_released_count30 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_released_count30);
	SELF.BJL.liens_released_count90 := le.BJL.liens_released_count90 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_released_count90);
	SELF.BJL.liens_released_count180 := le.BJL.liens_released_count180 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_released_count180);
	SELF.BJL.liens_released_count12 := le.BJL.liens_released_count12 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_released_count12);
	SELF.BJL.liens_released_count24 := le.BJL.liens_released_count24 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_released_count24);
	SELF.BJL.liens_released_count36 := le.BJL.liens_released_count36 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_released_count36);
	SELF.BJL.liens_released_count60 := le.BJL.liens_released_count60 + IF(sameLien or ri.evictionRec,0,ri.BJL.liens_released_count60);
	
	SELF.BJL.last_liens_unreleased_date := if((integer)le.BJL.last_liens_unreleased_date > (integer)ri.BJL.last_liens_unreleased_date, le.BJL.last_liens_unreleased_date, ri.BJL.last_liens_unreleased_date);
	SELF.BJL.last_liens_released_date := if((integer)le.BJL.last_liens_released_date > (integer)ri.BJL.last_liens_released_date, le.BJL.last_liens_released_date, ri.BJL.last_liens_released_date);
	
	SELF.BJL.eviction_recent_unreleased_count := le.BJL.eviction_recent_unreleased_count + IF(sameLien,0,ri.BJL.eviction_recent_unreleased_count);
	SELF.BJL.eviction_historical_unreleased_count := le.BJL.eviction_historical_unreleased_count + IF(sameLien,0,ri.BJL.eviction_historical_unreleased_count);
	SELF.BJL.eviction_recent_released_count := le.BJL.eviction_recent_released_count + IF(sameLien,0,ri.BJL.eviction_recent_released_count);
	SELF.BJL.eviction_historical_released_count := le.BJL.eviction_historical_released_count + IF(sameLien,0,ri.BJL.eviction_historical_released_count);
	
	SELF.BJL.eviction_count := le.BJL.eviction_count + IF(sameLien and le.BJL.eviction_count>0,0,ri.BJL.eviction_count);
	SELF.BJL.eviction_count30 := le.BJL.eviction_count30 + IF(sameLien,0,ri.BJL.eviction_count30);
	SELF.BJL.eviction_count90 := le.BJL.eviction_count90 + IF(sameLien,0,ri.BJL.eviction_count90);
	SELF.BJL.eviction_count180 := le.BJL.eviction_count180 + IF(sameLien,0,ri.BJL.eviction_count180);
	SELF.BJL.eviction_count12 := le.BJL.eviction_count12 + IF(sameLien and le.BJL.eviction_count>0,0,ri.BJL.eviction_count12);
	SELF.BJL.eviction_count24 := le.BJL.eviction_count24 + IF(sameLien,0,ri.BJL.eviction_count24);
	SELF.BJL.eviction_count36 := le.BJL.eviction_count36 + IF(sameLien,0,ri.BJL.eviction_count36);
	SELF.BJL.eviction_count60 := le.BJL.eviction_count60 + IF(sameLien,0,ri.BJL.eviction_count60);
	
	SELF.BJL.last_eviction_date := max(le.BJL.last_eviction_date,ri.BJL.last_eviction_date);
	
	self.liens.liens_unreleased_civil_judgment.count := le.liens.liens_unreleased_civil_judgment.count + IF(sameLien and le.liens.liens_unreleased_civil_judgment.count>0,0,ri.liens.liens_unreleased_civil_judgment.count);
	self.liens.liens_unreleased_civil_judgment.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_civil_judgment.earliest_filing_date,ri.liens.liens_unreleased_civil_judgment.earliest_filing_date);
	self.liens.liens_unreleased_civil_judgment.most_recent_filing_date := max(le.liens.liens_unreleased_civil_judgment.most_recent_filing_date,ri.liens.liens_unreleased_civil_judgment.most_recent_filing_date);
	self.liens.liens_unreleased_civil_judgment.total_amount := le.liens.liens_unreleased_civil_judgment.total_amount + IF(sameLien and le.liens.liens_unreleased_civil_judgment.total_amount>0,0,ri.liens.liens_unreleased_civil_judgment.total_amount);
	
	self.liens.liens_released_civil_judgment.count := le.liens.liens_released_civil_judgment.count + IF(sameLien and le.liens.liens_released_civil_judgment.count>0,0,ri.liens.liens_released_civil_judgment.count);
	self.liens.liens_released_civil_judgment.earliest_filing_date := ut.Min2(le.liens.liens_released_civil_judgment.earliest_filing_date,ri.liens.liens_released_civil_judgment.earliest_filing_date);
	self.liens.liens_released_civil_judgment.most_recent_filing_date := max(le.liens.liens_released_civil_judgment.most_recent_filing_date,ri.liens.liens_released_civil_judgment.most_recent_filing_date);
	self.liens.liens_released_civil_judgment.total_amount := le.liens.liens_released_civil_judgment.total_amount + IF(sameLien and le.liens.liens_released_civil_judgment.total_amount>0,0,ri.liens.liens_released_civil_judgment.total_amount);
	
	self.liens.liens_unreleased_federal_tax.count := le.liens.liens_unreleased_federal_tax.count + IF(sameLien and le.liens.liens_unreleased_federal_tax.count>0,0,ri.liens.liens_unreleased_federal_tax.count);
	self.liens.liens_unreleased_federal_tax.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_federal_tax.earliest_filing_date,ri.liens.liens_unreleased_federal_tax.earliest_filing_date);
	self.liens.liens_unreleased_federal_tax.most_recent_filing_date := max(le.liens.liens_unreleased_federal_tax.most_recent_filing_date,ri.liens.liens_unreleased_federal_tax.most_recent_filing_date);
	self.liens.liens_unreleased_federal_tax.total_amount := le.liens.liens_unreleased_federal_tax.total_amount + IF(sameLien and le.liens.liens_unreleased_federal_tax.total_amount>0,0,ri.liens.liens_unreleased_federal_tax.total_amount);
	
	self.liens.liens_released_federal_tax.count := le.liens.liens_released_federal_tax.count + IF(sameLien and le.liens.liens_released_federal_tax.count>0,0,ri.liens.liens_released_federal_tax.count);
	self.liens.liens_released_federal_tax.earliest_filing_date := ut.Min2(le.liens.liens_released_federal_tax.earliest_filing_date,ri.liens.liens_released_federal_tax.earliest_filing_date);
	self.liens.liens_released_federal_tax.most_recent_filing_date := max(le.liens.liens_released_federal_tax.most_recent_filing_date,ri.liens.liens_released_federal_tax.most_recent_filing_date);
	self.liens.liens_released_federal_tax.total_amount := le.liens.liens_released_federal_tax.total_amount + IF(sameLien and le.liens.liens_released_federal_tax.total_amount>0,0,ri.liens.liens_released_federal_tax.total_amount);
	
	self.liens.liens_unreleased_foreclosure.count := le.liens.liens_unreleased_foreclosure.count + IF(sameLien and le.liens.liens_unreleased_foreclosure.count>0,0,ri.liens.liens_unreleased_foreclosure.count);
	self.liens.liens_unreleased_foreclosure.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_foreclosure.earliest_filing_date,ri.liens.liens_unreleased_foreclosure.earliest_filing_date);
	self.liens.liens_unreleased_foreclosure.most_recent_filing_date := max(le.liens.liens_unreleased_foreclosure.most_recent_filing_date,ri.liens.liens_unreleased_foreclosure.most_recent_filing_date);
	self.liens.liens_unreleased_foreclosure.total_amount := le.liens.liens_unreleased_foreclosure.total_amount + IF(sameLien and le.liens.liens_unreleased_foreclosure.total_amount>0,0,ri.liens.liens_unreleased_foreclosure.total_amount);
	
	self.liens.liens_released_foreclosure.count := le.liens.liens_released_foreclosure.count + IF(sameLien and le.liens.liens_released_foreclosure.count>0,0,ri.liens.liens_released_foreclosure.count);
	self.liens.liens_released_foreclosure.earliest_filing_date := ut.Min2(le.liens.liens_released_foreclosure.earliest_filing_date,ri.liens.liens_released_foreclosure.earliest_filing_date);
	self.liens.liens_released_foreclosure.most_recent_filing_date := max(le.liens.liens_released_foreclosure.most_recent_filing_date,ri.liens.liens_released_foreclosure.most_recent_filing_date);
	self.liens.liens_released_foreclosure.total_amount := le.liens.liens_released_foreclosure.total_amount + IF(sameLien and le.liens.liens_released_foreclosure.total_amount>0,0,ri.liens.liens_released_foreclosure.total_amount);
	
	self.liens.liens_unreleased_landlord_tenant.count := le.liens.liens_unreleased_landlord_tenant.count + IF(sameLien and le.liens.liens_unreleased_landlord_tenant.count>0,0,ri.liens.liens_unreleased_landlord_tenant.count);
	self.liens.liens_unreleased_landlord_tenant.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_landlord_tenant.earliest_filing_date,ri.liens.liens_unreleased_landlord_tenant.earliest_filing_date);
	self.liens.liens_unreleased_landlord_tenant.most_recent_filing_date := max(le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date,ri.liens.liens_unreleased_landlord_tenant.most_recent_filing_date);
	self.liens.liens_unreleased_landlord_tenant.total_amount := le.liens.liens_unreleased_landlord_tenant.total_amount + IF(sameLien and le.liens.liens_unreleased_landlord_tenant.total_amount>0,0,ri.liens.liens_unreleased_landlord_tenant.total_amount);
	
	self.liens.liens_released_landlord_tenant.count := le.liens.liens_released_landlord_tenant.count + IF(sameLien and le.liens.liens_released_landlord_tenant.count>0,0,ri.liens.liens_released_landlord_tenant.count);
	self.liens.liens_released_landlord_tenant.earliest_filing_date := ut.Min2(le.liens.liens_released_landlord_tenant.earliest_filing_date,ri.liens.liens_released_landlord_tenant.earliest_filing_date);
	self.liens.liens_released_landlord_tenant.most_recent_filing_date := max(le.liens.liens_released_landlord_tenant.most_recent_filing_date,ri.liens.liens_released_landlord_tenant.most_recent_filing_date);
	self.liens.liens_released_landlord_tenant.total_amount := le.liens.liens_released_landlord_tenant.total_amount + IF(sameLien and le.liens.liens_released_landlord_tenant.total_amount>0,0,ri.liens.liens_released_landlord_tenant.total_amount);
	
	self.liens.liens_unreleased_lispendens.count := le.liens.liens_unreleased_lispendens.count + IF(sameLien and le.liens.liens_unreleased_lispendens.count>0,0,ri.liens.liens_unreleased_lispendens.count);
	self.liens.liens_unreleased_lispendens.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_lispendens.earliest_filing_date,ri.liens.liens_unreleased_lispendens.earliest_filing_date);
	self.liens.liens_unreleased_lispendens.most_recent_filing_date := max(le.liens.liens_unreleased_lispendens.most_recent_filing_date,ri.liens.liens_unreleased_lispendens.most_recent_filing_date);
	self.liens.liens_unreleased_lispendens.total_amount := le.liens.liens_unreleased_lispendens.total_amount + IF(sameLien and le.liens.liens_unreleased_lispendens.total_amount>0,0,ri.liens.liens_unreleased_lispendens.total_amount);
	
	self.liens.liens_released_lispendens.count := le.liens.liens_released_lispendens.count + IF(sameLien and le.liens.liens_released_lispendens.count>0,0,ri.liens.liens_released_lispendens.count);
	self.liens.liens_released_lispendens.earliest_filing_date := ut.Min2(le.liens.liens_released_lispendens.earliest_filing_date,ri.liens.liens_released_lispendens.earliest_filing_date);
	self.liens.liens_released_lispendens.most_recent_filing_date := max(le.liens.liens_released_lispendens.most_recent_filing_date,ri.liens.liens_released_lispendens.most_recent_filing_date);
	self.liens.liens_released_lispendens.total_amount := le.liens.liens_released_lispendens.total_amount + IF(sameLien and le.liens.liens_released_lispendens.total_amount>0,0,ri.liens.liens_released_lispendens.total_amount);
	
	self.liens.liens_unreleased_other_lj.count := le.liens.liens_unreleased_other_lj.count + IF(sameLien and le.liens.liens_unreleased_other_lj.count>0,0,ri.liens.liens_unreleased_other_lj.count);
	self.liens.liens_unreleased_other_lj.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_other_lj.earliest_filing_date,ri.liens.liens_unreleased_other_lj.earliest_filing_date);
	self.liens.liens_unreleased_other_lj.most_recent_filing_date := max(le.liens.liens_unreleased_other_lj.most_recent_filing_date,ri.liens.liens_unreleased_other_lj.most_recent_filing_date);
	self.liens.liens_unreleased_other_lj.total_amount := le.liens.liens_unreleased_other_lj.total_amount + IF(sameLien and le.liens.liens_unreleased_other_lj.total_amount>0,0,ri.liens.liens_unreleased_other_lj.total_amount);
	
	self.liens.liens_released_other_lj.count := le.liens.liens_released_other_lj.count + IF(sameLien and le.liens.liens_released_other_lj.count>0,0,ri.liens.liens_released_other_lj.count);
	self.liens.liens_released_other_lj.earliest_filing_date := ut.Min2(le.liens.liens_released_other_lj.earliest_filing_date,ri.liens.liens_released_other_lj.earliest_filing_date);
	self.liens.liens_released_other_lj.most_recent_filing_date := max(le.liens.liens_released_other_lj.most_recent_filing_date,ri.liens.liens_released_other_lj.most_recent_filing_date);
	self.liens.liens_released_other_lj.total_amount := le.liens.liens_released_other_lj.total_amount + IF(sameLien and le.liens.liens_released_other_lj.total_amount>0,0,ri.liens.liens_released_other_lj.total_amount);
	
	self.liens.liens_unreleased_other_tax.count := le.liens.liens_unreleased_other_tax.count + IF(sameLien and le.liens.liens_unreleased_other_tax.count>0,0,ri.liens.liens_unreleased_other_tax.count);
	self.liens.liens_unreleased_other_tax.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_other_tax.earliest_filing_date,ri.liens.liens_unreleased_other_tax.earliest_filing_date);
	self.liens.liens_unreleased_other_tax.most_recent_filing_date := max(le.liens.liens_unreleased_other_tax.most_recent_filing_date,ri.liens.liens_unreleased_other_tax.most_recent_filing_date);
	self.liens.liens_unreleased_other_tax.total_amount := le.liens.liens_unreleased_other_tax.total_amount + IF(sameLien and le.liens.liens_unreleased_other_tax.total_amount>0,0,ri.liens.liens_unreleased_other_tax.total_amount);
	
	self.liens.liens_released_other_tax.count := le.liens.liens_released_other_tax.count + IF(sameLien and le.liens.liens_released_other_tax.count>0,0,ri.liens.liens_released_other_tax.count);
	self.liens.liens_released_other_tax.earliest_filing_date := ut.Min2(le.liens.liens_released_other_tax.earliest_filing_date,ri.liens.liens_released_other_tax.earliest_filing_date);
	self.liens.liens_released_other_tax.most_recent_filing_date := max(le.liens.liens_released_other_tax.most_recent_filing_date,ri.liens.liens_released_other_tax.most_recent_filing_date);
	self.liens.liens_released_other_tax.total_amount := le.liens.liens_released_other_tax.total_amount + IF(sameLien and le.liens.liens_released_other_tax.total_amount>0,0,ri.liens.liens_released_other_tax.total_amount);
	
	self.liens.liens_unreleased_small_claims.count := le.liens.liens_unreleased_small_claims.count + IF(sameLien and le.liens.liens_unreleased_small_claims.count>0,0,ri.liens.liens_unreleased_small_claims.count);
	self.liens.liens_unreleased_small_claims.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_small_claims.earliest_filing_date,ri.liens.liens_unreleased_small_claims.earliest_filing_date);
	self.liens.liens_unreleased_small_claims.most_recent_filing_date := max(le.liens.liens_unreleased_small_claims.most_recent_filing_date,ri.liens.liens_unreleased_small_claims.most_recent_filing_date);
	self.liens.liens_unreleased_small_claims.total_amount := le.liens.liens_unreleased_small_claims.total_amount + IF(sameLien and le.liens.liens_unreleased_small_claims.total_amount>0,0,ri.liens.liens_unreleased_small_claims.total_amount);
	
	self.liens.liens_released_small_claims.count := le.liens.liens_released_small_claims.count + IF(sameLien and le.liens.liens_released_small_claims.count>0,0,ri.liens.liens_released_small_claims.count);
	self.liens.liens_released_small_claims.earliest_filing_date := ut.Min2(le.liens.liens_released_small_claims.earliest_filing_date,ri.liens.liens_released_small_claims.earliest_filing_date);
	self.liens.liens_released_small_claims.most_recent_filing_date := max(le.liens.liens_released_small_claims.most_recent_filing_date,ri.liens.liens_released_small_claims.most_recent_filing_date);
	self.liens.liens_released_small_claims.total_amount := le.liens.liens_released_small_claims.total_amount + IF(sameLien and le.liens.liens_released_small_claims.total_amount>0,0,ri.liens.liens_released_small_claims.total_amount);
	
	self.liens.liens_unreleased_suits.count := le.liens.liens_unreleased_suits.count + IF(sameLien and le.liens.liens_unreleased_suits.count>0,0,ri.liens.liens_unreleased_suits.count);
	self.liens.liens_unreleased_suits.earliest_filing_date := ut.Min2(le.liens.liens_unreleased_suits.earliest_filing_date,ri.liens.liens_unreleased_suits.earliest_filing_date);
	self.liens.liens_unreleased_suits.most_recent_filing_date := max(le.liens.liens_unreleased_suits.most_recent_filing_date,ri.liens.liens_unreleased_suits.most_recent_filing_date);
	self.liens.liens_unreleased_suits.total_amount := le.liens.liens_unreleased_suits.total_amount + IF(sameLien and le.liens.liens_unreleased_suits.total_amount>0,0,ri.liens.liens_unreleased_suits.total_amount);
	
	self.liens.liens_released_suits.count := le.liens.liens_released_suits.count + IF(sameLien and le.liens.liens_released_suits.count>0,0,ri.liens.liens_released_suits.count);
	self.liens.liens_released_suits.earliest_filing_date := ut.Min2(le.liens.liens_released_suits.earliest_filing_date,ri.liens.liens_released_suits.earliest_filing_date);
	self.liens.liens_released_suits.most_recent_filing_date := max(le.liens.liens_released_suits.most_recent_filing_date,ri.liens.liens_released_suits.most_recent_filing_date);
	self.liens.liens_released_suits.total_amount := le.liens.liens_released_suits.total_amount + IF(sameLien and le.liens.liens_released_suits.total_amount>0,0,ri.liens.liens_released_suits.total_amount);
	
	
	SELF := ri;
END;

liens_sorted := SORT(liens_main,seq,did,tmsid,rmsid,-bjl.last_liens_unreleased_date,-bjl.last_eviction_date);
liens_rolled := ROLLUP(liens_sorted,left.seq=right.seq and LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT)); 

layout_extended add_doc_NonFCRA(layout_extended le, koff_NonFCRA ri) := TRANSFORM
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
	isFelony := ri.criminal_offender_level='4' and ri.offense_score='F';
	nonFelony := (unsigned6)ri.did<>0 and ri.offense_score not in ['F', 'S', 'I'];
	
	SELF.BJL.criminal_count := (INTEGER)((unsigned6)ri.did<>0);
	SELF.BJL.felony_count := if(isFelony, 1, 0);
	SELF.crim_case_num:= ri.case_num;

	SELF.BJL.nonfelony_criminal_count := if(nonFelony, 1, 0);  // added for Profile Booster
	SELF.BJL.nonfelony_criminal_count12 := if(nonFelony and ProfileBooster.Common.MonthsApart_YYYYMMDD(myGetDate,(string)ri.earliest_offense_date,true) < 13, 1, 0);  // added for Profile Booster
	SELF.BJL.last_nonfelony_criminal_date := if(nonFelony, (unsigned4)ri.earliest_offense_date, 0); // added for Profile Booster
	
	SELF.BJL.last_criminal_date := (unsigned4)ri.earliest_offense_date;
	self.BJL.last_felony_date := if(isFelony, (unsigned4)ri.earliest_offense_date, 0);
	// these criminal counts are now felonies only
	self.BJL.criminal_count30 := if(isFelony and checkDays(myGetDate,ri.earliest_offense_date,30), 1, 0);
	self.BJL.criminal_count90 := if(isFelony and checkDays(myGetDate,ri.earliest_offense_date,90), 1, 0);
	self.BJL.criminal_count180 := if(isFelony and checkDays(myGetDate,ri.earliest_offense_date,180), 1, 0);
	SELF.BJL.criminal_count12 := if(isFelony and ProfileBooster.Common.MonthsApart_YYYYMMDD(myGetDate,(string)ri.earliest_offense_date,true) < 13, 1, 0); 
	self.BJL.criminal_count24 := if(isFelony and checkDays(myGetDate,ri.earliest_offense_date,ut.DaysInNYears(2)), 1, 0);
	self.BJL.criminal_count36 := if(isFelony and checkDays(myGetDate,ri.earliest_offense_date,ut.DaysInNYears(3)), 1, 0);
	self.BJL.criminal_count60 := if(isFelony and checkDays(myGetDate,ri.earliest_offense_date,ut.DaysInNYears(5)), 1, 0);
	
	isArrest := ri.data_type = '5';
	self.BJL.arrests_count := (unsigned)isArrest;
	self.BJL.arrests_count30 := if(isArrest and checkDays(myGetDate,ri.earliest_offense_date,30), 1, 0);
	self.BJL.arrests_count90 := if(isArrest and checkDays(myGetDate,ri.earliest_offense_date,90), 1, 0);
	self.BJL.arrests_count180 := if(isArrest and checkDays(myGetDate,ri.earliest_offense_date,180), 1, 0);
	SELF.BJL.arrests_count12 := if(isArrest and ProfileBooster.Common.MonthsApart_YYYYMMDD(myGetDate,(string)ri.earliest_offense_date,true) < 13, 1, 0); 
	self.BJL.arrests_count24 := if(isArrest and checkDays(myGetDate,ri.earliest_offense_date,ut.DaysInNYears(2)), 1, 0);
	self.BJL.arrests_count36 := if(isArrest and checkDays(myGetDate,ri.earliest_offense_date,ut.DaysInNYears(3)), 1, 0);
	self.BJL.arrests_count60 := if(isArrest and checkDays(myGetDate,ri.earliest_offense_date,ut.DaysInNYears(5)), 1, 0);
	self.BJL.date_last_arrest := if(isArrest, (unsigned4)ri.earliest_offense_date, 0);	// using the case date for the arrest date
	
	SELF := le;
END;

doc_added_roxie := JOIN (liens_rolled, koff_nonFCRA, 
                   (LEFT.did != 0) AND keyed(LEFT.did=RIGHT.sdid) AND
									 (stringlib.stringtouppercase(RIGHT.orig_state) not in ProfileBooster.Constants.setCriminalStatesRes) AND //CT criminal data is restricted for Profile Booster
									 (unsigned3)(RIGHT.earliest_offense_date[1..6]) < left.historydate, 
                   add_doc_nonFCRA(LEFT,RIGHT),
									 LEFT OUTER, KEEP(500), ATMOST (keyed(LEFT.did=RIGHT.sdid), riskwise.max_atmost));

doc_added_thor1 := JOIN (
	distribute(liens_rolled(did<>0), did), 
	distribute(pull(koff_nonFCRA(stringlib.stringtouppercase(orig_state) not in ProfileBooster.Constants.setCriminalStatesRes)), sdid), 
                   LEFT.did=RIGHT.sdid AND
									 (unsigned3)(RIGHT.earliest_offense_date[1..6]) < left.historydate, 
                   add_doc_nonFCRA(LEFT,RIGHT),
									 LEFT OUTER, KEEP(500), ATMOST (left.did=right.sdid, riskwise.max_atmost), 
	local);
doc_added_empty_did := liens_rolled(did=0);
doc_added_thor := doc_added_thor1 + doc_added_empty_did;

#IF(onThor)
	doc_added := doc_added_thor;
#ELSE
	doc_added := doc_added_roxie;
#END
									 
layout_extended roll_crim_counts(doc_added le, doc_added ri) :=
TRANSFORM
	self.bjl.criminal_count := le.bjl.criminal_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count);
	self.bjl.criminal_count30 := le.bjl.criminal_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count30);
	self.bjl.criminal_count90 := le.bjl.criminal_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count90);
	self.bjl.criminal_count180 := le.bjl.criminal_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count180);
	self.bjl.criminal_count12 := le.bjl.criminal_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count12);
	self.bjl.criminal_count24 := le.bjl.criminal_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count24);
	self.bjl.criminal_count36 := le.bjl.criminal_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count36);
	self.bjl.criminal_count60 := le.bjl.criminal_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.criminal_count60);
	self.bjl.last_criminal_date := max(le.bjl.last_criminal_date,ri.bjl.last_criminal_date);
	self.bjl.last_felony_date := max(le.bjl.last_felony_date,ri.bjl.last_felony_date);
	self.bjl.felony_count := le.bjl.felony_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.felony_count);
	self.bjl.last_nonfelony_criminal_date := max(le.bjl.last_nonfelony_criminal_date,ri.bjl.last_nonfelony_criminal_date);
	self.bjl.nonfelony_criminal_count := le.bjl.nonfelony_criminal_count+IF(le.crim_case_num=ri.crim_case_num and le.bjl.nonfelony_criminal_count > 0,0,ri.bjl.nonfelony_criminal_count);
	self.bjl.nonfelony_criminal_count12 := le.bjl.nonfelony_criminal_count12+IF(le.crim_case_num=ri.crim_case_num and le.bjl.nonfelony_criminal_count12 > 0,0,ri.bjl.nonfelony_criminal_count12);
	SELF := ri;
END;

crim_sorted := SORT(doc_added, seq,did,crim_case_num,-bjl.felony_count, -bjl.last_felony_date, -bjl.criminal_count, -bjl.last_criminal_date);
crim_counts_rolled := ROLLUP(crim_sorted, left.seq=right.seq and LEFT.did=RIGHT.did, roll_crim_counts(LEFT,RIGHT));

layout_extended roll_arrest_counts(doc_added le, doc_added ri) :=
TRANSFORM
	self.bjl.arrests_count := le.bjl.arrests_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count);
	self.bjl.arrests_count30 := le.bjl.arrests_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count30);
	self.bjl.arrests_count90 := le.bjl.arrests_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count90);
	self.bjl.arrests_count180 := le.bjl.arrests_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count180);
	self.bjl.arrests_count12 := le.bjl.arrests_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count12);
	self.bjl.arrests_count24 := le.bjl.arrests_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count24);
	self.bjl.arrests_count36 := le.bjl.arrests_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count36);
	self.bjl.arrests_count60 := le.bjl.arrests_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.bjl.arrests_count60);
	self.bjl.date_last_arrest := max(le.bjl.date_last_arrest,ri.bjl.date_last_arrest);
	SELF := ri;
END;

arrests_sorted := SORT(doc_added ,seq, did,crim_case_num,-bjl.arrests_count, -bjl.date_last_arrest);
arrest_counts_rolled := ROLLUP(arrests_sorted, left.seq=right.seq and LEFT.did=RIGHT.did, roll_arrest_counts(LEFT,RIGHT));

crim_rolled := join(crim_counts_rolled, arrest_counts_rolled, 
					left.seq=right.seq and left.did=right.did,
					transform(layout_extended,
						self.bjl.criminal_count := left.bjl.criminal_count;
						self.bjl.criminal_count30 := left.bjl.criminal_count30;
						self.bjl.criminal_count90 := left.bjl.criminal_count90;
						self.bjl.criminal_count180 := left.bjl.criminal_count180;
						self.bjl.criminal_count12 := left.bjl.criminal_count12;
						self.bjl.criminal_count24 := left.bjl.criminal_count24;
						self.bjl.criminal_count36 := left.bjl.criminal_count36;
						self.bjl.criminal_count60 := left.bjl.criminal_count60;
						self.bjl.last_criminal_date := left.bjl.last_criminal_date;
						self.bjl.last_felony_date := left.bjl.last_felony_date;
						self.bjl.felony_count := left.bjl.felony_count;
						self.bjl.last_nonfelony_criminal_date := left.bjl.last_nonfelony_criminal_date;
						self.bjl.nonfelony_criminal_count := left.bjl.nonfelony_criminal_count;
						self.bjl.nonfelony_criminal_count12 := left.bjl.nonfelony_criminal_count12;
						SELF := right;)); 



wFID_roxie := join(crim_rolled, kford, 
						left.did!=0 and keyed(left.did=right.did), 
						transform(layout_extended, self.fid := right.fid, self.BJL.foreclosure_flag := right.did!=0, self := left), 
						left outer, atmost(keyed(left.did=right.did), riskwise.max_atmost), keep(50));

wFID_thor := join(
	distribute(crim_rolled, did), 
	distribute(pull(kford), did), 
						left.did!=0 and left.did=right.did, 
						transform(layout_extended, self.fid := right.fid, self.BJL.foreclosure_flag := right.did!=0, self := left), 
						left outer, atmost(riskwise.max_atmost), keep(50), 
	local);
						
#IF(onThor)
	wFID := wFID_thor;
#ELSE
	wFID := wFID_roxie;
#END

layout_extended add_foreclosure_flag(layout_extended le, kforf rt) := transform
	self.BJL.last_foreclosure_date := rt.recording_date;
	self.BJL.foreclosure_flag := rt.fid!='';
	self := le;
end;	
					
all_foreclosures_roxie := join(wFID, kforf,
						left.fid!='' and 
						keyed(left.fid=right.fid) and
						(unsigned3)(right.recording_date[1..6]) < left.historydate,
						add_foreclosure_flag(left, right),
						left outer, atmost(keyed(left.fid=right.fid), riskwise.max_atmost), keep(50));

all_foreclosures_thor1 := join(
	distribute(wFID(fid<>''), hash64(fid)), 
	distribute(pull(kforf), hash64(fid)),
						left.fid=right.fid and
						(unsigned3)(right.recording_date[1..6]) < left.historydate,
						add_foreclosure_flag(left, right),
						left outer, atmost(left.fid=right.fid, riskwise.max_atmost), keep(50),
	local);
all_foreclosures_thor := all_foreclosures_thor1 + wFID(fid='');  // add back the records with blank FID						

#IF(onThor)
	all_foreclosures := all_foreclosures_thor;
#ELSE
	all_foreclosures := all_foreclosures_roxie;
#END

wForeclosures := dedup(sort(all_foreclosures, seq, did, -BJL.last_foreclosure_date), seq, did);


// output(liens_added, named('liens_added'),overwrite);
// output(liens_full, named('liens_full'),overwrite);
// output(liens_main, named('liens_main'),overwrite);
// output(liens_sorted, named('liens_sorted'),overwrite);
// output(liens_rolled, named('liens_rolled'),overwrite);
// output(evictions, named('evictions'),overwrite);
// output(liens_sorted, named('liens_sorted'),overwrite);
// output(doc_added, named('doc_added'),overwrite);
// output(crim_sorted, named('crim_sorted'),overwrite);
// output(crim_counts_rolled, named('crim_counts_rolled'),overwrite);
// output(crim_rolled, named('crim_rolled'),overwrite);

RETURN PROJECT(wForeclosures,layout_derog_process);

END;