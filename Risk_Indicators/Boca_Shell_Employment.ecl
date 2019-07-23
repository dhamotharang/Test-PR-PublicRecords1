﻿import _Control, paw, riskwise, ut, mdr, fcra, risk_indicators, doxie, Suppress;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Employment(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) clam_pre_employment, 
															boolean isFCRA, 
															boolean isPreScreen, 
															integer bsVersion,
															doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

patw := record
	clam_pre_employment.seq;
	clam_pre_employment.did;
	clam_pre_employment.historydate;
		
	unsigned6 contact_id := 0;
	string12 bdid := '';
	string10 company_status := '';
	string2 source := '';
	string1 active_phone_flag := '';
	string10 phone := '';
	string100 sources := '';	// for use in counting sources
	string200 active_phones := ''; // for use in counting active phones
	
// last seen date was removed from the final layout 12/21/2010, but still need it for the rollups
	unsigned4 Last_seen_date := 0;
	
	risk_indicators.layouts.layout_employment;
	
end;

patw_CCPA := record
    unsigned4 global_sid; // CCPA changes
	patw;
end;

patw_CCPA getPawDid(clam_pre_employment le, paw.Key_Did ri) := TRANSFORM
	self.seq := le.seq;
	self.did := le.did;
	self.historydate := le.historydate;
	self.contact_id := ri.contact_id;
	self := [];
END;

with_paw_did_roxie := join(clam_pre_employment, paw.Key_Did,
						left.did<>0 and 
						keyed(left.did=right.did), 
						getPawDid(LEFT,RIGHT),
						left outer, atmost(riskwise.max_atmost), keep(1000));

with_paw_did_thor := join(distribute(clam_pre_employment, hash64(did)), 
						distribute(pull(paw.Key_Did), hash64(did)),
						left.did<>0 and 
						keyed(left.did=right.did), 
						getPawDid(LEFT,RIGHT),
						left outer, atmost(riskwise.max_atmost), keep(1000), LOCAL);
						
#IF(onThor)
	with_paw_did := group(sort(with_paw_did_thor, seq), seq);
#ELSE
	with_paw_did := with_paw_did_roxie;
#END

patw_CCPA getPawFull(with_paw_did le, paw.Key_contactID ri) := TRANSFORM
	self.seq := le.seq;
	self.did := le.did;
	self.historydate := le.historydate;								
	self.contact_id := ri.contact_id;
	self.bdid := if(ri.contact_id<>0 and ri.company_name<>'' and ri.bdid=0, 'xyz', (string)ri.bdid);  // throw in a fake BDID for counting later if the BDID wasn't on the record
	self.company_status := ri.company_status;
	self.source := ri.source;
	self.phone := ri.phone;
	self.active_phone_flag := ri.active_phone_flag;
	self.company_title := ri.company_title;  // most recent company title
	dead_company := trim(ri.company_status)='DEAD';
	self.First_seen_date := if(dead_company, 0, (unsigned)ri.dt_first_seen);  //(non-dead businesses)
	self.Last_seen_date := if(dead_company, 0, (unsigned)ri.dt_last_seen); // (non-dead businesses)
	self.Business_ct := if(ri.contact_id<>0, 1, 0);  // number of different BDIDs worked for
	self.Dead_business_ct := if(ri.contact_id<>0 and dead_company, 1, 0);  // number of different BDIDs worked for that are dead
	self.Business_active_phone_ct := if(ri.active_phone_flag='Y' and ri.phone<>'' and ~dead_company, 1, 0); // number of active business phones
	self.Source_ct	:= if(ri.contact_id<>0, 1, 0);  // number of different PAW sources appeared on
	self.sources := '';
	self.active_phones := '';
	self.global_sid := ri.global_sid;
END;

pawfile_full_nonfcra_roxie := join(with_paw_did, paw.Key_contactid,
						left.contact_id<>0 and 
						keyed(left.contact_id=right.contact_id) 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate,
						getPawFull(LEFT,RIGHT),
						left outer,
						atmost(riskwise.max_atmost), keep(1000));

pawfile_full_nonfcra_thor := join(distribute(with_paw_did, hash64(contact_id)), 
						distribute(pull(paw.Key_contactid), hash64(contact_id)),
						left.contact_id<>0 and 
						left.contact_id=right.contact_id 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate,
						getPawFull(LEFT,RIGHT),
						left outer,
						atmost(riskwise.max_atmost), keep(1000), LOCAL);
	
pawfile_suppress_roxie := Suppress.MAC_SuppressSource(pawfile_full_nonfcra_roxie, mod_access);
pawfile_full_formatted_roxie := PROJECT(pawfile_suppress_roxie, TRANSFORM(patw,
                                                  SELF := LEFT));
																									
pawfile_suppress_thor := Suppress.MAC_SuppressSource(pawfile_full_nonfcra_thor, mod_access);
pawfile_full_formatted_thor := PROJECT(pawfile_suppress_thor, TRANSFORM(patw,
                                                  SELF := LEFT));
																									
