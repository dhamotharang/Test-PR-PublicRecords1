import doxie, doxie_files, liensv2, ut, risk_indicators, data_services;

slimmerrec := record
	unsigned6	did;
	
	UNSIGNED1 liens_recent_unreleased_count := 0;
	UNSIGNED1 liens_historical_unreleased_count := 0;
	UNSIGNED1 liens_unreleased_count30 := 0;
	UNSIGNED1 liens_unreleased_count90 := 0;
	UNSIGNED1 liens_unreleased_count180 := 0;
	UNSIGNED1 liens_unreleased_count12 := 0;
	UNSIGNED1 liens_unreleased_count24 := 0;
	UNSIGNED1 liens_unreleased_count36 := 0;
	UNSIGNED1 liens_unreleased_count60 := 0;
	string8 last_liens_unreleased_date := '';
	
	UNSIGNED1 liens_recent_released_count := 0;
	UNSIGNED1 liens_historical_released_count := 0;
	UNSIGNED1 liens_released_count30 := 0;
	UNSIGNED1 liens_released_count90 := 0;
	UNSIGNED1 liens_released_count180 := 0;
	UNSIGNED1 liens_released_count12 := 0;
	UNSIGNED1 liens_released_count24 := 0;
	UNSIGNED1 liens_released_count36 := 0;
	UNSIGNED1 liens_released_count60 := 0;
	UNSIGNED4 last_liens_released_date := 0;
		
	UNSIGNED1 eviction_recent_unreleased_count := 0;
	UNSIGNED1 eviction_historical_unreleased_count := 0;
	UNSIGNED1 eviction_recent_released_count := 0;
	UNSIGNED1 eviction_historical_released_count := 0;
	UNSIGNED1 eviction_count30 := 0;
	UNSIGNED1 eviction_count90 := 0;
	UNSIGNED1 eviction_count180 := 0;
	UNSIGNED1 eviction_count12 := 0;
	UNSIGNED1 eviction_count24 := 0;
	UNSIGNED1 eviction_count36 := 0;
	UNSIGNED1 eviction_count60 := 0;
	UNSIGNED4 last_eviction_date := 0;
	
END;

slimrec := RECORD
	slimmerrec;
	// liens extras
	string50 tmsid;
	STRING50 rmsid;
END;

mygetdate := ut.GetDate;

slimrec get_liens(LiensV2.file_liens_party le, liensv2.file_liens_main rt) := transform
	self.tmsid := le.tmsid;
	self.rmsid := le.rmsid;
									    
	// SELF.last_liens_unreleased_date := if(isDebtor and (INTEGER)le.date_last_seen=0, le.date_first_seen, '');
	history_date := 999999;
	isRecent := ut.DaysApart(le.date_first_seen,myGetDate)<365*2+1;

	// Unreleased Liens--------------------------------
	self.last_liens_unreleased_date := if((INTEGER)le.date_last_seen=0, le.date_first_seen, '');		
	SELF.liens_recent_unreleased_count := (INTEGER)(le.rmsid<>'' AND 
																				 (INTEGER)le.date_last_seen=0 AND
																					isRecent);
	SELF.liens_historical_unreleased_count := (INTEGER)(le.rmsid<>'' AND 
																						(INTEGER)le.date_last_seen=0 AND
																						~isRecent);
																						
	SELF.liens_unreleased_count30 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.liens_unreleased_count90 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.liens_unreleased_count180 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.liens_unreleased_count12 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.liens_unreleased_count24 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.liens_unreleased_count36 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.liens_unreleased_count60 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));																			
																																									
	// Released Liens	-----------------------------------		
	SELF.last_liens_released_date := if((INTEGER)le.date_last_seen<>0, (unsigned)le.date_first_seen, 0);
	SELF.liens_recent_released_count := (INTEGER)(le.rmsid<>'' AND 
																			(INTEGER)le.date_last_seen<>0 AND
																			isRecent);
	SELF.liens_historical_released_count := (INTEGER)(le.rmsid<>'' AND 
																					(INTEGER)le.date_last_seen<>0 AND
																					~isRecent);
																					
	SELF.liens_released_count30 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.liens_released_count90 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.liens_released_count180 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.liens_released_count12 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.liens_released_count24 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.liens_released_count36 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.liens_released_count60 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));																				
																					
																		
	isEviction := rt.eviction='Y';

	// evictions
	SELF.eviction_recent_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND isRecent);
	SELF.eviction_historical_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND ~isRecent);
	SELF.eviction_recent_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND isRecent);
	SELF.eviction_historical_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND ~isRecent);
	
	SELF.eviction_count30 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.eviction_count90 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.eviction_count180 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.eviction_count12 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.eviction_count24 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.eviction_count36 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.eviction_count60 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));

	SELF.last_eviction_date := if(isEviction, (unsigned)le.date_first_seen, 0);
	
	self.did := (integer)le.did;
end;



