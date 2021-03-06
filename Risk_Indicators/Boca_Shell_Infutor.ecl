import InfutorCID, ut, riskwise;

export Boca_Shell_Infutor(GROUPED DATASET(layout_bocashell_neutral) ids_wide) := FUNCTION

Layout_Infutor := RECORD
	unsigned4 seq;
	unsigned3 historydate;
	Layouts.Layout_Infutor;
END;


Layout_Infutor getInfutor(ids_wide le, InfutorCID.Key_Infutor_DID ri) := transform	
	firstscore := FnameScore(le.shell_input.fname, ri.fname);
	firstmatch := iid_constants.g(firstscore);
	lastscore := LnameScore(le.shell_input.lname, ri.lname);
	lastmatch := iid_constants.g(lastscore);
	zip_score := Risk_Indicators.AddrScore.zip_score(le.shell_input.in_zipcode, ri.zip);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.shell_input.in_city, le.shell_input.in_state, ri.p_city_name, ri.st, le.iid.cityzipflag);
	addrmatch := iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(le.shell_input.prim_range, le.shell_input.prim_name, le.shell_input.sec_range, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						zip_score, cityst_score) );
	phonescore := PhoneScore(le.shell_input.phone10, ri.phone);
	phonematch := iid_constants.gn(phonescore);

	self.infutor_date_first_seen := ri.dt_first_seen;
	myGetDate := (unsigned)risk_indicators.iid_constants.myGetDate(le.historydate);
	self.infutor_date_last_seen := if(ri.dt_last_seen > myGetDate, myGetDate, ri.dt_last_seen);  
							
	self.infutor_nap := iid_constants.comp_nap(firstmatch, lastmatch, addrmatch, phonematch);
	self := le;
end;
wInfutor := join(ids_wide, InfutorCID.Key_Infutor_DID,	
									left.did<>0 and
									keyed(left.did=right.did) and
									right.dt_first_seen < (unsigned)iid_constants.myGetDate(left.historydate),
									getInfutor(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));
									
Layout_Infutor rollInfutor(Layout_Infutor le, Layout_Infutor ri) := transform
	self.infutor_date_first_seen := ut.min2(le.infutor_date_first_seen, ri.infutor_date_first_seen);
	self.infutor_date_last_seen := max(le.infutor_date_last_seen, ri.infutor_date_last_seen);	
	self.infutor_nap := max(le.infutor_nap, ri.infutor_nap);
	
	self := le;
end;
rolledInfutor := rollup(wInfutor, true, rollInfutor(left,right));

return rolledInfutor;

END;