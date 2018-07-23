Import _Control, Impulse_Email, ut, FCRA, thrive, riskwise, mdr;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Impulse_FCRA(GROUPED DATASET(layout_bocashell_neutral) ids_wide, integer bsversion, 
		boolean isDirectToConsumerPurpose = false) := FUNCTION

Layout_Impulse := RECORD
	unsigned4 seq;
	unsigned3 historydate;
	Layouts.Layout_Impulse;
	string50 siteidsrc;	// internal
END;


// get corrections
Layout_Impulse impulse_corr(ids_wide le, FCRA.Key_Override_Impulse_FFID ri) := TRANSFORM
	myGetDate := iid_constants.myGetDate(le.historydate);
	hit := ri.did<>0;
	self.count := (integer)hit;
	self.first_seen_date := (unsigned)stringlib.stringfilterout(ri.created[1..10],'-');
	dt_last_seen := stringlib.stringfilterout(ri.lastmodified[1..10],'-');
	self.last_seen_date := (unsigned)dt_last_seen;	// seems to be the same as first seen date
	self.siteidsrc := ri.siteid;	// internal use for rollup
	self.siteid := ri.siteid+',';
	self.count30 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,30, le.historydate));
	self.count90 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,90, le.historydate));
	self.count180 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,180, le.historydate));
	self.count12 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate));
	self.count24 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(2), le.historydate));
	self.count36 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(3), le.historydate));
	self.count60 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(5), le.historydate));
	self.annual_income := ri.ln_annualincome;
	self.count12_6mos	:= 0;
	self.count12_12mos	:= 0;
	self.count12_24mos	:= 0;
	
	self := le;
end;
impulse_correct_roxie := join(ids_wide, FCRA.Key_Override_Impulse_FFID,
												keyed(right.flag_file_id in left.impulse_correct_ffid) and
												isDirectToConsumerPurpose = false, //if true don't return any impulse data
												impulse_corr(left, right),atmost(right.flag_file_id in left.impulse_correct_ffid, 100), keep(1));

impulse_correct_thor := join(ids_wide, pull(FCRA.Key_Override_Impulse_FFID),
												right.flag_file_id in left.impulse_correct_ffid and
												isDirectToConsumerPurpose = false, //if true don't return any impulse data
												impulse_corr(left, right), keep(1), LOCAL, ALL);

#IF(onThor)
	impulse_correct := impulse_correct_thor;
#ELSE
	impulse_correct := impulse_correct_roxie;
#END

Layout_Impulse addImpulse(ids_wide le, Impulse_Email.Key_Impulse_DID_FCRA ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	hit := ri.did<>0;
	self.count := (integer)hit;
	self.first_seen_date := (unsigned)stringlib.stringfilterout(ri.created[1..10],'-');
	dt_last_seen := stringlib.stringfilterout(ri.lastmodified[1..10],'-');
	self.last_seen_date := (unsigned)dt_last_seen;	// seems to be the same as first seen date
	self.siteidsrc := ri.siteid;	// internal use for rollup
	self.siteid := ri.siteid+',';
	self.count30 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,30, le.historydate));
	self.count90 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,90, le.historydate));
	self.count180 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,180, le.historydate));
	self.count12 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate));
	self.count24 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(2), le.historydate));
	self.count36 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(3), le.historydate));
	self.count60 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(5), le.historydate));
	self.annual_income := ri.ln_annualincome;
	self.count12_6mos	:= 0;
	self.count12_12mos	:= 0;
	self.count12_24mos	:= 0;
	self := le;
