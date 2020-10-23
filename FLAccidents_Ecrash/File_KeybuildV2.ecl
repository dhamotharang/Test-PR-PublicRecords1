IMPORT FLAccidents, ut, STD;

EXPORT File_KeybuildV2 := MODULE

// ###########################################################################
//                        FL Crash Accidents
//                        Join FLCrash_ss & FLCrash2v
// ###########################################################################
	dFLCrashSS := DISTRIBUTE(FLAccidents.basefile_flcrash_ss(lname + cname + prim_name <> ''), HASH32(accident_nbr, vin));
	dFLCrash2v := DISTRIBUTE(FLAccidents.basefile_flcrash2v, HASH32(accident_nbr, vehicle_id_nbr));
	
  Layout_eCrash.Consolidation_AgencyOri tFLCrashSS2v(dFLCrashSS L, dFLCrash2v R) := TRANSFORM
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
		//SELF.IdField :=	R.IdField;
		//Appriss Integration
		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec);
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
	dFLCrash4 := DISTRIBUTE(FLAccidents.BaseFile_FLCrash4(accident_nbr <> ''), HASH32(accident_nbr));
	
	Layout_eCrash.Consolidation_AgencyOri tFLCrashSS2v4(dFLCrashSS2v L, dFLCrash4 R) := TRANSFORM
		SELF.carrier_name := IF(l.carrier_name <> '', l.carrier_name, R.ins_company_name);
		SELF.Policy_num := IF(l.Policy_num <> '', l.Policy_num, R.ins_policy_nbr);
		//Appriss Integration
		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec);
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
	dFLCrash0 := DISTRIBUTE(FLAccidents.basefile_flcrash0(accident_nbr <> ''), HASH32(accident_nbr));
	
	Layout_eCrash.Consolidation_AgencyOri tFLCrashSS2v40(uFLCrashSS2v4 L, dFLCrash0 R) := TRANSFORM
		SELF.vehicle_incident_city := STD.Str.ToUpperCase(IF(L.accident_nbr = R.accident_nbr, R.city_town_name, ''));
		//Appriss Integration
		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec); 	
		SELF := L;
	END;
	jFLCrashSS2v4_0 := JOIN(distFLCrashSS2v4, dFLCrash0,
	                        LEFT.accident_nbr = RIGHT.accident_nbr,
							            tFLCrashSS2v40(LEFT, RIGHT), LEFT OUTER, LOCAL);
	dFLCrash := DISTRIBUTE(jFLCrashSS2v4_0, RANDOM());

