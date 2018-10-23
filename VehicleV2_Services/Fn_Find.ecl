import mdr, VehicleV2, driversv2, doxie, ut, suppress, Census_Data, VehicleV2_services, codes,
       doxie_Raw, doxie_build, CriminalRecords_Services, Address;

  doxie.MAC_Header_Field_Declare ();
	
	layout_w_keys := record
    VehicleV2_Services.Layouts.flat_vehicle;
		unsigned2 party_penalty := 0;
	END;

export Fn_Find(
							grouped dataset(doxie_Raw.Layout_VehRawBatchInput.input_w_keys) in_veh_keys,
              boolean report_mode = TRUE,
							boolean ExcludeLessors= FALSE,
              boolean alternate_route = false,
							boolean includeCriminalIndicators=FALSE,
							boolean include_non_regulated_data = false) 
							:= module 
	
	isCNSMR := ut.IndustryClass.is_Knowx;
	includeNonRegulatedData := include_non_regulated_data and ~doxie.DataRestriction.InfutorMV;

  layout_w_keys makeVehReport(in_veh_keys l, VehicleV2.Key_Vehicle_Main_Key r) := transform
	  self.vehicle_numberxbg1 := r.vehicle_key[1..20];
		self.year_make := r.Orig_Year;
		self.number_of_axles := r.orig_number_of_axles;
		self.net_weight := r.orig_net_weight;
		self.gross_weight := r.orig_gross_weight;
		self.source_field := r.source_code;
		self.make_code := r.best_make_code;
		self.vehicle_type := if(r.Orig_Vehicle_Type_Code<>'', r.Orig_Vehicle_Type_Code[1..4],r.orig_vehicle_type_desc[1..4]) ;
		self.model := if(r.Orig_Model_Code <> '', r.orig_model_code,r.vina_model);
		self.body_code := r.Orig_Body_Code;
		self.Major_color_code := r.Orig_Major_Color_Code;
		self.Minor_color_code := r.Orig_Minor_Color_Code;
		self.orig_vin := r.Orig_VIN;
		self.vin_2 := r.vina_vin;
		self.veh_type := r.VINA_Veh_Type;
		self.ncic_make :=r.VINA_NCIC_Make;
		self.model_year_yy := r.VINA_Model_Year_YY;
		self.vin := r.orig_vin;
		self.vin_pattern_indicator :=r.VINA_VIN_Pattern_Indicator;
		self.bypass_code := r.VINA_bypass_code;
		self.vp_restraint := r.VINA_VP_Restraint;
		self.vp_abbrev_make_name := r.vina_vp_abbrev_make_name;
		self.vp_year := r.VINA_vp_year;
		self.vp_series := r.VINA_vp_series;
		self.vp_model := r.VINA_vp_model;
		self.vp_air_conditioning := r.VINA_vp_air_conditioning;
		self.vp_power_steering  := r.VINA_vp_power_steering;
		self.vp_power_brakes  := r.VINA_vp_power_brakes;
		self.vp_power_windows := r.VINA_vp_power_windows;
		self.vp_tilt_wheel := r.VINA_vp_tilt_wheel;
		self.vp_roof := r.VINA_vp_roof;
		self.vp_optional_roof1 := r.VINA_vp_optional_roof1;
		self.vp_optional_roof2 := r.VINA_vp_optional_roof2;
		self.vp_radio := r.VINA_vp_radio;
		self.vp_optional_radio1 := r.VINA_vp_optional_radio1;
		self.vp_optional_radio2 := r.VINA_vp_optional_radio2;
		self.vp_transmission := r.VINA_vp_transmission;
		self.vp_optional_transmission1 := r.VINA_vp_optional_transmission1;
		self.vp_optional_transmission2 := r.VINA_vp_optional_transmission2;
		self.vp_anti_lock_brakes := r.VINA_vp_anti_lock_brakes;
		self.vp_front_wheel_drive := r.VINA_vp_front_wheel_drive;
		self.vp_four_wheel_drive := r.VINA_vp_four_wheel_drive;
		self.vp_security_system := r.VINA_vp_security_system;
		self.vp_daytime_running_lights := r.VINA_vp_daytime_running_lights;
		self.vp_series_name := r.VINA_vp_series_name;
		self.model_year := r.VINA_Model_Year;
		self.vina_series := r.VINA_Series;
		self.vina_model := r.VINA_Model;
		self.vina_body_style := r.VINA_Body_Style;
		self.make_description := r.VINA_Make_Desc;
		self.model_description := r.VINA_Model_Desc;
		self.series_description := r.VINA_Series_Desc;
		self.body_style_description := r.VINA_Body_Style_Desc;
		self.number_of_cylinders := r.VINA_Number_Of_Cylinders;
		self.engine_size := r.VINA_Engine_Size;
		self.fuel_code := r.VINA_Fuel_Code;
		self.fuel_type := r.VINA_Fuel_Code;
		self.vina_price := r.VINA_Price;
		self.source_code := r.source_code;
		self.vehicle_use := r.orig_vehicle_use_code;
		self.seq := l.input.seq;
		self := r;
		self := l;
    self.history_flag := ''; // self := [];
  END;
	
  // Probably this code do not always work as it was intended: 
  // there are more than 1,000 records matching by vehicle-key,
  // and ~200 by vehicle- and iteration-key.
	veh_recs0_mainkeyinfo := join(in_veh_keys,
								VehicleV2.Key_Vehicle_Main_Key,
								keyed(left.Vehicle_Key = right.Vehicle_Key[1..length(trim(left.vehicle_key))]) and
                // it =looks= like left.iteration_key cannot be blank here.
								keyed(left.iteration_key='' or left.Iteration_Key = right.Iteration_Key) and
                (includeNonRegulatedData or right.source_code not in MDR.sourceTools.set_infutor_all_veh), 
								makeVehReport(left, right),
								keep (VehicleV2_services.Constant.VEHICLE_PER_KEY), limit (10000));
															
								
 veh_recs0 := if(~isCNSMR, veh_recs0_mainkeyinfo);
	
	// for moxie queries this filtering is now done in runall
	veh_recs := if(alternate_route,
									veh_recs0,
									veh_recs0(ut.PermissionTools.dppa.state_ok(state_origin,dppa_purpose,,source_code)or
														(source_code in MDR.sourceTools.set_infutor_all_veh and ut.PermissionTools.dppa.ok(dppa_purpose))));
	
	// Similar issue: 3,000,000 by vehicle-key, ~4,500 by vehicle-, iteration-, sequence-key.
	owner_recs0_info :=join(in_veh_keys, vehiclev2.Key_Vehicle_Party_Key,
									keyed(left.vehicle_key=right.vehicle_key[1..length(trim(left.vehicle_key))]) and
									keyed(left.iteration_key='' or left.Iteration_key = right.Iteration_key) and// and
									keyed(left.sequence_key=''  or left.sequence_key= right.sequence_key) and
                  (includeNonRegulatedData or right.source_code not in MDR.sourceTools.set_infutor_all_veh),
									TRANSFORM (vehiclev2.Layout_Base_Party, SELF := RIGHT),
                  // TODO: should rather be PARTIES_PER_VEHICLE
									keep(VehicleV2_services.Constant.VEHICLE_PER_KEY), limit (10000));
	
									
	owner_recs0 := if(~isCNSMR, owner_recs0_info);
									
	vehiclev2.Layout_Base_Party get_dob_sex(owner_recs0 l, driversv2.Key_DL_DID r) := transform
		self.orig_dob := if(((unsigned) l.orig_dob) <> 0,l.orig_dob,(string8) r.dob);
		self.orig_sex := if(l.orig_sex <>'',l.orig_sex,r.sex_flag);
		self.orig_dl_number := if(l.orig_dl_number <>'',l.orig_dl_number,r.dl_number);
		self := l;
	END;
	
	// latest DL recs by expire date by did
	latest_dl_recs := PROJECT(DEDUP(SORT(
		JOIN(owner_recs0,Driversv2.Key_DL_DID,
         KEYED((UNSIGNED)LEFT.append_did=RIGHT.did),
         LEFT OUTER,LIMIT(10000,SKIP)),
			did,-expiration_date),did),RECORDOF(Driversv2.Key_DL_DID));

	owner_recs1 := join(owner_recs0,latest_dl_recs,left.append_did=right.did,
			get_dob_sex(left,right),keep(1),left outer);
	
	rec_base_w_ssn := record (vehiclev2.Layout_Base_Party)
		string9 use_ssn;
		string18 county_name;
    boolean hasCriminalConviction;
    boolean isSexualOffender;
	END;
	
	rec_base_w_ssn is_ofage(	vehiclev2.Layout_Base_Party l):=transform
				ofage := ut.PermissionTools.glb.minorOk(if(l.orig_dob ='',0, ut.age((integer) l.orig_dob)));
				
				underage := 'UNDERAGE INDIVIDUAL';
				
				self.vehicle_key := l.vehicle_key;
				self.iteration_key := l.iteration_key;
				self.sequence_key := l.sequence_key;
				self.orig_name_type := l.orig_name_type;
				self.Append_Clean_Name.lname := if(ofage, l.Append_Clean_Name.lname, underage);
				self.use_ssn := if(ofage,if(l.orig_ssn<>'',l.orig_ssn,l.append_ssn),'');
				self := if(ofage,l);
				self := [];
	end;
				
	owner_recs := project(owner_recs1,is_ofage(left));
	
	doxie.MAC_PruneOldSSNs(owner_recs,pruned_owner_recs,use_ssn,append_did);
	
	rec_base_w_ssn get_county(pruned_owner_recs l,census_data.Key_Fips2County r):=transform
		self.county_name := r.county_name;
		self := l;
	END;
	
	owner_recs_w_county := join(pruned_owner_recs,Census_Data.Key_Fips2County,keyed(left.Append_Clean_Address.st = right.state_code) and
			keyed(left.Append_Clean_Address.fips_county=right.county_fips),get_county(left,right),keep(1),left outer);
	
	dup_own_recs := dedup(sort(owner_recs_w_county,-date_last_seen,-reg_latest_effective_date, history, record,except Source_Code,State_Bitmap_Flag,Latest_Vehicle_Flag,Latest_Vehicle_Iteration_Flag,History,Date_First_Seen,Date_Last_Seen,Date_Vendor_First_Reported,
		Date_Vendor_Last_Reported,Orig_Party_Type,Orig_Conjunction),
		record,except Source_Code,State_Bitmap_Flag,Latest_Vehicle_Flag,Latest_Vehicle_Iteration_Flag,History,Date_First_Seen,Date_Last_Seen,Date_Vendor_First_Reported,
		Date_Vendor_Last_Reported,Orig_Party_Type,Orig_Conjunction);
		
	// add crim indicators
	recsIn := PROJECT(dup_own_recs,TRANSFORM({rec_base_w_ssn,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.append_did,SELF:=LEFT));
	CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
	dup_owner_recs := PROJECT(IF(includeCriminalIndicators,recsOut,recsIn),rec_base_w_ssn);

	layout_w_keys get_own(veh_recs l, dup_owner_recs r,integer C):=transform,skip(r.orig_name_type not in ['1','2','4','5','7'] or (r.orig_name_type in ['1','2'] and l.owner_2_customer_type<>'') or (r.orig_name_type in ['4','5'] and l.registrant_2_customer_type<>'') or (r.orig_name_type='7' and l.lein_holder_3_customer_type <>'') or
			(r.orig_name_type = '2' and ExcludeLessors = TRUE))

			
			name_type := map(r.orig_name_type IN ['4','5']  and l.registrant_1_customer_typexbg5=''=>'reg1',
										 r.orig_name_type IN ['4','5']  and l.registrant_2_customer_type=''=>'reg2',
										 r.orig_name_type IN ['1','2']  and l.owner_1_customer_typexbg3 = '' => 'own1',
										 r.orig_name_type IN ['1','2']  and l.owner_2_customer_type = '' => 'own2',
										 r.orig_name_type = '7' and l.lein_holder_1_customer_type = '' => 'lh1',
										 r.orig_name_type = '7' and l.lein_holder_2_customer_type = '' => 'lh2',
											'lh3');
											
											
		//	county_from_key := choosen(Census_Data.Key_Fips2County(keyed(state_code = r.Append_Clean_Address.st) and
		//	keyed(county_fips = r.Append_Clean_Address.fips_county)),1)[1].county_name;
			
			
      string company := if(r.Orig_Party_Type='I','',trim(r.Orig_Name));
			raw_penalty := if(report_mode or alternate_route,0, doxie.FN_Tra_Penalty_DID((string)r.Append_did) +
						doxie.FN_Tra_Penalty_SSN(r.use_ssn) +
						doxie.FN_Tra_Penalty_Name(r.Append_Clean_Name.fname, 
							r.Append_Clean_Name.mname, r.Append_Clean_Name.lname)+ 
						doxie.FN_Tra_Penalty_Addr(r.Append_Clean_Address.predir,
							r.Append_Clean_Address.prim_range, 
							r.Append_Clean_Address.prim_name,
							r.Append_Clean_Address.addr_suffix, 
							r.Append_Clean_Address.postdir,
							r.Append_Clean_Address.sec_range,
							r.Append_Clean_Address.v_city_name,
							r.Append_Clean_Address.St, r.Append_Clean_Address.zip5)+
							doxie.FN_Tra_Penalty_CName(company));
		self.party_penalty := map(report_mode or alternate_route=> 0,
															l.party_penalty < raw_penalty and C <> 1 =>l.party_penalty,
															raw_penalty);


		self.NonDMVSource := r.source_code in MDR.sourceTools.set_infutor_all_veh; 								 
		self.odometer_status :=  if(l.odometer_status<>'',l.odometer_status, r.Ttl_Odometer_Status_Code); //party
		self.odometer_date := if(l.odometer_date<>'',l.odometer_date, r.Ttl_Odometer_Date); // party
		self.odometer_mileage := if(l.odometer_mileage<>'',l.odometer_mileage, r.Ttl_Odometer_Mileage); // party

		self.owner_1_customer_typexbg3 := if(name_type='own1',
		if(r.Append_Clean_CName <> '','B','I'),l.owner_1_customer_typexbg3);
		self.own_1_feid_ssn :=if(name_type= 'own1',r.use_ssn,l.own_1_feid_ssn) ; // party
		self.own_1_customer_name :=if(name_type= 'own1', r.Orig_Name,l.own_1_customer_name); //party
		self.own_1_driver_license_number :=if(name_type= 'own1', r.Orig_DL_Number,l.own_1_driver_license_number);// party
		self.own_1_dob := if(name_type= 'own1',if(((integer)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.own_1_dob); // party
		self.own_1_sex :=if(name_type= 'own1', r.orig_sex,l.own_1_sex);//party
		self.own_1_address_number := if(name_type= 'own1',r.Append_Clean_Address.prim_range,l.own_1_address_number);//party
		self.own_1_street_address := if(name_type= 'own1',
		Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
		,l.own_1_street_address); //party
		self.own_1_apartment_number := if(name_type= 'own1',r.Append_Clean_Address.sec_range,l.own_1_apartment_number); //party
		self.own_1_city := if(name_type= 'own1',r.Append_Clean_Address.v_city_name,l.own_1_city); // party
		self.own_1_state :=if(name_type= 'own1', r.Append_Clean_Address.st,l.own_1_state); //party
		self.own_1_state_2 := if(name_type= 'own1', r.Append_Clean_Address.st,l.own_1_state);
		self.own_1_zip5_zip4_foreign_postal := if(name_type= 'own1',r.Append_Clean_Address.zip5,l.own_1_zip5_zip4_foreign_postal); // party
		self.own_1_title := if(name_type= 'own1',r.Append_Clean_Name.title,l.own_1_title);
		self.own_1_fname := if(name_type= 'own1',r.Append_Clean_Name.fname,l.own_1_fname) ;
		self.own_1_mname :=if(name_type= 'own1', r.Append_Clean_Name.mname,l.own_1_mname);
		self.own_1_lname :=if(name_type= 'own1', r.Append_Clean_Name.lname,l.own_1_lname);
		self.own_1_name_suffix := if(name_type= 'own1',r.Append_Clean_Name.name_suffix, l.own_1_name_suffix);
		self.own_1_did :=if(name_type= 'own1', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.own_1_did) ;
		self.own_1_ssn := if(name_type= 'own1',r.append_ssn, l.own_1_ssn);
		self.own_1_company_name := if(name_type= 'own1',r.Append_Clean_CName,l.own_1_company_name);
		self.own_1_prim_range := if(name_type= 'own1',r.Append_Clean_Address.prim_range,l.own_1_prim_range);
		self.own_1_predir:= if(name_type= 'own1',r.Append_Clean_Address.predir,l.own_1_predir);
		self.own_1_prim_name := if(name_type= 'own1',r.Append_Clean_Address.prim_name,l.own_1_prim_name);
		self.own_1_suffix := if(name_type= 'own1',r.Append_Clean_Address.addr_suffix,l.own_1_suffix);
		self.own_1_postdir:= if(name_type= 'own1',r.Append_Clean_Address.postdir,l.own_1_postdir);
		self.own_1_unit_desig := if(name_type= 'own1',r.Append_Clean_Address.unit_desig,l.own_1_unit_desig);
		self.own_1_sec_range := if(name_type= 'own1',r.Append_Clean_Address.sec_range,l.own_1_sec_range);
		self.own_1_p_city_name := if(name_type= 'own1',r.Append_Clean_Address.v_city_name,l.own_1_p_city_name);
		self.own_1_v_city_name:= if(name_type= 'own1',r.Append_Clean_Address.v_city_name,l.own_1_v_city_name);
		self.own_1_zip5 := if(name_type= 'own1',r.Append_Clean_Address.Zip5,l.own_1_zip5);
		self.own_1_zip4 := if(name_type='own1',r.Append_Clean_Address.Zip4,l.own_1_zip4);
		self.own_1_county := if(name_type='own1',r.Append_Clean_Address.fips_county,l.own_1_county);
		self.own_1_residence_county := if(name_type='own1',r.Append_Clean_Address.fips_county,l.own_1_residence_county);

		self.own_1_bdid := if(name_type='own1',r.Append_bdid,l.own_1_bdid);
		self.OWN_1_CUSTOMER_NUMBER := '';
		self.own_1_county_name := if(name_type='own1',r.county_name,l.own_1_county_name);
		self.own_1_geo_lat := if(name_type='own1',r.Append_Clean_Address.geo_lat, l.own_1_geo_lat);
		self.own_1_geo_long := if(name_type='own1',r.Append_Clean_Address.geo_long,l.own_1_geo_long);
		self.own_1_preglb_did := '';
		self.own_1_hasCriminalConviction := if(name_type='own1',r.hasCriminalConviction,l.own_1_hasCriminalConviction);
		self.own_1_isSexualOffender := if(name_type='own1',r.isSexualOffender,l.own_1_isSexualOffender);
		self.own_1_src_first_date := if(name_type='own1',(STRING8)ut.min2((unsigned)l.own_1_src_first_date,(unsigned)r.src_first_date),l.own_1_src_first_date);		
		self.own_1_src_last_date := if(name_type='own1',(STRING8)MAX((unsigned)l.own_1_src_last_date,(unsigned)r.src_last_date),l.own_1_src_last_date);

		self.owner_2_customer_type := if(name_type='own2',
			if(r.Append_Clean_CName <> '','B','I'),l.owner_2_customer_type);
		self.own_2_feid_ssn :=if(name_type= 'own2',r.use_ssn,l.own_2_feid_ssn) ; // party
		self.own_2_customer_name :=if(name_type= 'own2', r.Orig_Name,l.own_2_customer_name); //party
		self.own_2_driver_license_number :=if(name_type= 'own2', r.Orig_DL_Number,l.own_2_driver_license_number);// party
		self.own_2_dob := if(name_type= 'own2',if(((integer)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.own_2_dob); // party
		self.own_2_sex :=if(name_type= 'own2', r.orig_sex,l.own_2_sex);//party
		self.own_2_address_number := if(name_type= 'own2',r.Append_Clean_Address.prim_range,l.own_2_address_number);//party
		self.own_2_street_address := if(name_type= 'own2',
		Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
		,l.own_2_street_address); //party
		self.own_2_apartment_number := if(name_type= 'own2',r.Append_Clean_Address.sec_range,l.own_2_apartment_number); //party
		self.own_2_city := if(name_type= 'own2',r.Append_Clean_Address.v_city_name,l.own_2_city); // party
		self.own_2_state :=if(name_type= 'own2', r.Append_Clean_Address.st,l.own_2_state); //party
		self.own_2_state_2 :=if(name_type= 'own2', r.Append_Clean_Address.st,l.own_2_state); //party			
		self.own_2_zip5_zip4_foreign_postal := if(name_type= 'own2',r.Append_Clean_Address.zip5,l.own_2_zip5_zip4_foreign_postal); // party
		self.own_2_title := if(name_type= 'own2',r.Append_Clean_Name.title,l.own_2_title);
		self.own_2_fname := if(name_type= 'own2',r.Append_Clean_Name.fname,l.own_2_fname) ;
		self.own_2_mname :=if(name_type= 'own2', r.Append_Clean_Name.mname,l.own_2_mname);
		self.own_2_lname :=if(name_type= 'own2', r.Append_Clean_Name.lname,l.own_2_lname);
		self.own_2_name_suffix := if(name_type= 'own2',r.Append_Clean_Name.name_suffix, l.own_2_name_suffix);
		self.own_2_did :=if(name_type= 'own2', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.own_2_did);	
		self.own_2_ssn := if(name_type= 'own2',r.append_ssn, l.own_2_ssn);
		self.own_2_company_name := if(name_type= 'own2',r.Append_Clean_CName,l.own_2_company_name);
		self.own_2_prim_range := if(name_type= 'own2',r.Append_Clean_Address.prim_range,l.own_2_prim_range);
		self.own_2_predir:= if(name_type= 'own2',r.Append_Clean_Address.predir,l.own_2_predir);
		self.own_2_prim_name := if(name_type= 'own2',r.Append_Clean_Address.prim_name,l.own_2_prim_name);
		self.own_2_suffix := if(name_type= 'own2',r.Append_Clean_Address.addr_suffix,l.own_2_suffix);
		self.own_2_postdir:= if(name_type= 'own2',r.Append_Clean_Address.postdir,l.own_2_postdir);
		self.own_2_unit_desig := if(name_type= 'own2',r.Append_Clean_Address.unit_desig,l.own_2_unit_desig);
		self.own_2_sec_range := if(name_type= 'own2',r.Append_Clean_Address.sec_range,l.own_2_sec_range);
		self.own_2_p_city_name := if(name_type= 'own2',r.Append_Clean_Address.v_city_name,l.own_2_p_city_name);
		self.own_2_v_city_name:= if(name_type= 'own2',r.Append_Clean_Address.v_city_name,l.own_2_v_city_name);
		self.own_2_zip5 := if(name_type= 'own2',r.Append_Clean_Address.Zip5,l.own_2_zip5);
		self.own_2_zip4 := if(name_type='own2',r.Append_Clean_Address.Zip4,l.own_2_zip4);
		self.own_2_county := if(name_type='own2',r.Append_Clean_Address.fips_county,l.own_2_county);
		self.own_2_residence_county := if(name_type='own2',r.Append_Clean_Address.fips_county,l.own_2_residence_county);
		
		self.own_2_bdid := if(name_type='own2',r.Append_bdid,l.own_2_bdid);
		self.OWN_2_CUSTOMER_NUMBER := '';
		self.own_2_county_name := if(name_type='own2',r.county_name,l.own_2_county_name);
		self.own_2_geo_lat := if(name_type='own2',r.Append_Clean_Address.geo_lat, l.own_2_geo_lat);
		self.own_2_geo_long := if(name_type='own2',r.Append_Clean_Address.geo_long,l.own_2_geo_long);
		self.own_2_preglb_did := '';
		self.own_2_hasCriminalConviction := if(name_type='own2',r.hasCriminalConviction,l.own_2_hasCriminalConviction);
		self.own_2_isSexualOffender := if(name_type='own2',r.isSexualOffender,l.own_2_isSexualOffender);
		self.own_2_src_first_date := if(name_type='own2',(STRING8)ut.min2((unsigned)l.own_2_src_first_date,(unsigned)r.src_first_date),l.own_2_src_first_date);		
		self.own_2_src_last_date := if(name_type='own2',(STRING8)MAX((unsigned)l.own_2_src_last_date,(unsigned)r.src_last_date),l.own_2_src_last_date);

		self.registrant_1_customer_typexbg5 := if(name_type='reg1',
				if(r.Append_Clean_CName <> '','B','I'),l.registrant_1_customer_typexbg5);
		self.reg_1_feid_ssn :=if(name_type= 'reg1',r.use_ssn,l.reg_1_feid_ssn) ; // party
		self.reg_1_customer_name :=if(name_type= 'reg1', r.Orig_Name,l.reg_1_customer_name); //party
		self.reg_1_driver_license_number :=if(name_type= 'reg1', r.Orig_DL_Number,l.reg_1_driver_license_number);// party
		self.reg_1_dob := if(name_type= 'reg1',if(((integer)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.reg_1_dob); // party
		self.reg_1_sex :=if(name_type= 'reg1', r.orig_sex,l.reg_1_sex);//party
		self.reg_1_address_number := if(name_type= 'reg1',r.Append_Clean_Address.prim_range,l.reg_1_address_number);//party
		self.reg_1_street_address := if(name_type= 'reg1',
		Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
		,l.reg_1_street_address); //party
		self.reg_1_apartment_number := if(name_type= 'reg1',r.Append_Clean_Address.sec_range,l.reg_1_apartment_number); //party
		self.reg_1_city := if(name_type= 'reg1',r.Append_Clean_Address.v_city_name,l.reg_1_city); // party
		self.reg_1_state :=if(name_type= 'reg1', r.Append_Clean_Address.st,l.reg_1_state); //party
		self.reg_1_state_2 :=if(name_type= 'reg1', r.Append_Clean_Address.st,l.reg_1_state); 
		self.reg_1_zip5_zip4_foreign_postal := if(name_type= 'reg1',r.Append_Clean_Address.zip5,l.reg_1_zip5_zip4_foreign_postal); // party
		self.reg_1_title := if(name_type= 'reg1',r.Append_Clean_Name.title,l.reg_1_title);
		self.reg_1_fname := if(name_type= 'reg1',r.Append_Clean_Name.fname,l.reg_1_fname) ;
		self.reg_1_mname :=if(name_type= 'reg1', r.Append_Clean_Name.mname,l.reg_1_mname);
		self.reg_1_lname :=if(name_type= 'reg1', r.Append_Clean_Name.lname,l.reg_1_lname);
		self.reg_1_name_suffix := if(name_type= 'reg1',r.Append_Clean_Name.name_suffix, l.reg_1_name_suffix);
		self.reg_1_did :=if(name_type= 'reg1', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.reg_1_did) ;
		self.reg_1_ssn := if(name_type= 'reg1',r.append_ssn, l.reg_1_ssn);
		self.reg_1_company_name := if(name_type= 'reg1',r.Append_Clean_CName,l.reg_1_company_name);
		self.reg_1_prim_range := if(name_type= 'reg1',r.Append_Clean_Address.prim_range,l.reg_1_prim_range);
		self.reg_1_predir:= if(name_type= 'reg1',r.Append_Clean_Address.predir,l.reg_1_predir);
		self.reg_1_prim_name := if(name_type= 'reg1',r.Append_Clean_Address.prim_name,l.reg_1_prim_name);
		self.reg_1_suffix := if(name_type= 'reg1',r.Append_Clean_Address.addr_suffix,l.reg_1_suffix);
		self.reg_1_postdir:= if(name_type= 'reg1',r.Append_Clean_Address.postdir,l.reg_1_postdir);
		self.reg_1_unit_desig := if(name_type= 'reg1',r.Append_Clean_Address.unit_desig,l.reg_1_unit_desig);
		self.reg_1_sec_range := if(name_type= 'reg1',r.Append_Clean_Address.sec_range,l.reg_1_sec_range);
		self.reg_1_p_city_name := if(name_type= 'reg1',r.Append_Clean_Address.v_city_name,l.reg_1_p_city_name);
		self.reg_1_v_city_name:= if(name_type= 'reg1',r.Append_Clean_Address.v_city_name,l.reg_1_v_city_name);
		self.reg_1_zip5 := if(name_type= 'reg1',r.Append_Clean_Address.Zip5,l.reg_1_zip5);
		self.reg_1_zip4 := if(name_type='reg1',r.Append_Clean_Address.Zip4,l.reg_1_zip4);
		self.reg_1_county := if(name_type='reg1',r.Append_Clean_Address.fips_county,l.reg_1_county);
		self.reg_1_residence_county := if(name_type='reg1',r.Append_Clean_Address.fips_county,l.reg_1_residence_county);

		self.reg_1_bdid := if(name_type='reg1',r.Append_bdid,l.reg_1_bdid);
		self.reg_1_CUSTOMER_NUMBER := '';
		self.reg_1_county_name := if(name_type='reg1',r.county_name,l.reg_1_county_name);
		self.reg_1_geo_lat := if(name_type='reg1',r.Append_Clean_Address.geo_lat, l.reg_1_geo_lat);
		self.reg_1_geo_long := if(name_type='reg1',r.Append_Clean_Address.geo_long,l.reg_1_geo_long);
		self.reg_1_preglb_did := '';
		self.reg_1_hasCriminalConviction := if(name_type='reg1',r.hasCriminalConviction,l.reg_1_hasCriminalConviction);
		self.reg_1_isSexualOffender := if(name_type='reg1',r.isSexualOffender,l.reg_1_isSexualOffender);


		self.registrant_2_customer_type :=if(name_type='reg2',
				if(r.Append_Clean_CName <> '','B','I'),l.registrant_2_customer_type);
		self.reg_2_feid_ssn :=if(name_type= 'reg2',r.use_ssn,l.reg_2_feid_ssn) ; // party
		self.reg_2_customer_name :=if(name_type= 'reg2', r.Orig_Name,l.reg_2_customer_name); //party
		self.reg_2_driver_license_number :=if(name_type= 'reg2', r.Orig_DL_Number,l.reg_2_driver_license_number);// party
		self.reg_2_dob := if(name_type= 'reg2',if(((integer)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.reg_2_dob); // party
		self.reg_2_sex :=if(name_type= 'reg2', r.orig_sex,l.reg_2_sex);//party
		self.reg_2_address_number := if(name_type= 'reg2',r.Append_Clean_Address.prim_range,l.reg_2_address_number);//party
		self.reg_2_street_address := if(name_type= 'reg2',
		Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
		,l.reg_2_street_address); //party
		self.reg_2_apartment_number := if(name_type= 'reg2',r.Append_Clean_Address.sec_range,l.reg_2_apartment_number); //party
		self.reg_2_city := if(name_type= 'reg2',r.Append_Clean_Address.v_city_name,l.reg_2_city); // party
		self.reg_2_state :=if(name_type= 'reg2', r.Append_Clean_Address.st,l.reg_2_state); //party
		self.reg_2_state_2 :=if(name_type= 'reg2', r.Append_Clean_Address.st,l.reg_2_state);
		self.reg_2_zip5_zip4_foreign_postal := if(name_type= 'reg2',r.Append_Clean_Address.zip5,l.reg_2_zip5_zip4_foreign_postal); // party
		self.reg_2_title := if(name_type= 'reg2',r.Append_Clean_Name.title,l.reg_2_title);
		self.reg_2_fname := if(name_type= 'reg2',r.Append_Clean_Name.fname,l.reg_2_fname) ;
		self.reg_2_mname :=if(name_type= 'reg2', r.Append_Clean_Name.mname,l.reg_2_mname);
		self.reg_2_lname :=if(name_type= 'reg2', r.Append_Clean_Name.lname,l.reg_2_lname);
		self.reg_2_name_suffix := if(name_type= 'reg2',r.Append_Clean_Name.name_suffix, l.reg_2_name_suffix);
		self.reg_2_did :=if(name_type= 'reg2', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.reg_2_did);		
		self.reg_2_ssn := if(name_type= 'reg2',r.append_ssn, l.reg_2_ssn);
		self.reg_2_company_name := if(name_type= 'reg2',r.Append_Clean_CName,l.reg_2_company_name);
		self.reg_2_prim_range := if(name_type= 'reg2',r.Append_Clean_Address.prim_range,l.reg_2_prim_range);
		self.reg_2_predir:= if(name_type= 'reg2',r.Append_Clean_Address.predir,l.reg_2_predir);
		self.reg_2_prim_name := if(name_type= 'reg2',r.Append_Clean_Address.prim_name,l.reg_2_prim_name);
		self.reg_2_suffix := if(name_type= 'reg2',r.Append_Clean_Address.addr_suffix,l.reg_2_suffix);
		self.reg_2_postdir:= if(name_type= 'reg2',r.Append_Clean_Address.postdir,l.reg_2_postdir);
		self.reg_2_unit_desig := if(name_type= 'reg2',r.Append_Clean_Address.unit_desig,l.reg_2_unit_desig);
		self.reg_2_sec_range := if(name_type= 'reg2',r.Append_Clean_Address.sec_range,l.reg_2_sec_range);
		self.reg_2_p_city_name := if(name_type= 'reg2',r.Append_Clean_Address.v_city_name,l.reg_2_p_city_name);
		self.reg_2_v_city_name:= if(name_type= 'reg2',r.Append_Clean_Address.v_city_name,l.reg_2_v_city_name);
		self.reg_2_zip5 := if(name_type= 'reg2',r.Append_Clean_Address.Zip5,l.reg_2_zip5);
		self.reg_2_zip4 := if(name_type='reg2',r.Append_Clean_Address.Zip4,l.reg_2_zip4);
		self.reg_2_county := if(name_type='reg2',r.Append_Clean_Address.fips_county,l.reg_2_county);
		self.reg_2_residence_county := if(name_type='reg2',r.Append_Clean_Address.fips_county,l.reg_2_residence_county);

		self.reg_2_bdid := if(name_type='reg2',r.Append_bdid,l.reg_2_bdid);
		self.reg_2_CUSTOMER_NUMBER := '';
		self.reg_2_county_name := if(name_type='reg2',r.county_name,l.reg_2_county_name);
		self.reg_2_geo_lat := if(name_type='reg2',r.Append_Clean_Address.geo_lat, l.reg_2_geo_lat);
		self.reg_2_geo_long := if(name_type='reg2',r.Append_Clean_Address.geo_long,l.reg_2_geo_long);
		self.reg_2_preglb_did := '';
		self.reg_2_hasCriminalConviction := if(name_type='reg2',r.hasCriminalConviction,l.reg_2_hasCriminalConviction);
		self.reg_2_isSexualOffender := if(name_type='reg2',r.isSexualOffender,l.reg_2_isSexualOffender);


		self.lein_holder_1_customer_type := if(name_type='lh1',
				if(r.Append_Clean_CName <> '','B','I'),l.lein_holder_1_customer_type);
		self.lh_1_feid_ssn :=if(name_type= 'lh1',r.use_ssn,l.lh_1_feid_ssn) ; // party
		self.lh_1_customer_name :=if(name_type= 'lh1', r.Orig_Name,l.lh_1_customer_name); //party
		self.lh_1_driver_license_number :=if(name_type= 'lh1', r.Orig_DL_Number,l.lh_1_driver_license_number);// party
		self.lh_1_dob := if(name_type= 'lh1',if(((integer)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.lh_1_dob); // party
		self.lh_1_sex :=if(name_type= 'lh1', r.orig_sex,l.lh_1_sex);//party
		self.lh_1_address_number := if(name_type= 'lh1',r.Append_Clean_Address.prim_range,l.lh_1_address_number);//party
		self.lh_1_street_address := if(name_type= 'lh1',
		Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
		,l.lh_1_street_address); //party
		self.lh_1_apartment_number := if(name_type= 'lh1',r.Append_Clean_Address.sec_range,l.lh_1_apartment_number); //party
		self.lh_1_city := if(name_type= 'lh1',r.Append_Clean_Address.v_city_name,l.lh_1_city); // party
		self.lh_1_state :=if(name_type= 'lh1', r.Append_Clean_Address.st,l.lh_1_state); //party
		self.lh_1_zip5_zip4_foreign_postal := if(name_type= 'lh1',r.Append_Clean_Address.zip5,l.lh_1_zip5_zip4_foreign_postal); // party
		self.lh_1_residence_county := if(name_type='lh1',r.Append_Clean_Address.fips_county,l.lh_1_residence_county);
		self.lh_1_county_name := if(name_type='lh1',r.county_name,l.lh_1_county_name);		
		self.lh_1_zip5 := if(name_type= 'lh1',r.Append_Clean_Address.Zip5,l.lh_1_zip5);
		self.lh_1_zip4 := if(name_type='lh1',r.Append_Clean_Address.Zip4,l.lh_1_zip4);
		self.lh_1_lien_date := if(name_type[1..2]='lh' and l.lh_1_lien_date='',r.orig_lien_date, l.lh_1_lien_date);

		self.lein_holder_2_customer_type := if(name_type='lh2',
				if(r.Append_Clean_CName <> '','B','I'),l.lein_holder_2_customer_type);
		self.lh_2_feid_ssn :=if(name_type= 'lh2',r.use_ssn,l.lh_2_feid_ssn) ; // party
		self.lh_2_customer_name :=if(name_type= 'lh2', r.Orig_Name,l.lh_2_customer_name); //party
		self.lh_2_driver_license_number :=if(name_type= 'lh2', r.Orig_DL_Number,l.lh_2_driver_license_number);// party
		self.lh_2_dob := if(name_type= 'lh2',if(((integer)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.lh_2_dob); // party
		self.lh_2_sex :=if(name_type= 'lh2', r.orig_sex,l.lh_2_sex);//party
		self.lh_2_address_number := if(name_type= 'lh2',r.Append_Clean_Address.prim_range,l.lh_2_address_number);//party
		self.lh_2_street_address := if(name_type= 'lh2',
		Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
		,l.lh_2_street_address); //party
		self.lh_2_apartment_number := if(name_type= 'lh2',r.Append_Clean_Address.sec_range,l.lh_2_apartment_number); //party
		self.lh_2_city := if(name_type= 'lh2',r.Append_Clean_Address.v_city_name,l.lh_2_city); // party
		self.lh_2_state :=if(name_type= 'lh2', r.Append_Clean_Address.st,l.lh_2_state); //party
		self.lh_2_zip5_zip4_foreign_postal := if(name_type= 'lh2',r.Append_Clean_Address.zip5,l.lh_2_zip5_zip4_foreign_postal); // party
		self.lh_2_residence_county := if(name_type='lh2',r.Append_Clean_Address.fips_county,l.lh_2_residence_county);
		self.lh_2_county_name := if(name_type='lh2',r.county_name,l.lh_2_county_name);	
		self.lh_2_zip5 := if(name_type= 'lh2',r.Append_Clean_Address.Zip5,l.lh_2_zip5);
		self.lh_2_zip4 := if(name_type='lh2',r.Append_Clean_Address.Zip4,l.lh_2_zip4);

		
		self.lein_holder_3_customer_type := if(name_type='lh3',
						if(r.Append_Clean_CName <> '','B','I'),l.lein_holder_3_customer_type);
		self.lh_3_feid_ssn :=if(name_type= 'lh3',r.use_ssn,l.lh_3_feid_ssn) ; // party
		self.lh_3_customer_name :=if(name_type= 'lh3', r.Orig_Name,l.lh_3_customer_name); //party
		self.lh_3_driver_license_number :=if(name_type= 'lh3', r.Orig_DL_Number,l.lh_3_driver_license_number);// party
		self.lh_3_dob := if(name_type= 'lh3',if(((integer)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.lh_3_dob); // party
		self.lh_3_sex :=if(name_type= 'lh3', r.orig_sex,l.lh_3_sex);//party
		self.lh_3_address_number := if(name_type= 'lh3',r.Append_Clean_Address.prim_range,l.lh_3_address_number);//party
		self.lh_3_street_address := if(name_type= 'lh3',
		Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
		,l.lh_3_street_address); //party
		self.lh_3_apartment_number := if(name_type= 'lh3',r.Append_Clean_Address.sec_range,l.lh_3_apartment_number); //party
		self.lh_3_city := if(name_type= 'lh3',r.Append_Clean_Address.v_city_name,l.lh_3_city); // party
		self.lh_3_state :=if(name_type= 'lh3', r.Append_Clean_Address.st,l.lh_3_state); //party
		self.lh_3_zip5_zip4_foreign_postal := if(name_type= 'lh3',r.Append_Clean_Address.zip5,l.lh_3_zip5_zip4_foreign_postal); // party
		self.lh_3_residence_county := if(name_type='lh3',r.Append_Clean_Address.fips_county,l.lh_3_residence_county);
		self.lh_3_county_name := if(name_type='lh3',r.county_name,l.lh_3_county_name);	
		self.lh_3_zip5 := if(name_type= 'lh3',r.Append_Clean_Address.Zip5,l.lh_3_zip5);
		self.lh_3_zip4 := if(name_type='lh3',r.Append_Clean_Address.Zip4,l.lh_3_zip4);		
		
		self.license_plate_numberxbg4 := if(l.license_plate_numberxbg4<>'',l.license_plate_numberxbg4, r.Reg_License_Plate); //party
		self.true_license_plste_number := if(l.true_license_plste_number<>'',l.true_license_plste_number, r.Reg_License_Plate);	
		
		self.registration_effective_date :=if(l.registration_effective_date<>'',l.registration_effective_date, r.Reg_Latest_Effective_Date);
		self.registration_expiration_date :=if(l.registration_expiration_date<>'',l.registration_expiration_date, r.Reg_Latest_Expiration_Date);
		self.decal_number := if(l.decal_number<>'',l.decal_number, r.Reg_Decal_Number); // party
		self.decal_year := if(l.decal_year<>'',l.decal_year,r.Reg_Decal_Year);
		self.registration_status_code := if(l.registration_status_code<>'',l.registration_status_code, r.Reg_Status_Code);
		self.license_plate_code := if(l.license_plate_code<>'',l.license_plate_code, r.Reg_License_Plate_Type_Code);
		self.title_numberxbg9:=if(l.title_numberxbg9<>'',l.title_numberxbg9, r.Ttl_Number);
		self.title_issue_date :=if(l.title_issue_date<>'',l.title_issue_date, r.Ttl_Latest_Issue_Date);
		self.previous_title_issue_date := if(l.previous_title_issue_date<>'',l.previous_title_issue_date, r.Ttl_Previous_Issue_Date);
		self.title_status_code :=if(l.title_status_code<>'',l.title_status_code, r.Ttl_Status_Code);
		self.history_flag := if(C=1 or r.history='' or (r.history='E' and l.history_flag='H'), r.history,l.history_flag);

		date_last_seen := if(r.date_last_seen > l.dt_last_seen, r.date_last_seen,l.dt_last_seen);
		
		self.dt_last_seen := if(l.input.dateVal > 0 and date_last_seen > l.input.dateVal, 
        l.input.dateVal, date_last_seen);
		self.dt_vendor_last_reported := if(r.date_vendor_last_reported > l.dt_vendor_last_reported,
			r.date_vendor_last_reported,l.dt_vendor_last_reported);
		self.dt_first_seen := if((r.date_first_seen < l.dt_first_seen and r.date_first_seen <> 0) or C=1, r.date_first_seen,
			l.dt_first_seen);
		self.dt_vendor_first_reported := if((r.date_vendor_first_reported < l.dt_vendor_first_reported and r.date_vendor_first_reported <> 0) or C=1, r.date_vendor_first_reported,
			l.dt_vendor_first_reported);
		self.price := l.vina_price;
		self.history := self.history_flag;
		self.orig_state := r.state_origin;
		self.source := doxie_build.buildstate;
		self.first_registration_date :=if( ((unsigned4) r.reg_first_date < (unsigned4) l.first_registration_date and (unsigned4) r.reg_first_date <> 0) or c=1, r.reg_first_date,l.first_registration_date);
		pick := CASE((unsigned1) r.orig_name_type,
								1 => 1,
								2 => 2,
								4 => 3,
								5 => 4, 0);
		self.pick := if(l.wd_person_source=pick and l.pick = 0,
				map(name_type='own1'=> 1,
						name_type='own2' => 2,
						name_type='reg1' => 3,
						name_type='reg2'=>4,
						0),l.pick);//if(pick > 0 and pick < l.pick, pick, l.pick);					
		self.seq := l.input.seq;
		self := l;
		self := r;
		self := [];
	END;


	veh_w_owners0 := denormalize(veh_recs,dup_owner_recs,
		left.vehicle_key=right.vehicle_key and left.iteration_key=right.iteration_key
		and left.sequence_key = right.sequence_key,get_own(left,right,counter),grouped)
		(owner_1_customer_typexbg3 <> '' or registrant_1_customer_typexbg5 <> '' or
		lein_holder_1_customer_type <> '');

	Suppress.MAC_Mask(veh_w_owners0, veh_w_owners1, own_1_feid_ssn, null, true, false);
	Suppress.MAC_Mask(veh_w_owners1, veh_w_owners2, own_2_feid_ssn, null, true, false);
	Suppress.MAC_Mask(veh_w_owners2, veh_w_owners3, reg_1_feid_ssn, null, true, false);
	Suppress.MAC_Mask(veh_w_owners3, veh_w_owners4, reg_2_feid_ssn, null, true, false);
	Suppress.MAC_Mask(veh_w_owners4, veh_w_owners5, lh_1_feid_ssn,  null, true, false);
	Suppress.MAC_Mask(veh_w_owners5, veh_w_owners6, lh_2_feid_ssn,  null, true, false);
	Suppress.MAC_Mask(veh_w_owners6, shared gr_veh_w_owners, lh_3_feid_ssn, null, true, false);
			
	shared veh_w_owners := ungroup(gr_veh_w_owners);
	
	
	shared veh_w_owners_allowed := veh_w_owners((ln_branded_value OR source_code NOT IN mdr.Source_is_lnOnly) and
						(dateVal=0 OR dt_first_seen <= dateVal));


	cdk := codes.Key_Codes_V3;


layout_w_keys getDecode(layout_w_keys L, cdk R, STRING field) := 
transform
	self.history_name := IF(field = 'history_name',
		if((R.long_desc='CURRENT' and (l.registrant_1_customer_typexbg5<>'' or l.registrant_2_customer_type<>'')) or R.long_desc ='UNKNOWN'
		,R.long_desc,'HISTORICAL'),L.history_name);
	self.major_color_name := IF(field = 'major_color_name', R.long_desc, L.major_color_name);
	self.minor_color_name := IF(field = 'minor_color_name', R.long_desc, L.minor_color_name);
	self.orig_state_name := IF(field = 'state_origin_name', R.long_desc, L.orig_state_name);
	self.body_code_name := IF(field = 'body_code_name', R.long_desc, L.body_code_name);
	self.fuel_type_name := IF(field = 'fuel_type_name', R.long_desc, L.fuel_type_name);
	self.hull_material_type_name := IF(field = 'hull_material_type_name', R.long_desc, L.hull_material_type_name);
	self.license_plate_code_name := IF(field = 'license_plate_code_name', R.long_desc, L.license_plate_code_name);
	self.odometer_status_name := IF(field = 'odometer_status_name', R.long_desc, L.odometer_status_name);
	self.title_status_code_name := IF(field = 'title_status_code_name', R.long_desc, L.title_status_code_name);
	self.vehicle_type_name := IF(field = 'vehicle_type_name', R.long_desc, L.vehicle_type_name);
	self.vehicle_use_name := IF(field = 'vehicle_use_name', R.long_desc, L.vehicle_use_name);
	self.vessel_propulsion_type_name := IF(field = 'vessel_propulsion_type_name', R.long_desc, L.vessel_propulsion_type_name);
	self.vessel_type_name := IF(field = 'vessel_type_name', R.long_desc, L.vessel_type_name);
	self := L;
end;

o1 := join(veh_w_owners_allowed,cdk,
				keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND 
				keyed (right.field_name= (STRING50)'HISTORY_FLAG') AND
				(string15)Left.history = right.code,
			getDecode(LEFT,RIGHT,'history_name'),left outer, keep(1), limit(0));

o2 := join(o1,cdk,	
        keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'MAJOR_COLOR_CODE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.major_color_code = right.code),
			getDecode(LEFT, RIGHT, 'major_color_name'), left outer, KEEP(1), LIMIT(0));
o3 := join(o2,cdk,
        keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        keyed (right.field_name= (STRING50)'MINOR_COLOR_CODE') AND
        keyed ((string5)left.state_origin = right.field_name2) AND
        keyed ((string15)left.minor_color_code = right.code),
			getDecode(LEFT,RIGHT, 'minor_color_name'),left outer, KEEP(1), LIMIT(0));
o4 := join(o3,cdk,
        keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        keyed (right.field_name= (STRING50)'BODY_CODE') AND
        keyed ((string5)left.state_origin = right.field_name2) AND
        keyed ((string15)left.body_code = right.code),
			getDecode(LEFT,RIGHT,'body_code_name'),left outer, KEEP(1), LIMIT(0));
o5 := join(o4,cdk,
				keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'FUEL_TYPE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.fuel_type = right.code),
			getDecode(LEFT,RIGHT,'fuel_type_name'),left outer, KEEP(1), LIMIT(0));
o6 := join(o5,cdk,
        keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'HULL_MATERIAL_TYPE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.hull_material_type = right.code),
			getDecode(LEFT,RIGHT,'hull_material_type_name'),left outer, KEEP(1), LIMIT(0));
o7 := join(o6,cdk,
				keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'LICENSE_PLATE_CODE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.license_plate_code = right.code),
			getDecode(LEFT,RIGHT,'license_plate_code_name'),left outer, KEEP(1), LIMIT(0));
o8 := join(o7,cdk,
				keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'ODOMETER_STATUS') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.odometer_status = right.code),
			getDecode(LEFT,RIGHT,'odometer_status_name'),left outer, KEEP(1), LIMIT(0));
o9 := join(o8,cdk,	keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'TITLE_STATUS_CODE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.title_status_code = right.code),
			getDecode(LEFT,RIGHT,'title_status_code_name'),left outer, KEEP(1), LIMIT(0));
o10 := join(o9,cdk,	keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'VEHICLE_TYPE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.vehicle_type = right.code),
			getDecode(LEFT,RIGHT,'vehicle_type_name'),left outer, KEEP(1), LIMIT(0));
o11 := join(o10,cdk,
				keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'VEHICLE_USE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.vehicle_use = right.code),
			getDecode(LEFT,RIGHT,'vehicle_use_name'),left outer, KEEP(1), LIMIT(0));
o12 := join(o11,cdk,
				keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'VESSEL_PROPULSION_TYPE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.vessel_propulsion_type = right.code),
			getDecode(LEFT,RIGHT,'vessel_propulsion_type_name'),left outer, KEEP(1), LIMIT(0));
o13 := join(o12,cdk,
				keyed (right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
				keyed (right.field_name= (STRING50)'VESSEL_TYPE') AND
				keyed ((string5)left.state_origin = right.field_name2) AND
				keyed ((string15)left.vessel_type = right.code),
			getDecode(LEFT,RIGHT,'vessel_type_name'),left outer, KEEP(1), LIMIT(0));
o14 := join(o13,cdk,
				keyed (right.file_name = (STRING35)'GENERAL') AND
				keyed (right.field_name= (STRING50)'STATE_LONG') AND
				(string15)left.state_origin = right.code,
			getDecode(LEFT,RIGHT,'state_origin_name'),left outer, KEEP(1), LIMIT(0));
			
	out_layout := record
		doxie_Raw.Layout_VehRawBatchInput.input_layout input;
		doxie.Layout_VehicleSearch_wCrimInd;			
	end;

	out_layout map_lein_holder_county_names(o14 L) := transform
		self.vid :=(qstring25)  L.vehicle_numberxbg1;
		self := L;
	end;

	o15 := ungroup(project(o14,map_lein_holder_county_names(LEFT)));
	
	export v1_ret := o15;

END;



