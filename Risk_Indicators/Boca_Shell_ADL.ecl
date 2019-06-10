import _Control, riskwise, ut, STD, risk_indicators;
onThor := _Control.Environment.OnThor;

export Boca_Shell_ADL (GROUPED DATASET(risk_indicators.layout_output) iid, boolean isFCRA, unsigned1 dppa,
					string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction) := function

dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa, isFCRA);

risk_indicators.layout_output addADL(iid le, risk_indicators.key_ADL_Risk_Table_v4 ri) := transform
	// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[risk_indicators.iid_constants.posEquifaxRestriction]=risk_indicators.iid_constants.sFalse and
												DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse and
												((~isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse) or (isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]=risk_indicators.iid_constants.sFalse)) => ri.combo,
												((~isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse) or (isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]=risk_indicators.iid_constants.sFalse)) => ri.en,
												~isFCRA and DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse => ri.tn,
												ri.eq);  // default to the EQ version
	
	self.phones_per_adl := risk_indicators.iid_constants.capVelocity(ri.phone_ct);
	self.ssns_per_adl := risk_indicators.iid_constants.capVelocity(header_version.ssn_ct);
	self.addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.addr_ct);
	self.phones_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(ri.phone_ct_c6);
	self.ssns_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(header_version.ssn_ct_c6);
	self.ssns_per_adl_seen_18months := risk_indicators.iid_constants.capVelocity(header_version.ssn_ct_s18);
	self.addrs_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_c6);
	self.addrs_last_5years :=risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last5years);
	self.addrs_last_10years := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last10years);
	self.addrs_last_15years := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last15years);
	self.addrs_last30 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last30days);
	self.addrs_last90 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last90days);
	self.addrs_last12 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last1year);
	self.addrs_last24 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last2years);
	self.addrs_last36 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last3years);
	
	self.lnames_per_adl := risk_indicators.iid_constants.capVelocity(header_version.lname_ct);
	self.lnames_per_adl30 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct30);	
	self.lnames_per_adl90 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct90);
	self.lnames_per_adl180 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct180);
	self.lnames_per_adl12 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct12);
	self.lnames_per_adl24 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct24);
	self.lnames_per_adl36 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct36);
	self.lnames_per_adl60 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct60);
	self.last_from_did := if(risk_indicators.lnameScore(le.lname, header_version.newest_lname) >= 80, header_version.newest_lname2, header_version.newest_lname);
	self.newest_lname_dt_first_seen := header_version.newest_lname_dt_first_seen;
	self.mobility_indicator := (string)header_version.stability;

	reported_dob := if(dppa_ok or isFCRA, header_version.reported_dob, header_version.reported_dob_no_dppa);
	self.reported_dob := reported_dob;
	
	// because inferred age on file is pre-calculated at build time, 
	// update it with age as of runtime date if we have the reported dob on file
	age_today_from_reported_dob := risk_indicators.years_apart(risk_indicators.iid_constants.todaydate, reported_dob);
	inferred_age_on_file := if(dppa_ok or isFCRA, header_version.inferred_age, header_version.inferred_age_no_dppa);
	self.inferred_age := if(reported_dob > 0, age_today_from_reported_dob, inferred_age_on_file );
	
	cat := trim(stringlib.stringtouppercase(ri.adl_category));		// only realtime data
	self.adlCategory := risk_indicators.iid_constants.adlCategory(cat);
													 
	self.dl_addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.dl_addrs_per_adl);												 
	self.vo_addrs_per_adl :=risk_indicators.iid_constants.capVelocity(header_version.vo_addrs_per_adl);
	self.pl_addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.pl_addrs_per_adl);
	
	self.invalid_ssns_per_adl := risk_indicators.iid_constants.capVelocity(header_version.invalid_ssns_per_adl);
	self.invalid_ssns_per_adl_created_6months :=risk_indicators.iid_constants.capVelocity(header_version.invalid_ssns_per_adl_created_6months);
	self.invalid_addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.invalid_addrs_per_adl);
	self.invalid_addrs_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(header_version.invalid_addrs_per_adl_created_6months);
	
	self.address_history_summary.address_history_advo_college_hit := ri.college_address_in_history;
	
	self := le;
END;
ADLinfo_nonfcra_roxie := join(iid, risk_indicators.key_ADL_Risk_Table_v4, left.did != 0 and keyed(left.did=right.did), addADL(LEFT,RIGHT), left outer, 
								ATMOST(RiskWise.max_atmost), KEEP(1));
								
ADLinfo_nonfcra_thor := group(join(distribute(iid, hash64(did)), 
														 distribute(pull(risk_indicators.key_ADL_Risk_Table_v4), hash64(did)), 
														 left.did != 0 and (left.did=right.did), addADL(LEFT,RIGHT), left outer, 
								ATMOST(RiskWise.max_atmost), KEEP(1), LOCAL), seq, did);
								
#IF(onThor)
	ADLinfo_nonfcra := ADLinfo_nonfcra_thor;
