import _Control, InfutorCID, ut, riskwise, FCRA;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Infutor_FCRA(GROUPED DATASET(layout_bocashell_neutral) ids_wide) := FUNCTION

Layout_Infutor := RECORD
	unsigned4 seq;
	unsigned3 historydate;
	Risk_Indicators.Layouts.Layout_Infutor;
END;


// check corrections
Layout_Infutor infutor_corr(ids_wide le, FCRA.Key_Override_Infutor_FFID ri) := TRANSFORM
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
	self.infutor_date_last_seen := ri.dt_last_seen;
							
	self.infutor_nap := iid_constants.comp_nap(firstmatch, lastmatch, addrmatch, phonematch);
	
	self := le;
end;
infutor_correct_roxie := join(ids_wide, FCRA.Key_Override_Infutor_FFID,
												keyed(right.flag_file_id in left.infutor_correct_ffid),
												infutor_corr(left, right),left outer, atmost(right.flag_file_id in left.infutor_correct_ffid, 100));

infutor_correct_thor := join(ids_wide, pull(FCRA.Key_Override_Infutor_FFID),
												(right.flag_file_id in left.infutor_correct_ffid),
												infutor_corr(left, right),left outer, local, all);

#IF(onThor)
	infutor_correct := group(infutor_correct_thor, seq);
#ELSE
	infutor_correct := infutor_correct_roxie;
#END

Layout_Infutor getInfutor(ids_wide le, InfutorCID.Key_Infutor_DID_FCRA ri) := transform	
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
	self.infutor_date_last_seen := ri.dt_last_seen;
							
	self.infutor_nap := iid_constants.comp_nap(firstmatch, lastmatch, addrmatch, phonematch);
	self := le;
end;
wInfutor_roxie := join(ids_wide, InfutorCID.Key_Infutor_DID_FCRA,
									left.did<>0 and
									keyed(left.did=right.did) and
									right.dt_first_seen < (unsigned)iid_constants.myGetDate(left.historydate) and 
									trim((string)right.did)+trim(right.phone)+trim((string)right.dt_first_seen) not in left.infutor_correct_record_id and  // old way, using concatenated keys
									trim(right.persistent_record_id) not in	left.infutor_correct_record_id,  // new way, using persistent_record_id
									getInfutor(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));

wInfutor_thor := join(distribute(ids_wide, hash64(did)), 
									distribute(pull(InfutorCID.Key_Infutor_DID_FCRA), hash64(did)),
									left.did<>0 and
									left.did=right.did and
									right.dt_first_seen < (unsigned)iid_constants.myGetDate(left.historydate) and 
									trim((string)right.did)+trim(right.phone)+trim((string)right.dt_first_seen) not in left.infutor_correct_record_id and  // old way, using concatenated keys
									trim(right.persistent_record_id) not in	left.infutor_correct_record_id,  // new way, using persistent_record_id
									getInfutor(left,right), left outer, atmost(left.did=right.did, riskwise.max_atmost), KEEP(100), LOCAL);

#IF(onThor)
	wInfutor := wInfutor_thor;
#ELSE
	wInfutor := ungroup(wInfutor_roxie);
#END

combined := ungroup(infutor_correct + wInfutor);
combo := group( sort ( combined, seq), seq);									
									
									
Layout_Infutor rollInfutor(Layout_Infutor le, Layout_Infutor ri) := transform
	self.infutor_date_first_seen := ut.min2(le.infutor_date_first_seen, ri.infutor_date_first_seen);
	
	// cap each of the date last seen to the historydate before selecting the max of the 2
	myGetDate := (unsigned)risk_indicators.iid_constants.myGetDate(le.historydate);
	le_infutor_date_last_seen := if(le.infutor_date_last_seen > myGetDate, myGetDate, le.infutor_date_last_seen)  ;  
	ri_infutor_date_last_seen := if(ri.infutor_date_last_seen > myGetDate, myGetDate, ri.infutor_date_last_seen)  ;

	self.infutor_date_last_seen := MAX(le_infutor_date_last_seen, ri_infutor_date_last_seen);
	self.infutor_nap := MAX(le.infutor_nap, ri.infutor_nap);
	
	self := le;
end;
rolledInfutor := rollup(combo, true, rollInfutor(left,right));

return rolledInfutor;

END;