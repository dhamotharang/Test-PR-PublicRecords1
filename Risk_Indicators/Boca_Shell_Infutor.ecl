import InfutorCID, ut, riskwise, risk_indicators, doxie, Suppress, _control;

export Boca_Shell_Infutor(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

Layout_Infutor := RECORD
	unsigned4 seq;
	unsigned3 historydate;
	risk_indicators.Layouts.Layout_Infutor;
END;

Layout_Infutor_CCPA := RECORD
	integer8 did; // CCPA changes
  unsigned4 global_sid; // CCPA changes
  boolean skip_opt_out := false; // CCPA changes
	Layout_Infutor;
END;

Layout_Infutor_CCPA getInfutor(ids_wide le, InfutorCID.Key_Infutor_DID ri) := transform	
	firstscore := risk_indicators.FnameScore(le.shell_input.fname, ri.fname);
	firstmatch := risk_indicators.iid_constants.g(firstscore);
	lastscore := risk_indicators.LnameScore(le.shell_input.lname, ri.lname);
	lastmatch := risk_indicators.iid_constants.g(lastscore);
	zip_score := Risk_Indicators.AddrScore.zip_score(le.shell_input.in_zipcode, ri.zip);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.shell_input.in_city, le.shell_input.in_state, ri.p_city_name, ri.st, le.iid.cityzipflag);
	addrmatch := risk_indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(le.shell_input.prim_range, le.shell_input.prim_name, le.shell_input.sec_range, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						zip_score, cityst_score) );
	phonescore := risk_indicators.PhoneScore(le.shell_input.phone10, ri.phone);
	phonematch := risk_indicators.iid_constants.gn(phonescore);

	self.infutor_date_first_seen := ri.dt_first_seen;
	myGetDate := (unsigned)risk_indicators.iid_constants.myGetDate(le.historydate);
	self.infutor_date_last_seen := if(ri.dt_last_seen > myGetDate, myGetDate, ri.dt_last_seen);  
							
	self.infutor_nap := risk_indicators.iid_constants.comp_nap(firstmatch, lastmatch, addrmatch, phonematch);
    self.global_sid := ri.global_sid;
	self := le;
end;
wInfutor_unsuppressed_roxie := join(ids_wide, InfutorCID.Key_Infutor_DID,	
									left.did<>0 and
									keyed(left.did=right.did) and
									right.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
									getInfutor(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));

wInfutor_unsuppressed_thor := join(
	distribute(ids_wide, did), 
	distribute(pull(InfutorCID.Key_Infutor_DID), did),	
									left.did<>0 and
									(left.did=right.did) and
									right.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
									getInfutor(left,right), left outer, KEEP(100), local);
									
#IF(_control.Environment.onThor)
	wInfutor_unsuppressed := wInfutor_unsuppressed_thor;
#ELSE
	wInfutor_unsuppressed := wInfutor_unsuppressed_roxie;
#END									
									
wInfutor_flagged := Suppress.CheckSuppression(wInfutor_unsuppressed, mod_access);

wInfutor := PROJECT(wInfutor_flagged, TRANSFORM(Layout_Infutor,
	self.infutor_date_first_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.infutor_date_first_seen);
	self.infutor_date_last_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.infutor_date_last_seen);			
	self.infutor_nap := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.infutor_nap);
    SELF := LEFT;
)); 

combo := group( sort ( wInfutor, seq), seq);	

									
Layout_Infutor rollInfutor(Layout_Infutor le, Layout_Infutor ri) := transform
	self.infutor_date_first_seen := ut.min2(le.infutor_date_first_seen, ri.infutor_date_first_seen);
	self.infutor_date_last_seen := max(le.infutor_date_last_seen, ri.infutor_date_last_seen);	
	self.infutor_nap := max(le.infutor_nap, ri.infutor_nap);
	
	self := le;
end;

#if(_control.Environment.onThor_LeadIntegrity)
	rolledInfutor := project(ids_wide, transform(Layout_Infutor, self := left, self := []));  // for initial trending attributes, we don't need this function, so we can skip all of this code and make it run faster
#else
	rolledInfutor := rollup(combo, true, rollInfutor(left,right));
#end


return rolledInfutor;

END;