#IF(onThor)
	pawfile_full_nonfcra := group(sort(pawfile_full_formatted_thor,seq),seq);
#ELSE
	pawfile_full_nonfcra := pawfile_full_formatted_roxie;
#END

// can not use these sources if running in prescreen mode
restricted_prescreen_sources := [mdr.sourcetools.src_IL_Corporations,
																 mdr.sourcetools.src_NM_Corporations,
																 mdr.sourcetools.src_ID_Corporations,
																 mdr.sourcetools.src_KS_Corporations,
																 mdr.sourcetools.src_WA_Corporations,
																 mdr.sourcetools.src_SC_Corporations
																 ];

patw getPAWRawFCRA(clam_pre_employment le, paw.Key_DID_FCRA ri) := TRANSFORM
	self.seq := le.seq;
	self.did := le.did;
	self.historydate := le.historydate;											
	self.contact_id := ri.contact_id;
	self.bdid := if(ri.contact_id<>0 and ri.company_name<>'' and ri.bdid=0, 'xyz', (string)ri.bdid);  // throw in a fake BDID for counting later if the BDID wasn't on the record
	self.company_status := ri.company_status;
	self.source := ri.source;
	self.phone := ri.phone;
	self.active_phone_flag := ri.active_phone_flag;
	self.company_title := ri.company_title;  // most recent company title
	dead_company := trim(ri.company_status)='DEAD';
	self.First_seen_date := if(dead_company, 0, (unsigned)ri.dt_first_seen);  //(non-dead businesses)
	self.Last_seen_date := if(dead_company, 0, (unsigned)ri.dt_last_seen); // (non-dead businesses)
	self.Business_ct := if(ri.contact_id<>0, 1, 0);  // number of different BDIDs worked for
	self.Dead_business_ct := if(ri.contact_id<>0 and dead_company, 1, 0);  // number of different BDIDs worked for that are dead
	self.Business_active_phone_ct := if(ri.active_phone_flag='Y' and ri.phone<>'' and ~dead_company, 1, 0); // number of active business phones
	self.Source_ct	:= if(ri.contact_id<>0, 1, 0);  // number of different PAW sources appeared on
	self.sources := '';
	self.active_phones := '';
END;

pawfile_raw_FCRA_roxie := join(clam_pre_employment, paw.Key_DID_FCRA,
						left.did<>0 and 
						keyed(left.did=right.did) 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.dt_last_seen, risk_indicators.iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						~(isPreScreen and right.source in restricted_prescreen_sources) and
						(right.from_hdr='N' or bsVersion < 50) and  // if from_hdr='Y', this means the PAW association between consumer and business is a shared address only, filter those out for shell 5.0 and higher
						(string100)right.contact_id not in left.PAW_correct_record_id,  // don't include any records from raw data that have been corrected
						getPAWRawFCRA(LEFT,RIGHT),
						left outer,
						atmost(riskwise.max_atmost), keep(1000));
						
pawfile_raw_FCRA_thor := join(distribute(clam_pre_employment, hash64(did)), 
						distribute(pull(paw.Key_DID_FCRA), hash64(did)),
						left.did<>0 and 
						left.did=right.did
						and (unsigned)right.dt_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.dt_last_seen, risk_indicators.iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						~(isPreScreen and right.source in restricted_prescreen_sources) and
						(right.from_hdr='N' or bsVersion < 50) and  // if from_hdr='Y', this means the PAW association between consumer and business is a shared address only, filter those out for shell 5.0 and higher
						(string100)right.contact_id not in left.PAW_correct_record_id,  // don't include any records from raw data that have been corrected
						getPAWRawFCRA(LEFT,RIGHT),
						left outer,
						atmost(left.did=right.did, riskwise.max_atmost), keep(1000), LOCAL);

#IF(onThor)
	pawfile_raw_FCRA := group(sort(pawfile_raw_FCRA_thor,seq),seq);
#ELSE
	pawfile_raw_FCRA := pawfile_raw_FCRA_roxie;
#END

patw getPAWCorrections(clam_pre_employment le, fcra.Key_Override_PAW_ffid ri) := TRANSFORM
	self.seq := le.seq;
	self.did := le.did;
	self.historydate := le.historydate;											
	self.contact_id := ri.contact_id;
	self.bdid := if(ri.contact_id<>0 and ri.company_name<>'' and ri.bdid=0, 'xyz', (string)ri.bdid);  // throw in a fake BDID for counting later if the BDID wasn't on the record
	self.company_status := ri.company_status;
	self.source := ri.source;
	self.phone := ri.phone;
	self.active_phone_flag := ri.active_phone_flag;
	self.company_title := ri.company_title;  // most recent company title
	dead_company := trim(ri.company_status)='DEAD';
	self.First_seen_date := if(dead_company, 0, (unsigned)ri.dt_first_seen);  //(non-dead businesses)
	self.Last_seen_date := if(dead_company, 0, (unsigned)ri.dt_last_seen); // (non-dead businesses)
	self.Business_ct := if(ri.contact_id<>0, 1, 0);  // number of different BDIDs worked for
	self.Dead_business_ct := if(ri.contact_id<>0 and dead_company, 1, 0);  // number of different BDIDs worked for that are dead
	self.Business_active_phone_ct := if(ri.active_phone_flag='Y' and ri.phone<>'' and ~dead_company, 1, 0); // number of active business phones
	self.Source_ct	:= if(ri.contact_id<>0, 1, 0);  // number of different PAW sources appeared on
	self.sources := '';
	self.active_phones := ''