lien_party_debtors := LiensV2.file_liens_party((integer)did != 0 and name_type='D');
lien_main_evictions := liensv2.file_liens_main(eviction='Y');
w_evictions := join(lien_party_debtors, lien_main_evictions,  LEFT.rmsid=RIGHT.rmsid AND left.tmsid=right.tmsid,
						get_liens(LEFT, right), left outer);


slimrec roll_liens(slimrec le, slimrec rt) :=
TRANSFORM
	sameLien := le.tmsid=rt.tmsid and le.rmsid=rt.rmsid;

	SELF.liens_recent_unreleased_count := le.liens_recent_unreleased_count + IF(sameLien,0,rt.liens_recent_unreleased_count);
	SELF.liens_historical_unreleased_count := le.liens_historical_unreleased_count + IF(sameLien,0,rt.liens_historical_unreleased_count);
	SELF.liens_unreleased_count30 := le.liens_unreleased_count30 + IF(sameLien,0,rt.liens_unreleased_count30);
	SELF.liens_unreleased_count90 := le.liens_unreleased_count90 + IF(sameLien,0,rt.liens_unreleased_count90);
	SELF.liens_unreleased_count180 := le.liens_unreleased_count180 + IF(sameLien,0,rt.liens_unreleased_count180);
	SELF.liens_unreleased_count12 := le.liens_unreleased_count12 + IF(sameLien,0,rt.liens_unreleased_count12);
	SELF.liens_unreleased_count24 := le.liens_unreleased_count24 + IF(sameLien,0,rt.liens_unreleased_count24);
	SELF.liens_unreleased_count36 := le.liens_unreleased_count36 + IF(sameLien,0,rt.liens_unreleased_count36);
	SELF.liens_unreleased_count60 := le.liens_unreleased_count60 + IF(sameLien,0,rt.liens_unreleased_count60);
	
	SELF.liens_recent_released_count := le.liens_recent_released_count + IF(sameLien,0,rt.liens_recent_released_count);
	SELF.liens_historical_released_count := le.liens_historical_released_count + IF(sameLien,0,rt.liens_historical_released_count);
	SELF.liens_released_count30 := le.liens_released_count30 + IF(sameLien,0,rt.liens_released_count30);
	SELF.liens_released_count90 := le.liens_released_count90 + IF(sameLien,0,rt.liens_released_count90);
	SELF.liens_released_count180 := le.liens_released_count180 + IF(sameLien,0,rt.liens_released_count180);
	SELF.liens_released_count12 := le.liens_released_count12 + IF(sameLien,0,rt.liens_released_count12);
	SELF.liens_released_count24 := le.liens_released_count24 + IF(sameLien,0,rt.liens_released_count24);
	SELF.liens_released_count36 := le.liens_released_count36 + IF(sameLien,0,rt.liens_released_count36);
	SELF.liens_released_count60 := le.liens_released_count60 + IF(sameLien,0,rt.liens_released_count60);
	
	SELF.last_liens_unreleased_date := if((integer)le.last_liens_unreleased_date > (integer)rt.last_liens_unreleased_date, le.last_liens_unreleased_date, rt.last_liens_unreleased_date);
	SELF.last_liens_released_date := if((integer)le.last_liens_released_date > (integer)rt.last_liens_released_date, le.last_liens_released_date, rt.last_liens_released_date);
	
	SELF.eviction_recent_unreleased_count := le.eviction_recent_unreleased_count + IF(sameLien,0,rt.eviction_recent_unreleased_count);
	SELF.eviction_historical_unreleased_count := le.eviction_historical_unreleased_count + IF(sameLien,0,rt.eviction_historical_unreleased_count);
	SELF.eviction_recent_released_count := le.eviction_recent_released_count + IF(sameLien,0,rt.eviction_recent_released_count);
	SELF.eviction_historical_released_count := le.eviction_historical_released_count + IF(sameLien,0,rt.eviction_historical_released_count);
	
	SELF.eviction_count30 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count30);
	SELF.eviction_count90 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count90);
	SELF.eviction_count180 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count180);
	SELF.eviction_count12 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count12);
	SELF.eviction_count24 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count24);
	SELF.eviction_count36 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count36);
	SELF.eviction_count60 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count60);
	
	SELF.last_eviction_date := ut.max2(le.last_eviction_date,rt.last_eviction_date);
	
	SELF := rt;
END;

w_evictions_distr := DISTRIBUTE(w_evictions,HASH(did));
liens_and_evictions_rolled := ROLLUP(SORT(w_evictions_distr, did,tmsid,rmsid, local),LEFT.did=RIGHT.did, roll_liens(LEFT,RIGHT), local);

// remove the tmsid and rmsid from the final layout
liens_and_evictions_slimmed := PROJECT(liens_and_evictions_rolled,slimmerrec);

export Key_Bocashell_Liens_and_Evictions := index(liens_and_evictions_slimmed, 
                                                  {did}, 
                                                  {liens_and_evictions_slimmed}, 
                                                  data_services.data_location.prefix() + '~thor_data400::key::liensv2::bocashell_liens_and_evictions_did_' + doxie.Version_SuperKey);