//###########################################################################
//                       National Accidents
// ########################################################################### 
	NtlAccidents := FLAccidents.BaseFile_NtlAccidents_Alpharetta;

	Layout_eCrash.Consolidation_AgencyOri tNtlAccidents(NtlAccidents L) := TRANSFORM
		SELF.did := IF(L.did = 0, '000000000000', INTFORMAT(L.did, 12, 1));	
		SELF.accident_nbr := (STRING40)((UNSIGNED6)L.vehicle_incident_id + 10000000000);
		SELF.accident_date := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
		SELF.b_did := IF(L.bdid = 0, '', INTFORMAT(L.bdid, 12, 1)); 
		SELF.cname := STD.Str.ToUpperCase(L.business_name);
		SELF.addr_suffix := L.suffix;
		SELF.zip := L.zip5;
		SELF.record_type := CASE(STD.Str.ToUpperCase(TRIM(L.party_type, LEFT, RIGHT)),
														 'OWNER' => 'Property Owner',
														 'DRIVER' => 'Vehicle Driver',
														 'VEHICLE OWNER' => 'Property Owner',
                             'VEHICLE DRIVER' => 'Vehicle Driver',
                             '');
		SELF.driver_license_nbr := IF(REGEXFIND('[0-9]', L.pty_drivers_license), L.pty_drivers_license, '');
		SELF.dlnbr_st := L.pty_drivers_license_st;
		SELF.tag_nbr := IF(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1, L.tag, '');	
		SELF.tagnbr_st := IF(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1, L.tag_state, '');
		SELF.vin := L.vehvin;
		SELF.accident_location := MAP(L.cross_street <> '' AND L.cross_street <> 'N/A' => L.street + ' & ' + L.cross_street, L.street);
		SELF.accident_street := L.street;
		SELF.accident_cross_street := MAP(L.cross_street <> 'N/A' => L.cross_street, '');
		SELF.jurisdiction := TRIM(L.edit_agency_name, LEFT, RIGHT);
		SELF.jurisdiction_state := L.state_abbr;
		SELF.st := IF(l.st = '', SELF.jurisdiction_state, l.st);
		SELF.jurisdiction_nbr := L.agency_id;
		SELF.image_hash := L.pdf_image_hash;
		SELF.airbags_deploy := L.airbags_deploy;
		SELF.dob := L.dob;
		SELF.Policy_num := L.policy_nbr; 
		SELF.Policy_Effective_Date := ''; 
		SELF.Policy_Expiration_Date := '';
		SELF.Report_Has_Coversheet := IF(L.PDF_IMAGE_HASH <> '' OR L.tif_image_hash <> '', '1', '0');
		SELF.other_vin_indicator := '';
		SELF.vehicle_year := L.vehYear;	
		SELF.vehicle_make := L.vehMake;
		SELF.make_description := IF(L.make_description <> '', L.make_description, L.vehMake);
		SELF.model_description := IF(L.model_description <> '', L.model_description, L.vehModel);
		SELF.vehicle_incident_city := STD.Str.ToUpperCase(L.inc_city);
		SELF.vehicle_incident_st := STD.Str.ToUpperCase(L.state_abbr);
		SELF.point_of_impact := L.impact_location;
		SELF.towed := L.Car_Towed;
		SELF.Impact_Location := L.Impact_Location;
		SELF.carrier_name := L.legal_name;
		SELF.client_type_id := L.client_type_id;
		SELF.vehicle_unit_number := '';
		SELF.next_street := '';
		SELF.work_type_id := ''; 
		SELF.ssn := ''; 
		SELF.cru_order_id := L.order_id; 
		SELF.cru_sequence_nbr :=L.sequence_nbr; 
		SELF.date_vendor_last_reported := L.last_changed;
		SELF.creation_date := ''; 
		SELF.report_type_id := L.service_id;
		SELF.tif_image_hash := L.tif_image_hash; 
		SELF.acct_nbr := L.acct_nbr; 
		SELF.addl_report_number := L.REPORT_NBR;
		//Appriss Integration
		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.agency_id := L.agency_id; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec);	 	
		SELF := L;
		SELF := [];
	END;
	pNtlAccidents := PROJECT(NtlAccidents, tNtlAccidents(LEFT));

