import _Control, riskwise, ut, doxie;
onThor := _Control.Environment.OnThor;

export getVelocityHist(GROUPED DATASET(iid_constants.layout_outx) iid2, boolean isFCRA, unsigned1 dppa,
												string50 DataRestriction, unsigned1 BSversion) := FUNCTION

iid_roxie := group(sort(iid2,seq,did),seq,did);

iid_thor := group(sort(distribute(iid2, hash64(seq,did)),seq,did, LOCAL),seq,did, LOCAL);

#IF(onThor)
	iid := iid_thor;
#ELSE
	iid := iid_roxie;
#END

dppa_ok := iid_constants.dppa_ok(dppa, isFCRA);

age_hist := Risk_Indicators.getAgeHist(iid);


counts_per_ssn := table(iid, {seq, historydate, did, ssn_from_did,
															_ssns_per_adl := count(group, ssns_per_adl>0),
															_ssns_per_adl_created_6months := count(group, ssns_per_adl_created_6months>0),
															_ssns_per_adl_created_outside_6months := count(group, ssns_per_adl>0 and ssns_per_adl_created_6months=0),
															_ssns_per_adl_seen_18months := count(group, ssns_per_adl_seen_18months>0)}, seq, historydate, did,  ssn_from_did);

														
ssn_counts_by_seq_did := table(counts_per_ssn, {seq, historydate, did, ssns_per_adl := count(group, _ssns_per_adl>0),
															ssns_per_adl_created_6months := count(group, _ssns_per_adl_created_6months>0 and _ssns_per_adl_created_outside_6months=0),
															ssns_per_adl_seen_18months := count(group, _ssns_per_adl_seen_18months>0)}, seq, historydate, did, few);

rolled_ssns := project(ssn_counts_by_seq_did, transform(iid_constants.layout_outx, self := left, self := []));



iid_constants.layout_outx count_addrs_per_did(iid_constants.layout_outx le, iid_constants.layout_outx ri) := transform
	self.addrs_per_adl := iid_constants.capVelocity(le.addrs_per_adl + 
								if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_per_adl));
	self.addrs_per_adl_created_6months := iid_constants.capVelocity(le.addrs_per_adl_created_6months + 
											if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_per_adl_created_6months));
											
	self.addrs_last_5years := iid_constants.capVelocity(le.addrs_last_5years + 
											if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last_5years));
	self.addrs_last_10years := iid_constants.capVelocity(le.addrs_last_10years + 
											if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last_10years));
	self.addrs_last_15years := iid_constants.capVelocity(le.addrs_last_15years + 
											if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last_15years));										
	
	self.addrs_last30 := iid_constants.capVelocity(le.addrs_last30 + if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last30));
	self.addrs_last90 := iid_constants.capVelocity(le.addrs_last90 + if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last90));
	self.addrs_last12 := iid_constants.capVelocity(le.addrs_last12 + if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last12));
	self.addrs_last24 := iid_constants.capVelocity(le.addrs_last24 + if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last24));
	self.addrs_last36 := iid_constants.capVelocity(le.addrs_last36 + if(trim(le.addr_from_did)=trim(ri.addr_from_did), 0, ri.addrs_last36));
	
	self := ri;
end;

addresses_deduped := dedup(sort(iid, seq, did, addr_from_did, if(hdr_dt_first_seen=0, 999999, hdr_dt_first_seen), hdr_dt_last_seen), seq, did, addr_from_did);
 
counts_per_address_roxie := table(addresses_deduped, {
												seq, did,
												addr_from_did,
												_addrs_per_adl := count(group, addrs_per_adl>0),
												_addrs_per_adl_created_6months := count(group, addrs_per_adl_created_6months>0),
												_addrs_last_5years := count(group, addrs_last_5years>0),
												_addrs_last_10years := count(group, addrs_last_10years>0),
												_addrs_last_15years := count(group, addrs_last_15years>0),
												_addrs_last30 := count(group, addrs_last30>0),
												_addrs_last90 := count(group, addrs_last90>0),
												_addrs_last12 := count(group, addrs_last12>0),
												_addrs_last24 := count(group, addrs_last24>0),
												_addrs_last36 := count(group, addrs_last36>0),												
												}, seq, did, addr_from_did, few);