end;
wImpulse_roxie := join(ids_wide, Impulse_Email.Key_Impulse_DID_FCRA, 
														left.did<>0 and 
														(unsigned)stringlib.stringfilterout(right.created[1..7],'-')< left.historydate and
														trim((string)right.did)+trim(right.created) not in left.impulse_correct_record_id and
														keyed(left.did=right.did) and
														(ut.daysapart(stringlib.stringfilterout(right.lastmodified[1..10],'-'), 
																						iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
														isDirectToConsumerPurpose = false,
														addImpulse(left,right), left outer, atmost(riskwise.max_atmost));

wImpulse_thor := join(distribute(ids_wide, hash64(did)), 
														distribute(pull(Impulse_Email.Key_Impulse_DID_FCRA), hash64(did)), 
														left.did<>0 and 
														(unsigned)stringlib.stringfilterout(right.created[1..7],'-')< left.historydate and
														trim((string)right.did)+trim(right.created) not in left.impulse_correct_record_id and
														(left.did=right.did) and
														(ut.daysapart(stringlib.stringfilterout(right.lastmodified[1..10],'-'), 
																						iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
														isDirectToConsumerPurpose = false,
														addImpulse(left,right), left outer, LOCAL);

#IF(onThor)
	wImpulse := wImpulse_thor;
#ELSE
	wImpulse := ungroup(wImpulse_roxie);
#END

//for BS 5.3 - join to Impulse a second time using history date + 2 years in order to populate the offset history date counts
Layout_Impulse addImpulseOffset(ids_wide le, Impulse_Email.Key_Impulse_DID_FCRA ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	hit := ri.did<>0;
	dt_first_seen	 			:= stringlib.stringfilterout(ri.created[1..10],'-');
	dt_last_seen 				:= stringlib.stringfilterout(ri.lastmodified[1..10],'-');

	self.siteidsrc 			:= ri.siteid;	// internal use for rollup
	self.siteid 				:= ri.siteid+',';
	self.count12_6mos 	:= if(le.archive_date_6mo = '99999999', -1, (integer)(hit AND risk_indicators.iid_constants.checkdays(le.archive_date_6mo,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate)));
	self.count12_12mos 	:= if(le.archive_date_12mo = '99999999', -1, (integer)(hit AND risk_indicators.iid_constants.checkdays(le.archive_date_12mo,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate)));
	self.count12_24mos 	:= if(le.archive_date_24mo = '99999999', -1, (integer)(hit AND risk_indicators.iid_constants.checkdays(le.archive_date_24mo,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate)));
	//remaining fields were populated by the first join so set them to 0 here so the rollup is not impacted later
	self.count := 0;
	self.first_seen_date := 0;
	self.last_seen_date := 0;	
	self.count30 := 0;
	self.count90 := 0;
	self.count180 := 0;
	self.count12 := 0;
	self.count24 := 0;
	self.count36 := 0;
	self.count60 := 0;
	self.annual_income := 0;
	self := le;
end;
wImpulseOffset_roxie := join(ids_wide, Impulse_Email.Key_Impulse_DID_FCRA, 
														left.did<>0 and 
														(unsigned)stringlib.stringfilterout(right.created[1..7],'-')< left.historydate + 200 and
														trim((string)right.did)+trim(right.created) not in left.impulse_correct_record_id and
														keyed(left.did=right.did) and
														(ut.daysapart(stringlib.stringfilterout(right.lastmodified[1..10],'-'), 
																						iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
														isDirectToConsumerPurpose = false,
														addImpulseOffset(left,right), left outer, atmost(riskwise.max_atmost));

wImpulseOffset_thor := join(distribute(ids_wide, hash64(did)), 
														distribute(pull(Impulse_Email.Key_Impulse_DID_FCRA), hash64(did)), 
														left.did<>0 and 
														(unsigned)stringlib.stringfilterout(right.created[1..7],'-')< left.historydate + 200 and
														trim((string)right.did)+trim(right.created) not in left.impulse_correct_record_id and
														(left.did=right.did) and
														(ut.daysapart(stringlib.stringfilterout(right.lastmodified[1..10],'-'), 
																						iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
														isDirectToConsumerPurpose = false,
														addImpulseOffset(left,right), left outer, LOCAL);

#IF(onThor)
	wImpulseOffset := wImpulseOffset_thor;
#ELSE
	wImpulseOffset := ungroup(wImpulseOffset_roxie);
#END

combined := if(bsversion >= 53, ungroup(impulse_correct + wImpulse + wImpulseOffset), ungroup(impulse_correct + wImpulse));
combo_impulse := group( sort ( combined, seq, siteid, -last_seen_date), seq);

// ADD THRIVE RECORDS FOR VERSION 5.0 AND HIGHER
key_main := thrive.keys().Did_fcra.qa;

Layout_Impulse append_thrive(ids_wide le, key_main rt) := transform
	self.seq := le.seq;
		
	myGetDate := iid_constants.myGetDate(le.historydate);
	hit := rt.did<>0;
	self.count := (integer)hit;
	dt_first_seen := rt.dt_first_seen;
	dt_last_seen := rt.dt_last_seen;
	self.first_seen_date := dt_first_seen;
	self.last_seen_date := dt_last_seen;	
	// thrive doesn't have siteid, use the employer name instead to differentiate
	self.siteidsrc := rt.employer[1..5];	
	self.siteid := rt.employer[1..5]+',';
	self.count30 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,30, le.historydate));
	self.count90 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,90, le.historydate));
	self.count180 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,180, le.historydate));
	self.count12 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate));
	self.count24 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(2), le.historydate));
	self.count36 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(3), le.historydate));
	self.count60 := (integer)(hit AND risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)dt_last_seen,ut.DaysInNYears(5), le.historydate));
	annual_income := map(rt.pay_frequency in ['BIWEEKLY', 'BI-WEEKLY'] => (unsigned)rt.income * 26,
														rt.pay_frequency='WEEKLY' => (unsigned)rt.income * 52,
														(unsigned)rt.income);
	self.annual_income := min(annual_income, 9999999999); // cap it just in case the data contains some ungodly amount for someone
	self.count12_6mos	:= 0;
	self.count12_12mos	:= 0;
	self.count12_24mos	:= 0;
	self := le;
