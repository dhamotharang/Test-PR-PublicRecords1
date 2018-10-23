import _Control, risk_indicators, gong, riskwise, ut, header, doxie, mdr, drivers, FCRA, gateway;
onThor := _Control.Environment.OnThor;

export get_IID_Best_Flags (GROUPED DATASET(risk_indicators.layout_output) iid_input,  
															unsigned1 glb, 
															unsigned1 dppa,
															boolean isFCRA,
															string datarestriction, 
															string datapermission, 
															integer bsversion,
															unsigned8 BSOptions) := FUNCTION

// a few of the functions in here need the input in layout_output instead of layout_outx
// iid_input := project(iid, transform(risk_indicators.layout_output, self := left));

dk := choosen(if(isFCRA, doxie.Key_FCRA_max_dt_last_seen, doxie.key_max_dt_last_seen), 1);
header_build_date := (unsigned3) ((string) dk[1].max_date_last_seen)[1..6] : global;
require2ele := false;
isUtility := true; // turn off the utility searching in this function, don't need it for the couple counters we need here
runSSNCodes := false;
exactmatchlevel := risk_indicators.iid_constants.default_ExactMatchLevel;
lastseenthreshold := risk_indicators.iid_constants.oneyear;

dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa, isFCRA);

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

slim_addr_rec add_header_by_address(risk_indicators.layout_output le, Doxie.Key_Header_Address rt) := transform
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
		
Header_Address_Key := if(isFCRA, Doxie.Key_FCRA_Header_Address, Doxie.Key_Header_Address);