counts_per_address_thor := table(distribute(addresses_deduped, hash64(seq,did)), {
												seq, did,
												addr_from_did,
												_addrs_per_adl := count(group, addrs_per_adl>0),
												_addrs_per_adl_created_6months := count(group, addrs_per_adl_created_6months>0),
												_addrs_last_5years := count(group, addrs_last_5years>0),
												_addrs_last_10years := count(group, addrs_last_10years>0),
												_addrs_last_15years := count(group, addrs_last_15years>0),
												_addrs_last30 := count(group, addrs_last30>0),
												_addrs_last90 := count(group, addrs_last90>0),
												_addrs_last12 := count(group, addrs_last12>0),
												_addrs_last24 := count(group, addrs_last24>0),
												_addrs_last36 := count(group, addrs_last36>0),												
												}, seq, did, addr_from_did, LOCAL);

#IF(onThor)
	counts_per_address := counts_per_address_thor;
#ELSE
	counts_per_address := counts_per_address_roxie;
#END

addr_counts_by_seq_did := table(counts_per_address, {
												seq, did,
												addrs_per_adl := count(group, _addrs_per_adl >0),
												addrs_per_adl_created_6months := count(group, _addrs_per_adl_created_6months>0),
												addrs_last_5years := count(group, _addrs_last_5years>0),
												addrs_last_10years := count(group, _addrs_last_10years>0),
												addrs_last_15years := count(group, _addrs_last_15years>0),
												addrs_last30 := count(group, _addrs_last30>0),
												addrs_last90 := count(group, _addrs_last90>0),
												addrs_last12 := count(group, _addrs_last12>0),
												addrs_last24 := count(group, _addrs_last24>0),
												addrs_last36 := count(group, _addrs_last36>0),												
												},seq, did, few);												


rolled_addrs := project(addr_counts_by_seq_did, transform(iid_constants.layout_outx, self := left, self := []));

iid_constants.layout_outx joinRolls(iid_constants.layout_outx le, iid_constants.layout_outx ri) := transform
	self.addrs_per_adl := ri.addrs_per_adl; 
	self.addrs_per_adl_created_6months := ri.addrs_per_adl_created_6months;
	self.addrs_last_5years := ri.addrs_last_5years;
	self.addrs_last_10years := ri.addrs_last_10years;
	self.addrs_last_15years := ri.addrs_last_15years;
	self.addrs_last30 := ri.addrs_last30;
	self.addrs_last90 := ri.addrs_last90;
	self.addrs_last12 := ri.addrs_last12;
	self.addrs_last24 := ri.addrs_last24;
	self.addrs_last36 := ri.addrs_last36;
	self := le;
END;
rolled_ssn_addr_roxie := join(rolled_ssns, rolled_addrs, left.seq=right.seq and left.did=right.did, joinRolls(LEFT,RIGHT), left outer, lookup);

rolled_ssn_addr_thor := join(distribute(rolled_ssns, hash64(seq,did)), distribute(rolled_addrs, hash64(seq,did)), 
															left.seq=right.seq and left.did=right.did, joinRolls(LEFT,RIGHT), left outer, LOCAL);

#IF(onThor)
	rolled_ssn_addr := rolled_ssn_addr_thor;
#ELSE
	rolled_ssn_addr := rolled_ssn_addr_roxie;
#END

// add addrs per dl, vo, pl here
addrs_per_src := record
	iid.seq;
	iid.did;
	iid.addr_from_did;
	iid.src;
END;
d_addr := TABLE(iid(TRIM(addr_from_did)<>''), addrs_per_src, seq, did, addr_from_did, src);


addr_stats := record
	seq := d_addr.seq;
	did := d_addr.did;
	dl_addrs_per_adl := count(group, d_addr.src='D');
	vo_addrs_per_adl := count(group, d_addr.src='VO');
	pl_addrs_per_adl := count(group, d_addr.src='PL');
END;
addr_counts := table(d_addr, addr_stats, seq, did);
////////////////////////////////////////////

iid_constants.layout_outx addAddrsPerSrc(iid_constants.layout_outx le, addr_stats ri) := transform
	self.dl_addrs_per_adl := iid_constants.capVelocity(ri.dl_addrs_per_adl);
	self.vo_addrs_per_adl := iid_constants.capVelocity(ri.vo_addrs_per_adl);
	self.pl_addrs_per_adl := iid_constants.capVelocity(ri.pl_addrs_per_adl);
	self := le;
end;
rolled_ssn_addr2 := join(rolled_ssn_addr, addr_counts, left.seq=right.seq and left.did=right.did, addAddrsPerSrc(left,right), left outer, lookup);

