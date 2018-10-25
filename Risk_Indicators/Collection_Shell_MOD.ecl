import _Control, doxie, doxie_files, risk_indicators, riskwise, watchdog, ut,CriminalRecords_Services, 
	dx_BestRecords;

onThor := _Control.Environment.OnThor;

export Collection_Shell_MOD := module

export max_addresses := 100;  // this is what BS_Services is using
export cap4Byte := 9998;  // use 9998 because 9999 is a default value for distance not calculated... 

// common function for calculating the distance between 2 addresses
export calculate_distance(string lat1, string long1, string lat2, string long2) := function
	distance_temp := if(lat1='' or lat2='', '',
											(string)round(ut.ll_dist((REAL)Lat1,(REAL)Long1,
																								(REAL)Lat2,(REAL)Long2)) );
	distance := if((unsigned)distance_temp > 9999, '9999', distance_temp);
	return distance;
end;

// common function for calculating months between 2 dates
export months_apart(unsigned3 some_yearmonth, unsigned3 some_yearmonth2) := function
		days := ut.DaysApart((string)some_yearmonth + '01', (string)some_yearmonth2 + '01' );
		days_in_a_month := 30.5;
		calculated_months := days/days_in_a_month;
		months := if(some_yearmonth=0 or some_yearmonth2=0, 0, calculated_months);
		return round(months);
end;

// layout of flags about the input record	
shared input_flag_rec := RECORD
   string1 input_fnamepop;
   string1 input_lnamepop;
   string1 input_addrpop;
   string1 input_ssnlength;
   string1 input_dobpop;
   string1 input_hphnpop;
   string1 adl_addr;
   string1 wf_hphn;
   string1 adl_ssn;
   string1 adl_dob;
  END;

// layout of the EDA search results
shared layout_es := RECORD
   string10 phone10;
   string2 nxx_type;
   string6 phone_first_seen;
   string6 phone_last_seen;
   string1 name_match_flag;
   unsigned6 p_did;
  END;

// layout of the skiptrace results	
shared layout_se := RECORD
   unsigned6 did;
   string10 phone10;
   string2 nxx_type;
   string6 phone_first_seen;
   string6 phone_last_seen;
   string1 name_match_flag;
   unsigned6 p_did;
  END;

// common layout between expanded skip trace and progressive address search
shared layout_sx_ap := RECORD
   string4 distance_to_applicant;
   unsigned6 did;
   string10 phone10;
   string2 nxx_type;
   string6 phone_first_seen;
   string6 phone_last_seen;
   unsigned6 p_did;
  END;
	
// layout of phones plus results	
shared layout_pp := RECORD
   string4 distance_to_applicant;
   unsigned6 did;
   string10 phone10;
   string2 nxx_type;
   string1 active_phone;
   string1 listing_type;
   string6 phone_first_seen;
   string6 phone_last_seen;
   unsigned6 p_did;
  END;

// shared layout between spouse, parents, closest relatives and co-resident results
shared layout_sp_md_cl_cr := RECORD
   unsigned6 did;
   unsigned3 hdr_dt_first_seen;
   unsigned3 hdr_dt_last_seen;
   string1 bankruptcy_sourced;
   string1 property_sourced;
   string1 criminal_sourced;
   string4 distance_to_applicant;
   unsigned6 p_did;
   string10 phone10;
   string2 nxx_type;
   string6 phone_first_seen;
   string6 phone_last_seen;
   string4 timesincesharedaddress;
   string4 lengthsharedaddress;
  END;

// layout of neighbors results
shared layout_ne := RECORD
   unsigned6 did;
   unsigned3 hdr_dt_first_seen;
   unsigned3 hdr_dt_last_seen;
   string1 bankruptcy_sourced;
   string1 property_sourced;
   string1 criminal_sourced;
   string4 distance_to_applicant;
   string10 phone10;
   string2 nxx_type;
   string6 phone_first_seen;
   string6 phone_last_seen;
  END;

// layout of results from people at work
shared layout_wk := RECORD
   string4 distance_to_applicant;
   unsigned6 did;
   string10 phone10;
   string2 nxx_type;
   string1 active_phone;
   string6 phone_first_seen;
   string6 phone_last_seen;
   string2 source;
   string10 company_status;
  END;

// layout of just the fields they are interested in from each address in the address history
export addr_common := RECORD
   unsigned3 dt_first_seen;
   unsigned3 dt_last_seen;
   string1 addr_type;
   string4 distance_moved;
  END;

shared addr_common___1 := RECORD
   unsigned3 dt_first_seen;
   unsigned3 dt_last_seen;
   string1 addr_type;
  END;

// definition of just the collection shell fields
export collection_shell_layout := RECORD
  string20 acctno;
  input_flag_rec input_flags;
  layout_ES es;
  layout_SE se1;
  layout_SE se2;
  layout_SE se3;
  layout_SE se4;
  layout_SX_AP ap1;
  layout_SX_AP ap2;
  layout_SX_AP ap3;
  layout_SX_AP sx1;
  layout_SX_AP sx2;
  layout_SP_MD_CL_CR sp;
  layout_SP_MD_CL_CR md1;
  layout_SP_MD_CL_CR md2;
  layout_SP_MD_CL_CR cl1;
  layout_SP_MD_CL_CR cl2;
  layout_SP_MD_CL_CR cl3;
  layout_SP_MD_CL_CR cr;
  layout_NE ne1;
  layout_NE ne2;
  layout_NE ne3;
	layout_PP pp1;
  layout_PP pp2;
  layout_PP pp3;
  layout_wk wk;
  addr_common addr1;
  addr_common addr2;
  addr_common addr3;
  addr_common addr4;
  addr_common addr5;
  addr_common___1 addr6;
  string1 incarceration_flag;
	string3 contactability_score := '';
