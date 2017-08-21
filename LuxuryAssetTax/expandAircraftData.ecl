import faa, faaV2_services, Corp2, Address, codes;

export expandAircraftData( DATASET(LuxuryAssetTax.Layouts.IdVehicleRec) input, 
                   DATASET(faa.layout_aircraft_registration_out) aircraft,
									 DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) corpData,
									 BOOLEAN contactData = false) := FUNCTION

  distInput := DISTRIBUTE(input, HASH32(vehKey));
	distAircraft := DISTRIBUTE(aircraft, HASH32(n_number));
	distCorpData := DISTRIBUTE(corpData, HASH32(bdid));
	distCorpData1 := DEDUP(SORT(distCorpData, bdid, record_type, -dt_vendor_last_reported, local), bdid, local);
	aircraftInfo := PROJECT(faa.key_aircraft_info(), faa.layout_aircraft_info);
	
	LuxuryAssetTax.Layouts.outputRec extractAircraftFields(LuxuryAssetTax.Layouts.IdVehicleRec L, faa.layout_aircraft_registration_out R) := TRANSFORM
		SELF.rec.seqKey := R.last_action_date; //Need to a date for sorting (and dedupping?)
		SELF.rec.sort1 := L.vehKey;
		SELF.rec.sort2 := R.last_action_date;
		SELF.rec := L;

		SELF.out.Process_Flag := IF(contactData, 'WC', 'WOC');
		
		SELF.out.reg_1_did := (unsigned6) R.did_out;
		SELF.out.reg_1_bdid := (unsigned6) R.bdid_out;
		SELF.out.reg_1_first_name := R.fname;
		SELF.out.reg_1_middle_name := R.mname;
		SELF.out.reg_1_last_name := R.lname;
		SELF.out.reg_1_ssn := R.best_ssn;
		SELF.out.reg_1_company_name := R.compname;
		SELF.out.reg_1_address := R.street + R.street2; // TODO clean up
		SELF.out.reg_1_city := R.city;
		SELF.out.reg_1_state := R.state;
		SELF.out.reg_1_zip_code := R.zip_code;

		SELF.out.Type_Flag := 'AC';
		SELF.out.Id_Number := R.n_number;
		SELF.out.Year := R.year_mfr;
		SELF.out.Make := R.aircraft_mfr_name;
		SELF.out.Model := R.model_name;
		SELF.out.Body_Style := R.mfr_mdl_code; //Temp Value to link to aircraft info table
		SELF.out.Type_Description := '';
		SELF.out.Certification_Issue_Date := R.cert_issue_date;
		SELF.out.Last_Action_Date := R.last_action_date;
		status := TRIM(R.current_flag);
		SELF.out.Reg_Status := MAP((status='A')=>'ACTIVE'
															  ,(status='H')=>'HISTORICAL'
															  ,'');
		reg := TRIM(R.type_registrant);
		SELF.out.Reg_Type := MAP((reg='1')=>'Individual'
														  ,(reg='2')=>'Partnership'
														  ,(reg='3')=>'Corporation'
														  ,(reg='4')=>'Co-Owned'
														  ,(reg='5')=>'Government'
														  ,(reg='6')=>'Non Citizen Corporation'
														  ,(reg='7')=>'Non Citizen Co-Owned'
														  ,'');
		
		SELF.out := [];
	END;

	out1 := JOIN(distInput, 
							 distAircraft, 
							 LEFT.vehKey = RIGHT.n_number, 
							 extractAircraftFields(LEFT, RIGHT), local);
							 
	LuxuryAssetTax.Layouts.outputRec addAircraftInfo(LuxuryAssetTax.Layouts.outputRec L, faa.layout_aircraft_info R) := TRANSFORM
		SELF.out.Body_Style := codes.FAA_AIRCRAFT_REF.AIRCRAFT_CATEGORY_CODE(R.aircraft_category_code);
		SELF.out.Type_Description := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(R.type_aircraft);
		
		SELF := L;
	END;
	
	out1a := JOIN(out1,
	              aircraftInfo,
								LEFT.out.Body_Style = RIGHT.aircraft_mfr_model_code,
								addAircraftInfo(LEFT, RIGHT));
	

	LuxuryAssetTax.Layouts.outputRec extractCorpFields(LuxuryAssetTax.Layouts.outputRec L, Corp2.Layout_Corporate_Direct_Corp_Base R) := TRANSFORM
    SELF.rec.lastReportDate := R.dt_vendor_last_reported;
		
		SELF.out.Charter_Number := R.corp_orig_sos_charter_nbr;
		SELF.out.Corp_Name := R.corp_legal_name;
		SELF.out.Status := R.corp_status_desc;
		SELF.out.Incorp_State := R.corp_state_origin;

		SELF.out.Incorp_Date := IF(R.corp_inc_date<>'',
		                           R.corp_inc_date,
															 R.corp_forgn_date);

		SELF.out.Orig_org_struct_description := R.corp_orig_org_structure_desc;
		SELF.out.corp_addr := Address.Addr1FromComponents(
		                          R.corp_addr1_prim_range, 
															R.corp_addr1_predir, 
															R.corp_addr1_prim_name,
															R.corp_addr1_addr_suffix, 
															R.corp_addr1_postdir, 
															R.corp_addr1_unit_desig, 
															R.corp_addr1_sec_range) + ' ' +
															IF(R.corp_addr1_p_city_name<>'',trim(R.corp_addr1_p_city_name)+', ','') +
															IF(R.corp_addr1_state<>'',trim(R.corp_addr1_state)+' ','') +
															IF(R.corp_addr1_zip5<>'',trim(R.corp_addr1_zip5),'') +
															IF(trim(R.corp_addr1_zip4)<>'','-'+ trim(R.corp_addr1_zip4),'');
		SELF.out.reg_agent_name := R.corp_ra_name;
		SELF.out.reg_agent_addr := Address.Addr1FromComponents(R.corp_ra_prim_range, 
																											R.corp_ra_predir, 
																											R.corp_ra_prim_name,
																											R.corp_ra_addr_suffix, 
																											R.corp_ra_postdir, 
																											R.corp_ra_unit_desig, 
																											R.corp_ra_sec_range) +
														 IF(R.corp_ra_p_city_name<>'',trim(R.corp_ra_p_city_name)+', ','') +
														 IF(R.corp_ra_state<>'',trim(R.corp_ra_state)+' ','') +
														 IF(R.corp_ra_zip5<>'',trim(R.corp_ra_zip5),'') +
														 IF(trim(R.corp_ra_zip4)<>'','-'+ trim(R.corp_ra_zip4),'');
		SELF := L;
	END;

	distOut1 := DISTRIBUTE(out1a, HASH32(rec.id));

	out2 := JOIN(distOut1, 
							 distCorpData1, 
							 LEFT.rec.id = RIGHT.bdid, 
							 extractCorpFields(LEFT, RIGHT), local);

	out2a := JOIN(out2, 
  						 distCorpData1, 
							 LEFT.out.owner1_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.own_1_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);

	out2b := JOIN(out2a, 
  						 distCorpData1, 
							 LEFT.out.owner2_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.own_2_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);

	out2c := JOIN(out2b, 
  						 distCorpData1, 
							 LEFT.out.reg_1_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.reg_1_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);

	out2d := JOIN(out2c, 
  						 distCorpData1, 
							 LEFT.out.reg_2_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.reg_2_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);

	LuxuryAssetTax.Layouts.outputRec setFlags(LuxuryAssetTax.Layouts.outputRec L) := TRANSFORM
		compare_date := IF(L.out.Last_Action_Date <> '',
		                   L.out.Last_Action_Date,
											 '');
														    
		SELF.out.Incorp_Reg_Year_Match := 
		     IF(compare_date <> '' AND compare_date[1..4] = L.out.Incorp_Date[1..4], 'Y', 'N');
		SELF.out.Bought_Before_LLC_Incorp := 
		     IF(compare_date <> '' AND compare_date < L.out.Incorp_Date, 'Y', 'N');
		SELF.out.Business_Owned := 
		     IF(L.rec.corp_key = L.out.own_1_corp_key 
				    OR L.rec.corp_key = L.out.own_2_corp_key 
						OR L.rec.corp_key = L.out.reg_1_corp_key 
						OR L.rec.corp_key = L.out.reg_2_corp_key,
				    'Y', 'N');
		//Default - will will be updated in expandContactInfo if applicable
		SELF.out.Contact_Owned := 'N';
		SELF := L;
	END;	
	
	out3 := PROJECT(out2d, setFlags(LEFT));
	
	sortedOut3 := SORT(out3, rec.id, out.Id_Number, rec.vehKey, out.Certification_Issue_Date);

  RETURN sortedOut3;
END;