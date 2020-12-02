//In this attribute FLCrash data is consolidated for eCrash build.

IMPORT PromoteSupers, ut, Std;
// ###########################################################################
//                        FL Crash Accidents
//                        Join FLCrash_ss & FLCrash2v
// ###########################################################################
	dFLCrashSS := DISTRIBUTE(basefile_flcrash_ss(lname + cname + prim_name <> ''), HASH32(accident_nbr, vin));
	dFLCrash2v := DISTRIBUTE(basefile_flcrash2v, HASH32(accident_nbr, vehicle_id_nbr));
	
  aid_layouts.ConsolidationBase tFLCrashSS2v(dFLCrashSS L, dFLCrash2v R) := TRANSFORM
		SELF.ultid := L.ultid;
		SELF.orgid := L.orgid;
		SELF.seleid := L.seleid;
		SELF.proxid := L.proxid;
		SELF.powid := L.powid;
		SELF.empid := L.empid;
		SELF.dotid := L.dotid;
		SELF.ultscore := L.ultscore;
		SELF.orgscore := L.orgscore;
		SELF.selescore := L.selescore;
		SELF.proxscore := L.proxscore;
		SELF.powscore := L.powscore;
		SELF.empscore := L.empscore;
		SELF.dotscore := L.dotscore;
		SELF.ultweight := L.ultweight;
		SELF.orgweight := L.orgweight;
		SELF.seleweight := L.seleweight;
		SELF.proxweight := L.proxweight;
		SELF.powweight := L.powweight;
		SELF.empweight := L.empweight;
		SELF.dotweight := L.dotweight;
		SELF.dt_first_seen := L.accident_date;
		SELF.dt_last_seen := L.accident_date;
		SELF.report_code := 'FA';
		SELF.report_category := 'Auto Report';
		SELF.report_code_desc := 'Auto Accident';
		SELF.vehicle_incident_id	:= '';
		SELF.vehicle_status	:= MAP(L.accident_nbr = R.accident_nbr AND 
															 L.vin = R. vehicle_id_nbr AND 
															 R.vina_series + R.vina_model + R.reference_number +
															 R.vina_make + R.vina_body_style + R.series_description +
															 R.car_series + R.car_body_style + R.car_cid + R.car_cylinders <> '' => 'V',
															 '');
		SELF.accident_location := '';
		SELF.accident_street := '';
		SELF.accident_cross_street	:= '';
		SELF.jurisdiction := 'FLORIDA HP';
		SELF.jurisdiction_state := 'FL';
		SELF.jurisdiction_nbr := '';
		SELF.image_hash := '';
		SELF.airbags_deploy := '';
		SELF.dob := '';
		SELF.driver_license_nbr := IF(REGEXFIND('[0-9]', L.driver_license_nbr), L.driver_license_nbr, '');
		SELF.carrier_name := R.ins_company_name;
		SELF.client_type_id := '';
		SELF.vehicle_incident_city	:= '';
		SELF.vehicle_incident_st := 'FL';
		SELF.Policy_num := R.ins_policy_nbr; 
		SELF.Policy_Effective_Date := ''; 
		SELF.Policy_Expiration_Date	:= '';
		SELF.Report_Has_Coversheet := '0';
		SELF.date_vendor_last_reported := L.accident_date;
		SELF := L;
		SELF := R;
		SELF := []; 
  END;
	jFLCrashSS_2v := JOIN(dFLCrashSS, dFLCrash2v,
									      LEFT.accident_nbr = RIGHT.accident_nbr AND 
									      LEFT.vin = RIGHT.vehicle_id_nbr,
									      tFLCrashSS2v(LEFT, RIGHT), LEFT OUTER, LOCAL);

// ###########################################################################
//                        FL Crash Accidents
//             Join FLCrash_ss, FLCrash2v with FLCrash4
// ###########################################################################				
	//Get Carrier_info from driver file 98385
	dFLCrashSS2v := DISTRIBUTE(jFLCrashSS_2v, HASH32(accident_nbr));
	dFLCrash4 := DISTRIBUTE(BaseFile_FLCrash4(accident_nbr <> ''), HASH32(accident_nbr));
	
	aid_layouts.ConsolidationBase tFLCrashSS2v4(dFLCrashSS2v L, dFLCrash4 R) := TRANSFORM
		SELF.carrier_name := IF(l.carrier_name <> '', l.carrier_name, R.ins_company_name);
		SELF.Policy_num := IF(l.Policy_num <> '', l.Policy_num, R.ins_policy_nbr);
		SELF := L;
	END;
	jFLCrashSS2v_4 := JOIN(dFLCrashSS2v, dFLCrash4,
												 LEFT.accident_nbr = RIGHT.accident_nbr AND 
												 TRIM(LEFT.record_type, LEFT, RIGHT) IN ['Vehicle Driver', 'Driver'] AND 
												 ut.nneq(TRIM(LEFT.driver_license_nbr, LEFT, RIGHT), TRIM(RIGHT.driver_dl_nbr, LEFT, RIGHT)) AND 
												 LEFT.fname = RIGHT.fname AND 
												 LEFT.lname = RIGHT.lname,
												 tFLCrashSS2v4(LEFT, RIGHT), LEFT OUTER, LOCAL);	
	dFLCrashSS2v4 := DISTRIBUTE(jFLCrashSS2v_4);		 
	uFLCrashSS2v4	:= DEDUP(dFLCrashSS2v4, ALL, LOCAL);

// ###########################################################################
//                        FL Crash Accidents
//             Join FLCrash_ss, FLCrash2v, FLCrash4 with FLCrash0
// ###########################################################################		
	distFLCrashSS2v4 := DISTRIBUTE(uFLCrashSS2v4, HASH32(accident_nbr));
	dFLCrash0 := DISTRIBUTE(basefile_flcrash0(accident_nbr <> ''), HASH32(accident_nbr));
	
	aid_layouts.ConsolidationBase tFLCrashSS2v40(uFLCrashSS2v4 L, dFLCrash0 R) := TRANSFORM
		SELF.vehicle_incident_city := STD.Str.ToUpperCase(IF(L.accident_nbr = R.accident_nbr, R.city_town_name, ''));
		SELF := L;
	END;
	jFLCrashSS2v4_0 := JOIN(distFLCrashSS2v4, dFLCrash0,
	                        LEFT.accident_nbr = RIGHT.accident_nbr,
							            tFLCrashSS2v40(LEFT, RIGHT), LEFT OUTER, LOCAL);
	FLCrashConsolidationBase := DISTRIBUTE(jFLCrashSS2v4_0, RANDOM());

  PromoteSupers.MAC_SF_BuildProcess(FLCrashConsolidationBase, '~thor_data400::base::flcrash_Consolidation', NewFLCrashConsolidationBase, 2, , TRUE);

EXPORT FLCrash_BuildConsolidatedBaseFile := NewFLCrashConsolidationBase;