END;

paw_corrections_FCRA_roxie := join(clam_pre_employment, fcra.Key_Override_PAW_ffid,
						keyed(right.flag_file_id in left.PAW_correct_ffid) 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.dt_last_seen, risk_indicators.iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						(right.from_hdr='N' or bsVersion < 50) and
						~(isPreScreen and right.source in restricted_prescreen_sources),
						getPAWCorrections(LEFT, RIGHT),
						atmost(riskwise.max_atmost), keep(1000));						

paw_corrections_FCRA_thor := join(clam_pre_employment, pull(fcra.Key_Override_PAW_ffid),
						right.flag_file_id in left.PAW_correct_ffid
						and (unsigned)right.dt_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.dt_last_seen, risk_indicators.iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						(right.from_hdr='N' or bsVersion < 50) and
						~(isPreScreen and right.source in restricted_prescreen_sources),
						getPAWCorrections(LEFT, RIGHT), keep(1000), LOCAL, ALL);			
						
#IF(onThor)
	paw_corrections_FCRA := paw_corrections_FCRA_thor;
#ELSE
	paw_corrections_FCRA := paw_corrections_FCRA_roxie;
#END

pawfile_full_FCRA := pawfile_raw_FCRA + paw_corrections_FCRA;
						
pawfile_full := ungroup(if(isFCRA, pawfile_full_FCRA, pawfile_full_nonfcra));

patw roll_paw(patw le, patw rt) := transform
	self.company_title := if(le.company_title='', rt.company_title, if(le.last_seen_date>rt.last_seen_date,le.company_title,rt.company_title));
	self.first_seen_date := if(rt.first_seen_date<le.first_seen_date and rt.first_seen_date<>0, rt.first_seen_date, le.first_seen_date);
	self.last_seen_date := if(rt.last_seen_date>le.last_seen_date, rt.last_seen_date, le.last_seen_date);
	
	source_seen := stringlib.stringfind(le.sources, le.source, 1)>0;
	self.sources := if(source_seen, le.sources, trim(le.sources) + ',' + le.source); 
	self.source_ct := if(source_seen or le.sources='', le.source_ct, le.source_ct + rt.source_ct);
	
	self.business_ct := if(le.bdid=rt.bdid, le.business_ct, le.business_ct + rt.business_ct);
	// self.dead_business_ct := if(le.bdid=rt.bdid, le.dead_business_ct, le.dead_business_ct + rt.dead_business_ct);  // don't count these here because we need a seperate table for that
	
	new_phone := le.phone<>'' and stringlib.stringfind(le.active_phones, le.phone, 1)=0 ;
	self.Business_active_phone_ct := if(new_phone, le.business_active_phone_ct + 1, le.Business_active_phone_ct);
	self.active_phones := if(new_phone, trim(le.active_phones) + ',' + le.phone, le.active_phones);

	self := rt;
end;

grouped_pawfile := group(pawfile_full, seq);
sorted_pawfile_full := sort(grouped_pawfile, seq, -(unsigned)bdid, -last_seen_date, -first_seen_date);

rolled_paw := rollup(sorted_pawfile_full, true, roll_paw(left, right));

dead_business_ct_per_bdid := table(grouped_pawfile, {seq, bdid, dead_business_count := count(group, dead_business_ct=1)}, 
											seq, bdid);

dead_business_ct_per_seq := table(dead_business_ct_per_bdid, {seq, dead_business_ct := count(group, dead_business_count>0)}, 
											seq);

with_dead_business_counts := join(rolled_paw, dead_business_ct_per_seq, left.seq=right.seq, 
	transform(patw,
	self.dead_business_ct:= right.dead_business_ct;
	self := left));
	
with_paw := group(join(clam_pre_employment, with_dead_business_counts, left.seq=right.seq,
									transform(risk_indicators.Layout_Boca_Shell, self.employment := right, self := left), 
									left outer, keep(1)), seq);			
												
// output(sorted_pawfile_full, named('sorted_pawfile_full'));               
// output(dead_business_ct_per_bdid, named('dead_business_ct_per_bdid'));
// output(dead_business_ct_per_seq, named('dead_business_ct_per_seq'));
// output(rolled_paw, named('rolled_paw'));
// output(with_dead_business_counts, named('with_dead_business_counts'));

return with_paw;

end;