rolled_ssn_addr3 := if(BSversion>2, rolled_ssn_addr2, rolled_ssn_addr);	// don't do dl/vo/pl counts if not version 3


//////////////// add invalid ssn and addr counts
ss := dedup(sort(iid(invalid_ssn_From_did<>''), invalid_ssn_from_did, -invalid_ssns_per_adl_created_6months), invalid_ssn_from_did);


// Get info from SSA table
SSN_Map_Key := if(isFCRA, doxie.Key_SSN_FCRA_Map, doxie.Key_SSN_Map);
iid_constants.layout_outx get_ssa(iid le, SSN_Map_Key ri) := TRANSFORM
	isSequenceValid := IF(ri.ssn5<>'',true,false);
	
	vssn := Risk_indicators.Validate_SSN(le.invalid_ssn_from_did,'');
	
	isValidFormat := ~(vssn.invalid OR vssn.begin_invalid OR
											vssn.middle_invalid OR vssn.last_invalid);
											
	validSSN := (isSequenceValid and isValidFormat) or length(trim(le.invalid_ssn_from_did))=4;								
	self.invalid_ssn_from_did := if(validSSN, '', le.invalid_ssn_from_did);	// remove socials that are valid, count 4 byte socials as valid
	self.invalid_ssns_per_adl := if(validSSN, 0, le.invalid_ssns_per_adl);
	self.invalid_ssns_per_adl_created_6months := if(validSSN, 0, le.invalid_ssns_per_adl_created_6months);
	
	SELF := le;
END;
with_ssa_roxie := JOIN(ss((length(trim(invalid_ssn_from_did))<>4) and (invalid_ssn_from_did[1..5]<>'00000') and (invalid_ssn_from_did[6..9]<>'0000')), 
									SSN_Map_Key,
															(trim(LEFT.invalid_ssn_from_did)<>'') AND
														 keyed(LEFT.invalid_ssn_from_did[1..5]=RIGHT.ssn5) AND
														 keyed(Left.invalid_ssn_from_did[6..9] between Right.start_serial and Right.end_serial) AND
														 ((unsigned3)(RIGHT.start_date[1..6]) < left.historydate),
														 get_ssa(LEFT,RIGHT), 
														 LEFT OUTER, atmost(Riskwise.max_atmost), keep(1));
								
with_ssa_thor := JOIN(distribute(ss((length(trim(invalid_ssn_from_did))<>4) and (invalid_ssn_from_did[1..5]<>'00000') and (invalid_ssn_from_did[6..9]<>'0000')), hash64(invalid_ssn_from_did[1..5])), 
															distribute(pull(SSN_Map_Key), hash64(ssn5)),
														 (trim(LEFT.invalid_ssn_from_did)<>'') AND
														 (LEFT.invalid_ssn_from_did[1..5]=RIGHT.ssn5) AND
														 (Left.invalid_ssn_from_did[6..9] between Right.start_serial and Right.end_serial) AND
														 ((unsigned3)(RIGHT.start_date[1..6]) < left.historydate),
														 get_ssa(LEFT,RIGHT), 
														 LEFT OUTER, keep(1), LOCAL);
														 
#IF(onThor)
	with_ssa := GROUP(SORT(with_ssa_thor, seq,did), seq,did);
#ELSE
	with_ssa := GROUP(SORT(with_ssa_roxie, seq,did), seq,did);
#END

iid_constants.layout_outx count_invalid_ssns_per_did(iid_constants.layout_outx le, iid_constants.layout_outx ri) := transform
	self.invalid_ssns_per_adl := iid_constants.capVelocity(le.invalid_ssns_per_adl + ri.invalid_ssns_per_adl);
	self.invalid_ssns_per_adl_created_6months := iid_constants.capVelocity(le.invalid_ssns_per_adl_created_6months + ri.invalid_ssns_per_adl_created_6months);
	self := ri;
end;
rolled_invalid_ssns := rollup(with_ssa, true, count_invalid_ssns_per_did(left,right));	// believe IID is grouped by seq

///////////////////////////////////////////////

//joinem
iid_constants.layout_outx addInvalid(iid_constants.layout_outx le, rolled_invalid_ssns ri) := transform
	self.invalid_ssns_per_adl := ri.invalid_ssns_per_adl; 
	self.invalid_ssns_per_adl_created_6months := ri.invalid_ssns_per_adl_created_6months;
	self := le;
