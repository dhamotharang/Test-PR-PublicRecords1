EXPORT map_basefile(STRING filedate) := FUNCTION

IMPORT FLAccidents, Address, ut, driversv2, STD, scrubs, scrubs_ecrash, nid, PromoteSupers;

  eCrashCombined := Infiles.eCrashCmbnd;
  vina	:= DISTRIBUTE(FLAccidents.File_VINA, HASH32(Vin_Input));
  dvina := DEDUP(SORT(vina, Vin_Input, -((UNSIGNED)Model_Year), RECORD, LOCAL), Vin_Input, LOCAL):PERSIST('~thor_data400::persist::ecrash_vina');
  AgencyCombined := Infiles.Agencycmbnd;
	
// #############################################################################################
// Clean names and addresses then append vina info
// #############################################################################################
  temp_addr_layout := RECORD
		eCrashCombined;
		STRING temp_addr1 := '';
		STRING temp_addr2 := '';
  END;

	temp_addr_layout tAddrCleanSpaces(eCrashCombined L) := TRANSFORM
		SELF.temp_addr1 := STD.Str.CleanSpaces(TRIM(L.Address, LEFT, RIGHT));
		SELF.temp_addr2 := STD.Str.CleanSpaces(TRIM(L.CITY, LEFT, RIGHT) + IF(TRIM(L.CITY, LEFT, RIGHT) <> '',', ',' ') + 
		                                       TRIM(L.STATE, LEFT, RIGHT) + ' ' + TRIM(L.ZIP_code, LEFT, RIGHT)[1..5]);
		SELF := L;
	END;
  eCrashCmbndAddr := PROJECT(eCrashCombined, tAddrCleanSpaces(LEFT));
 
  eCrashCmbndBlankAddr := eCrashCmbndAddr(temp_addr1 = '' AND temp_addr2 = ''); 
  eCrashCmbndNBlankAddr := eCrashCmbndAddr(~(temp_addr1 = '' AND temp_addr2 = '')); 

//Clean address
  Address.MAC_Address_Clean(eCrashCmbndNBlankAddr, temp_addr1, temp_addr2, TRUE, appndAddr);	
  eCrashCmbndCleanAddr := appndAddr + PROJECT(eCrashCmbndBlankAddr, TRANSFORM({appndAddr}, SELF.clean := '', SELF := LEFT));	

// Add name_type
  Address.Mac_Is_Business_Parsed(eCrashCmbndCleanAddr, eCrashPreClean, FIRST_NAME, MIDDLE_NAME, LAST_NAME, '');