#ELSE
	ADLinfo_nonfcra := ADLinfo_nonfcra_roxie;
#END

risk_indicators.layout_output addADL_FCRA(iid le, risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered ri) := transform
	// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[risk_indicators.iid_constants.posEquifaxRestriction]=risk_indicators.iid_constants.sFalse and
												DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse and
												((~isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse) or (isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]=risk_indicators.iid_constants.sFalse)) => ri.combo,
												((~isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse) or (isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]=risk_indicators.iid_constants.sFalse)) => ri.en,
												~isFCRA and DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse => ri.tn,
												ri.eq);  // default to the EQ version
	self.phones_per_adl := risk_indicators.iid_constants.capVelocity(ri.phone_ct);
	self.ssns_per_adl := risk_indicators.iid_constants.capVelocity(header_version.ssn_ct);
	self.addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.addr_ct);
	self.phones_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(ri.phone_ct_c6);
	self.ssns_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(header_version.ssn_ct_c6);
	self.ssns_per_adl_seen_18months :=risk_indicators.iid_constants.capVelocity(header_version.ssn_ct_s18);
	self.addrs_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_c6);
	self.addrs_last_5years := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last5years);
	self.addrs_last_10years := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last10years);
	self.addrs_last_15years := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last15years);
	self.addrs_last30 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last30days);
	self.addrs_last90 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last90days);
	self.addrs_last12 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last1year);
	self.addrs_last24 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last2years);
	self.addrs_last36 := risk_indicators.iid_constants.capVelocity(header_version.addr_ct_last3years);
	
	self.lnames_per_adl := risk_indicators.iid_constants.capVelocity(header_version.lname_ct);
	self.lnames_per_adl30 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct30);	
	self.lnames_per_adl90 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct90);
	self.lnames_per_adl180 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct180);
	self.lnames_per_adl12 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct12);
	self.lnames_per_adl24 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct24);
	self.lnames_per_adl36 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct36);
	self.lnames_per_adl60 := risk_indicators.iid_constants.capVelocity(header_version.lname_ct60);
	self.last_from_did := if(risk_indicators.lnameScore(le.lname, header_version.newest_lname) >= 80, header_version.newest_lname2, header_version.newest_lname);
	self.newest_lname_dt_first_seen := header_version.newest_lname_dt_first_seen;
	self.mobility_indicator := (string)header_version.stability;

	reported_dob := if(dppa_ok or isFCRA, header_version.reported_dob, header_version.reported_dob_no_dppa);
	self.reported_dob := reported_dob;
	
	// because inferred age on file is pre-calculated at build time, 
	// update it with age as of runtime date if we have the reported dob on file
	age_today_from_reported_dob := risk_indicators.years_apart(risk_indicators.iid_constants.todaydate, reported_dob);
	inferred_age_on_file := if(dppa_ok or isFCRA, header_version.inferred_age, header_version.inferred_age_no_dppa);
	self.inferred_age := if(reported_dob > 0, age_today_from_reported_dob, inferred_age_on_file );
	
	cat := trim(stringlib.stringtouppercase(ri.adl_category));		// only realtime data
	self.adlCategory := risk_indicators.iid_constants.adlCategory(cat);
													 
	self.dl_addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.dl_addrs_per_adl);												 
	self.vo_addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.vo_addrs_per_adl);
	self.pl_addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.pl_addrs_per_adl);
	
	self.invalid_ssns_per_adl :=risk_indicators.iid_constants.capVelocity(header_version.invalid_ssns_per_adl);
	self.invalid_ssns_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(header_version.invalid_ssns_per_adl_created_6months);
	self.invalid_addrs_per_adl := risk_indicators.iid_constants.capVelocity(header_version.invalid_addrs_per_adl);
	self.invalid_addrs_per_adl_created_6months := risk_indicators.iid_constants.capVelocity(header_version.invalid_addrs_per_adl_created_6months);
	
	self.address_history_summary.address_history_advo_college_hit := ri.college_address_in_history;
	
	self := le;
END;								

ADLinfo_fcra_roxie := join(iid, risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered, left.did != 0 and keyed(left.did=right.did), addADL_FCRA(LEFT,RIGHT), left outer, 
								ATMOST(RiskWise.max_atmost), KEEP(1));

ADLinfo_fcra_thor := group(join(distribute(iid, hash64(did)),
													distribute(pull(risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered), hash64(did)),
													left.did != 0 and (left.did=right.did), addADL_FCRA(LEFT,RIGHT), left outer, 
								ATMOST(RiskWise.max_atmost), KEEP(1), LOCAL),seq,did);

#IF(onThor)
	ADLinfo_fcra := ADLinfo_fcra_thor;
#ELSE
	ADLinfo_fcra := ADLinfo_fcra_roxie;
#END

ADLinfo := if(isFCRA, ADLinfo_fcra, ADLinfo_nonfcra);						
								
return group(sort(ADLinfo, seq), seq);

END;