END;
j_invalid_ssn_addr := join(rolled_ssn_addr3, rolled_invalid_ssns, left.seq=right.seq and left.did=right.did, addInvalid(LEFT,RIGHT), left outer, lookup);

j_invalid_ssn_addr2 := if(BSversion>2, j_invalid_ssn_addr, rolled_ssn_addr3);	// for bsversion 3 do invalid ssns

/////////////////////////////////////////////////

// invalid addrs
// dedup and sort by the chronology address because we are checking the chronozip4 to see if it is invalid or not (chrono and invalid_addr_from_did are the same except chrono has zip in a seperate field that is easy to check)
sa := dedup(sort(iid((trim(chronoprim_range) + trim(chronoprim_name) + trim(chronozip4))<>''), trim(chronoprim_range) + trim(chronoprim_name) + trim(chronozip4), -invalid_addrs_per_adl_created_6months), trim(chronoprim_range) + trim(chronoprim_name) + trim(chronozip4));

iid_constants.layout_outx validAddr(sa le) := transform
	invalidAddr := le.chronozip4='';	
	
	self.invalid_addr_from_did := if(invalidAddr, le.invalid_addr_from_did, '');
	self.invalid_addrs_per_adl := if(invalidAddr, le.invalid_addrs_per_adl, 0);
	self.invalid_addrs_per_adl_created_6months := if(invalidAddr, le.invalid_addrs_per_adl_created_6months, 0);
	self := le;
end;
checkAddr := project(sa, validAddr(left));


iid_constants.layout_outx count_invalid_addrs_per_did(iid_constants.layout_outx le, iid_constants.layout_outx ri) := transform
	self.invalid_addrs_per_adl := iid_constants.capVelocity(le.invalid_addrs_per_adl + ri.invalid_addrs_per_adl);
	self.invalid_addrs_per_adl_created_6months := iid_constants.capVelocity(le.invalid_addrs_per_adl_created_6months + ri.invalid_addrs_per_adl_created_6months);
	self := ri;
end;
rolled_invalid_addrs := rollup(checkAddr, true, count_invalid_addrs_per_did(left,right));	// believe IID is grouped by seq


/////////////////////////////////////////////////

// joimem invalids
iid_constants.layout_outx addInvalidAddr(iid_constants.layout_outx le, rolled_invalid_addrs ri) := transform
	self.invalid_addrs_per_adl := ri.invalid_addrs_per_adl; 
	self.invalid_addrs_per_adl_created_6months := ri.invalid_addrs_per_adl_created_6months;
	self := le;
END;
jInvalids := join(j_invalid_ssn_addr2, rolled_invalid_addrs, left.seq=right.seq and left.did=right.did, addInvalidAddr(LEFT,RIGHT), left outer, lookup);

jInvalids2 := if(BSversion>2, jInvalids, j_invalid_ssn_addr2);	// for bsversion 3 add invalid addrs

////////////////////////////////////////////////

// add last names
lname_slim := record
	iid.seq;
	iid.did;
	myGetDate := risk_indicators.iid_constants.myGetDate(iid.historydate);
	iid.last_from_did;
	dt_first_seen := MIN(GROUP,IF(iid.chronodate_first=0,999999,iid.chronodate_first));
	dt_last_seen := MAX(GROUP,iid.dt_last_seen);
END;
d_last := TABLE(iid(TRIM(last_from_did)<>''), lname_slim, seq, did, historydate, last_from_did);


lname_stats := record
	did := d_last.did;
	seq := d_last.seq;
	lnames_per_adl := count(group);
	lnames_per_adl30 := count(group, ut.DaysApart(d_last.myGetDate, ((string) d_last.dt_first_seen)[1..6]+'31') < 30);	// within the last 30 days
	lnames_per_adl90 := count(group, ut.DaysApart(d_last.myGetDate, ((string) d_last.dt_first_seen)[1..6]+'31') < 90);	// within the last 90 days
	lnames_per_adl180 := count(group, ut.DaysApart(d_last.myGetDate, ((string) d_last.dt_first_seen)[1..6]+'31') < 180);
	lnames_per_adl12 := count(group, ( (unsigned)d_last.myGetDate[1..6] - (unsigned)((string) d_last.dt_first_seen)[1..6] ) < 100);	// within the last 1 year
	lnames_per_adl24 := count(group, ( (unsigned)d_last.myGetDate[1..6] - (unsigned)((string) d_last.dt_first_seen)[1..6] ) < 200);	// within the last 2 years
	lnames_per_adl36 := count(group, ( (unsigned)d_last.myGetDate[1..6] - (unsigned)((string) d_last.dt_first_seen)[1..6] ) < 300);	// within the last 3 years	
	lnames_per_adl60 := count(group, ( (unsigned)d_last.myGetDate[1..6] - (unsigned)((string) d_last.dt_first_seen)[1..6] ) < 500); // within the last 5 years
