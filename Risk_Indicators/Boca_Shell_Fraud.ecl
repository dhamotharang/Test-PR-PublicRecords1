import doxie, riskwise, risk_indicators, Suppress, _control;

export Boca_Shell_Fraud := module

export layout_identities_input := record
	unsigned6 did;
	unsigned3 historydate;
end;

export layout_identities_output := record
	unsigned6 did;
	unsigned3 historydate;
	boolean bureau_only;
	boolean bureau_only_last_1month;
	boolean bureau_only_last_6months;
	boolean suspicious_ssn;
	string9 ssn;  // hang on to the SSN that is suspicious in case we get questions about it
end;

// accepts a dataset of ADLs, dedupes them, searches the header and SSN table to find "suspicious" identities (as defined in fraudpoint 2.0 project) 
// suspicious = ADLs_per_SSN seen in the last 18 months > 3 or SSN invalid or SSN issued prior to DOB or identity is credit bureau only or header first seen within the last year
export suspicious_identities_function_hist(dataset(layout_identities_input) input_adls,
																		doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := function

slim_rec := record
	unsigned6 did;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	string2 src;
	string9 ssn;
	unsigned4 dob;
	string1 valid_ssn;
	unsigned3 historydate;
	string1 valid_dob;
	unsigned dt_nonglb_last_seen;
	// recordof(doxie.key_header) hdr;
end;

#IF(_control.Environment.onThor) 
	// onThor, use distribute and do the sort and dedup locally
	deduped_input_adls := dedup(sort(distribute(input_adls, did),did, local), did, local);
#ELSE
	deduped_input_adls := dedup(sort(input_adls,did), did);
#END;

// if history mode, do the full searching of header and ssn_table...
with_header_unsuppressed_roxie := join(deduped_input_adls, doxie.key_header, 
								keyed(left.did=right.s_did) and 
									left.did != 0 and 
									right.dt_last_seen <> 0 and
									right.dt_first_seen < left.historydate,
									transform({slim_rec, UNSIGNED4 global_sid}, 
										self.global_sid := right.global_sid;
										self.historydate := (unsigned3)(risk_indicators.iid_constants.myGetDate(left.historydate)[1..6]);
										self := right), 
								atmost(riskwise.max_atmost), keep(500));
								
with_header_unsuppressed_thor := join(
	distribute(deduped_input_adls, did), 
	distribute(pull(doxie.key_header)(dt_last_seen <> 0), s_did), 
								(left.did=right.s_did) and 
									right.dt_first_seen < left.historydate,
									transform({slim_rec, UNSIGNED4 global_sid}, 
										self.global_sid := right.global_sid;
										self.historydate := (unsigned3)(risk_indicators.iid_constants.myGetDate(left.historydate)[1..6]);
										self := right), 
								// atmost(riskwise.max_atmost), 
								keep(500), local);

#IF(_control.Environment.onThor) 
	with_header_unsuppressed := with_header_unsuppressed_thor;
#ELSE
	with_header_unsuppressed := with_header_unsuppressed_roxie;
#END;

with_header := Suppress.Suppress_ReturnOldLayout(with_header_unsuppressed, mod_access, slim_rec);

did_stats_roxie := table(with_header, {did,
											historydate,
											total_records := count(group),
											bureau_records := count(group, src in Risk_Indicators.iid_constants.bureau_sources);//src in ['EQ','EN','TN']);
											first_seen := min(group, if(dt_first_seen=0, 999999, dt_first_seen)),
											last_seen := max(group, dt_last_seen),
											}, did, historydate);
did_stats_thor := table(distribute(with_header, did), {did,
											historydate,
											total_records := count(group),
											bureau_records := count(group, src in Risk_Indicators.iid_constants.bureau_sources);//src in ['EQ','EN','TN']);
											first_seen := min(group, if(dt_first_seen=0, 999999, dt_first_seen)),
											last_seen := max(group, dt_last_seen),
											}, did, historydate, local); 

#IF(_control.Environment.onThor) 
	did_stats := did_stats_thor;
#ELSE
	did_stats := did_stats_roxie;
#END;
	
suspicious_header := did_stats(	(first_seen<>999999 and first_seen >= (historydate - 100)	)		or							// IdentityRiskLevel = 3, first seen within the last year or
																(bureau_records=total_records) or 																					// IdentityRiskLevel = 4,  only shows up on Bureau records or
																((bureau_records>0 and total_records>0 and last_seen < (historydate - 100))) //and
															 );
//trying to get the same logic as Risk_Indicators.Key_Suspicious_Identities by adding some filtering
did_ssn_dob_roxie := table(with_header((trim(ssn) <> '' and valid_ssn <> 'M') 
									and (~(valid_dob = 'M' and valid_ssn = 'B' and dt_nonglb_last_seen = 0) and 
									~(valid_dob = 'M' and valid_ssn = 'F'))  and 
									~(valid_dob = 'M' and valid_ssn = 'R' and dt_nonglb_last_seen != 0) and
									~(valid_dob = '' and valid_ssn = '' and ssn = '' and dob = 0) 
									) ,
								{did, ssn, dob, historydate},did, ssn, dob, historydate);//, valid_dob, valid_ssn 
								
did_ssn_dob_thor := table(
		distribute(with_header((trim(ssn) <> '' and valid_ssn <> 'M') 
									and (~(valid_dob = 'M' and valid_ssn = 'B' and dt_nonglb_last_seen = 0) and 
									~(valid_dob = 'M' and valid_ssn = 'F'))  and 
									~(valid_dob = 'M' and valid_ssn = 'R' and dt_nonglb_last_seen != 0) and
									~(valid_dob = '' and valid_ssn = '' and ssn = '' and dob = 0) 
									), did) ,  // distribute this file by DID so table can be done local
								{did, ssn, dob, historydate},did, ssn, dob, historydate, local);//, valid_dob, valid_ssn 

#IF(_control.Environment.onThor) 
	did_ssn_dob := did_ssn_dob_thor;
#ELSE
	did_ssn_dob := did_ssn_dob_roxie;
#END;
								
slim2 := record
	did_ssn_dob;
	recordof(risk_indicators.Key_SSN_Table_v4_2) ssntable;
end;

// use the SSNs to search the ssn_table to find out if it's valid SSN or has multiple Identities or ssn issued prior to DOB
suspicious_ssns_unsuppressed_roxie := join(did_ssn_dob, risk_indicators.Key_SSN_Table_v4_2, 
	keyed(left.ssn=right.ssn)	and
	(	// only keep records that are suspicious
		right.combo.recentcount >= 3 or 
		right.isvalidformat=false or 
		( (unsigned)((string8)left.dob)[1..4] >  (unsigned)((string8)right.official_last_seen)[1..4] and right.official_last_seen<>0)
	),
	// transform(slim2,	self.ssntable := right, self := left), atmost(riskwise.max_atmost), keep(1));  // use this line if debugging to find out why it was suspicious
	transform({recordof(did_ssn_dob), UNSIGNED4 global_sid},	self.global_sid := right.global_sid; self := left), atmost(riskwise.max_atmost));


suspicious_ssns_unsuppressed_thor := join(
	distribute(did_ssn_dob, hash64(ssn)), 
	distribute(pull(risk_indicators.Key_SSN_Table_v4_2), hash64(ssn)), 
	(left.ssn=right.ssn)	and
	(	// only keep records that are suspicious
		right.combo.recentcount >= 3 or 
		right.isvalidformat=false or 
		( (unsigned)((string8)left.dob)[1..4] >  (unsigned)((string8)right.official_last_seen)[1..4] and right.official_last_seen<>0)
	),
	// transform(slim2,	self.ssntable := right, self := left), atmost(riskwise.max_atmost), keep(1));  // use this line if debugging to find out why it was suspicious
	transform({recordof(did_ssn_dob), UNSIGNED4 global_sid},	self.global_sid := right.global_sid; self := left), 
	// atmost(riskwise.max_atmost), 
	local);

#IF(_control.Environment.onThor) 
	suspicious_ssns_unsuppressed := suspicious_ssns_unsuppressed_thor;
#ELSE
	suspicious_ssns_unsuppressed := suspicious_ssns_unsuppressed_roxie;
#END;


suspicious_ssns := Suppress.Suppress_ReturnOldLayout(suspicious_ssns_unsuppressed, mod_access, recordof(did_ssn_dob));

#IF(_control.Environment.onThor) 
	dids_with_suspicious_ssns := dedup(sort(distribute(suspicious_ssns, hash64(did, ssn)), did, ssn, local), did, local);
#ELSE
	dids_with_suspicious_ssns := dedup(sort(suspicious_ssns, did, ssn), did);
#END;


layout_identities_output add_suspicious_ssn(suspicious_header le, dids_with_suspicious_ssns rt) := transform
		self.did := if(le.did=0, rt.did, le.did);
		self.historydate := if(le.did=0, rt.historydate, le.historydate);
		self.bureau_only := le.did<>0 and le.bureau_records=le.total_records;
		firstseen31 := ((STRING)le.first_seen)[1..6]+'31';
		self.bureau_only_last_1month := le.did<>0 and le.bureau_records=le.total_records and 
			risk_indicators.iid_constants.checkdays(risk_indicators.iid_constants.full_history_date(le.historydate),firstseen31,30, le.historydate);
		self.bureau_only_last_6months := le.did<>0 and le.bureau_records=le.total_records and 
			risk_indicators.iid_constants.checkdays(risk_indicators.iid_constants.full_history_date(le.historydate),firstseen31,risk_indicators.iid_constants.sixmonths, le.historydate);
		self.suspicious_ssn := rt.did<>0;
		self.ssn := if(rt.did<>0, rt.ssn, '');
end;
		

// atmost 1 record per DID in suspicious_header and 1 per DID in dids_with_suspicious_ssns
suspicious_identities_roxie := join(suspicious_header,dids_with_suspicious_ssns, 
	left.did=right.did,
	add_suspicious_ssn(left, right), full outer);
	
suspicious_identities_thor := join(distribute(suspicious_header, did), distribute(dids_with_suspicious_ssns, did), 
	left.did=right.did,
	add_suspicious_ssn(left, right), full outer, local);
	
#IF(_control.Environment.onThor) 
	suspicious_identities := suspicious_identities_thor;
#ELSE
	suspicious_identities := suspicious_identities_roxie;
#END;
	
// output(with_header, named('with_header'));
// output(did_stats, named('did_stats'));
// output(suspicious_header, named('suspicious_header'));
// output(did_ssn_dob, named('did_ssn_dob'));
// output(suspicious_ssns, named('suspicious_ssns'));
// output(dids_with_suspicious_ssns,  named('dids_with_suspicious_ssns'));
// output(suspicious_identities, named('suspicious_identities'));
	return suspicious_identities;

end;


end;