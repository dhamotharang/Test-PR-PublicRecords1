// *******************************************************************************************************************************************************
// ********  IF YOU CHANGE LOGIC IN THIS FUNCTION, ALSO MODIFY THE CORRESPONDING CODE WITHIN Risk_Indicators.get_IID_Best_Flags ATTRIBUTE ****************
// *******************************************************************************************************************************************************

import _Control, risk_indicators, gong, riskwise, ut, header, doxie, mdr, drivers, FCRA;
onThor := _Control.Environment.OnThor;

export getPhoneADDRVelocity (GROUPED DATASET(risk_indicators.iid_constants.layout_outx) iid, boolean isUtility=false, unsigned1 dppa,
															boolean isFCRA=false,
															string50 DataRestriction=iid_constants.default_DataRestriction, 
															integer bsversion,
															unsigned8 BSOptions) := FUNCTION

dk := choosen(if(isFCRA, doxie.Key_FCRA_max_dt_last_seen, doxie.key_max_dt_last_seen), 1);

header_build_date := (unsigned3) ((string) dk[1].max_date_last_seen)[1..6] : global;

dppa_ok := iid_constants.dppa_ok(dppa, isFCRA);

dedup_by_did := dedup(sort(iid, seq, did), seq, did);

risk_indicators.iid_constants.layout_outx addPhone(iid le, gong.Key_History_did ri) := transform
	self.phone_from_did := ri.phone10;
	self.phones_per_adl := if(trim(ri.phone10)!='',1,0);
	myGetDate := iid_constants.myGetDate(le.historydate);
	self.phones_per_adl_created_6months := if(trim(ri.phone10)!='' and ut.DaysApart(myGetDate,ri.dt_first_seen) < 183, 1, 0);
	self.gong_ADL_dt_first_seen := ri.dt_first_seen;
  self.gong_ADL_dt_last_seen := ri.dt_last_seen;
	self := le;
	self := [];
END;
gong_history_did_key := if(isFCRA, gong.Key_FCRA_History_did, gong.key_history_did);

gong_by_did_roxie := join(dedup_by_did, gong_history_did_key,
											left.did != 0 and keyed(left.did=right.l_did) and
											// check date
											((unsigned)RIGHT.dt_first_seen <= (unsigned)iid_constants.myGetDate(left.historydate)) AND
											(RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))), 
											addPhone(LEFT,RIGHT), left outer, atmost(left.did=right.l_did, Riskwise.max_atmost), keep(100));

gong_by_did_thor_did := join(distribute(dedup_by_did(did!=0), hash64(did)), 
											distribute(pull(gong_history_did_key(did!=0)), hash64(did)),
											(left.did=right.l_did) and
											// check date
											((unsigned)RIGHT.dt_first_seen <= (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
											(RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))), 
											addPhone(LEFT,RIGHT), left outer, atmost(left.did=right.l_did, Riskwise.max_atmost), keep(100), LOCAL);
											
gong_by_did_thor := sort(gong_by_did_thor_did + dedup_by_did(did=0), seq, did);											
											
#IF(onThor)
	gong_by_did := gong_by_did_thor;
#ELSE
	gong_by_did := gong_by_did_roxie;
#END

risk_indicators.iid_constants.layout_outx count_phones_per_did(risk_indicators.iid_constants.layout_outx le, risk_indicators.iid_constants.layout_outx rt) := transform
	self.phones_per_adl := le.phones_per_adl+IF(le.phone_from_did=rt.phone_from_did ,0, rt.phones_per_adl);
	self.phones_per_adl_created_6months := le.phones_per_adl_created_6months + if(le.phone_from_did=rt.phone_from_did and le.phones_per_adl_created_6months>0, 0, rt.phones_per_adl_created_6months);
	self.gong_ADL_dt_first_seen := (string)ut.Min2((unsigned)le.gong_ADL_dt_first_seen, (unsigned)rt.gong_ADL_dt_first_seen);
	self.gong_ADL_dt_last_seen := (string)MAX ((unsigned)le.gong_ADL_dt_last_seen, (unsigned)rt.gong_ADL_dt_last_seen);
	self := rt;
end;
rolled_phones_per_did := rollup(sort(group(gong_by_did, seq, did), seq, phone_from_did, -phones_per_adl_created_6months), true, count_phones_per_did(left,right));