// #############################################################################################
//                  Join eCrashCmbnd & Vina
// #############################################################################################	
//Parse appended 182 byte clean address field and standardize data values
  Layout_BaseFile teCrashVinVina(eCrashPreClean L, dvina R) := TRANSFORM
		SELF.date_vendor_first_reported := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.Sent_to_HPCC_DateTime);
		SELF.date_vendor_last_reported := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.Sent_to_HPCC_DateTime);
		CrashDate := IF(TRIM(L.crash_date, LEFT, RIGHT) <> '0000-00-00',
										STD.Str.FilterOut(TRIM(L.crash_date, LEFT, RIGHT),'-'),
										'');
		SELF.crash_date := CrashDate;
		SELF.dt_first_seen := CrashDate;
		SELF.dt_last_seen := CrashDate;
		SELF.creation_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.creation_date);
		SELF.date_of_birth := IF(TRIM(L.date_of_birth, LEFT, RIGHT)[1..10] <> '0000-00-00',
														 Functions.dateconv(L.date_of_birth),
														 '');
		SELF.officer_report_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.officer_report_date);
		SELF.ems_notified_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.ems_notified_date);				
		SELF.ems_arrival_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.ems_arrival_date);
		SELF.death_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.death_date);
		SELF.home_phone := STD.Str.Filter(L.home_phone,'0123456789');
		set_ptype := ['P1','P2','P3','P4','P5','P6','P7','P8','P9'];
		SELF.person_type := IF(L.person_type IN set_ptype,'PASSENGER', L.person_type);
		SELF.passenger_number := IF(L.passenger_number <> '0', L.passenger_number, '');
		SELF.total_occupants_in_vehicle := IF(L.total_occupants_in_vehicle <> '0', L.total_occupants_in_vehicle, '');
		SELF.number_of_vehicles := IF(L.number_of_vehicles <> '0', L.number_of_vehicles, '');
		SELF.loss_street_speed_limit := IF(L.loss_street_speed_limit <> '0', L.loss_street_speed_limit, '');
		SELF.vehicle_towed_derived := IF(L.vehicle_towed_derived <> '0', L.vehicle_towed_derived, '');
		SELF.age := IF(L.age <> '0', L.age, '');
		SELF.cru_order_id := IF(L.cru_order_id <> '0', L.cru_order_id, '');
		SELF.cru_sequence_nbr := IF(L.cru_sequence_nbr <> '0', L.cru_sequence_nbr, '');
		SELF.city_code := IF(L.city_code <> '00', L.city_code, '');
		SELF.other_unit_vehicle_damage_amount := L.other_unit_vehicle_damage_amount[1..STD.Str.Find(L.other_unit_vehicle_damage_amount, '.', 1)-1] + '00';
		SELF.report_code := MAP(L.source_id ='TF' => 'TF', 
														L.source_id ='TM' => 'TM',
														'EA');
		SELF.report_category := Tables_eCrash.ReportCategory(L.report_type_id);
		SELF.report_code_desc := Tables_eCrash.ReportCodeDesc(L.report_type_id);									
		SELF.prim_range := L.clean[1..10]; 
		SELF.predir := L.clean[11..12];					   
		SELF.prim_name := L.clean[13..40];
		SELF.addr_suffix := L.clean[41..44];
		SELF.postdir := L.clean[45..46];
		SELF.unit_desig := L.clean[47..56];
		SELF.sec_range := L.clean[57..64];
		SELF.p_city_name := L.clean[65..89];
		SELF.v_city_name := L.clean[90..114];
		SELF.st := IF(L.clean[115..116] = '', ziplib.ZipToState2(L.clean[117..121]), L.clean[115..116]);
		SELF.z5 := L.clean[117..121];
		SELF.z4 := L.clean[122..125];
		SELF.cart := L.clean[126..129];
		SELF.cr_sort_sz := L.clean[130];
		SELF.lot := L.clean[131..134];
		SELF.lot_order := L.clean[135];
		SELF.dpbc := L.clean[136..137];
		SELF.chk_digit := L.clean[138];
		SELF.rec_type := L.clean[139..140];
		SELF.county_code := L.clean[141..145];
		SELF.geo_lat := L.clean[146..155];
		SELF.geo_long := L.clean[156..166];
		SELF.msa := L.clean[167..170];
		SELF.geo_blk := L.clean[171..177];
		SELF.geo_match := L.clean[178];
		SELF.err_stat := L.clean[179..182];
	//Parse 73 byte clean name field
		CleanName := IF(L.nametype <> 'B', Address.CleanPersonFML73(REGEXREPLACE(' +', L.FIRST_NAME + ' ' + L.MIDDLE_NAME + ' ' + L.LAST_NAME, ' ')),'');
		SELF.nameType := L.nametype;	
		lfname := IF(L.nametype <> 'B', CleanName[6..25], L.FIRST_NAME);
		lmname := IF(L.nametype <> 'B', CleanName[26..45], L.MIDDLE_NAME);
		llname := IF(L.nametype <> 'B', CleanName[46..65], L.LAST_NAME);
		SELF.title := IF(L.nametype <> 'B', CleanName[1..5], '');
		SELF.fname := IF(lfname = 'UNKNOWN', '', lfname);
		SELF.mname := IF(lmname = 'UNKNOWN', '', lmname);
		SELF.lname := IF(llname = 'UNKNOWN', '', llname);
		SELF.suffix := IF(L.nametype <> 'B', CleanName[66..70], '');
		SELF.name_score := IF(L.nametype <> 'B', CleanName[71..73], '');
		SELF.cname := IF(L.nametype = 'B', L.FIRST_NAME + ' ' + L.MIDDLE_NAME + ' ' + L.LAST_NAME, '');
		SELF.orig_fname := L.FIRST_NAME;
		SELF.orig_lname := L.last_name;
		SELF.orig_mname := L.middle_name;
	// populated by Vina File
		SELF.vehicle_seg := IF(L.vin = R.vin_input, R.variable_segment, '');	
		SELF.vehicle_seg_type := IF(L.vin = R.vin_input, R.veh_type, '');	
		SELF.model_year := IF(L.vin = R.vin_input, R.model_year, '');	
		SELF.body_style_code := IF(L.vin = R.vin_input, R.vina_body_style, '');	
		SELF.engine_size := IF(L.vin = R.vin_input, R.engine_size, '');	
		SELF.fuel_code := IF(L.vin = R.vin_input, R.fuel_code, '');	
		SELF.number_of_driving_wheels	:= IF(L.vin = R.vin_input, R.vp_tilt_wheel, '');	
		SELF.steering_type := IF(L.vin = R.vin_input, R.vp_power_steering, '');		
		SELF.vina_series := IF(L.vin = R.vin_input, R.vina_series, '');	
		SELF.vina_model := IF(L.vin = R.vin_input, R.vina_model, '');	
		SELF.vina_make := IF(L.vin = R.vin_input, R.make_description, '');	
		SELF.vina_body_style := IF(L.vin = R.vin_input, R.vina_body_style, '');		
		SELF.make_description := IF(L.vin = R.vin_input, R.make_description, TRIM(L.make, LEFT, RIGHT));			
		SELF.model_description := IF(L.vin = R.vin_input, R.model_description, L.model);		
		SELF.series_description := IF(L.vin = R.vin_input, R.series_description, '');	
		SELF.car_cylinders := IF(L.vin = R.vin_input, R.number_of_cylinders, '');		
		prefix := MAP(//le.report_code[1] = 'I' and le.vehicle_incident_id[1..3] = 'OID'    => 1000000000000,
									//le.report_code[1] = 'I' => 2000000000000,
									 SELF.report_code = 'EA' => 3000000000000,
									 SELF.report_code = 'TM' => 4000000000000,
									 SELF.report_code = 'TF' => 5000000000000, 
									//le.report_code = 'FA' => 6000000000000,
									 0);
		SELF.idfield := prefix + (UNSIGNED6) L.incident_id;  
		SELF := L;
		SELF := [];
  END;
  jeCrashVin_Vina := JOIN(DISTRIBUTE(eCrashPreClean(vin <> ''), HASH32(vin)), dvina,
				                  LEFT.vin = RIGHT.vin_input,
				                  teCrashVinVina(LEFT, RIGHT), LEFT OUTER, LOCAL);				
