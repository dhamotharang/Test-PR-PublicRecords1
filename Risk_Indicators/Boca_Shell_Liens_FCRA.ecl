import _Control, doxie_files, FCRA, ut, liensv2, riskwise, Risk_Indicators, STD;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Liens_FCRA (integer bsVersion, unsigned8 BSOptions=0, 
		GROUPED DATASET(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus) w_bankruptcy) := function
 
  todaysdate := (string) risk_indicators.iid_constants.todaydate;
	FilterLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.FilterLiens) > 0;

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus add_liens(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, liensv2.key_liens_did_FCRA ri) :=
	TRANSFORM
		SELF.rmsid := ri.rmsid;
		self.tmsid := ri.tmsid;
		SELF := le;
	END;

	liens_added_roxie := JOIN(w_bankruptcy, liensv2.key_liens_did_FCRA, 
											keyed(LEFT.did=RIGHT.did),
											add_liens(LEFT,RIGHT), LEFT OUTER, atmost(riskwise.max_atmost), keep(100));

	liens_added_thor := JOIN(distribute(w_bankruptcy, hash64(did)), 
											distribute(pull(liensv2.key_liens_did_FCRA), hash64(did)), 
											LEFT.did=RIGHT.did,
											add_liens(LEFT,RIGHT), LEFT OUTER, atmost(riskwise.max_atmost), keep(100), LOCAL);
											
	#IF(onThor)
		liens_added := group(sort(distribute(liens_added_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
	#ELSE
		liens_added := liens_added_roxie;
	#END
  
	MAC_liensParty_transform(trans_name, key_liens_party) := MACRO	

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus trans_name(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, key_liens_party ri) := TRANSFORM
		myGetDate := iid_constants.myGetDate(le.historydate);
		isRecent := ut.DaysApart(ri.date_first_seen,myGetDate)<365*2+1;

		// Unreleased Liens--------------------------------
		SELF.BJL.liens_recent_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																					 (INTEGER)ri.date_last_seen=0 AND
																						isRecent);
		SELF.BJL.liens_historical_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																							(INTEGER)ri.date_last_seen=0 AND
																							~isRecent);
																							
		SELF.BJL.liens_unreleased_count30 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,30));
		SELF.BJL.liens_unreleased_count90 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,90));
		SELF.BJL.liens_unreleased_count180 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,180));
		SELF.BJL.liens_unreleased_count12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(1)));
		SELF.BJL.liens_unreleased_count24 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(2)));
		SELF.BJL.liens_unreleased_count36 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(3)));
		SELF.BJL.liens_unreleased_count60 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(5)));																			
		SELF.BJL.liens_unreleased_count84 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7)));																			
																																									
		// Released Liens	-----------------------------------																		
		SELF.BJL.liens_recent_released_count := (INTEGER)(ri.rmsid<>'' AND 
																				(INTEGER)ri.date_last_seen<>0 AND
																				isRecent);
		SELF.BJL.liens_historical_released_count := (INTEGER)(ri.rmsid<>'' AND 
																						(INTEGER)ri.date_last_seen<>0 AND
																						~isRecent);
																						
		SELF.BJL.liens_released_count30 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,30));
		SELF.BJL.liens_released_count90 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,90));
		SELF.BJL.liens_released_count180 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,180));
		SELF.BJL.liens_released_count12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(1)));
		SELF.BJL.liens_released_count24 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(2)));
		SELF.BJL.liens_released_count36 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(3)));
		SELF.BJL.liens_released_count60 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(5)));																				
		SELF.BJL.liens_released_count84 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7)));																				
																						
		self.BJL.last_liens_unreleased_date := if((INTEGER)ri.date_last_seen=0, ri.date_first_seen, '');																			
		SELF.BJL.liens_last_unrel_date84 := if((INTEGER)ri.date_last_seen=0 and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7),le.historydate), ri.date_first_seen, '');		
		SELF.BJL.last_liens_released_date := if((INTEGER)ri.date_last_seen<>0, (unsigned)ri.date_first_seen, 0);
		SELF.BJL.liens_last_rel_date84		:= if((INTEGER)ri.date_last_seen<>0 and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(7),le.historydate), (unsigned)ri.date_last_seen, 0);
		
		SELF.date_first_seen := (unsigned)ri.date_first_seen;// to be used in evictions
		SELF.date_last_seen := (unsigned)ri.date_last_seen;// to be used in evictions
		
		self.tmsid := if(ri.tmsid='', '', le.tmsid);	// set these to blank so that we miss on the evictions search below
		self.rmsid := if(ri.rmsid='', '', le.rmsid);

		SELF := le;
	END;

	endmacro;

	MAC_liensParty_transform(get_liensparty_raw, liensv2.key_liens_party_id_FCRA);
	MAC_liensParty_transform(get_liensparty_corrections, fcra.key_Override_liensv2_party_ffid);

	liens_party_raw_roxie := JOIN (liens_added, liensv2.key_liens_party_id_FCRA, 
											LEFT.rmsid<>'' AND
											keyed(LEFT.rmsid=RIGHT.rmsid) AND keyed(left.tmsid=right.tmsid) and 
											left.did=(unsigned)right.did and
											(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
											FCRA.lien_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate),RIGHT.date_first_seen) and right.name_type='D'
											AND (string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
											and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid,  // new way - exclude corrected records that match the persistent_record_id										
											get_liensparty_raw(LEFT,RIGHT), LEFT OUTER,
											ATMOST(keyed(LEFT.rmsid=RIGHT.rmsid) AND keyed(left.tmsid=right.tmsid), riskwise.max_atmost));

	liens_party_raw_thor_rmsid := JOIN (distribute(liens_added(rmsid<>''), hash64(rmsid)), 
											distribute(pull(liensv2.key_liens_party_id_FCRA(name_type='D')), hash64(rmsid)), 
											(LEFT.rmsid=RIGHT.rmsid) AND (left.tmsid=right.tmsid) and 
											left.did=(unsigned)right.did and
											(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
											FCRA.lien_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate),RIGHT.date_first_seen)
											AND (string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
											and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid,  // new way - exclude corrected records that match the persistent_record_id										
											get_liensparty_raw(LEFT,RIGHT), LEFT OUTER,
											ATMOST((LEFT.rmsid=RIGHT.rmsid) AND (left.tmsid=right.tmsid), riskwise.max_atmost), LOCAL);

	liens_party_raw_thor := group(sort(distribute(liens_party_raw_thor_rmsid + liens_added(rmsid=''), hash64(seq)), seq, LOCAL), seq, LOCAL);

	#IF(onThor)
		liens_party_raw := liens_party_raw_thor;
	#ELSE
		liens_party_raw := liens_party_raw_roxie;
	#END
  
	unique_ffids := dedup(sort(liens_added,did), did);
	 
	liens_party_overrides_roxie := JOIN (unique_ffids, fcra.key_Override_liensv2_party_ffid,
											exists(left.lien_correct_ffid) and
											keyed(right.flag_file_id IN left.lien_correct_ffid) and 
											left.did=(unsigned)right.did and
											(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
											FCRA.lien_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate),RIGHT.date_first_seen) and right.name_type='D',
											get_liensparty_corrections(LEFT, RIGHT),
											ATMOST(riskwise.max_atmost));

	liens_party_overrides_thor := JOIN (unique_ffids(exists(lien_correct_ffid)), pull(fcra.key_Override_liensv2_party_ffid),
											right.flag_file_id IN left.lien_correct_ffid and 
											left.did=(unsigned)right.did and
											(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
											FCRA.lien_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate),RIGHT.date_first_seen) and right.name_type='D',
											get_liensparty_corrections(LEFT, RIGHT), ALL, LOCAL);
					
	#IF(onThor)
		liens_party_overrides := liens_party_overrides_thor;
	#ELSE
		liens_party_overrides := liens_party_overrides_roxie;
	#END
  
	MAC_liensMain_transform(trans_name, key_liens_main) := MACRO	

	Risk_Indicators.Layouts_Derog_Info.Layout_derog_process_plus_ftd trans_name(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, key_liens_main ri) := transform
		myGetDate := iid_constants.myGetDate(le.historydate);
		isRecent := ut.DaysApart((string8)le.date_first_seen,myGetDate)<365*2+1;

		isEviction := ri.eviction='Y';
		self.evictionInd := isEviction;

		// evictions
		SELF.BJL.eviction_recent_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND isRecent);
		SELF.BJL.eviction_historical_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND ~isRecent);
		SELF.BJL.eviction_recent_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND isRecent);
		SELF.BJL.eviction_historical_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND ~isRecent);

		SELF.BJL.eviction_count := (integer)(isEviction and (INTEGER)le.date_last_seen=0) ; // fcra eviction must be unreleased
		SELF.BJL.eviction_count30 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,30));
		SELF.BJL.eviction_count90 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,90));
		SELF.BJL.eviction_count180 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,180));
		SELF.BJL.eviction_count12 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1)));
		SELF.BJL.eviction_count24 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2)));
		SELF.BJL.eviction_count36 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3)));
		SELF.BJL.eviction_count60 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5)));
		SELF.BJL.eviction_count84 := (integer)(isEviction and (INTEGER)le.date_last_seen=0 and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(7)));

		SELF.BJL.last_eviction_date := if(isEviction, (unsigned)le.date_first_seen, 0);

		// they want liens seperated by type and released or unreleased for modeling shell 3.0
		ftd := trim(stringlib.stringtouppercase(ri.filing_type_desc));
		goodResult := ri.rmsid<>'';
		unreleased := le.date_last_seen=0;
		released := le.date_last_seen<>0;
		
		// only count evictions in the liens buckets if you are running version prior to 50
		isCivilJudgment := ftd in iid_constants.setCivilJudgment and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA) );
		isCivilJudgmentReleased := ftd in iid_constants.setCivilJudgment and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isFederalTax := ftd in iid_constants.setFederalTax and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isFederalTaxReleased := ftd in iid_constants.setFederalTax and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isForeclosure := ftd in iid_constants.setForeclosure and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isForeclosureReleased := ftd in iid_constants.setForeclosure and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isLandlordTenant := ftd in iid_constants.setLandlordTenant and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isLandlordTenantReleased := ftd in iid_constants.setLandlordTenant and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isLisPendens := ftd in iid_constants.setLisPendens and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isLisPendensReleased := ftd in iid_constants.setLisPendens and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherLJ := ftd not in iid_constants.setOtherLJ and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherLJReleased := ftd not in iid_constants.setOtherLJ and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherTax := ftd in iid_constants.setOtherTax and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherTaxReleased := ftd in iid_constants.setOtherTax and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isSmallClaims := ftd in iid_constants.setSmallClaims and goodResult and unreleased and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isSmallClaimsReleased := ftd in iid_constants.setSmallClaims and goodResult and released and (bsversion<50 or (~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isSuits := ftd in iid_constants.setSuitsFCRA and goodResult and unreleased and (bsversion<50 or (~isEviction));
		isSuitsReleased := ftd in iid_constants.setSuitsFCRA and goodResult and released and (bsversion<50 or (~isEviction));

		isWithin84 := risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(7),le.historydate);
		isAnyUnreleased := (isCivilJudgment or isFederalTax or isForeclosure or isLandlordTenant or isLisPendens or isOtherLJ or isOtherTax or isSmallClaims) and not isSuits;
		isAnyReleased 	:= (isCivilJudgmentReleased or isFederalTaxReleased or isForeclosureReleased or isLandlordTenantReleased or isLisPendensReleased or isOtherLJReleased or isOtherTaxReleased or isSmallClaimsReleased) and not isSuitsReleased;

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
		
	// suits don't apply in FCRA leave them as 0
		self.liens.liens_unreleased_suits.count := 0;
		self.liens.liens_unreleased_suits.earliest_filing_date :=  0;
		self.liens.liens_unreleased_suits.most_recent_filing_date := 0;
		self.liens.liens_unreleased_suits.total_amount := 0;
		self.liens.liens_released_suits.count := 0;
		self.liens.liens_released_suits.earliest_filing_date := 0;
		self.liens.liens_released_suits.most_recent_filing_date := 0;
		self.liens.liens_released_suits.total_amount := 0;
		
		// blank out line counters and dates for suits on records that were counted in Liens Party join above
		SELF.BJL.liens_recent_unreleased_count := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_recent_unreleased_count);
		SELF.BJL.liens_historical_unreleased_count := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_historical_unreleased_count	);																					
		SELF.BJL.liens_unreleased_count30 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count30 );	
		SELF.BJL.liens_unreleased_count90 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count90 );	
		SELF.BJL.liens_unreleased_count180 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count180 );	
		SELF.BJL.liens_unreleased_count12 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count12 );	
		SELF.BJL.liens_unreleased_count24 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count24 );	
		SELF.BJL.liens_unreleased_count36 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count36 );	
		SELF.BJL.liens_unreleased_count60 :=	if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count60 );																																						
		SELF.BJL.liens_unreleased_count84 :=	if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_unreleased_count84 );																																						
		SELF.BJL.liens_recent_released_count :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_recent_released_count );	
		SELF.BJL.liens_historical_released_count := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_historical_released_count );	
		SELF.BJL.liens_released_count30 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count30 );	
		SELF.BJL.liens_released_count90 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count90 );	
		SELF.BJL.liens_released_count180 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count180 );	
		SELF.BJL.liens_released_count12 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count12 );	
		SELF.BJL.liens_released_count24 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count24 );	
		SELF.BJL.liens_released_count36 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count36 );	
		SELF.BJL.liens_released_count60 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count60 );	
		SELF.BJL.liens_released_count84 :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.liens_released_count84 );	
		self.BJL.last_liens_unreleased_date := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), '', le.BJL.last_liens_unreleased_date );	
		SELF.BJL.liens_last_unrel_date84 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), '', le.bjl.liens_last_unrel_date84);
		SELF.BJL.last_liens_released_date :=  if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.BJL.last_liens_released_date );	
		SELF.BJL.liens_last_rel_date84 := if(bsversion>=50 and (isSuits or isSuitsReleased or isEviction), 0, le.bjl.liens_last_rel_date84);
		self.ftd := if(goodResult, '1', '0');
		SELF := le;
		self := [];
	end;
	endmacro;


	MAC_liensMain_transform(get_liens_main_raw, liensv2.key_liens_main_id_FCRA);
	MAC_liensMain_transform(get_liens_main_corrections, fcra.key_Override_liensv2_main_ffid);

	liens_main_raw_roxie := JOIN(liens_party_raw, liensV2.key_liens_main_ID_FCRA,
												left.rmsid<>'' and left.tmsid<>'' and 
												keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid) and
												right.filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens and
												right.filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50 AND
												(string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
												and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid,  // new way - exclude corrected records that match the persistent_record_id										
												get_liens_main_raw(LEFT,RIGHT), left outer, 
												ATMOST(keyed(LEFT.tmsid=RIGHT.tmsid) and keyed(left.rmsid=right.rmsid), riskwise.max_atmost));

	liens_main_raw_thor_pre := JOIN(distribute(liens_party_raw(rmsid <> '' and tmsid <> ''), hash64(tmsid, rmsid)), 
												distribute(pull(liensV2.key_liens_main_ID_FCRA(
																filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens and filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50)), hash64(tmsid, rmsid)),
												(left.tmsid=right.tmsid) and (left.rmsid=right.rmsid) and
												(string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
												and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid,  // new way - exclude corrected records that match the persistent_record_id										
												get_liens_main_raw(LEFT,RIGHT), left outer, 
												ATMOST((LEFT.tmsid=RIGHT.tmsid) and (left.rmsid=right.rmsid), riskwise.max_atmost), LOCAL);
												
	liens_main_raw_thor := group(sort(distribute(liens_main_raw_thor_pre + 
																		project(liens_party_raw(rmsid='' or tmsid=''), transform(Risk_Indicators.Layouts_Derog_Info.Layout_derog_process_plus_ftd,
																						self.ftd := '0', self := left, self := [])), hash64(seq)), seq, LOCAL), seq, LOCAL);

	#IF(onThor)
		liens_main_raw := liens_main_raw_thor;
	#ELSE
		liens_main_raw := liens_main_raw_roxie;
	#END
  
	liens_main_overrides_roxie := JOIN(liens_party_overrides, fcra.key_Override_liensv2_main_ffid,
											exists(left.lien_correct_ffid) and
											keyed(right.flag_file_id IN left.lien_correct_ffid),  
												get_liens_main_corrections(LEFT,RIGHT), 
												ATMOST(riskwise.max_atmost));

	liens_main_overrides_thor := JOIN(liens_party_overrides(exists(lien_correct_ffid)), 
											pull(fcra.key_Override_liensv2_main_ffid),
											(right.flag_file_id IN left.lien_correct_ffid),  
												get_liens_main_corrections(LEFT,RIGHT), ALL);
											
#IF(onThor)
	liens_main_overrides := liens_main_overrides_thor;
#ELSE
	liens_main_overrides := liens_main_overrides_roxie;
#END

	liens_full := group(ungroup(liens_main_raw(ftd ='1') + liens_main_overrides(ftd ='1')), did);

	liensWBankruptcy := JOIN(UNGROUP(w_bankruptcy), liens_full, 
		LEFT.did = RIGHT.did,
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Layout_derog_process_plus_ftd,
			SELF.BJL.liens_recent_unreleased_count        := RIGHT.BJL.liens_recent_unreleased_count       ;   
			SELF.BJL.liens_historical_unreleased_count    := RIGHT.BJL.liens_historical_unreleased_count   ;
			SELF.BJL.liens_unreleased_count30             := RIGHT.BJL.liens_unreleased_count30            ;
			SELF.BJL.liens_unreleased_count90             := RIGHT.BJL.liens_unreleased_count90            ;
			SELF.BJL.liens_unreleased_count180            := RIGHT.BJL.liens_unreleased_count180           ;
			SELF.BJL.liens_unreleased_count12             := RIGHT.BJL.liens_unreleased_count12            ;
			SELF.BJL.liens_unreleased_count24             := RIGHT.BJL.liens_unreleased_count24            ;
			SELF.BJL.liens_unreleased_count36             := RIGHT.BJL.liens_unreleased_count36            ;
			SELF.BJL.liens_unreleased_count60             := RIGHT.BJL.liens_unreleased_count60            ;
			SELF.BJL.liens_unreleased_count84             := RIGHT.BJL.liens_unreleased_count84            ;
			SELF.BJL.liens_recent_released_count          := RIGHT.BJL.liens_recent_released_count         ;
			SELF.BJL.liens_historical_released_count      := RIGHT.BJL.liens_historical_released_count     ;
			SELF.BJL.liens_released_count30               := RIGHT.BJL.liens_released_count30              ;
			SELF.BJL.liens_released_count90               := RIGHT.BJL.liens_released_count90              ;
			SELF.BJL.liens_released_count180              := RIGHT.BJL.liens_released_count180             ;
			SELF.BJL.liens_released_count12               := RIGHT.BJL.liens_released_count12              ;
			SELF.BJL.liens_released_count24               := RIGHT.BJL.liens_released_count24              ;
			SELF.BJL.liens_released_count36               := RIGHT.BJL.liens_released_count36              ;
			SELF.BJL.liens_released_count60               := RIGHT.BJL.liens_released_count60              ;
			SELF.BJL.liens_released_count84               := RIGHT.BJL.liens_released_count84              ;
			SELF.BJL.last_liens_unreleased_date           := RIGHT.BJL.last_liens_unreleased_date          ;
			SELF.BJL.liens_last_unrel_date84	            := RIGHT.BJL.liens_last_unrel_date84          	 ;
			SELF.BJL.last_liens_released_date             := RIGHT.BJL.last_liens_released_date            ;
			SELF.BJL.liens_last_rel_date84	              := RIGHT.BJL.liens_last_rel_date84	             ;
			SELF.BJL.eviction_recent_unreleased_count     := RIGHT.BJL.eviction_recent_unreleased_count    ;
			SELF.BJL.eviction_historical_unreleased_count := RIGHT.BJL.eviction_historical_unreleased_count;
			SELF.BJL.eviction_recent_released_count       := RIGHT.BJL.eviction_recent_released_count      ;
			SELF.BJL.eviction_historical_released_count   := RIGHT.BJL.eviction_historical_released_count  ;
			SELF.BJL.eviction_count                       := RIGHT.BJL.eviction_count                      ;
			SELF.BJL.eviction_count30                     := RIGHT.BJL.eviction_count30                    ;
			SELF.BJL.eviction_count90                     := RIGHT.BJL.eviction_count90                    ;
			SELF.BJL.eviction_count180                    := RIGHT.BJL.eviction_count180                   ;
			SELF.BJL.eviction_count12                     := RIGHT.BJL.eviction_count12                    ;
			SELF.BJL.eviction_count24                     := RIGHT.BJL.eviction_count24                    ;
			SELF.BJL.eviction_count36                     := RIGHT.BJL.eviction_count36                    ;
			SELF.BJL.eviction_count60                     := RIGHT.BJL.eviction_count60                    ;
			SELF.BJL.eviction_count84                     := RIGHT.BJL.eviction_count84                    ;
			SELF.BJL.last_eviction_date                   := RIGHT.BJL.last_eviction_date                  ;			
			SELF.rmsid := right.rmsid; 
			SELF.tmsid := right.tmsid;
			SELF.date_first_seen := right.date_first_seen;
			SELF.date_last_seen := right.date_last_seen;
			SELF.evictionInd := right.evictionInd;
			SELF.bk_tmsid := right.tmsid;
			SELF.Liens := RIGHT.Liens;
			SELF.ftd := right.ftd;
			SELF := LEFT;
			SELF := [];
			),
		LEFT OUTER);

	Risk_Indicators.Layouts_Derog_Info.Layout_derog_process_plus_ftd roll_liens(Risk_Indicators.Layouts_Derog_Info.Layout_derog_process_plus_ftd le, 
		Risk_Indicators.Layouts_Derog_Info.Layout_derog_process_plus_ftd ri) :=
	TRANSFORM
		sameLien := le.tmsid=ri.tmsid and le.rmsid=ri.rmsid;

	//don't increment the lien counters in shell 5.0 and higher if right record is an eviction
		SELF.BJL.liens_recent_unreleased_count := le.BJL.liens_recent_unreleased_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_recent_unreleased_count);
		SELF.BJL.liens_historical_unreleased_count := le.BJL.liens_historical_unreleased_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_historical_unreleased_count);
		SELF.BJL.liens_unreleased_count30 := le.BJL.liens_unreleased_count30 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count30);
		SELF.BJL.liens_unreleased_count90 := le.BJL.liens_unreleased_count90 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count90);
		SELF.BJL.liens_unreleased_count180 := le.BJL.liens_unreleased_count180 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count180);
		SELF.BJL.liens_unreleased_count12 := le.BJL.liens_unreleased_count12 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count12);
		SELF.BJL.liens_unreleased_count24 := le.BJL.liens_unreleased_count24 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count24);
		SELF.BJL.liens_unreleased_count36 := le.BJL.liens_unreleased_count36 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count36);
		SELF.BJL.liens_unreleased_count60 := le.BJL.liens_unreleased_count60 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count60);
		SELF.BJL.liens_unreleased_count84 := le.BJL.liens_unreleased_count84 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_unreleased_count84);
		
		SELF.BJL.liens_recent_released_count := le.BJL.liens_recent_released_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_recent_released_count);
		SELF.BJL.liens_historical_released_count := le.BJL.liens_historical_released_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_historical_released_count);
		SELF.BJL.liens_released_count30 := le.BJL.liens_released_count30 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count30);
		SELF.BJL.liens_released_count90 := le.BJL.liens_released_count90 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count90);
		SELF.BJL.liens_released_count180 := le.BJL.liens_released_count180 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count180);
		SELF.BJL.liens_released_count12 := le.BJL.liens_released_count12 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count12);
		SELF.BJL.liens_released_count24 := le.BJL.liens_released_count24 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count24);
		SELF.BJL.liens_released_count36 := le.BJL.liens_released_count36 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count36);
		SELF.BJL.liens_released_count60 := le.BJL.liens_released_count60 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count60);
		SELF.BJL.liens_released_count84 := le.BJL.liens_released_count84 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.BJL.liens_released_count84);
		
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

	liens_rolled_original := ROLLUP(SORT(liensWBankruptcy,did,tmsid,rmsid,
		-bjl.last_liens_unreleased_date,-bjl.last_eviction_date, record),
		LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT)); 

	// if the bsOption is turned on to remove liens, use the w_bankruptcy data prior to the liens joins
	liens_rolled := if(FilterLiens, //at query level read in posLiensJudgRestriction
		ungroup(w_bankruptcy), ungroup( project(liens_rolled_original, 
		transform(Risk_Indicators.Layouts_Derog_Info.Layout_derog_process_plus, self := left, self := []))));
	
	// output(liens_full, named('liens_full_orig'));
	// output(liens_rolled, named('liens_rolled'));
	// output(liensWBankruptcy, named('liensWBankruptcy'));
	// output(w_bankruptcy, named('w_bankruptcy'));
	// output(liens_added, named('liens_added'));
	// output(liens_party_raw, named('liens_party_raw'));
	// output(unique_ffids, named('unique_ffids'));
	// output(liens_party_overrides, named('liens_party_overrides'));
	// output(liens_main_raw, named('liens_main_raw'));
	// output(liens_main_overrides, named('liens_main_overrides'));
	// output(liens_full, named('liens_full'));
	// output(liensWBankruptcy, named('liensWBankruptcy'));
	// output(liens_rolled_original, named('liens_rolled_original'));
	// output(liens_rolled, named('liens_rolled'));
	 RETURN GROUP(liens_rolled, Seq);
 END;