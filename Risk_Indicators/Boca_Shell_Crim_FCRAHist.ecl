import _Control, doxie_files, ut, doxie, fcra, liensv2, riskwise, Risk_Indicators;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Crim_FCRAHist (integer bsVersion, unsigned8 BSOptions=0,
	GROUPED DATASET(Risk_Indicators.Layouts_Derog_Info.layout_extended) w_BankLiens) := FUNCTION

	fcra_offenders_key := doxie_files.Key_Offenders(true);
	fcra_offenses_key := doxie_files.Key_Offenses(true);
	fcra_court_offenses_key := doxie_files.Key_Court_Offenses(true);
	Risk_Indicators.Layouts_Derog_Info.layout_extended add_doc_FCRA(Risk_Indicators.Layouts_Derog_Info.layout_extended le, fcra_offenders_key ri) := TRANSFORM
		// only need 1 of the offense records for that offender key to be "dismissed" to throw this record out
		//prior version of FCRA offense key consisted of DOC, crim and SO offenses
		//now all three are separated into different keys
		dismissed_offense := choosen(
												fcra_offenses_key(keyed(ok=ri.offender_key) and (stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0 )), 
																 1);
		dismissed_court_offense := choosen(
												fcra_court_offenses_key(keyed(ofk=ri.offender_key) and (stringlib.stringfind(court_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(court_disp_desc_2, 'DISMISSED', 1) > 0 )),
																1);
		dismissed_roxie := exists(dismissed_offense) or exists(dismissed_court_offense);
    // set dismissed to false if running on thor. we will handle the logic in separate joins to improve performance, since doing the keyed searches takes forever on a large ds.
		dismissed_thor := false;

    #IF(onThor)
      dismissed := dismissed_thor;
    #ELSE
      dismissed := dismissed_roxie;
    #END
    
		myGetDate := iid_constants.myGetDate(le.historydate);
		criminal_count := (INTEGER)((unsigned6)ri.did<>0 and not dismissed);
		SELF.BJL.criminal_count := criminal_count;
		SELF.BJL.last_criminal_date := if(criminal_count > 0, (unsigned)ri.fcra_date, 0);
		
		SELF.crim_case_num:= ri.case_num;
		
		isFelony := ri.offense_score='F' and not dismissed;
		SELF.BJL.criminal_count30 := (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,30));
		SELF.BJL.criminal_count90 := (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,90));
		SELF.BJL.criminal_count180 := (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,180));
		SELF.BJL.criminal_count12 := (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,ut.DaysInNYears(1)));
		SELF.BJL.criminal_count24 := (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,ut.DaysInNYears(2)));
		SELF.BJL.criminal_count36 := (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,ut.DaysInNYears(3)));
		SELF.BJL.criminal_count60 := (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,ut.DaysInNYears(5)));
			
		felony_count := if(isFelony, 1, 0);
		SELF.BJL.last_felony_date := if(felony_count>0, (unsigned)ri.fcra_date, 0);	
		SELF.BJL.felony_count := felony_count;	
		
		nonfelony := (unsigned6)ri.did<>0 and ri.offense_score<>'F' and not dismissed;
		SELF.BJL.last_nonfelony_criminal_date := if(nonfelony, (unsigned)ri.fcra_date, 0);
		SELF.BJL.nonfelony_criminal_count12 := (INTEGER)(nonfelony and Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)ri.fcra_date,ut.DaysInNYears(1)));
		//these new fields for BS 5.3 are populated in the next join - default them to 0 here
		SELF.BJL.criminal_count12_6mos  := 0;
		SELF.BJL.criminal_count12_12mos := 0;
		SELF.BJL.criminal_count12_24mos := 0;

    // Adding this for thor logic so we can track if offense if dismissed in later joins to offenses/count offenses key
		SELF.offender_key := ri.offender_key;

		SELF := le;
	END;

	doc_added_crim_roxie := JOIN (w_BankLiens, fcra_offenders_key, 
										 (LEFT.did != 0) AND keyed(LEFT.did=RIGHT.sdid) AND
											(unsigned3)(RIGHT.fcra_date[1..6]) < left.historydate AND
											FCRA.crim_is_ok(iid_constants.myGetDate(left.historydate),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag) AND
											// for shell version 3 or higher, only allow criminal records with offense_score = M or F
											( (bsversion >= 3 and RIGHT.offense_score in risk_indicators.iid_constants.set_valid_offense_scores) or
											RIGHT.offense_score NOT IN ['I'] ),
										 add_doc_FCRA(LEFT,RIGHT),
										LEFT OUTER, KEEP(10), ATMOST(keyed(LEFT.did=RIGHT.sdid), 
										riskwise.max_atmost));
	
	fcra_offenders_key_thor := pull(fcra_offenders_key);

	doc_added_crim_thor_did := JOIN (distribute(w_BankLiens(did != 0), hash64(did)), 
											distribute(fcra_offenders_key_thor, hash64(sdid)), 
										 (LEFT.did=RIGHT.sdid) AND
											(unsigned3)(RIGHT.fcra_date[1..6]) < left.historydate AND
											FCRA.crim_is_ok(iid_constants.myGetDate(left.historydate),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag) AND
											// for shell version 3 or higher, only allow criminal records with offense_score = M or F
											( (bsversion >= 3 and RIGHT.offense_score in risk_indicators.iid_constants.set_valid_offense_scores) or
											RIGHT.offense_score NOT IN ['I'] ),
										 add_doc_FCRA(LEFT,RIGHT),
										LEFT OUTER, KEEP(10), ATMOST((LEFT.did=RIGHT.sdid), 
										riskwise.max_atmost), LOCAL);
                    
  // on Roxie, we do logic to determine if the offense is dismissed in the join above. On thor though, check the
  // other offense keys here to speed up performance -- throw out any record that we find marked as dismissed in
  // the offense/court offense key for equivalent to roxie logic.
	doc_added_crim_thor_not_dismissed1 := JOIN(distribute(doc_added_crim_thor_did, hash64(offender_key)), 
                                                distribute(pull(fcra_offenses_key(stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0 )), hash64(ok)),
                                                left.offender_key=right.ok,
                                                transform(recordof(left),  self := left),
                                                left only, LOCAL);
	doc_added_crim_thor_not_dismissed2 := JOIN(distribute(doc_added_crim_thor_not_dismissed1, hash64(offender_key)), 
                                                distribute(pull(fcra_court_offenses_key(stringlib.stringfind(court_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(court_disp_desc_2, 'DISMISSED', 1) > 0 )), hash64(ofk)),
                                                left.offender_key=right.ofk,
                                                transform(recordof(left), self := left),
                                                left only, LOCAL);
                                                
  other_thor_recs := JOIN(distribute(w_BankLiens, hash64(seq)), 
                          distribute(doc_added_crim_thor_not_dismissed2, hash64(seq)), 
                          LEFT.seq = RIGHT.seq, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY, LOCAL);
	doc_added_crim_thor := group(sort(distribute(doc_added_crim_thor_not_dismissed2 + other_thor_recs, hash64(seq)), seq, local), seq, local);
	
	#IF(onThor)
		doc_added_crim := doc_added_crim_thor;
	#ELSE
		doc_added_crim := doc_added_crim_roxie;
	#END
  
	//for BS 5.3, join again using history date + 2 years in order to populate the new offset criminal_count12 fields
	Risk_Indicators.Layouts_Derog_Info.layout_extended add_doc_FCRA_offset(Risk_Indicators.Layouts_Derog_Info.layout_extended le, fcra_offenders_key ri) := TRANSFORM
		dismissed_offense := choosen(
												fcra_offenses_key(keyed(ok=ri.offender_key) and (stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0 )), 
																 1);
		dismissed_court_offense := choosen(
												fcra_court_offenses_key(keyed(ofk=ri.offender_key) and (stringlib.stringfind(court_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(court_disp_desc_2, 'DISMISSED', 1) > 0 )),
																1);
		dismissed_roxie := exists(dismissed_offense) or exists(dismissed_court_offense);
    // set dismissed to false if running on thor. we will handle the logic in separate joins to improve performance, since doing the keyed searches takes forever on a large ds.
		dismissed_thor := false;

    #IF(onThor)
      dismissed := dismissed_thor;
    #ELSE
      dismissed := dismissed_roxie;
    #END
    
		myGetDate := iid_constants.myGetDate(le.historydate);
		
		SELF.crim_case_num:= ri.case_num;
		
		isFelony := ri.offense_score='F' and not dismissed;
		SELF.BJL.criminal_count12_6mos := if(le.archive_date_6mo = '99999999', 0, (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(le.archive_date_6mo,(STRING8)ri.fcra_date,ut.DaysInNYears(1))));
		SELF.BJL.criminal_count12_12mos := if(le.archive_date_12mo = '99999999', 0, (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(le.archive_date_12mo,(STRING8)ri.fcra_date,ut.DaysInNYears(1))));
		SELF.BJL.criminal_count12_24mos := if(le.archive_date_24mo = '99999999', 0, (INTEGER)(isFelony and Risk_Indicators.iid_constants.checkingDays(le.archive_date_24mo,(STRING8)ri.fcra_date,ut.DaysInNYears(1))));
		SELF.offender_key := ri.offender_key;
		SELF := le;
	END;

	doc_added_crim_offset_roxie := JOIN (w_BankLiens, fcra_offenders_key, 
										 (LEFT.did != 0) AND keyed(LEFT.did=RIGHT.sdid) AND
											(unsigned3)(RIGHT.fcra_date[1..6]) < (left.historydate + 200) AND
											FCRA.crim_is_ok(iid_constants.myGetDate(left.historydate + 200),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag) AND
											// for shell version 3 or higher, only allow criminal records with offense_score = M or F
											( (bsversion >= 3 and RIGHT.offense_score in risk_indicators.iid_constants.set_valid_offense_scores) or
											RIGHT.offense_score NOT IN ['I'] ),
										 add_doc_FCRA_offset(LEFT,RIGHT),
										LEFT OUTER, KEEP(10), ATMOST(keyed(LEFT.did=RIGHT.sdid), 
										riskwise.max_atmost));	

	doc_added_crim_offset_thor_did := JOIN (distribute(w_BankLiens(did!=0), hash64(did)), 
											distribute(fcra_offenders_key_thor, hash64(sdid)), 
										 (LEFT.did=RIGHT.sdid) AND
											(unsigned3)(RIGHT.fcra_date[1..6]) < (left.historydate + 200) AND
											FCRA.crim_is_ok(iid_constants.myGetDate(left.historydate + 200),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag) AND
											// for shell version 3 or higher, only allow criminal records with offense_score = M or F
											( (bsversion >= 3 and RIGHT.offense_score in risk_indicators.iid_constants.set_valid_offense_scores) or
											RIGHT.offense_score NOT IN ['I'] ),
										 add_doc_FCRA_offset(LEFT,RIGHT),
										LEFT OUTER, KEEP(10), ATMOST((LEFT.did=RIGHT.sdid), 
										riskwise.max_atmost), LOCAL);	

	doc_added_crim_offset_not_dismissed1 := JOIN(distribute(doc_added_crim_offset_thor_did, hash64(offender_key)), 
                                                distribute(pull(fcra_offenses_key(stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0 )), hash64(ok)),
                                                left.offender_key=right.ok,
                                                transform(recordof(left),  self := left),
                                                left only, LOCAL);
	doc_added_crim_offset_not_dismissed2 := JOIN(distribute(doc_added_crim_offset_not_dismissed1, hash64(offender_key)), 
                                                distribute(pull(fcra_court_offenses_key(stringlib.stringfind(court_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(court_disp_desc_2, 'DISMISSED', 1) > 0 )), hash64(ofk)),
                                                left.offender_key=right.ofk,
                                                transform(recordof(left), self := left),
                                                left only, LOCAL);
                                                
  other_thor_recs_offset := JOIN(distribute(w_BankLiens, hash64(seq)), 
                          distribute(doc_added_crim_offset_not_dismissed2, hash64(seq)), 
                          LEFT.seq = RIGHT.seq, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY, LOCAL);
                          
	doc_added_crim_offset_thor := group(sort(distribute(doc_added_crim_offset_not_dismissed2+ other_thor_recs_offset, hash64(seq)), seq, local), seq, local);

	#IF(onThor)
		doc_added_crim_offset := doc_added_crim_offset_thor;
	#ELSE
		doc_added_crim_offset := doc_added_crim_offset_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_extended roll_doc_offset(Risk_Indicators.Layouts_Derog_Info.layout_extended le, Risk_Indicators.Layouts_Derog_Info.layout_extended ri) :=
	TRANSFORM
		sameCrim := le.crim_case_num=ri.crim_case_num;

		SELF.BJL.criminal_count12_6mos := if(le.archive_date_6mo = '99999999', 0, le.BJL.criminal_count12_6mos+IF(sameCrim,0,ri.BJL.criminal_count12_6mos));
		SELF.BJL.criminal_count12_12mos := if(le.archive_date_12mo = '99999999', 0, le.BJL.criminal_count12_12mos+IF(sameCrim,0,ri.BJL.criminal_count12_12mos));
		SELF.BJL.criminal_count12_24mos := if(le.archive_date_24mo = '99999999', 0, le.BJL.criminal_count12_24mos+IF(sameCrim,0,ri.BJL.criminal_count12_24mos));

		SELF := ri;
	END;
	// include in the rollup only those records that actually have a bankruptcy occurring within the "offset" archive date's 12 month window - filter all other records out
	doc_rolled_offset := ROLLUP(SORT(doc_added_crim_offset(BJL.criminal_count12_6mos > 0 or BJL.criminal_count12_12mos > 0 or BJL.criminal_count12_24mos > 0),did,crim_case_num),
											LEFT.did=RIGHT.did and LEFT.crim_case_num = RIGHT.crim_case_num, 
											roll_doc_offset(LEFT,RIGHT));

	doc_added_crim_53 := JOIN(doc_added_crim, doc_rolled_offset, 
		LEFT.seq = RIGHT.seq and LEFT.did = RIGHT.did and LEFT.crim_case_num = RIGHT.crim_case_num,
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_extended,
				haveleft  := LEFT.did <> 0;
				haveright := RIGHT.did <> 0;
				SELF.seq 															:= max(LEFT.seq, RIGHT.seq);	//take whichever is populated
				SELF.historydate											:= max(LEFT.historydate, RIGHT.historydate);
				SELF.DID															:= max(LEFT.DID, RIGHT.DID);
				SELF.crim_case_num										:= max(LEFT.crim_case_num, RIGHT.crim_case_num);
				SELF.BJL.criminal_count 							:= if(haveleft, LEFT.BJL.criminal_count, 0);
				SELF.BJL.last_criminal_date 					:= if(haveleft, LEFT.BJL.last_criminal_date, 0);
				SELF.BJL.criminal_count30 						:= if(haveleft, LEFT.BJL.criminal_count30, 0);
				SELF.BJL.criminal_count90 						:= if(haveleft, LEFT.BJL.criminal_count90, 0);
				SELF.BJL.criminal_count180 						:= if(haveleft, LEFT.BJL.criminal_count180, 0);
				SELF.BJL.criminal_count12 						:= if(haveleft, LEFT.BJL.criminal_count12, 0);
				SELF.BJL.criminal_count24 						:= if(haveleft, LEFT.BJL.criminal_count24, 0);
				SELF.BJL.criminal_count36 						:= if(haveleft, LEFT.BJL.criminal_count36, 0);
				SELF.BJL.criminal_count60 						:= if(haveleft, LEFT.BJL.criminal_count60, 0);
				SELF.BJL.last_felony_date 						:= if(haveleft, LEFT.BJL.last_felony_date, 0);
				SELF.BJL.felony_count 								:= if(haveleft, LEFT.BJL.felony_count, 0);
				SELF.BJL.last_nonfelony_criminal_date := if(haveleft, LEFT.BJL.last_nonfelony_criminal_date, 0);
				SELF.BJL.nonfelony_criminal_count12 	:= if(haveleft, LEFT.BJL.nonfelony_criminal_count12, 0);
				SELF.BJL.criminal_count12_6mos  			:= if(haveright, RIGHT.BJL.criminal_count12_6mos, 0);
				SELF.BJL.criminal_count12_12mos 			:= if(haveright, RIGHT.BJL.criminal_count12_12mos, 0);
				SELF.BJL.criminal_count12_24mos 			:= if(haveright, RIGHT.BJL.criminal_count12_24mos, 0);		
				SELF := LEFT),
		FULL OUTER);

	// output(w_BankLiens, named('Crim_input'));
	// output(doc_added_crim, named('doc_added_crim'));
	// output(doc_added_crim_offset, named('doc_added_crim_offset'));
	// output(doc_rolled_offset, named('doc_rolled_offset'));
	// output(doc_added_crim_53, named('doc_added_crim_53'));
	
	RETURN if(bsversion >= 53, group(doc_added_crim_53, seq), group(doc_added_crim, seq));
END;