//Get blank vin records 
  Layout_BaseFile teCrashNoVin(eCrashPreClean L) := TRANSFORM
    SELF.date_vendor_first_reported := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.Sent_to_HPCC_DateTime);
    SELF.date_vendor_last_reported  := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.Sent_to_HPCC_DateTime);
		CrashDate := IF(TRIM(L.crash_date, LEFT, RIGHT) <> '0000-00-00',
										STD.Str.FilterOut(TRIM(L.crash_date, LEFT, RIGHT),'-'),
										'');
		SELF.crash_date := CrashDate;
		SELF.dt_first_seen := CrashDate;
		SELF.dt_last_seen := CrashDate;
    SELF.creation_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.creation_date);
    SELF.date_of_birth := IF(TRIM(L.date_of_birth, LEFT, RIGHT)[1..10] <> '0000-00-00',
                             Functions.dateconv(L.date_of_birth),
														 '');
    SELF.officer_report_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.officer_report_date);																				
    SELF.ems_notified_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.ems_notified_date);																				
    SELF.ems_arrival_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.ems_arrival_date);
    SELF.death_date := mod_Utilities.ConvDtTimeStampToYYYYMMDD(L.death_date);
    SELF.home_phone := STD.Str.Filter(L.home_phone,'0123456789');
     set_ptype := ['P1','P2','P3','P4','P5','P6','P7','P8','P9'];
    SELF.person_type := IF(L.person_type IN set_ptype,'PASSENGER', L.person_type);
    SELF.passenger_number := IF(L.passenger_number <> '0', L.passenger_number, '');
    SELF.total_occupants_in_vehicle	:= IF(L.total_occupants_in_vehicle <> '0', L.total_occupants_in_vehicle, '');
    SELF.number_of_vehicles := IF(L.number_of_vehicles <> '0', L.number_of_vehicles, '');
    SELF.loss_street_speed_limit := IF(L.loss_street_speed_limit <> '0', L.loss_street_speed_limit, '');
    SELF.vehicle_towed_derived := IF(L.vehicle_towed_derived <> '0', L.vehicle_towed_derived, '');
    SELF.age := IF(L.age <> '0', L.age, '');
    SELF.cru_order_id := IF(L.cru_order_id <> '0', L.cru_order_id, '');
    SELF.cru_sequence_nbr := IF(L.cru_sequence_nbr <> '0', L.cru_sequence_nbr, '');
    SELF.city_code := IF(L.city_code <> '00', L.city_code, '');
    SELF.other_unit_vehicle_damage_amount := L.other_unit_vehicle_damage_amount[1..STD.Str.Find(L.other_unit_vehicle_damage_amount, '.', 1)-1] + '00';
    SELF.report_code := MAP(L.source_id = 'TF' => 'TF', 
		                        L.source_id = 'TM' => 'TM',
														'EA');
		SELF.report_category := Tables_eCrash.ReportCategory(L.report_type_id);
		SELF.report_code_desc := Tables_eCrash.ReportCodeDesc(L.report_type_id);									
    SELF.prim_range := L.clean[1..10]; 
    SELF.predir := L.clean[11..12];					   
    SELF.prim_name := L.clean[13..40];
    SELF.addr_suffix := L.clean[41..44];
    SELF.postdir := L.clean[45..46];
    SELF.unit_desig := L.clean[47..56];
    SELF.sec_range := L.clean[57..64];
    SELF.p_city_name := L.clean[65..89];
    SELF.v_city_name := L.clean[90..114];
    SELF.st := IF(L.clean[115..116]='', ziplib.ZipToState2(L.clean[117..121]), L.clean[115..116]);
    SELF.z5 := L.clean[117..121];
    SELF.z4 := L.clean[122..125];
    SELF.cart := L.clean[126..129];
    SELF.cr_sort_sz := L.clean[130];
    SELF.lot := L.clean[131..134];
    SELF.lot_order := L.clean[135];
    SELF.dpbc := L.clean[136..137];
    SELF.chk_digit := L.clean[138];
    SELF.rec_type := L.clean[139..140];
    SELF.county_code := L.clean[141..145];
    SELF.geo_lat := L.clean[146..155];
    SELF.geo_long := L.clean[156..166];
    SELF.msa := L.clean[167..170];
    SELF.geo_blk := L.clean[171..177];
    SELF.geo_match := L.clean[178];
    SELF.err_stat := L.clean[179..182];
    //Parse 73 byte clean name field
    CleanName := IF (L.nametype <> 'B', Address.CleanPersonFML73(REGEXREPLACE(' +', L.FIRST_NAME + ' ' + L.MIDDLE_NAME + ' ' + L.LAST_NAME, ' ')),'');
    SELF.nameType := L.nametype;	
    lfname := IF(L.nametype <> 'B',CleanName[6..25], L.FIRST_NAME);
    lmname := IF(L.nametype <> 'B',CleanName[26..45], L.MIDDLE_NAME);
    llname := IF(L.nametype <> 'B',CleanName[46..65], L.LAST_NAME);
    SELF.title := IF(L.nametype <> 'B', CleanName[1..5], '');
    SELF.fname := IF(lfname ='UNKNOWN', '', lfname);
    SELF.mname := IF(lmname ='UNKNOWN', '', lmname);
    SELF.lname := IF(llname ='UNKNOWN', '', llname);
    SELF.suffix := IF(L.nametype <> 'B', CleanName[66..70], '');
    SELF.name_score := IF(L.nametype <> 'B', CleanName[71..73], '');
    SELF.cname := IF(L.nametype = 'B',L.FIRST_NAME + ' '+ L.MIDDLE_NAME + ' ' + L.LAST_NAME, '');
    SELF.orig_fname := L.FIRST_NAME;
    SELF.orig_lname := L.last_name;
    SELF.orig_mname := L.middle_name;
	  prefix := MAP(//le.report_code[1] = 'I' and le.vehicle_incident_id[1..3] = 'OID'    => 1000000000000,
                  //le.report_code[1] = 'I' => 2000000000000,
                  SELF.report_code = 'EA' => 3000000000000,
                  SELF.report_code = 'TM' => 4000000000000,
                  SELF.report_code = 'TF' => 5000000000000, 
                  //le.report_code = 'FA' => 6000000000000,
                  0);
    SELF.idfield := prefix + (UNSIGNED6) L.incident_id;
    SELF := L;
    SELF := [];
  END;
  peCrashNoVin := PROJECT(eCrashPreClean(vin = ''), teCrashNoVin(LEFT));
			
  eCrashClean := jeCrashVin_Vina + peCrashNoVin:PERSIST('~thor_data400::persist::ecrash_clean');
	