//// Address //////////////
// slim down the layout for computing the address velocity.  
// we get a lot of records from this join, let's keep it as slim as we can to conserve memory
slim_addr_rec := record
	UNSIGNED4 seq;
	UNSIGNED6 did;
	unsigned3 historydate;
	// for counting SSNs per address
	string9 ssn_from_addr;
	integer ssns_per_addr;
	integer ssns_per_addr_current;
	integer ssns_per_addr_created_6months;
	// for counting ADLs per address
	UNSIGNED6 DID_from_srch;
	integer adls_per_addr;
	integer adls_per_addr_current;
	integer adls_per_addr_created_6months;
end;

slim_addr_rec add_header_by_address(risk_indicators.iid_constants.layout_outx le, Doxie.Key_Header_Address rt) := transform
  head_first_seen := ((string) rt.dt_first_seen)[1..6];	
	self.DID_from_srch := rt.did;
	self.ssn_from_addr := rt.ssn;	
	self.adls_per_addr := if(rt.did!=0,1,0);
	self.adls_per_addr_current := if(rt.did!=0 and rt.dt_last_seen>=header_build_date, 1, 0);
	
	myGetDate := iid_constants.myGetDate(le.historydate);
	self.adls_per_addr_created_6months := if(rt.did!=0 and ut.DaysApart(myGetDate, head_first_seen+'31') < 183, 1, 0);
	self.ssns_per_addr := if(trim(rt.ssn)!='',1,0);
	self.ssns_per_addr_current := if(trim(rt.ssn)!='' and rt.dt_last_seen>=header_build_date,1,0);
	self.ssns_per_addr_created_6months := if(trim(rt.ssn) != '' and ut.DaysApart(myGetDate, head_first_seen+'31') < 183, 1, 0);
	self := le;
end;	

header_address_key := if(isFCRA, Doxie.Key_FCRA_Header_Address, Doxie.Key_Header_Address);