end;

// full collection shell results includes collection shell layout + the full bocashell
export collection_shell_layout_full := record
	collection_shell_layout cs;
	risk_indicators.Layout_Boca_Shell;
end;

export collection_shell_layout_edina := record
	collection_shell_layout - acctno cs;
	risk_indicators.Layout_Boca_Shell_edina;
end;

export collection_shell_layout_edina_v4 := record
	collection_shell_layout - acctno cs;
	risk_indicators.Layout_Boca_Shell_edina_v4;
end;

export collection_shell_layout_edina_v41 := record
	collection_shell_layout - acctno cs;
	risk_indicators.Layout_Boca_Shell_edina_v41;
end;

export best_rec := record
	unsigned6 seq := 0;
	unsigned6    did := 0;
	qstring10    phone := '';
	qstring9     ssn := '';
	integer4     dob := 0;
	qstring5     title := '';
	qstring20    fname := '';
	qstring20    mname := '';
	qstring20    lname := '';
	qstring5     name_suffix := '';
	qstring10    prim_range := '';
	string2      predir := '';
	qstring28    prim_name := '';
	qstring4     suffix := '';
	string2      postdir := '';
	qstring10    unit_desig := '';
	qstring8     sec_range := '';
	qstring25    city_name := '';
	string2      st := '';
	qstring5     zip := '';
	qstring4     zip4 := '';
	string65 			street_addr := '';
	STRING10 lat := '';
	STRING11 long := '';
	STRING1  addr_type := '';
	STRING4  addr_status := '';
	string3 county := '';
	string7 geo_blk := '';
end;

export getBestCleaned(dataset(doxie.layout_references) deduped_dids,string50 DataRestriction, integer GLB_Purpose, boolean clean_address=true)  := function
	// permitted if not specifically restricted
	experian_permitted := DataRestriction[risk_indicators.iid_constants.posExperianRestriction]<>risk_indicators.iid_constants.sTrue;
	
	best_rec get_best_layout(deduped_dids l, dx_BestRecords.layout_best r) := transform
		self.did := l.did;
		// need the lat and long, so we need to clean the best address
		street_addr  := Risk_Indicators.MOD_AddressClean.street_address('',R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
		cleaned_addr := if(clean_address, Risk_Indicators.MOD_AddressClean.clean_addr(street_addr, r.city_name, r.st, r.zip), '');
		self.street_addr := street_addr;
		self.lat := cleaned_addr[146..155];
		self.long := cleaned_addr[156..166];
		self.addr_type := cleaned_addr[139];
		self.addr_status := cleaned_addr[179..182];
		self.county := cleaned_addr[143..145];
		self.geo_blk := cleaned_addr[171..177];
		self := r;
	END;

	wdog_perm := dx_BestRecords.fn_get_perm_type(glb_flag := ut.glb_ok(GLB_Purpose), 
		utility_flag := false, 
		filter_exp_flag := ~experian_permitted, 
		pre_glb_flag := (DataRestriction[23] = '1'));

	best_recs_roxie := dx_BestRecords.append(deduped_dids, did, wdog_perm, on_thor := false);
	best_recs_thor := dx_BestRecords.append(deduped_dids, did, wdog_perm, on_thor := true);

	best_data_roxie := project(best_recs_roxie, get_best_layout(left, left._best));
	best_data_thor := project(best_recs_thor, get_best_layout(left, left._best), local);
										
  #IF(onThor)
		best_data := best_data_thor;
	#ELSE
		best_data := best_data_roxie;
	#END
  
	return best_data;

end;

// function which flags a person as being possibly incarcerated
export getIncarceration(dataset(doxie.layout_references) dids) := function

	incarc_temp := record
		unsigned6 did;
		string60	offender_key;
		string1 incarceration_flag;
		// recordof(doxie_files.Key_Punishment) punishment;  // for debugging only
	end;

	offender_keys := JOIN(dids, doxie_files.Key_Offenders(), 
											left.did<>0 and 
											KEYED(LEFT.did = RIGHT.sdid),
										TRANSFORM(incarc_temp, SELF.offender_key := RIGHT.offender_key, SELF := LEFT, self := []), atmost(riskwise.max_atmost), keep(500));

	// Find out possible incarcerations
	did_ofndrKeys := DEDUP(SORT(offender_keys, did, offender_key),did, offender_key);
	// output(did_ofndrKeys, named('did_ofndrKeys'));
		
	with_punishment := JOIN(did_ofndrKeys, doxie_files.Key_Punishment(), 
										KEYED(LEFT.offender_key = RIGHT.ok), 
										atmost(riskwise.max_atmost), keep(500), left outer);
	// OUTPUT(with_punishment, NAMED('Results'));

	CriminalRecords_Services.MAC_Incarceration_Filter(with_punishment, with_punishment_flagged)
	possible_incarceration := project(dedup(sort(with_punishment_flagged, did, -incarceration_flag), did), incarc_temp);
	
	return possible_incarceration;

end;


end;