END;
lname_counts := table(d_last, lname_stats, seq, did);


d_last_corrected := project(d_last, transform(recordof(d_last), 
																							self.dt_first_seen := if(left.dt_first_seen=999999, 0, left.dt_first_seen), 
																							self := left ));

most_recent_last := sort(d_last_corrected, did, -dt_first_seen, -last_from_did );

lname_rec := record
	lname_counts;
	string20 newest_lname;
	string20 newest_lname2;
	unsigned3 newest_lname_dt_first_seen;
end;

lname_results_all := join(lname_counts, most_recent_last, left.seq=right.seq and left.did=right.did, 
											transform(lname_rec, self.newest_lname := right.last_from_did,
																self.newest_lname_dt_first_seen := right.dt_first_seen, 
																self := left, self := [])/*, keep(2)*/);
		
		
lname_results := dedup(sort(lname_results_all, seq, did,-newest_lname_dt_first_seen, -newest_lname ),seq,did,keep(2));
lname_rec rollIt(lname_rec le, lname_rec ri) := transform
	self.newest_lname2 := ri.newest_lname;
	self := le;
end;
rolled_lnames := rollup(lname_results, left.did=right.did, rollIt(left, right));																


iid_constants.layout_outx addLnames(iid_constants.layout_outx le, lname_results ri) := transform
	self.last_from_did := if(LnameScore(le.lname, ri.newest_lname) >= 80, ri.newest_lname2, ri.newest_lname);
	self.lnames_per_adl := iid_constants.capVelocity(ri.lnames_per_adl);
	self.lnames_per_adl30 := iid_constants.capVelocity(ri.lnames_per_adl30);	
	self.lnames_per_adl90 := iid_constants.capVelocity(ri.lnames_per_adl90);
	self.lnames_per_adl180 := iid_constants.capVelocity(ri.lnames_per_adl180);
	self.lnames_per_adl12 := iid_constants.capVelocity(ri.lnames_per_adl12);
	self.lnames_per_adl24 := iid_constants.capVelocity(ri.lnames_per_adl24);
	self.lnames_per_adl36 := iid_constants.capVelocity(ri.lnames_per_adl36);
	self.lnames_per_adl60 := iid_constants.capVelocity(ri.lnames_per_adl60);
	self.newest_lname_dt_first_seen := ri.newest_lname_dt_first_seen;
	self := le;
end;
rolled_ssn_addr_lname_roxie := join(jInvalids2, rolled_lnames, left.seq=right.seq and left.did=right.did, addLnames(LEFT,RIGHT), left outer, lookup);

rolled_ssn_addr_lname_thor := join(distribute(jInvalids2, hash64(seq, did)), 
																	 distribute(rolled_lnames, hash64(seq, did)), 
																	 left.seq=right.seq and left.did=right.did, 
																	 addLnames(LEFT,RIGHT), left outer, LOCAL);

#IF(onThor)
	rolled_ssn_addr_lname := rolled_ssn_addr_lname_thor;
#ELSE
	rolled_ssn_addr_lname := rolled_ssn_addr_lname_roxie;
#END

iid_constants.layout_outx addADL(rolled_ssn_addr le, key_ADL_Risk_Table_v4 ri) := transform
	// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[iid_constants.posEquifaxRestriction]=iid_constants.sFalse and
												DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse and
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.combo,
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.en,
												~isFCRA and DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse => ri.tn,
												ri.eq);  // default to the EQ version
	
	
	cat := trim(stringlib.stringtouppercase(ri.adl_category));		// only realtime data
	self.adlCategory := map(cat = 'DEAD' => '1 DEAD',
													 cat = 'NOISE' => '2 NOISE',
													 cat = 'H_MERGE' => '3 H_MERGE',
													 cat = 'C_MERGE' => '4 C_MERGE',
													 cat = 'INACTIVE' => '5 INACTIVE',
													 cat = 'AMBIG' => '6 AMBIG',
													 cat = 'NO_SSN' => '7 NO_SSN',
													 cat = 'CORE' => '8 CORE',
													 cat <> '' => '0 OTHER',
													 '0 NONE');	// this should never happen when populated
	self.address_history_summary.address_history_advo_college_hit := ri.college_address_in_history;
	self := le;
