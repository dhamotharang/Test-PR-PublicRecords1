import _Control, InfutorCID, ut, riskwise, FCRA;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Infutor_Phone(GROUPED DATASET(layout_bocashell_neutral) bs, boolean isFCRA, INTEGER BSVersion) := FUNCTION

layout_bocashell_neutral getInfutor(bs le, InfutorCID.Key_Infutor_Phone ri) := transform	
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

	self.infutor_phone.infutor_date_first_seen := ri.dt_first_seen;
	myGetDate := (unsigned)risk_indicators.iid_constants.myGetDate(le.historydate);
	self.infutor_phone.infutor_date_last_seen  := if(ri.dt_last_seen > myGetDate, myGetDate, ri.dt_last_seen);

	self.infutor_phone.infutor_nap := iid_constants.comp_nap(firstmatch, lastmatch, addrmatch, phonematch);
	
	// only add IR to sources if it matches at least 2 elements
	goodHit := IF(((INTEGER)firstmatch+(INTEGER)lastmatch+(INTEGER)addrmatch+(INTEGER)phonematch)>1,true,false);	
	self.phone_verification.phone_sources := map(goodhit and trim(le.phone_verification.phone_sources)='' =>	'IR,',
													goodhit =>	trim(le.phone_verification.phone_sources) + 'IR,',
													le.phone_verification.phone_sources);
	self := le;
end;


infutor_correct_roxie := join(bs, FCRA.Key_Override_Infutor_FFID,
												keyed(right.flag_file_id in left.infutor_correct_ffid),
												getInfutor(left, row(right,recordof(InfutorCID.Key_Infutor_Phone))),/*left outer,*/ atmost(right.flag_file_id in left.infutor_correct_ffid, 100));

infutor_correct_thor := join(bs(infutor_correct_ffid <> []), FCRA.Key_Override_Infutor_FFID,
												right.flag_file_id in left.infutor_correct_ffid,
												getInfutor(left, row(right,recordof(InfutorCID.Key_Infutor_Phone))),/*left outer,*/ atmost(right.flag_file_id in left.infutor_correct_ffid, 100));

#IF(onThor)
	infutor_correct := infutor_correct_thor;
#ELSE
	infutor_correct := infutor_correct_roxie;
#END

Infutor_key := if(isFCRA, InfutorCID.Key_Infutor_Phone_FCRA, InfutorCID.Key_Infutor_Phone);

wInfutor_roxie := join(	bs,Infutor_key ,	// need to make sure this populates in the current layout edina infutor fields and not the DID results
			trim(left.shell_input.phone10)<>'' and
			keyed(left.shell_input.phone10=right.phone) and
			right.dt_first_seen < (unsigned)iid_constants.myGetDate(left.historydate) and 
			(~isFCRA or trim((string)right.did)+trim(right.phone)+trim((string)right.dt_first_seen) not in left.infutor_correct_record_id),
			getInfutor(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));

wInfutor_thor_phone := join(distribute(	bs(trim(shell_input.phone10) <> ''), hash64(shell_input.phone10)),
			distribute(pull(Infutor_key), hash64(phone)) ,	// need to make sure this populates in the current layout edina infutor fields and not the DID results
			(left.shell_input.phone10=right.phone) and
			right.dt_first_seen < (unsigned)iid_constants.myGetDate(left.historydate) and 
			(~isFCRA or trim((string)right.did)+trim(right.phone)+trim((string)right.dt_first_seen) not in left.infutor_correct_record_id),
			getInfutor(left,right), left outer, atmost(left.shell_input.phone10=right.phone, riskwise.max_atmost), KEEP(100), LOCAL);						

wInfutor_thor := wInfutor_thor_phone + bs(trim(shell_input.phone10)='');

#IF(onThor)
	wInfutor := wInfutor_thor;
#ELSE
	wInfutor := wInfutor_roxie;
#END

combined := if(isFCRA, ungroup(infutor_correct + wInfutor), ungroup(wInfutor));
combo_roxie := group( sort ( combined, seq), seq);										
combo_thor := group(sort(distribute(combined, hash64(seq)), seq, local), seq, local);

#IF(onThor)
	combo := combo_thor;
#ELSE
	combo := combo_roxie;
#END

layout_bocashell_neutral rollInfutor(layout_bocashell_neutral le, layout_bocashell_neutral ri) := transform
	self.infutor_phone.infutor_date_first_seen := MIN(le.infutor_phone.infutor_date_first_seen, ri.infutor_phone.infutor_date_first_seen);
	self.infutor_phone.infutor_date_last_seen := MAX(le.infutor_phone.infutor_date_last_seen, ri.infutor_phone.infutor_date_last_seen);
	self.infutor_phone.infutor_nap := MAX(le.infutor_phone.infutor_nap, ri.infutor_phone.infutor_nap);
	
	phone_sources := le.phone_verification.phone_sources + ri.phone_verification.phone_sources;
	phone_sources_cat := if(stringlib.stringfind(phone_sources, 'GH', 1) > 0, 'GH,', '') + 
												if(stringlib.stringfind(phone_sources, 'WP', 1) > 0, 'WP,', '') + 
												if(stringlib.stringfind(phone_sources, 'TG', 1) > 0, 'TG,', '') + 
												if(stringlib.stringfind(phone_sources, 'U', 1) > 0, 'U,', '') + 
												if(stringlib.stringfind(phone_sources, 'IR', 1) > 0, 'IR,', '');
	self.phone_verification.phone_sources := trim(phone_sources_cat);
	
	self := le;
end;
rolledInfutor := rollup(combo, true, rollInfutor(left,right));

// added for JIRA MS 42

infutor_final :=  PROJECT (rolledInfutor, TRANSFORM (layout_bocashell_neutral, 
									napLT9 := left.infutor_phone.infutor_nap < 9;
									self.infutor_phone.infutor_date_first_seen := if(napLT9 and BSVersion >=50 ,0, left.infutor_phone.infutor_date_first_seen);
									self.infutor_phone.infutor_date_last_seen := if(napLT9 and BSVersion >=50 ,0, left.infutor_phone.infutor_date_last_seen);
									SELF := LEFT));
return infutor_final;
//return rolledInfutor;

END;