// ###########################################################################
//                National Accidents Inquiries (CRU Inquiries)
// ###########################################################################
	NtlAccidentsInquiry := File_CRU_inquiries;
	
	Layout_eCrash.Consolidation_AgencyOri tNtlAccidentsInquiry(NtlAccidentsInquiry L, UNSIGNED1 cnt) := TRANSFORM
		SELF.report_code := 'I'+ L.report_code;
		SELF.report_category := L.report_category;
		SELF.report_code_desc := L.report_code_desc;
		SELF.accident_nbr := IF(L.vehicle_incident_id[1..3] = 'OID',
														(STRING40)((UNSIGNED6)L.vehicle_incident_id[4..] + 100000000000),
														(STRING40)((UNSIGNED6)L.vehicle_incident_id + 10000000000));
		SELF.accident_date := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
		SELF.accident_location := MAP(L.cross_street <> '' AND L.cross_street <> 'N/A' => L.street + ' & ' + L.cross_street, L.street);
		SELF.accident_street := L.street;
		SELF.accident_cross_street := MAP(L.cross_street <> 'N/A' => L.cross_street, '');
		SELF.jurisdiction := STD.Str.ToUpperCase(TRIM(L.EDIT_AGENCY_NAME, LEFT, RIGHT));
		SELF.jurisdiction_state := STD.Str.ToUpperCase(L.State);
		SELF.st := IF(L.st = '', SELF.jurisdiction_state, L.st);
		SELF.jurisdiction_nbr := L.AGENCY_ID;
		SELF.cru_jurisdiction := STD.Str.ToUpperCase(TRIM(L.EDIT_AGENCY_NAME, LEFT, RIGHT));
		SELF.cru_jurisdiction_nbr := L.AGENCY_ID + '_' + L.STATE_NBR; 
		SELF.vehicle_incident_city := STD.Str.ToUpperCase(L.city);
		SELF.vehicle_incident_st := STD.Str.ToUpperCase(L.state);
		SELF.did := CHOOSE(cnt, IF(L.did = 0, '000000000000', INTFORMAT(L.did, 12, 1)), '000000000000', '000000000000');	
		SELF.prim_range := CHOOSE(cnt, L.prim_range, '', ''); 
		SELF.predir := CHOOSE(cnt, L.predir, '', '');
		SELF.prim_name := CHOOSE(cnt, L.prim_name, '', '');
		SELF.postdir := CHOOSE(cnt, L.postdir, '', '');
		SELF.unit_desig := CHOOSE(cnt, L.unit_desig, '', '');
		SELF.sec_range := CHOOSE(cnt, L.sec_range, '', '');
		SELF.v_city_name := CHOOSE(cnt, L.v_city_name, '', '');
		SELF.zip4 := CHOOSE(cnt, L.zip4, '', '');
		SELF.addr_suffix := CHOOSE(cnt, L.suffix, '', '');
		SELF.zip := CHOOSE(cnt, L.zip5, '', '');
		SELF.record_type :=	CHOOSE(cnt, 'Vehicle Driver', '', '');
		SELF.driver_license_nbr := CHOOSE(cnt, IF(REGEXFIND('[0-9]', L.drivers_license), L.drivers_license, ''), '', '');
		SELF.dlnbr_st := CHOOSE(cnt, L.drivers_license_st, '', '');
		SELF.tag_nbr := CHOOSE(cnt, L.otag, '', '');
		SELF.tagnbr_st := CHOOSE(cnt, L.otag_state, '', '');
		SELF.vin :=	CHOOSE(cnt, L.vin, '', '');
		SELF.title := CHOOSE(cnt, L.title, L.title2, L.title3); 
		SELF.name_suffix := CHOOSE(cnt, L.name_suffix, L.name_suffix2, L.name_suffix3); 
		SELF.fname :=	CHOOSE(cnt, L.fname, L.fname2, L.fname3); 
		SELF.lname := CHOOSE(cnt, L.lname, L.lname2, L.lname3); 
		SELF.mname :=	CHOOSE(cnt, L.mname, L.mname2, L.mname3);
		t_orig_fname2 := IF(TRIM(L.orig_fname2 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_fname2); 
		t_orig_lname2 := IF(TRIM(L.orig_lname2 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_lname2);
		f_orig_lname2 := IF(REGEXFIND('[0-9]', t_orig_lname2) = true, '', t_orig_lname2); 
		t_orig_fname3 := IF(TRIM(L.orig_fname3 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_fname3); 
		t_orig_lname3 := IF(TRIM(L.orig_lname3 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_lname3); 
		f_orig_lname3 := IF(REGEXFIND('[0-9]', t_orig_lname3) = TRUE, '', t_orig_lname3);
		SELF.orig_fname := CHOOSE(cnt, L.orig_fname, IF(TRIM(t_orig_fname2, LEFT, RIGHT) = '' AND TRIM(f_orig_lname2, LEFT, RIGHT) = '', SKIP, t_orig_fname2), IF(TRIM(t_orig_fname3, LEFT, RIGHT) ='' AND TRIM(f_orig_lname3, LEFT, RIGHT) ='',SKIP,t_orig_fname3)); 
		SELF.orig_lname := CHOOSE(cnt,L.orig_lname,f_orig_lname2, f_orig_lname3); 
		SELF.orig_mname := CHOOSE(cnt,L.orig_mname,L.orig_mname2, L.orig_mname3); 
		SELF.DOB :=	CHOOSE(cnt, L.DOB_1, '', '');
		SELF.vehicle_year := CHOOSE(cnt, L.Year, '', '');
		SELF.vehicle_make := CHOOSE(cnt, L.make, '', '');
		SELF.make_description := CHOOSE(cnt, IF(L.make_description <> '', L.make_description, L.Make), '', '');
		SELF.model_description := CHOOSE(cnt, IF(L.model_description <> '', L.model_description, L.Model), '', '');
		SELF.carrier_name := CHOOSE(cnt, L.legal_name, '', '');
		SELF.ssn :=	CHOOSE(cnt, L.ssn_1, '', '');
		SELF.vehicle_status := CHOOSE(cnt, L.vehicle_status, '', '');
		SELF.vehicle_seg := CHOOSE(cnt, L.vehicle_seg, '', '');
		SELF.vehicle_seg_type := CHOOSE(cnt, L.vehicle_seg_type, '', '');
		SELF.model_year := CHOOSE(cnt, L.model_year, '', '');
		SELF.body_style_code := CHOOSE(cnt, L.body_style_code, '', '');
		SELF.engine_size := CHOOSE(cnt, L.engine_size, '', '');
		SELF.fuel_code := CHOOSE(cnt, L.fuel_code, '', '');
		SELF.number_of_driving_wheels := CHOOSE(cnt, L.number_of_driving_wheels, '', '');
		SELF.steering_type := CHOOSE(cnt, L.steering_type, '', '');
		SELF.vina_series := CHOOSE(cnt, L.vina_series, '', '');
		SELF.vina_model := CHOOSE(cnt, L.vina_model, '', '');
		SELF.vina_make := CHOOSE(cnt, L.vina_make, '', '');
		SELF.vina_body_style := CHOOSE(cnt, L.vina_body_style, '', '');
		SELF.series_description := CHOOSE(cnt, L.series_description, '', '');
		SELF.car_cylinders := CHOOSE(cnt, L.car_cylinders, '', '');
		SELF.Report_Has_Coversheet := '0';
		SELF.cru_order_id := L.order_id; 
		SELF.cru_sequence_nbr := L.sequence_nbr; 
		SELF.date_vendor_last_reported := L.last_changed;
		SELF.creation_date := ''; 
		SELF.report_type_id := L.service_id;
		SELF.addl_report_number := L.REPORT_NBR;
		SELF.acct_nbr := L.acct_nbr; 
		SELF.CRU_inq_name_type := CHOOSE(cnt, '1', '2', '3');
		SELF.reason_id := L.reason_id; 
	  //Appriss Integration
		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.agency_id := L.agency_id; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec);	
		SELF := L;
		SELF := [];
	END;
  normNtlAccidentsInquiry := NORMALIZE(NtlAccidentsInquiry, 3, tNtlAccidentsInquiry(LEFT, COUNTER));

// ###########################################################################
//                    eCrash Accidents
// ###########################################################################
  //Drop Iyetek metadata IF matches with full report
	IyetekFull := DISTRIBUTE(BaseFile(source_id = 'TF'), HASH32(State_Report_Number));
	IyetekMeta := DISTRIBUTE(BaseFile(source_id = 'TM'), HASH32(state_report_number));

	jdropIyetekMetadata := JOIN(IyetekMeta, IyetekFull, 
	                            LEFT.state_report_number = RIGHT.State_Report_Number AND 
															LEFT.ORI_Number = RIGHT.ORI_Number AND 
															LEFT.loss_state_abbr = RIGHT.loss_state_abbr AND
															LEFT.report_type_id = RIGHT.report_type_id, 
															TRANSFORM(Layout_Basefile, SELF := LEFT),
															LEFT ONLY, LOCAL);
	eCrashAccidents := BaseFile(source_id <> 'TM') + jdropIyetekMetadata; //contains EA , TF, TM

	Layout_eCrash.Consolidation_AgencyOri teCrashAccidents(eCrashAccidents L, UNSIGNED1 cnt) := TRANSFORM
		SELF.accident_nbr := IF(L.source_id IN ['TM', 'TF'], L.state_report_number, L.case_identifier);
		SELF.accident_date := IF(L.incident_id[1..9] = '188188188', '20100901', L.crash_date);
		SELF.b_did := IF(L.bdid = 0, '', INTFORMAT(L.bdid, 12, 1)); 
		SELF.cname := L.cname;
		SELF.name_suffix := L.suffix;
		SELF.did := IF(L.did = 0, '000000000000', INTFORMAT(L.did, 12, 1));	
		SELF.zip := L.z5;
		SELF.zip4 := L.z4;
		SELF.record_type := L.person_type;
		SELF.driver_license_nbr := IF(REGEXFIND('[0-9]', L.drivers_license_number), L.drivers_license_number, '');
		SELF.dlnbr_st := L.drivers_license_jurisdiction; 
		SELF.tag_nbr := IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, L.License_Plate, L.Other_Unit_License_Plate), L.License_Plate);
		SELF.tagnbr_st := IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, L.Registration_State, L.Other_Unit_Registration_State), L.Registration_State);
		SELF.vin := IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, L.vin, L.Other_Unit_VIN), L.vin);
		SELF.accident_location := MAP(TRIM(L.loss_cross_street, LEFT, RIGHT) <> '' AND 
		                              TRIM(L.loss_cross_street, LEFT, RIGHT) <> 'N/A' => TRIM(L.loss_street, LEFT, RIGHT) + ' & ' + TRIM(L.loss_cross_street, LEFT, RIGHT),
																	L.loss_street);
		SELF.accident_street := L.loss_street;
		SELF.accident_cross_street := MAP(L.loss_cross_street <> 'N/A' => L.loss_cross_street, '');
		SELF.jurisdiction := IF(L.incident_id[1..9] = '188188188', 'LN Test PD', TRIM(L.agency_name, LEFT, RIGHT));
		SELF.jurisdiction_state := IF(L.case_identifier = '11030001', 'GA', L.Loss_state_Abbr);
		SELF.st := IF(L.st = '', SELF.jurisdiction_state, L.st);
		SELF.jurisdiction_nbr := IF(L.incident_id[1..9] = '188188188', '1536035', L.AGENCY_ID);
		SELF.image_hash := L.hash_key;
		SELF.airbags_deploy := L.Airbags_Deployed_Derived;
		SELF.vehicle_incident_id := L.incident_id;
		SELF.vehicle_status := IF(L.other_unit_vin <> '', CHOOSE(cnt, L.vin_status, L.other_unit_vin_status), L.vin_status);
		SELF.dob := MAP(L.incident_id[1..9] = '188188188' AND L.lname = 'DOE' => '19690201',
										L.incident_id[1..9] = '188188188' AND L.lname = 'SMITH' => '19500405',
										L.date_of_birth);										
		year := TRIM(IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, IF(L.model_year <> '', L.model_year, L.model_yr),
																														L.other_model_year),
																														IF(L.model_year <> '', L.model_year, L.model_yr)), LEFT, RIGHT);																														
		SELF.vehicle_year := MAP(LENGTH(year) = 2 AND year > '50' => '19' + year,
                             LENGTH(year) = 2 AND year <= '50' => '20' + year,
														 year);
		SELF.model_year := MAP(LENGTH(year) = 2 AND year > '50' => '19' + year,
                           LENGTH(year) = 2 AND year <= '50' => '20' + year,
													 year);
		SELF.vehicle_make := IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, IF(L.make_description <> '', L.make_description, L.make),
																														IF(L.other_make_description <> '', L.other_make_description, L.Other_Unit_Make)),
																														IF(L.make_description <> '', L.make_description, L.make));
		SELF.make_description := IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, IF(L.make_description <> '', L.make_description, L.make),
																														IF(L.other_make_description <> '', L.other_make_description, L.Other_Unit_Make)),
																														IF(L.make_description <> '', L.make_description, L.make));
		SELF.model_description := IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, IF(L.model_description <> '', L.model_description, L.model),
																														IF(L.other_model_description <> '', L.other_model_description, L.other_unit_model)),
																														IF(L.model_description <> '', L.model_description, L.model));
		SELF.vehicle_incident_city := STD.Str.ToUpperCase(L.Crash_City);
		SELF.vehicle_incident_st := STD.Str.ToUpperCase(L.Loss_State_Abbr);
		SELF.towed := L.Vehicle_Towed_Derived;		
		SELF.impact_location := IF(L.report_code = 'TM',
															 IF(L.initial_point_of_contact[1..25] <> '', 'Damaged_Area_1: ' + L.initial_point_of_contact[1..25], '') +
															 IF(L.initial_point_of_contact[25..] <> '', 'Damaged_Area_2: ' + L.initial_point_of_contact[25..], ''),																						
															IF(L.Damaged_Areas_Derived1 <> '', 'Damaged_Area_1: ' + L.Damaged_Areas_Derived1, '') + 
															IF(L.Damaged_Areas_Derived2 <> '', 'Damaged_Area_2: ' + L.Damaged_Areas_Derived2, '')
														 );					
		SELF.Policy_num := L.Insurance_Policy_Number; 
		SELF.Policy_Effective_Date := TRIM(L.Insurance_Effective_Date, LEFT, RIGHT); 
		SELF.Policy_Expiration_Date := L.Insurance_Expiration_Date;
		SELF.carrier_name := L.Insurance_Company;
		SELF.client_type_id := '';
		SELF.Report_Has_Coversheet := IF(L.Report_Has_Coversheet = '1', '1','0');
		SELF.other_vin_indicator := IF(L.Other_Unit_VIN <> '', CHOOSE(cnt, '1', '2'), '');
		SELF.vehicle_unit_number := L.unit_number;
		SELF.next_street := L.next_street;
		SELF.addl_report_number := IF(L.source_id IN ['TF', 'TM'], L.case_identifier, L.state_report_number);
		SELF.agency_id := L.agency_id;
		SELF.agency_ori := L.ori_number;
		SELF.orig_agency_ori := L.agency_ori;
		SELF.Insurance_Company_Standardized := L.Insurance_Company_Standardized;
		SELF.is_available_for_public := IF(L.report_code IN ['TF', 'EA'], '1', L.is_available_for_public);
		SELF.report_status := L.report_status;
		SELF.date_vendor_last_reported := L.date_vendor_last_reported;
		SELF.creation_date := L.creation_date; 
		SELF.report_type_id := L.report_type_id;
		SELF.ssn := L.ssn; 
		SELF.cru_jurisdiction := L.cru_agency_name; 
		SELF.cru_jurisdiction_nbr := L.cru_agency_id;
    //Policy records Addition
		SELF.fatality_involved := L.fatality_involved;
		SELF.latitude := L.lattitude;
		SELF.longitude := L.Longitude;
		SELF.address1 := L.address;
		SELF.address2 := L.address2;
		SELF.state := L.State;
		SELF.home_phone := L.home_phone;
    //End of Police Record/Claims Process		
		//BuyCrash
		SELF.officer_id := L.officer_id;		
		//Appriss Integration
		SELF.Releasable := IF(TRIM(L.Releasable, LEFT, RIGHT) IN ['\\N', 'NULL', ''], '1', L.Releasable); 			
		SELF := L;
		SELF := []; 
	END;
	normeCrashAccidents := NORMALIZE(eCrashAccidents, 2, teCrashAccidents(LEFT, COUNTER));