// #############################################################################################
// Append DID using lfname and dl match --bug # 48839
// #############################################################################################	
  eCrashADL := Fn_AppendADL(eCrashClean);
	
// #############################################################################################
// Join eCrash Reports with Supplemental Reports to get super_report_id
// #############################################################################################
  eCrashAccidents := DEDUP(SORT(DISTRIBUTE(eCrashADL, HASH32(incident_id)), RECORD, LOCAL), RECORD, LOCAL):PERSIST('~thor_data400::persist::ecrash_did');	
	dsSupplemental := DISTRIBUTE(Files.base.Supplemental, HASH32(incident_id)); 
	jeCrash_Supplemental := JOIN(eCrashAccidents, dsSupplemental, 
												       LEFT.incident_id = RIGHT.incident_id, 
												       TRANSFORM(Layout_Basefile,
																         SELF.super_report_id := RIGHT.super_report_id,
																				 SELF := LEFT), LEFT OUTER, LOCAL); 
										 
// #############################################################################################
// Apply Scrubs to eCrash reports
// #############################################################################################	
	eCrashScrub := PROJECT(jeCrash_Supplemental, Layouts.scrubs);	
	eCrashScrubStep1 := scrubs_ecrash.Scrubs.FromNone(eCrashScrub);
  maxprocessdate := MAX(eCrashScrubStep1.ExpandedInFile(date_vendor_last_reported [1..2]= '20'), date_vendor_last_reported);
	eCrashScrubStep2 := scrubs_ecrash.Scrubs.FromExpanded(eCrashScrubStep1.ExpandedInFile(date_vendor_last_reported = maxprocessdate)); 
	
