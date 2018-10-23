import _Control, DriversV2, Certegy, RiskWise, Risk_Indicators, InsuranceHeader_BestOfBest, Business_Risk_BIP, Drivers;
onThor := _Control.Environment.OnThor;

// this function accepts layout_output instead of just a slim layout_input so that we can check if the drlc is valid before searching anyting
export iid_DL_verification(grouped DATASET(Risk_Indicators.Layout_Output) indata, integer dppa, boolean isFCRA=false,
													 string10 ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel, unsigned8 BSOptions,
													 string50 DataPermission=risk_indicators.iid_constants.default_DataPermission, 
													 unsigned1 BSversion) := function
	
	// check that user has permissible purpose to see DL data
	dppa_ok := Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);
	dl_ok	:= Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);
	
	// for 1/28/2014 release, if CIID/FlexID v1, then change logic for any_dl_found to make sure the DL found is valid by today's standards
	iidV1 := (BSOptions & Risk_Indicators.iid_constants.BSOptions.IsInstantIDv1) > 0;
	
//===================================================
//=== This check was added for all customer using ===
//===  Atributes version 201 (primarily AMEX)     ===
//=== These customers are not required to enter   ===
//=== the DL # or DL state                        ===
//===================================================	
	return_sources := (BSOptions & Risk_Indicators.iid_constants.BSOptions.AlwaysCheckInsurance) > 0 or bsversion >= 52;
	
	//This check will allow the use of the Insurance header DL information
	allowInsuranceDL := ((BSOptions & Risk_Indicators.iid_constants.BSOptions.AllowInsuranceDLInfo) > 0 or bsversion >= 52) and dl_ok;
	

ExactDriverLicenseRequired := ExactMatchLevel[Risk_Indicators.iid_constants.posExactDLMatch]=Risk_Indicators.iid_constants.sTrue;	

mytemp := record
	string dl_source;
end;

dl_temp := record
	dataset(mytemp) dl_verified_sources;
	Risk_Indicators.Layout_Output;
end;

dl_temp get_dl_did(indata le, DriversV2.Key_DL_DID ri) := TRANSFORM
	self.dl_searched := le.did<>0 and le.dl_number<>'' and le.dl_state<>'';
	dl_score := Risk_Indicators.DLscore(le.dl_number, ri.dl_number, le.dl_state, ri.st);
	self.dl_score := dl_score;
	dl_match := (Risk_Indicators.iid_constants.tscore(dl_score) > Risk_Indicators.iid_constants.min_score)  and (if(ExactDriverLicenseRequired, le.dl_number=ri.dl_number, true));
	self.verified_dl := if(dl_match, ri.dl_number, '');
	self.dl_verified_sources := if(dl_match, dataset([{'D'}], mytemp), dataset([], mytemp) );
	self.any_dl_found := (ri.dl_number<>'' and ~iidV1) OR (ri.dl_number<>'' AND risk_indicators.Validate_DL(le.dl_state, ri.dl_number, le.fname, le.lname, le.dob, dl_Match, le.dlsocsvalflag, le.dlsocsdobflag)='0' AND iidV1);
	self.dl_exists := (le.dl_number <> '') and (le.dl_number=ri.dl_number);
	self := le;
END;