// Risk_Indicators.getPhoneAddrVelocity has branch of code to handle prior to 50, but this function will only be called for shell 52 and higher, so we have removed that branch here
header_by_address_roxie := join(iid_input, Header_Address_Key,	
															left.prim_name!='' and left.z5!='' and
															keyed(left.prim_name=right.prim_name)/* and keyed(left.st=right.st)*/ and
															keyed(left.z5=right.zip) and keyed(right.prim_range=left.prim_range) and
															keyed(left.sec_range=right.sec_range) and
															left.predir=right.predir and left.postdir=right.postdir and			
															RIGHT.dt_first_seen < left.historydate and  // check date,
															
															// check permissions
															right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
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

header_by_address_thor_addr := join(distribute(iid_input(prim_name!='' and z5!=''), hash64(prim_name,z5,prim_range,sec_range)), 
															distribute(pull(Header_Address_Key), hash64(prim_name,zip,prim_range,sec_range)),	
															(left.prim_name=right.prim_name)/* and (left.st=right.st)*/ and
															(left.z5=right.zip) and (right.prim_range=left.prim_range) and
															(left.sec_range=right.sec_range) and
															left.predir=right.predir and left.postdir=right.postdir and			
															RIGHT.dt_first_seen < left.historydate and  // check date,
															// check permissions
															right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
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
																		keep(2000), LOCAL);
header_by_address_thor := header_by_address_thor_addr + PROJECT(iid_input(prim_name='' or z5=''), TRANSFORM(slim_addr_rec, SELF := LEFT, SELF := []));

#IF(onThor)
	header_by_address := header_by_address_thor;
#ELSE
	header_by_address := header_by_address_roxie;
#END

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

ssns_per_addr_counts_roxie := table(counts_per_ssn, {seq, did, 
															ssns_per_addr := count(group, _ssns_per_addr>0),
															ssns_per_addr_current := count(group, _ssns_per_addr_current>0),
															ssns_per_addr_created_6months := count(group, _ssns_per_addr_created_6months>0)}, 
															seq, did, few);
															
ssns_per_addr_counts_thor := table(distribute(counts_per_ssn, hash64(seq,did)), {seq, did, 
															ssns_per_addr := count(group, _ssns_per_addr>0),
															ssns_per_addr_current := count(group, _ssns_per_addr_current>0),
															ssns_per_addr_created_6months := count(group, _ssns_per_addr_created_6months>0)}, 
															seq, did, local);
									
#IF(onThor)
	ssns_per_addr_counts := ssns_per_addr_counts_thor;
#ELSE
	ssns_per_addr_counts := ssns_per_addr_counts_roxie;
#END

// ADL per address counts
counts_per_adl_roxie := table(header_by_address, {seq, did, DID_from_srch, historydate,
															_adls_per_addr := count(group, adls_per_addr>0),
															_adls_per_addr_current := count(group, adls_per_addr_current>0),
															_adls_per_addr_created_6months := count(group, adls_per_addr_created_6months>0),
															}, seq, did, DID_from_srch, historydate, few);									

counts_per_adl_thor := table(distribute(header_by_address, hash64(seq, did)), {seq, did, DID_from_srch, historydate,
															_adls_per_addr := count(group, adls_per_addr>0),
															_adls_per_addr_current := count(group, adls_per_addr_current>0),
															_adls_per_addr_created_6months := count(group, adls_per_addr_created_6months>0),
															}, seq, did, DID_from_srch, historydate, local);	
                              
#IF(onThor)
	counts_per_adl := counts_per_adl_thor;
#ELSE
	counts_per_adl := counts_per_adl_roxie;
#END

adls_per_addr_counts_roxie := table(counts_per_adl, {seq, did, 
															adls_per_addr := count(group, _adls_per_addr>0),
															adls_per_addr_current := count(group, _adls_per_addr_current>0),
															adls_per_addr_created_6months := count(group, _adls_per_addr_created_6months>0)}, 
															seq, did, few);
															
adls_per_addr_counts_thor := table(distribute(counts_per_adl, hash64(seq,did)), {seq, did, 
															adls_per_addr := count(group, _adls_per_addr>0),
															adls_per_addr_current := count(group, _adls_per_addr_current>0),
															adls_per_addr_created_6months := count(group, _adls_per_addr_created_6months>0)}, 
															seq, did, local);

#IF(onThor)
	adls_per_addr_counts := adls_per_addr_counts_thor;
#ELSE
	adls_per_addr_counts := adls_per_addr_counts_roxie;
#END

with_ssn_per_addr_counts := join(iid_input, ssns_per_addr_counts, left.seq=right.seq and left.did=right.did, 
		transform(risk_indicators.layout_output, 
			self.ssns_per_addr := risk_indicators.iid_constants.capVelocity(right.ssns_per_addr); 
			self.ssns_per_addr_current := risk_indicators.iid_constants.capVelocity(right.ssns_per_addr_current); 
			self.ssns_per_addr_created_6months := risk_indicators.iid_constants.capVelocity(right.ssns_per_addr_created_6months);
			self := left), left outer);

with_adls_per_addr_counts := join(with_ssn_per_addr_counts, adls_per_addr_counts, left.seq=right.seq and left.did=right.did, 
		transform(risk_indicators.layout_output, 
			self.adls_per_addr := risk_indicators.iid_constants.capVelocity(right.adls_per_addr); 
			self.adls_per_addr_current := risk_indicators.iid_constants.capVelocity(right.adls_per_addr_current); 
			self.adls_per_addr_created_6months := risk_indicators.iid_constants.capVelocity(right.adls_per_addr_created_6months);
			self := left), left outer);

phone_counts_per_best_addr := Risk_Indicators.iid_getAddressInfo(iid_input, glb, isFCRA, require2ele, bsversion, isUtility,
ExactMatchLevel, LastSeenThreshold, BSOptions);
											
with_best_address_counts := join(with_adls_per_addr_counts, phone_counts_per_best_addr,	left.seq=right.seq,
		transform(risk_indicators.layout_output, 
			self.phones_per_addr := right.phones_per_addr;
			self.phones_per_addr_current := right.phones_per_addr_current;
			self.phones_per_addr_created_6months := right.phones_per_addr_created_6months;
			self := left), left outer, keep(1));
										

// Now that we have the velocity counters per address, let's get the SSN counts and flags

// for optimization, set bsoptions := 0 and bsversion := 40 for this function call
best_ssn_flags := risk_indicators.iid_getSSNFlags(iid_input, dppa, glb, isFCRA, runSSNCodes, 
											ExactMatchLevel, DataRestriction, BSversion, BSOptions, DataPermission );

with_best_ssn_flags := join(with_best_address_counts, best_ssn_flags, left.seq=right.seq,
		transform(risk_indicators.layout_output,
							
								self.deceasedDate := right.deceaseddate;
								self.decsflag := right.decsflag;
								self.socsdobflag := if(right.PWsocsdobflag='2', '3', right.socsdobflag);  // if randomized ssn, set socsdobflag=3
								self.socsvalflag := map(right.socsvalflag='3' => '7',
																				right.socsvalflag='2' => '6',
																				right.pwsocsvalflag);
								self.addrs_per_ssn := right.addrs_per_ssn;
								self.addrs_per_ssn_created_6months := right.addrs_per_ssn_created_6months;
								self.adls_per_ssn_seen_18months := right.adls_per_ssn_seen_18months;
								self.adls_per_ssn_created_6months := right.adls_per_ssn_created_6months;
								
								self := left), left outer, keep(1));
							
// now get the phone flags							
runAreaCodeSplitSearch := false;

best_zip_flags := risk_indicators.iid_getZipFlags(iid_input);
best_phone_flags := risk_indicators.iid_getPhoneAddrFlags(best_zip_flags, isFCRA, runAreaCodeSplitSearch, bsversion);

with_best_phone_flags := join(with_best_ssn_flags, best_phone_flags, left.seq=right.seq,
		transform(risk_indicators.layout_output,
			self.hriskphoneflag := right.hriskphoneflag;
			
			self.hphonetypeflag := map(right.hriskphoneflag='5' => 'D', // set disconnected status first, if not disconnected, set to hphonetypeflag 
																	right.hphonetypeflag in ['4','6','7','8','9','B'] => 'U',  // for anthing in this set, make the hphonetypeflag = 'U'
																	right.hphonetypeflag ='5' => '4',  // set all 5 to value of 4 instead so values go from 0-4
																	right.hphonetypeflag ) ;   
			
			self.hphonevalflag := right.hphonevalflag;
			self.pwphonezipflag := right.pwphonezipflag;
			self := left), left outer, keep(1));
		

// don't call the gateways for this best phone info
gateways := dataset([],Gateway.Layouts.Config);
allowcellphones := false;  // not going to targus gateway for this function anyway, so keep this turned off
companyId := '';

best_phoneInfo := risk_indicators.iid_getPhoneInfo(group(with_best_phone_flags, seq), gateways, dppa, glb, isfcra, require2ele, bsversion,
		allowcellphones, exactmatchlevel, lastseenthreshold, bsoptions, companyID);  // leave the rest of the parameters as the defaults

with_best_phoneInfo := best_phoneInfo;
		
// with_best_phoneInfo := join(with_best_phone_flags, best_phoneInfo, left.seq=right.seq,
	// transform(risk_indicators.layout_output,
		// self.adls_per_phone_current  := right.adls_per_phone_current;
		// self.adls_per_phone_created_6months := right.adls_per_phone_created_6months;
		// self := left), left outer, keep(1));
	

// now calculate the hriskaddrflag on the best address.  
// first need the zipclass
bestaddr_zipclass := risk_indicators.iid_getZipFlags(iid_input);

layout_output_tmp := record
	risk_indicators.layout_output;
	string key_sec_range := '';
end;							 
							 
layout_output_tmp flagroll(layout_output_tmp l, layout_output_tmp r) := transform
	self	:= if(trim(l.sec_range) != '' and 
			trim(l.key_sec_range) = '' and
			trim(r.key_sec_range) != '', 
		r, l);	
END;

layout_output_tmp bestaddr_highrisk_transform(risk_indicators.layout_output l,risk_indicators.key_HRI_Address_To_SIC r) := transform
	// override the address type to a P if the high risk database finds a match to 'UNITED STATES POSTAL SERVICE'													
	addr_type := if(trim(r.sic_code)='2265', 'P', l.addr_type);	
	self.hriskaddrflag := MAP(trim(l.zipclass) = 'P' => '1',
														trim(l.zipclass) = 'U' => '2',
														trim(l.zipclass) = 'M' or trim(addr_type) = 'M' => '3',
														trim(l.prim_name)='' OR trim(l.z5)='' => '5',
														trim(r.sic_code)='' => '0',	 		 
														//trying to keep the cmra hits	
														trim(r.sic_code)<>'' and r.sic_code in risk_indicators.iid_constants.setCRMA => '4',		
														//trying to not keep the lift from cmra that aren't cmra that become rc 14	
														trim(r.sic_code)<>'' and trim(l.sec_range) = trim(r.sec_range) => '4',
														'0');
	self.key_sec_range := r.sec_range;
	self := l;
END;

with_bestaddr_hriskaddrflag_tmp_roxie := if (isFCRA,
			join(bestaddr_zipclass,risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA,
				left.z5!='' and left.prim_name != '' and
				keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and 
				keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
				keyed(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,bestaddr_highrisk_transform(left,right),left outer,
				ATMOST(keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
					  keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
						keyed(ut.NNEQ(left.sec_range, right.sec_range)), RiskWise.max_atmost), keep(100)),
			join(bestaddr_zipclass,risk_indicators.key_HRI_Address_To_SIC,
				left.z5!='' and left.prim_name != '' and
				keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and 
				keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
				keyed(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,bestaddr_highrisk_transform(left,right),left outer,
				ATMOST(keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
					  keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
						keyed(ut.NNEQ(left.sec_range, right.sec_range)), RiskWise.max_atmost), keep(100)));

with_bestaddr_hriskaddrflag_tmp_thor := if (isFCRA,
			join(distribute(bestaddr_zipclass, hash64(z5, prim_name, addr_suffix, predir, postdir, prim_range)),
				distribute(pull(risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA), hash64(z5, prim_name, suffix, predir, postdir, prim_range)),
				left.z5!='' and left.prim_name != '' and
				(left.z5=right.z5) and (left.prim_name=right.prim_name) and (left.addr_suffix=right.suffix) and 
				(left.predir=right.predir) and (left.postdir=right.postdir) and (left.prim_range=right.prim_range) and 
				(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,bestaddr_highrisk_transform(left,right),left outer,
				ATMOST(left.z5=right.z5 and left.prim_name=right.prim_name and left.addr_suffix=right.suffix and
					  left.predir=right.predir and left.postdir=right.postdir and left.prim_range=right.prim_range, RiskWise.max_atmost), keep(100), LOCAL),
			join(distribute(bestaddr_zipclass, hash64(z5, prim_name, addr_suffix, predir, postdir, prim_range)),
				distribute(pull(risk_indicators.key_HRI_Address_To_SIC), hash64(z5, prim_name, suffix, predir, postdir, prim_range)),
				left.z5!='' and left.prim_name != '' and
				(left.z5=right.z5) and (left.prim_name=right.prim_name) and (left.addr_suffix=right.suffix) and 
				(left.predir=right.predir) and (left.postdir=right.postdir) and (left.prim_range=right.prim_range) and 
				(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,bestaddr_highrisk_transform(left,right),left outer,
				ATMOST(left.z5=right.z5 and left.prim_name=right.prim_name and left.addr_suffix=right.suffix and
					  left.predir=right.predir and left.postdir=right.postdir and left.prim_range=right.prim_range, RiskWise.max_atmost), keep(100), LOCAL));

#IF(onThor)
	with_bestaddr_hriskaddrflag_tmp := group(sort(with_bestaddr_hriskaddrflag_tmp_thor, seq, LOCAL), seq, LOCAL);
#ELSE
	with_bestaddr_hriskaddrflag_tmp := with_bestaddr_hriskaddrflag_tmp_roxie;
#END

with_bestaddr_hriskaddrflag_tmp_sorted := sort(with_bestaddr_hriskaddrflag_tmp, seq, -hriskaddrflag);						
with_bestaddr_hriskaddrflag_rolled := rollup(with_bestaddr_hriskaddrflag_tmp_sorted, left.seq = right.seq, flagroll(left,right));

// join the hriskaddrflag to the with_best_phoneinfo dataset
with_bestaddr_hriskaddrflag := join(with_best_phoneInfo, with_bestaddr_hriskaddrflag_rolled, left.seq=right.seq,
	transform(risk_indicators.layout_output, 
		self.hriskaddrflag := right.hriskaddrflag,
		self := left), left outer, keep(1));

// output(iid_input, named('iid_input'));
// output(with_best_address_counts, named('with_best_address_counts'));
// output(best_ssn_flags, named('best_ssn_flags'));
// output(best_phone_flags, named('best_phone_flags'));
// output(best_phoneInfo, named('best_phoneInfo'));
// output(bestaddr_zipclass, named('bestaddr_zipclass'));
// output(with_bestaddr_hriskaddrflag_tmp, named('with_bestaddr_hriskaddrflag_tmp'));
// output(with_bestaddr_hriskaddrflag_rolled, named('with_bestaddr_hriskaddrflag_rolled'));


return with_bestaddr_hriskaddrflag;

END;