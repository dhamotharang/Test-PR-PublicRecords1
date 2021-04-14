IMPORT STD; 

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
EXPORT Map_eCrashAccidents_To_eCrashConsolidation := NORMALIZE(eCrashAccidents(is_terminated_agency = FALSE), 2, teCrashAccidents(LEFT, COUNTER));