//Search State DL keys by DID
with_dl_did_roxie := join(indata, DriversV2.Key_DL_DID, 
					drivers.state_dppa_ok(left.dl_state,dppa) and 
					left.did<>0 and left.dl_number<>'' and left.dl_state<>'' and  // doesn't pay to search unless we have a DID found from input and DL info populated
					right.source_code IN risk_indicators.iid_constants.SetValidStateSrcs AND
					keyed(left.did=right.did), 									
					get_dl_did(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(100));

with_dl_did_thor_pre := join(distribute(indata(did<>0 and dl_number<>'' and dl_state<>''), hash64(did)), 
					distribute(pull(DriversV2.Key_DL_DID), hash64(did)), 
					drivers.state_dppa_ok(left.dl_state,dppa) and 
					right.source_code IN risk_indicators.iid_constants.SetValidStateSrcs AND
					(left.did=right.did), 									
					get_dl_did(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(100), local);

with_dl_did_thor := group(with_dl_did_thor_pre + project(indata(did=0 or dl_number='' or dl_state=''), transform(dl_temp, self := left, self := [])), seq);

#IF(onThor)
	with_dl_did := with_dl_did_thor;
#ELSE
	with_dl_did := with_dl_did_roxie;
#END

dl_temp roll_dl(dl_temp le, dl_temp rt) := transform
	self.dl_searched := le.dl_searched or rt.dl_searched;
	self.any_DL_found := le.any_dl_found or rt.any_dl_found;
	use_left := risk_indicators.iid_constants.tscore(le.dl_score) >= risk_indicators.iid_constants.tscore(rt.dl_score);
	self.DL_score := if(use_left, le.dl_score, rt.dl_score);
	self.verified_DL := if(use_left, le.verified_DL, rt.verified_DL);	
	self.dl_exists := if(use_left, le.dl_exists, rt.dl_exists);															
	
	// count a blank as already seen so it doesn't get added
	source_already_seen := rt.dl_verified_sources[1].dl_source='' or rt.dl_verified_sources[1].dl_source in set(le.dl_verified_sources, dl_source);
	
	// don't add the same source to the list more than once
	self.dl_verified_sources := le.dl_verified_sources + if(~source_already_seen, rt.dl_verified_sources);
																
	self.insurance_dl_used := le.insurance_dl_used or rt.insurance_dl_used;
	self := rt;
end;

InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input into_insurance_input(dl_temp le) := transform
	self.FirstName := le.fname;
	self.Lastname := le.lname;
	self.DateofBirth := le.dob;
	self.DL_St := le.dl_state;
	self:=le;
end;

rolled_dl_did := rollup(group(sort(with_dl_did, seq, -verified_dl), seq), true, roll_dl(left,right));

Slimmed_dl_did := project(rolled_dl_did, into_insurance_input(left));

//Search Insurance DL keys by DID
//======================================================================================
//=== for attribute version 201 customers - no DL # or DL state is required on input === 
//=== (these customers are identified by using return_sources)                         ===
//======================================================================================
insurance_dl_did := InsuranceHeader_BestOfBest.search_Insurance_DL_by_Did(Slimmed_dl_did,dppa,isFCRA,DataPermission);

dl_temp get_insurance_dl_did(rolled_dl_did le, insurance_dl_did ri) := TRANSFORM
	self.dl_searched := le.dl_searched or (le.did<>0 and le.dl_number<>'' and le.dl_state<>'' and le.verified_dl='');
	insurance_dl_score := IF(le.dl_number = ri.dl_nbr AND le.dl_state = ri.dl_state, 100, 0);
	use_insurance := (insurance_dl_score = 100 and risk_indicators.iid_constants.tscore(insurance_dl_score) > risk_indicators.iid_constants.tscore(le.dl_score)) or (return_sources);
	self.dl_score := if(use_insurance, if(insurance_dl_score = 100, insurance_dl_score, le.dl_score), le.dl_score); 
	dl_match := insurance_dl_score = 100 and (le.dl_number=ri.dl_nbr);
	self.verified_dl := if(use_insurance, if(dl_match, ri.dl_nbr, le.verified_dl/*''*/), le.verified_dl); 
	self.dl_verified_sources := le.dl_verified_sources +  if( use_insurance, if(dl_match, dataset([{ri.src}], mytemp), dataset([], mytemp) ),  dataset([], mytemp) );  
	self.any_dl_found := le.any_dl_found or ((ri.dl_nbr<>'' and ~iidV1) OR (ri.dl_nbr<>'' and risk_indicators.Validate_DL(le.dl_state, ri.dl_nbr, le.fname, le.lname, le.dob, dl_Match, le.dlsocsvalflag, le.dlsocsdobflag) = '0' AND iidV1));
	self.dl_exists := le.dl_exists or ((le.dl_number<>'') and (le.dl_number=ri.dl_nbr));
	self.insurance_dl_used := ri.dl_data_used;
	self := le;
END;

with_insurance_dl_did_roxie := join(rolled_dl_did, insurance_dl_did, 
					left.did<>0 and ((left.dl_number<>'' and left.dl_state<>'') or (return_sources)) and             
					left.did=right.did,
					get_insurance_dl_did(LEFT, RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(100));
					
with_insurance_dl_did_thor_pre := join(distribute(rolled_dl_did(did<>0 and ((dl_number<>'' and dl_state<>'') or (return_sources))), hash64(did)), 
					distribute(insurance_dl_did, hash64(did)), 
					left.did=right.did,
					get_insurance_dl_did(LEFT, RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(100), local);

with_insurance_dl_did_thor := with_insurance_dl_did_thor_pre + rolled_dl_did(did=0 or ((dl_number='' or dl_state='') and not (return_sources)));

#IF(onThor)
	with_insurance_dl_did := with_insurance_dl_did_thor;
#ELSE
	with_insurance_dl_did := with_insurance_dl_did_roxie;
#END

rolled_insurance_did := rollup(group(sort(with_insurance_dl_did, seq, -verified_dl), seq), true, roll_dl(left,right));

//Search Certegy keys by DID

dl_did_rolled := if(allowInsuranceDL,rolled_insurance_did, rolled_dl_did);

dl_temp get_certegy(dl_did_rolled le, certegy.key_certegy_did ri) := TRANSFORM
	self.dl_searched := le.dl_searched or (le.did<>0 and le.dl_number<>'' and le.dl_state<>'' and le.verified_dl='');
	certegy_dl_score := Risk_Indicators.DLscore(le.dl_number, ri.orig_dl_num, le.dl_state, ri.orig_dl_state);
	use_certegy := risk_indicators.iid_constants.tscore(certegy_dl_score) > risk_indicators.iid_constants.tscore(le.dl_score);
	self.dl_score := if(use_certegy, certegy_dl_score, le.dl_score);
	dl_match := (certegy_dl_score > Risk_Indicators.iid_constants.min_score) and (if(ExactDriverLicenseRequired, le.dl_number=ri.orig_dl_num, true));
	self.verified_dl := if(use_certegy, if(dl_match, ri.orig_dl_num, le.verified_dl), le.verified_dl);
	self.dl_verified_sources := le.dl_verified_sources + if( use_certegy OR return_sources, if(dl_match, dataset([{'CY'}], mytemp), dataset([], mytemp) ), dataset([], mytemp) );
	
	self.any_dl_found := le.any_dl_found or ((ri.orig_dl_num<>'' and ~iidV1) OR (ri.orig_dl_num<>'' and risk_indicators.Validate_DL(le.dl_state, ri.orig_dl_num, le.fname, le.lname, le.dob, dl_Match, le.dlsocsvalflag, le.dlsocsdobflag) = '0' AND iidV1));
	self.dl_exists := le.dl_exists or ((le.dl_number<>'') and (le.dl_number=ri.orig_dl_num));
	self := le;
END;


with_certegy_roxie := join(dl_did_rolled, certegy.key_certegy_did, 
					dppa_ok and 
					left.did<>0 and left.dl_number<>'' and left.dl_state<>'' and 
					keyed(left.did=right.did),
					get_certegy(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(100));

with_certegy_thor_pre := join(distribute(dl_did_rolled(did<>0 and dl_number<>'' and dl_state<>''), hash64(did)), 
					distribute(pull(certegy.key_certegy_did), hash64(did)), 
					dppa_ok and 
					(left.did=right.did),
					get_certegy(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(100), local);

with_certegy_thor := group(with_certegy_thor_pre + dl_did_rolled(did=0 or dl_number='' or dl_state=''), seq);

#IF(onThor)
	with_certegy := with_certegy_thor;
#ELSE
	with_certegy := with_certegy_roxie;
#END

rolled_certegy := rollup(group(sort(with_certegy, seq, -verified_dl), seq), true, roll_dl(left,right));

//Search State keys by DL
dl_temp get_dl(rolled_certegy le, DriversV2.Key_DL_Number ri) := TRANSFORM
	self.dl_searched := le.dl_searched or (le.dl_number<>''  and le.dl_state<>'' and le.fname<>'' and le.lname<>'' and le.verified_dl='');
	firstscore := risk_indicators.FnameScore(le.fname, ri.fname);
	lastscore := risk_indicators.LnameScore(le.lname, ri.lname);
	name_match := Risk_Indicators.iid_constants.g(firstscore) and Risk_Indicators.iid_constants.g(lastscore);
	state_match := le.dl_state=ri.st; 
	self.dl_score := if(le.verified_dl<>'', le.dl_score, if(name_match and state_match, 100, 0));
	self.verified_dl := if(le.verified_dl<>'', le.verified_dl, if(name_match and state_match, ri.s_dl, ''));
	self.dl_verified_sources := le.dl_verified_sources + if(name_match and state_match, dataset([{'D'}], mytemp), dataset([], mytemp) );
	self.any_dl_found := le.any_dl_found;
	self.dl_exists := le.dl_exists or ((ri.s_dl<>'' and name_match and state_match) and (le.dl_number=ri.s_dl));
	self := le;
END;

with_dl_roxie := join(rolled_certegy, DriversV2.Key_DL_Number, 
							left.dl_number<>'' and  left.dl_state<>'' and 
							left.fname<>'' and left.lname<>'' and drivers.state_dppa_ok(left.dl_state,dppa) and 
							right.source_code IN risk_indicators.iid_constants.SetValidStateSrcs AND
							keyed(left.dl_number=right.s_dl),
							get_dl(LEFT,RIGHT),
							left outer, atmost(riskwise.max_atmost), keep(100));

with_dl_thor_pre := join(distribute(rolled_certegy(dl_number<>'' and  dl_state<>''), hash64(dl_number)), 
							distribute(pull(DriversV2.Key_DL_Number), hash64(s_dl)),
							left.fname<>'' and left.lname<>'' and
							drivers.state_dppa_ok(left.dl_state,dppa) and 
							right.source_code IN risk_indicators.iid_constants.SetValidStateSrcs AND
							(left.dl_number=right.s_dl),
							get_dl(LEFT,RIGHT),
							left outer, atmost(riskwise.max_atmost), keep(100), local);

with_dl_thor := group(with_dl_thor_pre + rolled_certegy(dl_number='' or  dl_state=''), seq);

#IF(onThor)
	with_dl := with_dl_thor;
#ELSE
	with_dl := with_dl_roxie;
#END

rolled_dl := rollup(group(sort(with_dl, seq, -verified_dl), seq), true, roll_dl(left,right));

Slimmed_state := project(rolled_dl, into_insurance_input(left));

//Search the Insurance DL keys by DL
insurance_dl_dl := InsuranceHeader_BestOfBest.search_Insurance_DL_by_DL(Slimmed_state,dppa,isFCRA,DataPermission);

dl_temp get_insurance_dl_dl(rolled_dl le, insurance_dl_dl ri) := TRANSFORM
	self.dl_searched := le.dl_searched or (le.dl_number<>'' and le.dl_state<>'' and le.fname<>'' and le.lname<>'' and le.verified_dl='');
	firstscore := risk_indicators.FnameScore(le.fname, ri.fname);
	lastscore := risk_indicators.LnameScore(le.lname, ri.lname);
	name_match := Risk_Indicators.iid_constants.g(firstscore) and Risk_Indicators.iid_constants.g(lastscore);
	state_match := le.dl_state=ri.dl_state; 
	self.dl_score := if(le.verified_dl<>'', le.dl_score, if(name_match and state_match, 100, 0));
	self.verified_dl := if(le.verified_dl<>'', le.verified_dl, if(name_match and state_match, ri.dl_nbr, ''));
	self.dl_verified_sources := le.dl_verified_sources + if(name_match and state_match, dataset([{ri.src}], mytemp), dataset([], mytemp) );
	self.any_dl_found := le.any_dl_found;
	self.dl_exists := le.dl_exists or ((ri.dl_nbr<>'' and name_match and state_match) and (le.dl_number=ri.dl_nbr));
	self.insurance_dl_used := le.insurance_dl_used or ri.dl_data_used;
	self := le;
END;

with_insurance_dl_dl_roxie := join(rolled_dl, insurance_dl_dl, 
							left.dl_number<>'' and  left.dl_state<>'' and 
							left.fname<>'' and left.lname<>'' and 
							left.dl_number=right.dl_nbr,
							get_insurance_dl_dl(LEFT,RIGHT),
							left outer, atmost(riskwise.max_atmost), keep(100));

with_insurance_dl_dl_thor_pre := join(distribute(rolled_dl(dl_number<>'' and  dl_state<>''), hash64(dl_number)), 
							distribute(insurance_dl_dl, hash64(dl_nbr)), 
							left.fname<>'' and left.lname<>'' and 
							left.dl_number=right.dl_nbr,
							get_insurance_dl_dl(LEFT,RIGHT),
							left outer, atmost(riskwise.max_atmost), keep(100), local);

with_insurance_dl_dl_thor := with_insurance_dl_dl_thor_pre + rolled_dl(dl_number='' or  dl_state='');

#IF(onThor)
	with_insurance_dl_dl := with_insurance_dl_dl_thor;
#ELSE
	with_insurance_dl_dl := with_insurance_dl_dl_roxie;
#END

//We should have the highest verified record at this point.
rolled_insurance_dl := rollup(group(sort(with_insurance_dl_dl, seq, -verified_dl), seq), true, roll_dl(left,right));

Final_dl_temp := if(allowInsuranceDL, rolled_insurance_dl, rolled_dl);

final_dl := project(final_dl_temp, transform(risk_indicators.Layout_Output,
	deduped_dl_sources := dedup(sort(left.dl_verified_sources, dl_source), dl_source);
	self.verified_dl_sources := Business_Risk_BIP.Common.convertDelimited(deduped_dl_sources, dl_source, Business_Risk_BIP.Constants.FieldDelimiter);
	self := left));

//=====For Debug Purposes========================================
// output(BSOptions,named('BSOptions'));
// output(DataPermission,named('DataPermission'));
// output(dl_ok,named('dl_ok'));
// output(return_sources,named('return_sources'));
// output(iidV1,named('iidV1'));
// output(allowInsuranceDL,named('allowInsuranceDL'));
// output(with_dl_did,named('with_dl_did'));
// output(rolled_dl_did,named('rolled_dl_did'));
// output(with_insurance_dl_did,named('with_insurance_dl_did'));
// output(rolled_insurance_did,named('rolled_insurance_did'));
// output(with_certegy,named('with_certegy'));
// output(rolled_certegy,named('rolled_certegy'));
// output(with_dl,named('with_dl'));
// output(rolled_dl,named('rolled_dl'));
// output(with_insurance_dl_dl,named('with_insurance_dl_dl'));
// output(rolled_insurance_dl,named('rolled_insurance_dl')); 
// output(Final_dl_temp,named('Final_dl_temp'));
// output(Final_dl,named('Final_dl'));
//===============================================================
return Final_dl;

end;