// ###########################################################################
// Combine FL Crash, Ntl Accidents, Ntl Inquiries & eCrash Data
// ###########################################################################
	CombineAccidents := dFLCrash + pNtlAccidents + normNtlAccidentsInquiry + normeCrashAccidents;
	
  //Perform Convertion to UpperCase
	UpCaseCombineAccidents := Fn_Upcase(CombineAccidents); 
	CombineAccidentsDID := UpCaseCombineAccidents(~(fname <> '' AND lname <> '' AND vin <> '' AND (UNSIGNED) did = 0)); 
	CombineAccidentsNoDID := UpCaseCombineAccidents(fname <> '' AND lname <> '' AND vin <> '' AND (UNSIGNED) did = 0);
	
  //Get DID from Vehicle file by name AND vin
	getMVRDID := Fn_Mvr_DID(CombineAccidentsNoDID);
	
	CleanAllAccidents := CombineAccidentsDID + getMVRDID;
	dAllAccidents := DISTRIBUTE(CleanAllAccidents, HASH32(accident_nbr));
	sAllAccidents := SORT(dAllAccidents, accident_date, accident_nbr, jurisdiction_state, vin, tag_nbr, lname, fname, mname, did, record_type, 
	                                     prim_name, dob, report_code, report_type_id, MAP(work_type_id IN ['1', '0'] => 2, 1), 
																			 date_vendor_last_reported, creation_date, LENGTH(TRIM(carrier_name, LEFT, RIGHT)) <> 0, 
																			 LENGTH(TRIM(driver_license_nbr, LEFT, RIGHT)) <> 0, vehicle_incident_id, LOCAL); // give preference to ecrash work type 1's over 2, 3
	uAllAccidents := DEDUP(sAllAccidents, accident_date, accident_nbr, jurisdiction_state, vin, tag_nbr, lname, fname, mname, did, record_type, 
	                                      prim_name, dob, report_code, report_type_id, RIGHT, LOCAL);
																				
	//scrub the accident number AND UNK issue
	Layout_eCrash.Consolidation_AgencyOri tAllAccidents(uAllAccidents L) := TRANSFORM
		t_scrub := STD.Str.Filter(L.accident_nbr, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		SELF.accident_nbr := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK' + L.vehicle_incident_id, t_scrub); 
		SELF.orig_accnbr := L.accident_nbr; 
		SELF.addl_report_number := IF(STD.Str.FilterOut(TRIM(L.addl_report_number, LEFT, RIGHT), '0') <>'', L.addl_report_number, '');
		SELF.scrub_addl_report_number := STD.Str.Filter(SELF.addl_report_number, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		SELF.policy_effective_date := MAP(TRIM(L.policy_effective_date)[1] = '0' => '',
																			TRIM(L.policy_effective_date)[8] = '-' => TRIM(L.policy_effective_date)[1..7],
                                      TRIM(L.policy_effective_date));
		SELF := L;
	END;
	SHARED AllAccidents := PROJECT(uAllAccidents, tAllAccidents(LEFT)): PERSIST('~thor_data400::persist::ecrash_ssV2');

// ###########################################################################
// Accident data for Insurance eCrash CRU Keys / Queries
// ###########################################################################
	SHARED InteractiveReports := ['I0', 'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'];
	SHARED AlphaIA := AllAccidents (report_code[1] = 'I' AND report_code NOT IN InteractiveReports); 
	SHARED AlphaOther := AllAccidents (report_code[1] <> 'I');
	SHARED AlphaCmbnd := AlphaOther + AlphaIA (reason_id IN ['HOLD', 'AFYI', 'ASSI', 'AUTO', 'CALL', 'PRAC', 'SEAR', 'SECR', 'WAIT', 'PRAI']);
	SHARED AlphaOtherVendors := AlphaCmbnd(TRIM(vendor_code, LEFT, RIGHT) <> 'COPLOGIC');
	SHARED AlphaCoplogic := AlphaCmbnd(TRIM(vendor_code, LEFT, RIGHT) = 'COPLOGIC' AND 
	                                   ((TRIM(supplemental_report, LEFT, RIGHT) = '1' AND TRIM(super_report_id, LEFT, RIGHT) <> TRIM(report_id, LEFT, RIGHT)) OR 
																		  (TRIM(supplemental_report, LEFT, RIGHT) = '0' AND TRIM(super_report_id, LEFT, RIGHT) = TRIM(report_id, LEFT, RIGHT)) OR 
																		  (TRIM(supplemental_report, LEFT, RIGHT) = '' AND TRIM(super_report_id, LEFT, RIGHT) = TRIM(report_id, LEFT, RIGHT) )
																		 )
																		);
	SHARED ALLAlphaAccidents := AlphaOtherVendors + AlphaCoplogic;																
	SHARED fAlphaAccidents := ALLAlphaAccidents(STD.Str.ToUpperCase(TRIM(orig_agency_ori, ALL)) NOT IN Agency_exclusion.CRU_Agency_ori_list AND
																							STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN Agency_exclusion.CRU_Agency_ori_list);
	SHARED ActiveAlphaAccidents := PROJECT(fAlphaAccidents, TRANSFORM(Layout_eCrash.Accidents_Alpha, SELF := LEFT;));
	EXPORT Alpha := ActiveAlphaAccidents;	

// ###########################################################################
//  ALL Accidents report data
// ###########################################################################
	SHARED eCrashAccidents := AllAccidents(CRU_inq_name_type NOT IN ['2', '3'] AND 
	                                report_code NOT IN InteractiveReports AND 
																	TRIM(vendor_code, LEFT, RIGHT) <> 'COPLOGIC');

// ###########################################################################
//  ALL Accidents report data for eCrash Keys / Queries
// ###########################################################################																	
	EXPORT out := PROJECT(eCrashAccidents, TRANSFORM(Layout_eCrash.Consolidation, SELF := LEFT;));

// ###########################################################################
//  ALL Accidents report data for PR Keys / Queries
// ###########################################################################													 
	SHARED EcrashAgencyExclusionAgencyOri := eCrashAccidents(STD.Str.ToUpperCase(TRIM(orig_agency_ori, ALL)) NOT IN Agency_exclusion.Agency_ori_list AND
																										 STD.Str.ToUpperCase(TRIM(orig_agency_ori, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list
																										 );																																						
	SHARED EcrashAgencyExclusion := EcrashAgencyExclusionAgencyOri(STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN Agency_exclusion.Agency_ori_list AND
																																 STD.Str.ToUpperCase(TRIM(agency_ori, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list
																																 );
	EXPORT prout := PROJECT(EcrashAgencyExclusion, TRANSFORM(Layout_eCrash.Consolidation, SELF := LEFT;));

// ###########################################################################
//  ALL Accidents report data for eCrash Search Records
// ###########################################################################
	SHARED SearchRecs := out(report_code IN ['EA', 'TM', 'TF'] AND 
	                         work_type_id NOT IN ['2', '3'] AND 
												   (TRIM(report_type_id, ALL) IN ['A', 'DE'] OR STD.str.ToUpperCase(TRIM(vendor_code, LEFT, RIGHT)) = 'CMPD'));
	EXPORT eCrashSearchRecs := DISTRIBUTE(PROJECT(SearchRecs, Layouts.key_search_layout), HASH32(accident_nbr)):INDEPENDENT;

END; 