header_by_address_pre50_roxie := join(dedup_by_did, header_address_key,	
															left.prim_name!='' and left.z5!='' and
															keyed(left.prim_name=right.prim_name)/* and keyed(left.st=right.st)*/ and
															keyed(left.z5=right.zip) and keyed(right.prim_range=left.prim_range) and
															left.predir=right.predir and left.postdir=right.postdir and
															left.sec_range=right.sec_range and								// should this be ut.NNEQ?
															RIGHT.dt_first_seen < left.historydate and  // check date,
																 
															// check permissions
															right.src not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
															(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
															(~mdr.Source_is_DPPA(RIGHT.src) OR
																(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
															~risk_indicators.iid_constants.filtered_source(right.src, right.st) and
															(~IsFCRA OR ~FCRA.Restricted_Header_Src (RIGHT.src, '')) and
															(~isFCRA or 
																((right.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR (right.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR right.src not in ['BA','L2'])
															),
														add_header_by_address(left,right), left outer, 
														
														atmost(left.prim_name=right.prim_name 
																		and left.z5=right.zip
																		and right.prim_range=left.prim_range, 1000), 
																		keep(500));
																		
header_by_address_pre50_thor_addr := join(distribute(dedup_by_did(prim_name!='' and z5!=''), hash64(prim_name, z5, prim_range)), 
															distribute(pull(header_address_key), hash64(prim_name, zip, prim_range)),
															(left.prim_name=right.prim_name)/* and keyed(left.st=right.st)*/ and
															(left.z5=right.zip) and (right.prim_range=left.prim_range) and
															left.predir=right.predir and left.postdir=right.postdir and
															left.sec_range=right.sec_range and								// should this be ut.NNEQ?
															
															RIGHT.dt_first_seen < left.historydate and  // check date,
															// check permissions
															right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
															(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
															(~mdr.Source_is_DPPA(RIGHT.src) OR
																(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
															~risk_indicators.iid_constants.filtered_source(right.src, right.st) and
															(~IsFCRA OR ~FCRA.Restricted_Header_Src (RIGHT.src, '')) and
															(~isFCRA or 
																((right.src='BA' and FCRA.bankrupt_is_ok(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR (right.src='L2' and FCRA.lien_is_ok(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR right.src not in ['BA','L2'])
															),
														add_header_by_address(left,right), left outer,
														atmost(left.prim_name=right.prim_name 
																		and left.z5=right.zip
																		and right.prim_range=left.prim_range, 1000), keep(500), local);																		

header_by_address_pre50_thor := header_by_address_pre50_thor_addr + project(dedup_by_did(prim_name='' or z5=''), TRANSFORM(slim_addr_rec, self := left));

#IF(onThor)
	header_by_address_pre50 := header_by_address_pre50_thor;
#ELSE
	header_by_address_pre50 := header_by_address_pre50_roxie;
#END
																		
header_by_address_50_roxie := join(dedup_by_did, header_address_key,	
															left.prim_name!='' and left.z5!='' and
															keyed(left.prim_name=right.prim_name)/* and keyed(left.st=right.st)*/ and
															keyed(left.z5=right.zip) and keyed(right.prim_range=left.prim_range) and
															keyed(left.sec_range=right.sec_range) and
															left.predir=right.predir and left.postdir=right.postdir and			
															RIGHT.dt_first_seen < left.historydate and  // check date,
															
															// check permissions
															right.src not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
															(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
															(~mdr.Source_is_DPPA(RIGHT.src) OR
																(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
															~risk_indicators.iid_constants.filtered_source(right.src, right.st) and
															(~IsFCRA OR ~FCRA.Restricted_Header_Src (RIGHT.src, '')) and
															(~isFCRA or 
																((right.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR (right.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR right.src not in ['BA','L2'])
															),
														add_header_by_address(left,right), left outer, 
														atmost(left.prim_name=right.prim_name 
																		and left.z5=right.zip
																		and right.prim_range=left.prim_range 
																		and left.sec_range=right.sec_range, 2001), 
																		keep(2000));

header_by_address_50_thor_addr := join(distribute(dedup_by_did(prim_name!='' and z5!=''), hash64(prim_name, z5, prim_range)), 
															distribute(pull(header_address_key), hash64(prim_name, zip, prim_range)),															
															(left.prim_name=right.prim_name)/* and keyed(left.st=right.st)*/ and
															(left.z5=right.zip) and (right.prim_range=left.prim_range) and
															left.predir=right.predir and left.postdir=right.postdir and
															left.sec_range=right.sec_range and								// should this be ut.NNEQ?
															
															RIGHT.dt_first_seen < left.historydate and  // check date,
															// check permissions
															right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
															(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
															(~mdr.Source_is_DPPA(RIGHT.src) OR
																(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
															~risk_indicators.iid_constants.filtered_source(right.src, right.st) and
															(~IsFCRA OR ~FCRA.Restricted_Header_Src (RIGHT.src, '')) and
															(~isFCRA or 
																((right.src='BA' and FCRA.bankrupt_is_ok(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR (right.src='L2' and FCRA.lien_is_ok(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
																OR right.src not in ['BA','L2'])
															),
														add_header_by_address(left,right), left outer,
														atmost(left.prim_name=right.prim_name 
																		and left.z5=right.zip
																		and right.prim_range=left.prim_range 
																		and left.sec_range=right.sec_range, 2001), keep(2000), local);							

header_by_address_50_thor := header_by_address_50_thor_addr + project(dedup_by_did(prim_name='' or z5=''), TRANSFORM(slim_addr_rec, self := left));

#IF(onThor)
	header_by_address_50 := header_by_address_50_thor;
#ELSE
	header_by_address_50 := header_by_address_50_roxie;
#END

// temporary, leave the header_by_address alone for versions prior to 50.  
// per bug 164071, Difference in the 2 joins is the atmost condition and the keep() 									
header_by_address := if(bsversion >=50, header_by_address_50, header_by_address_pre50);
						
// SSN per Address counts
counts_per_ssn_roxie := table(header_by_address, {seq, did, ssn_from_addr,
															_ssns_per_addr := count(group, ssns_per_addr>0),
															_ssns_per_addr_current := count(group, ssns_per_addr_current>0),
															_ssns_per_addr_created_6months := count(group, ssns_per_addr_created_6months>0)
															}, seq, did, ssn_from_addr, few);									
counts_per_ssn_thor := table(distribute(header_by_address, hash64(seq,did)), {seq, did, ssn_from_addr,
															_ssns_per_addr := count(group, ssns_per_addr>0),
															_ssns_per_addr_current := count(group, ssns_per_addr_current>0),
															_ssns_per_addr_created_6months := count(group, ssns_per_addr_created_6months>0)
															}, seq, did, ssn_from_addr, local);		

#IF(onThor)
	counts_per_ssn := counts_per_ssn_thor;
#ELSE
	counts_per_ssn := counts_per_ssn_roxie;
#END

ssns_per_addr_counts := table(counts_per_ssn, {seq, did, 
															ssns_per_addr := count(group, _ssns_per_addr>0),
															ssns_per_addr_current := count(group, _ssns_per_addr_current>0),
															ssns_per_addr_multiple_use := count(group, _ssns_per_addr>1),
															ssns_per_addr_created_6months := count(group, _ssns_per_addr_created_6months>0)}, 
															seq, did, few);

// rolled_ssn_counts := project(ssn_counts, transform(iid_constants.layout_outx, self := left, self := []));
									

// ADL per address counts
counts_per_adl_roxie := table(header_by_address, {seq, did, DID_from_srch, historydate,
															_adls_per_addr := count(group, adls_per_addr>0),
															_adls_per_addr_current := count(group, adls_per_addr_current>0),
															_adls_per_addr_created_6months := count(group, adls_per_addr_created_6months>0),
															SuspciousADLsperAddr := 0  // initialize this variable to 0
															}, seq, did, DID_from_srch, historydate, few);									

counts_per_adl_thor := table(distribute(header_by_address, hash64(seq, did)), {seq, did, DID_from_srch, historydate,
															_adls_per_addr := count(group, adls_per_addr>0),
															_adls_per_addr_current := count(group, adls_per_addr_current>0),
															_adls_per_addr_created_6months := count(group, adls_per_addr_created_6months>0),
															SuspciousADLsperAddr := 0  // initialize this variable to 0
															}, seq, did, DID_from_srch, historydate, local);				
															
#IF(onThor)
	counts_per_adl := counts_per_adl_thor;
#ELSE
	counts_per_adl := counts_per_adl_roxie;
#END

adls_from_address := project(counts_per_adl(DID_from_srch<>0), 
	transform(risk_indicators.Boca_Shell_Fraud.layout_identities_input, self.did := left.DID_from_srch;
							 self.historydate := left.historydate;));
							 
suspicious_identities_hist := risk_indicators.Boca_Shell_Fraud.suspicious_identities_function_hist(adls_from_address);

// if realtime production mode, search just the suspicious Identities key instead
suspicious_identities_realtime := join(adls_from_address, Risk_Indicators.Key_Suspicious_Identities,
	keyed(left.did=right.did),
		transform(risk_indicators.Boca_Shell_Fraud.layout_identities_output,
			self.did := left.did;
			self.historydate := left.historydate;
			self := right), atmost(riskwise.max_atmost), keep(1));
			
// check the first record in the batch to determine if this a realtime transaction or an archive test
// if the record is default_history_date or same month as today's date, run production_realtime_mode
production_realtime_mode := adls_from_address[1].historydate=risk_indicators.iid_constants.default_history_date
														or adls_from_address[1].historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]);	
														suspicious_identities := if(production_realtime_mode, suspicious_identities_realtime, suspicious_identities_hist);


with_suspcious_ids := join(counts_per_adl, suspicious_identities, 
															left.DID_from_srch=right.did, 
															transform(recordof(counts_per_adl),
															self.SuspciousADLsperAddr := if(right.did<>0, 1, 0);
															self := left), left outer, atmost(riskwise.max_atmost), keep(1));

// only do the suspicious identity searching in fraudpoint
isFraudpoint :=  (BSOptions & iid_constants.BSOptions.IncludeFraudVelocity) > 0;
address_velocity_raw := if(isFCRA, counts_per_adl, if(isFraudpoint or bsversion>=41, with_suspcious_ids, counts_per_adl));

adls_per_addr_counts_roxie := table(address_velocity_raw, {seq, did, 
															suspicious_adls_per_addr_created_6months  := count(group, SuspciousADLsperAddr > 0 and _adls_per_addr_created_6months>0),
															adls_per_addr := count(group, _adls_per_addr>0),
															adls_per_addr_current := count(group, _adls_per_addr_current>0),
															adls_per_addr_multiple_use := count(group, _adls_per_addr>1),
															adls_per_addr_created_6months := count(group, _adls_per_addr_created_6months>0)}, 
															seq, did, few);

adls_per_addr_counts_thor := table(distribute(address_velocity_raw, hash64(seq,did)), {seq, did, 
															suspicious_adls_per_addr_created_6months  := count(group, SuspciousADLsperAddr > 0 and _adls_per_addr_created_6months>0),
															adls_per_addr := count(group, _adls_per_addr>0),
															adls_per_addr_current := count(group, _adls_per_addr_current>0),
															adls_per_addr_multiple_use := count(group, _adls_per_addr>1),
															adls_per_addr_created_6months := count(group, _adls_per_addr_created_6months>0)}, 
															seq, did, local);

#IF(onThor)
	adls_per_addr_counts := adls_per_addr_counts_thor;
#ELSE
	adls_per_addr_counts := adls_per_addr_counts_roxie;
#END

// rolled_adl_counts := project(ssn_counts_by_seq_did, transform(iid_constants.layout_outx, self := left, self := []));

risk_indicators.iid_constants.layout_outx getPhoneCounts(iid le, rolled_phones_per_did ri) := TRANSFORM
		self.phones_per_adl := iid_constants.capVelocity(ri.phones_per_adl);
		self.phones_per_adl_created_6months := iid_constants.capVelocity(ri.phones_per_adl_created_6months);
		self.gong_ADL_dt_first_seen := ri.gong_ADL_dt_first_seen;
		self.gong_ADL_dt_last_seen := ri.gong_ADL_dt_last_seen;	
		self := le;
END;
									
with_phone_counts_roxie := join(iid, rolled_phones_per_did, left.seq=right.seq and left.did=right.did, 
	getPhoneCounts(LEFT, RIGHT), left outer);

with_phone_counts_thor := join(distribute(iid, hash64(seq, did)),
															 distribute(rolled_phones_per_did, hash64(seq, did)),
															 left.seq=right.seq and left.did=right.did, 
															 getPhoneCounts(LEFT, RIGHT), left outer,
															 local);
															 
#IF(onThor)
	with_phone_counts := with_phone_counts_thor;
#ELSE
	with_phone_counts := with_phone_counts_roxie;
#END

risk_indicators.iid_constants.layout_outx getSSNPerAddrCounts(with_phone_counts le, ssns_per_addr_counts ri)  := TRANSFORM
		self.ssns_per_addr := iid_constants.capVelocity(ri.ssns_per_addr); 
		self.ssns_per_addr_current := iid_constants.capVelocity(ri.ssns_per_addr_current); 
		self.ssns_per_addr_multiple_use := iid_constants.capVelocity(ri.ssns_per_addr_multiple_use);
		self.ssns_per_addr_created_6months := iid_constants.capVelocity(ri.ssns_per_addr_created_6months);
		self := le;
END;

with_ssn_per_addr_counts_roxie := join(with_phone_counts, ssns_per_addr_counts, left.seq=right.seq and left.did=right.did, 
	getSSNPerAddrCounts(LEFT, RIGHT), left outer);
	
with_ssn_per_addr_counts_thor := join(with_phone_counts, distribute(ssns_per_addr_counts, hash64(seq,did)), left.seq=right.seq and left.did=right.did, 
	getSSNPerAddrCounts(LEFT, RIGHT), left outer, local);	
		
#IF(onThor)
	with_ssn_per_addr_counts := with_ssn_per_addr_counts_thor;
#ELSE
	with_ssn_per_addr_counts := with_ssn_per_addr_counts_roxie;
#END

risk_indicators.iid_constants.layout_outx getADLsPerAddrCounts(with_ssn_per_addr_counts le, adls_per_addr_counts ri) := TRANSFORM
		self.suspicious_adls_per_addr_created_6months := iid_constants.capVelocity(ri.suspicious_adls_per_addr_created_6months);
		self.adls_per_addr := iid_constants.capVelocity(ri.adls_per_addr); 
		self.adls_per_addr_current := iid_constants.capVelocity(ri.adls_per_addr_current); 
		self.adls_per_addr_multiple_use := iid_constants.capVelocity(ri.adls_per_addr_multiple_use); 
		self.adls_per_addr_created_6months := iid_constants.capVelocity(ri.adls_per_addr_created_6months);
		self := le;
END;

with_adls_per_addr_counts_roxie := join(with_ssn_per_addr_counts, adls_per_addr_counts, left.seq=right.seq and left.did=right.did, 
	getADLsPerAddrCounts(LEFT, RIGHT), left outer);

with_adls_per_addr_counts_thor := join(with_ssn_per_addr_counts, distribute(adls_per_addr_counts, hash64(seq, did)), left.seq=right.seq and left.did=right.did, 
	getADLsPerAddrCounts(LEFT, RIGHT), left outer, local);

#IF(onThor)
	with_adls_per_addr_counts := with_adls_per_addr_counts_thor;
#ELSE
	with_adls_per_addr_counts := with_adls_per_addr_counts_roxie;
#END

with_adls_per_addr_counts_grouped_roxie := group(sort(with_adls_per_addr_counts, seq, did), seq, did);
with_adls_per_addr_counts_grouped_thor := group(sort(with_adls_per_addr_counts, seq, did, local), seq, did, local);

#IF(onThor)
	with_adls_per_addr_counts_grouped := with_adls_per_addr_counts_grouped_thor;
#ELSE
	with_adls_per_addr_counts_grouped := with_adls_per_addr_counts_grouped_roxie;
#END

RETURN with_adls_per_addr_counts_grouped;
END;