end;
	
wThrive_roxie := join (ids_wide, key_main,
		left.did<>0 and
    keyed (left.did = right.did) and
		right.src = mdr.sourceTools.src_Thrive_PD  and
		((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) AND
		(ut.daysapart((string)right.dt_first_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
		append_thrive(left, right),
    atmost(riskwise.max_atmost)
  );
	
wThrive_thor := join (distribute(ids_wide(did<>0), hash64(did)), 
		distribute(pull(key_main), hash64(did)),
    (left.did = right.did) and
		right.src = mdr.sourceTools.src_Thrive_PD  and
		((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)) AND
		(ut.daysapart((string)right.dt_first_seen, risk_indicators.iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
		append_thrive(left, right), LOCAL
  );
	
#IF(onThor)
	wThrive := wThrive_thor;
#ELSE
	wThrive := ungroup(wThrive_roxie);
#END

//for BS 53 join to Thrive a second time using history date + 2 years in order to populate the offset history date counts
Layout_Impulse append_thrive_offset(ids_wide le, key_main rt) := transform
	self.seq := le.seq;
		
	myGetDate := iid_constants.myGetDate(le.historydate);
	hit := rt.did<>0;

	self.count := 0;
	dt_first_seen := rt.dt_first_seen;
	dt_last_seen := rt.dt_last_seen;
	self.first_seen_date := 0;
	self.last_seen_date := 0;	
	self.siteidsrc := rt.employer[1..5];	
	self.siteid := rt.employer[1..5]+',';
	self.count30 := 0;
	self.count90 := 0;
	self.count180 := 0;
	self.count12 := 0;
	self.count24 := 0;
	self.count36 := 0;
	self.count60 := 0;
	self.annual_income := 0; // cap it just in case the data contains some ungodly amount for someone
	self.count12_6mos		:= if(le.archive_date_6mo = '99999999', -1, (integer)(hit AND risk_indicators.iid_constants.checkdays(le.archive_date_6mo,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate)));
	self.count12_12mos	:= if(le.archive_date_12mo = '99999999', -1, (integer)(hit AND risk_indicators.iid_constants.checkdays(le.archive_date_12mo,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate)));
	self.count12_24mos	:= if(le.archive_date_24mo = '99999999', -1, (integer)(hit AND risk_indicators.iid_constants.checkdays(le.archive_date_24mo,(STRING8)dt_last_seen,ut.DaysInNYears(1), le.historydate)));
	self := le;
end;
	
wThriveOffset_roxie := join (ids_wide, key_main,
		left.did<>0 and
    keyed (left.did = right.did) and
		right.src = mdr.sourceTools.src_Thrive_PD  and
		((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate) + 20000) AND
		(ut.daysapart((string)right.dt_first_seen, risk_indicators.iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
		append_thrive_offset(left, right),
    atmost(riskwise.max_atmost)
  );

wThriveOffset_thor := join (distribute(ids_wide(did<>0), hash64(did)), 
		distribute(pull(key_main), hash64(did)),
    (left.did = right.did) and
		right.src = mdr.sourceTools.src_Thrive_PD  and
		((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate) + 20000) AND
		(ut.daysapart((string)right.dt_first_seen, risk_indicators.iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
		append_thrive_offset(left, right), LOCAL
  );
	
#IF(onThor)
	wThriveOffset := wThriveOffset_thor;
#ELSE
	wThriveOffset := ungroup(wThriveOffset_roxie);
#END

paydayrecords := map(bsversion>=53	=> ungroup(combo_impulse + wThrive + wThriveOffset), 
										 bsversion>=50	=> ungroup(combo_impulse + wThrive), 
																			 ungroup(combo_impulse));  // only use impulse for shell versions prior to 5.0

sorted_payday := group(sort(paydayrecords,seq, siteid, -last_seen_date),seq);

Layout_Impulse rollImpulse(Layout_Impulse le, Layout_Impulse ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	self.count := le.count + ri.count;
	self.first_seen_date := ut.Min2(le.first_seen_date,ri.first_seen_date);
	self.last_seen_date := if(MAX(le.last_seen_date,ri.last_seen_date) > (unsigned)myGetDate, (unsigned)myGetDate, MAX(le.last_seen_date,ri.last_seen_date));
	siteSeen := Stringlib.StringFind(trim(le.siteid),trim(ri.siteidsrc)+',',1)>0;
	self.siteidsrc := ri.siteidsrc;	// so we go on to the next record for checking
	self.siteid := IF(siteSeen, le.siteid, TRIM(le.siteid)+ri.siteidsrc+',');
	self.count30 := le.count30 + ri.count30;
	self.count90 := le.count90 + ri.count90;
	self.count180 := le.count180 + ri.count180;
	self.count12 := le.count12 + ri.count12;
	self.count24 := le.count24 + ri.count24;
	self.count36 := le.count36 + ri.count36;
	self.count60 := le.count60 + ri.count60;
	self.annual_income := if(le.annual_income=0, ri.annual_income, le.annual_income);
	//for these new offset archive date counts, -1 indicates we couldn't compute so leave as -1
	self.count12_6mos := if(le.count12_6mos = -1, -1, le.count12_6mos + ri.count12_6mos);
	self.count12_12mos := if(le.count12_12mos = -1, -1, le.count12_12mos + ri.count12_12mos);
	self.count12_24mos := if(le.count12_24mos = -1, -1, le.count12_24mos + ri.count12_24mos);
	self := le;
end;

// output(wImpulse, named('wImpulse'));
// output(wThrive, named('wThrive'));

rolled_Impulse := rollup(sorted_payday, left.seq=right.seq, rollImpulse(left,right));	

return rolled_Impulse;


END;