END;
ADLinfo_nonfcra_orig_roxie := join(rolled_ssn_addr_lname, risk_indicators.key_ADL_Risk_Table_v4, left.did != 0 and keyed(left.did=right.did), 
							addADL(LEFT,RIGHT), left outer, atmost(Riskwise.max_atmost), keep(1));	

ADLinfo_nonfcra_orig_thor := join(distribute(rolled_ssn_addr_lname, hash64(did)), 
							distribute(pull(risk_indicators.key_ADL_Risk_Table_v4(did<>0)), hash64(did)), 
							left.did != 0 and(left.did=right.did), 
							addADL(LEFT,RIGHT), left outer, atmost(Riskwise.max_atmost), keep(1), LOCAL);	
							
#IF(onThor)
	ADLinfo_nonfcra_orig := ADLinfo_nonfcra_orig_thor;
#ELSE
	ADLinfo_nonfcra_orig := ADLinfo_nonfcra_orig_roxie;
#END

ADLinfo_nonfcra := join(ADLinfo_nonfcra_orig, age_hist, left.did=right.did and left.seq = right.seq,
							transform(recordof(ADLinfo_nonfcra_orig), self.inferred_age := right.inferred_age_hist, 
																									 self.reported_dob := right.reported_dob_hist,
																									 self := LEFT), 
							 atmost(Riskwise.max_atmost), keep(1));	

iid_constants.layout_outx addADL_FCRA(rolled_ssn_addr le, risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered ri) := transform
	// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[iid_constants.posEquifaxRestriction]=iid_constants.sFalse and
												DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse and
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.combo,
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.en,
												~isFCRA and DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse => ri.tn,
												ri.eq);  // default to the EQ version
	

	
	cat := trim(stringlib.stringtouppercase(ri.adl_category));		// only realtime data
	self.adlCategory := map(cat = 'DEAD' => '1 DEAD',
													 cat = 'NOISE' => '2 NOISE',
													 cat = 'H_MERGE' => '3 H_MERGE',
													 cat = 'C_MERGE' => '4 C_MERGE',
													 cat = 'INACTIVE' => '5 INACTIVE',
													 cat = 'AMBIG' => '6 AMBIG',
													 cat = 'NO_SSN' => '7 NO_SSN',
													 cat = 'CORE' => '8 CORE',
													 cat <> '' => '0 OTHER',
													 '0 NONE');	// this should never happen when populated
	self.address_history_summary.address_history_advo_college_hit := ri.college_address_in_history;
	self := le;
END;

ADLinfo_fcra_orig_roxie := join(rolled_ssn_addr_lname, risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered, left.did != 0 and keyed(left.did=right.did), 
							addADL_FCRA(LEFT,RIGHT), left outer, atmost(Riskwise.max_atmost), keep(1));	
							
ADLinfo_fcra_orig_thor := join(distribute(rolled_ssn_addr_lname, hash64(did)), 
															 distribute(pull(risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered), hash64(did)), 
															 (left.did=right.did), 
							addADL_FCRA(LEFT,RIGHT), left outer, atmost(Riskwise.max_atmost), keep(1), LOCAL);								
							
#IF(onThor)
	ADLinfo_fcra_orig := ADLinfo_fcra_orig_thor;
#ELSE
	ADLinfo_fcra_orig := ADLinfo_fcra_orig_roxie;
#END

ADLinfo_fcra := join(ADLinfo_fcra_orig, age_hist, left.did=right.did and left.seq = right.seq,
							transform(recordof(ADLinfo_nonfcra_orig), self.inferred_age := right.inferred_age_hist, 
																									 self.reported_dob := right.reported_dob_hist,
																									 self := LEFT), 
							 atmost(Riskwise.max_atmost), keep(1));	

ADLinfo := if(isFCRA, ADLinfo_fcra, ADLinfo_nonfcra);

