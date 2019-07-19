Import Impulse_Email, ut, thrive, riskwise, mdr, risk_indicators, doxie, Suppress;

export Boca_Shell_Impulse(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide, integer bsversion, doxie.IDataAccess mod_access  = doxie.IDataAccess) := FUNCTION

Layout_Impulse := RECORD
	unsigned4 seq;
	unsigned3 historydate;
	risk_indicators.Layouts.Layout_Impulse;
	string50 siteidsrc;	// internal
END;

Layout_Impulse_CCPA := RECORD
    integer8 did; // CCPA changes
    unsigned4 global_sid; // CCPA changes
    Layout_Impulse;
END;

Layout_Impulse_CCPA addImpulse(ids_wide le, Impulse_Email.Key_Impulse_DID ri) := transform
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
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
	self.count12_6mos  := 0;
	self.count12_12mos := 0;
	self.count12_24mos := 0;
	self.annual_income := ri.ln_annualincome;
    self.global_sid := ri.global_sid;
	self := le;
end;
wImpulse := join(ids_wide, Impulse_Email.Key_Impulse_DID, left.did<>0 and (unsigned)stringlib.stringfilterout(right.created[1..7],'-')< left.historydate and	
																// left.did=right.did, addImpulse(left,right), left outer);
																keyed(left.did=right.did), addImpulse(left,right), left outer, atmost(riskwise.max_atmost));


// ADD THRIVE RECORDS FOR VERSION 5.0 AND HIGHER
key_main := thrive.keys().did.qa;

Layout_Impulse_CCPA append_thrive(ids_wide le, key_main rt) := transform
	self.seq := le.seq;
		
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
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
	self.count12_6mos  := 0;
	self.count12_12mos := 0;
	self.count12_24mos := 0;
	annual_income := map(rt.pay_frequency in ['BIWEEKLY', 'BI-WEEKLY'] => (unsigned)rt.income * 26,
														rt.pay_frequency='WEEKLY' => (unsigned)rt.income * 52,
														(unsigned)rt.income);
	self.annual_income := min(annual_income, 9999999999); // cap it just in case the data contains some ungodly amount for someone
	self.global_sid := rt.global_sid;
    self := le;
end;
	
wThrive := join (ids_wide, key_main,
		left.did<>0 and
     keyed (left.did = right.did) and    
		((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)) AND
		right.src = mdr.sourceTools.src_Thrive_PD, 
		// and ((string)right.persistent_record_id not in main_rids),  // don't need to worry about corrections in nonFCRA
		append_thrive(left, right),
     atmost(riskwise.max_atmost)
  );

paydayrecords := if(bsversion>=50, ungroup(wImpulse + wThrive), ungroup(wImpulse));  // only use impulse for shell versions prior to 5.0
sorted_payday := group(sort(paydayrecords,seq, siteid, -last_seen_date),seq);

Layout_Impulse_CCPA rollImpulse(Layout_Impulse_CCPA le, Layout_Impulse_CCPA ri) := transform
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
	self.count := le.count + ri.count;
	self.first_seen_date := ut.Min2(le.first_seen_date,ri.first_seen_date);
	self.last_seen_date := if(max(le.last_seen_date,ri.last_seen_date) > (unsigned)myGetDate, (unsigned)myGetDate, max(le.last_seen_date,ri.last_seen_date));
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
	self := le;
end;

Suppressed_Impulse := Suppress.MAC_SuppressSource(rollup(sorted_payday, left.seq=right.seq, rollImpulse(left,right)), mod_access);	

rolled_Impulse := PROJECT(Suppressed_Impulse, TRANSFORM(Layout_Impulse,
                                                  SELF := LEFT));
                                                  
// output(wImpulse, named('wImpulse'));
// output(wThrive, named('wThrive'));

return rolled_Impulse;

END;