//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
	eCrashOrbitstats := eCrashScrubStep2.OrbitStats():PERSIST('~persist::ecrash_scrubs_rpt');
//Submits stats to Orbit
	eCrashSubmitStats := Scrubs.OrbitProfileStats('Scrubs_eCrash',, eCrashOrbitstats, filedate).SubmitStats;
//Output Scrubs report with examples in WU
	eCrashScrubsReportWithExamples := Scrubs.OrbitProfileStats('Scrubs_eCrash',, eCrashOrbitstats, filedate).CompareToProfile_with_examples;
//Send Alerts and Scrubs reports via email 
	eCrashScrubsAlert := eCrashScrubsReportWithExamples(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(eCrashScrubsAlert);	
  mailfile := STD.System.Email.SendEmailAttachData ('DataDevelopment-InsRiskeCrash@lexisnexisrisk.com; sudhir.kasavajjala@lexisnexis.com',
																						        'Scrubs eCrash Report ', //subject
																						        'Scrubs eCrash Report ', //body
																						        (data)attachment,
																						        'text/csv',
																						        'ScrubsReport.csv',
																						        ,
																					          ,
																						        'sudhir.kasavajjala@lexisnexis.com');	
  //append bitmap to base
  eCrashAccidentsAll := PROJECT(eCrashScrubStep1.BitmapInfile, Layout_Basefile):PERSIST('~thor_data400::persist::ecrash_base'); 
											 
// #############################################################################################
// Insurance eCrashSlim Base file
// #############################################################################################	
  Layout_InseCrashSlim t_eCrashSlim(eCrashAccidentsAll L) := TRANSFORM
	  //fabricated
		SELF.accident_nbr := IF(L.source_id IN ['TM','TF'], L.state_report_number, L.case_identifier);
		SELF.accident_date := IF(L.incident_id[1..9] = '188188188', '20100901', L.crash_date);
		SELF.impact_location := IF(L.report_code = 'TM',
                               IF(L.initial_point_of_contact[1..25] <> '','Damaged_Area_1: ' + L.initial_point_of_contact[1..25], '')
															 +
														   IF(L.initial_point_of_contact[25..] <> '','Damaged_Area_2: ' + L.initial_point_of_contact[25..], ''),
														   IF(L.damaged_areas_derived1 <> '', 'Damaged_Area_1: ' + L.damaged_areas_derived1, '') 
															 +
															 IF(L.damaged_areas_derived2 <> '','Damaged_Area_2: ' + L.damaged_areas_derived2,'')
														  );
		SELF := L;
	END;
	pInseCrashSlim := PROJECT(eCrashAccidentsAll, t_eCrashSlim(LEFT)):PERSIST('~thor_data400::persist::InseCrashSlim_base', SINGLE);
											 
// #############################################################################################
// Build & Promote Base files
// 1) eCrashBase 2) InseCrashSlimBase 3) SupplementalBase
// 4) DocumentBase 5) AgencyBase
// #############################################################################################			
 	PromoteSupers.Mac_SF_BuildProcess(eCrashAccidentsAll, '~thor_data400::base::ecrash', BuildeCrashBase, , , TRUE);
 	PromoteSupers.Mac_SF_BuildProcess(pInseCrashSlim, '~thor_data400::base::InseCrashSlim', BuildInseCrashSlimBase , , , TRUE);
  PromoteSupers.Mac_SF_BuildProcess(BuildSuppmentalReports.compare_add_new, '~thor_data400::base::ecrash_supplemental', BuildSupplementalBase, , , TRUE);
	PromoteSupers.Mac_SF_BuildProcess(BuildPhotoFile.CmbndPhotos, '~thor_data400::base::ecrash_documents', BuildPhotoIDBase, , , TRUE);
	PromoteSupers.Mac_SF_BuildProcess(AgencyCombined, '~thor_data400::base::agency_cmbnd', BuildAgencyCmbndBase, , , TRUE);

RETURN SEQUENTIAL(BuildSupplementalBase,
                  eCrashSubmitStats,
		              OUTPUT(eCrashScrubsReportWithExamples, ALL, NAMED('ScrubsReportWithExamples')),
		              IF(COUNT(eCrashScrubsAlert) > 1, mailfile, OUTPUT('No_Scrubs_Alerts')),
                  BuildeCrashBase,
									BuildInseCrashSlimBase,
									BuildPhotoIDBase,
									BuildAgencyCmbndBase,
									fn_Validate,
									Proc_Build_Consolidation(filedate),
									//Validate CRU Base file count -- DF-27413
		              FLAccidents_Ecrash.fn_Validate_cru(filedate) 
								 );

END;