// Pull the header information and filter for unique and useable addresses
iid_header := UNGROUP(PROJECT(iid, TRANSFORM(layouts.layout_header_plus_hist_date, self.seq := left.seq, self.historydate := left.historydate, SELF := LEFT.h)));
iid_header_filtered := iid_header (dt_first_seen != 0, dt_last_seen != 0, prim_name[1..6] != 'PO BOX');
iid_header_clean := DEDUP(SORT(iid_header_filtered, seq, did, dt_first_seen, dt_last_seen, prim_range, prim_name, zip), seq, did, dt_first_seen, dt_last_seen, prim_range, prim_name, zip);
// Calculate the address stability
stabilityHistorical := Risk_Indicators.getAddrStabilityHist(iid_header_clean);

// Now join the calculated stability back with the original DID's.
ADLStability := JOIN(ADLinfo, stabilityHistorical, LEFT.did = RIGHT.did AND LEFT.seq=RIGHT.seq, TRANSFORM(iid_constants.layout_outx, SELF.mobility_indicator := (STRING)RIGHT.stability; SELF := LEFT), LEFT OUTER, LOOKUP);

iid_constants.layout_outx joinEm(iid le, ADLStability ri) := transform
	self.ssns_per_adl := ri.ssns_per_adl;
	self.ssns_per_adl_created_6months := ri.ssns_per_adl_created_6months;
	self.ssns_per_adl_seen_18months := ri.ssns_per_adl_seen_18months;
	self.addrs_per_adl := ri.addrs_per_adl;
	self.addrs_per_adl_created_6months := ri.addrs_per_adl_created_6months;
	self.addrs_last_5years := ri.addrs_last_5years;
	self.addrs_last_10years := ri.addrs_last_10years;
	self.addrs_last_15years := ri.addrs_last_15years;
	self.addrs_last30 := ri.addrs_last30;
	self.addrs_last90 := ri.addrs_last90;
	self.addrs_last12 := ri.addrs_last12;
	self.addrs_last24 := ri.addrs_last24;
	self.addrs_last36 := ri.addrs_last36;
	self.reported_dob := ri.reported_dob;
	self.inferred_age := ri.inferred_age;
	self.mobility_indicator := ri.mobility_indicator;
	self.last_from_did := ri.last_from_did;
	self.lnames_per_adl := ri.lnames_per_adl;
	self.lnames_per_adl30 := ri.lnames_per_adl30;	
	self.lnames_per_adl90 := ri.lnames_per_adl90;
	self.lnames_per_adl180 := ri.lnames_per_adl180;
	self.lnames_per_adl12 := ri.lnames_per_adl12;
	self.lnames_per_adl24 := ri.lnames_per_adl24;
	self.lnames_per_adl36 := ri.lnames_per_adl36;
	self.lnames_per_adl60 := ri.lnames_per_adl60;
	self.newest_lname_dt_first_seen := ri.newest_lname_dt_first_seen;
	self.invalid_ssns_per_adl := if(BSversion>2, ri.invalid_ssns_per_adl, 0);
	self.invalid_ssns_per_adl_created_6months := if(BSversion>2, ri.invalid_ssns_per_adl_created_6months, 0);
	self.invalid_addrs_per_adl := if(BSversion>2, ri.invalid_addrs_per_adl, 0); 
	self.invalid_addrs_per_adl_created_6months := if(BSversion>2, ri.invalid_addrs_per_adl_created_6months, 0);
	self.dl_addrs_per_adl := if(BSversion>2, ri.dl_addrs_per_adl, 0);
	self.vo_addrs_per_adl := if(BSversion>2, ri.vo_addrs_per_adl, 0);
	self.pl_addrs_per_adl := if(BSversion>2, ri.pl_addrs_per_adl, 0);
	self.adlcategory := ri.adlcategory;
	self.address_history_summary.address_history_advo_college_hit := ri.address_history_summary.address_history_advo_college_hit ;
	self := le;
END;

velocityOut := group(sort(join(iid, ADLStability, left.seq=right.seq and left.did=right.did, joinEm(left,right), left outer, lookup),seq,did),seq,did);	// join back to multiple IID records

// output(iid, named('iid'));
// output(addresses_deduped, named('addresses_deduped'));
// output(counts_per_address, named('counts_per_address'));
// output(addr_counts_by_seq_did, named('addr_counts_by_seq_did'));
// output(age_hist, named('age_hist'));
// output(ADLinfo_nonfcra_orig, named('ADLinfo_nonfcra_orig'));
// output(ADLinfo_nonfcra, named('ADLinfo_nonfcra'));
RETURN velocityOut;

END;