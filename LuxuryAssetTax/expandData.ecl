import VehicleV2, Corp2, Address;

export expandData( DATASET(LuxuryAssetTax.Layouts.IdVehicleRec) input, 
                   DATASET(VehicleV2.Layout_Base_Party) vehParty,
									 DATASET(VehicleV2.Layout_Base_Main) vehMain,
									 DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) corpData,
									 BOOLEAN contactData = false) := FUNCTION

  distInput := DISTRIBUTE(input, HASH32(vehKey));
	distVehParty := DISTRIBUTE(vehParty, HASH32(vehicle_key));
	distVehMain := DISTRIBUTE(vehMain, HASH32(vehicle_key));
	distCorpData := DISTRIBUTE(corpData, HASH32(bdid));
	distCorpData1 := DEDUP(SORT(distCorpData, bdid, record_type, -dt_vendor_last_reported, local), bdid, local);
	
	LuxuryAssetTax.Layouts.outputRec extractPartyFieldsPass(LuxuryAssetTax.Layouts.IdVehicleRec L, VehicleV2.Layout_Base_Party R) := TRANSFORM
		SELF.rec.sort1 := L.iterKey;
		SELF.rec.sort2 := L.seqKey;
		SELF.rec := L;
		
		SELF.out.Process_Flag := IF(contactData, 'WC', 'WOC');
		
		SELF.out.owner1_did := IF(R.orig_name_type = '1', R.Append_DID, 0);
		SELF.out.owner1_bdid := IF(R.orig_name_type = '1', R.Append_BDID, 0);
		SELF.out.owner1_first_name := IF(R.orig_name_type = '1', R.Append_Clean_Name.fname, '');
		SELF.out.owner1_middle_name := IF(R.orig_name_type = '1', R.Append_Clean_Name.mname, '');
		SELF.out.owner1_last_name := IF(R.orig_name_type = '1', R.Append_Clean_Name.lname, '');
		SELF.out.owner1_SSN := IF(R.orig_name_type = '1', 
		                          IF(R.Orig_SSN != '', R.Orig_SSN, R.Append_SSN),
															'');
		SELF.out.owner1_company_name := IF(R.orig_name_type = '1', R.Append_Clean_CName, '');
		SELF.out.owner1_address := IF(R.orig_name_type = '1', R.Orig_Address, '');
		SELF.out.owner1_city := IF(R.orig_name_type = '1', R.Orig_City, '');
		SELF.out.owner1_state := IF(R.orig_name_type = '1', R.Orig_State, '');
		SELF.out.owner1_zip_code := IF(R.orig_name_type = '1', R.Orig_Zip, '');		

		SELF.out.reg_1_did := IF(R.orig_name_type = '1', 0, R.Append_DID);
		SELF.out.reg_1_bdid := IF(R.orig_name_type = '1', 0, R.Append_BDID);
		SELF.out.reg_1_first_name := IF(R.orig_name_type = '1', '', R.Append_Clean_Name.fname);
		SELF.out.reg_1_middle_name := IF(R.orig_name_type = '1', '', R.Append_Clean_Name.mname);
		SELF.out.reg_1_last_name := IF(R.orig_name_type = '1', '', R.Append_Clean_Name.lname);
		SELF.out.reg_1_ssn := IF(R.orig_name_type = '1', 
		                         '', 
														 IF(R.Orig_SSN != '', R.Orig_SSN, R.Append_SSN));
		SELF.out.reg_1_company_name := IF(R.orig_name_type = '1', '', R.Append_Clean_CName);
		SELF.out.reg_1_address := IF(R.orig_name_type = '1', '', R.Orig_Address);
		SELF.out.reg_1_city := IF(R.orig_name_type = '1', '', R.Orig_City);
		SELF.out.reg_1_state := IF(R.orig_name_type = '1', '', R.Orig_State);
		SELF.out.reg_1_zip_code := IF(R.orig_name_type = '1', '', R.Orig_Zip);

		SELF.out.Type_Flag := 'MV';
		SELF.out.First_Reg_Date := R.Reg_First_Date;
		SELF.out.Earliest_Reg_Date := R.Reg_Earliest_Effective_Date;
		SELF.out.Latest_Reg_Date := R.Reg_Latest_Effective_Date;
		SELF.out.Expiration_Date := R.Reg_Latest_Expiration_Date;
		SELF.out.Reg_Decal_Number := R.Reg_Decal_Number;
		SELF.out.Reg_Status := R.Reg_Status_Desc;
		SELF.out.Reg_Type := R.Reg_License_Plate_Type_Desc;
		SELF.out.Title_Number := R.Ttl_Number;
		SELF.out.Earliest_Title_Date := R.Ttl_Earliest_Issue_Date;
		SELF.out.Title_Latest_Issue_Date := R.Ttl_Latest_Issue_Date;
		SELF.out.Title_Status := R.Ttl_Status_Desc;
		SELF.out.Tag_Number := R.Reg_License_Plate;
		SELF.out.Tag_State := R.Reg_License_State;
		
		SELF.out := [];
	END;

	//LEFT/RIGHT intentionally reversed for performance.
	out1 := JOIN(distVehParty, 
							 distInput, 
							 RIGHT.vehKey = LEFT.Vehicle_Key AND 
							 RIGHT.iterKey = LEFT.Iteration_Key AND
							 RIGHT.seqKey = LEFT.Sequence_Key, 
							 extractPartyFieldsPass(RIGHT, LEFT), 
							 RIGHT OUTER,
							 local);

	LuxuryAssetTax.Layouts.outputRec rollupRegistrations(LuxuryAssetTax.Layouts.outputRec L, LuxuryAssetTax.Layouts.outputRec R) := TRANSFORM
	  Boolean owner1Found := L.out.owner1_did != 0 OR
		                       L.out.owner1_bdid != 0 OR
													 trim(L.out.owner1_first_name) != '' OR
													 trim(L.out.owner1_middle_name) != '' OR
													 trim(L.out.owner1_last_name) != '' OR
													 trim(L.out.owner1_SSN) != '' OR
													 trim(L.out.owner1_company_name) != '' OR
													 trim(L.out.owner1_address) != '' OR
													 trim(L.out.owner1_city) != '' OR
													 trim(L.out.owner1_state) != '' OR
													 trim(L.out.owner1_zip_code) != '';
													 
		SELF.out.owner1_did := IF(owner1Found, L.out.owner1_did, R.out.owner1_did);
		SELF.out.owner1_bdid := IF(owner1Found, L.out.owner1_bdid, R.out.owner1_bdid);
		SELF.out.owner1_first_name := IF(owner1Found, L.out.owner1_first_name, R.out.owner1_first_name);
		SELF.out.owner1_middle_name := IF(owner1Found, L.out.owner1_middle_name, R.out.owner1_middle_name);
		SELF.out.owner1_last_name := IF(owner1Found, L.out.owner1_last_name, R.out.owner1_last_name);
		SELF.out.owner1_SSN := IF(owner1Found, L.out.owner1_SSN, R.out.owner1_SSN);
		SELF.out.owner1_company_name := IF(owner1Found, L.out.owner1_company_name, R.out.owner1_company_name);
		SELF.out.owner1_address := IF(owner1Found, L.out.owner1_address, R.out.owner1_address);
		SELF.out.owner1_city := IF(owner1Found, L.out.owner1_city, R.out.owner1_city);
		SELF.out.owner1_state := IF(owner1Found, L.out.owner1_state, R.out.owner1_state);
		SELF.out.owner1_zip_code := IF(owner1Found, L.out.owner1_zip_code, R.out.owner1_zip_code);	

		SELF.out.owner2_did := IF(owner1Found, R.out.owner1_did, 0);
		SELF.out.owner2_bdid := IF(owner1Found, R.out.owner1_bdid, 0);
		SELF.out.owner2_first_name := IF(owner1Found, R.out.owner1_first_name, '');
		SELF.out.owner2_middle_name := IF(owner1Found, R.out.owner1_middle_name, '');
		SELF.out.owner2_last_name := IF(owner1Found, R.out.owner1_last_name, '');
		SELF.out.owner2_SSN := IF(owner1Found, R.out.owner1_SSN, '');
		SELF.out.owner2_company_name := IF(owner1Found, R.out.owner1_company_name, '');
		SELF.out.owner2_address := IF(owner1Found, R.out.owner1_address, '');
		SELF.out.owner2_city := IF(owner1Found, R.out.owner1_city, '');
		SELF.out.owner2_state := IF(owner1Found, R.out.owner1_state, '');
		SELF.out.owner2_zip_code := IF(owner1Found, R.out.owner1_zip_code, '');	
		
		Boolean reg1Found := L.out.reg_1_did != 0 OR
		                     L.out.reg_1_bdid != 0 OR
												 trim(L.out.reg_1_first_name) != '' OR
												 trim(L.out.reg_1_middle_name) != '' OR
												 trim(L.out.reg_1_last_name) != '' OR
												 trim(L.out.reg_1_ssn) != '' OR
												 trim(L.out.reg_1_company_name) != '' OR
												 trim(L.out.reg_1_city) != '' OR
												 trim(L.out.reg_1_state) != '' OR
												 trim(L.out.reg_1_zip_code) != '';
		                     
		SELF.out.reg_1_did := IF(reg1Found, L.out.reg_1_did, R.out.reg_1_did);
		SELF.out.reg_1_bdid := IF(reg1Found, L.out.reg_1_bdid, R.out.reg_1_bdid);
		SELF.out.reg_1_first_name := IF(reg1Found, L.out.reg_1_first_name, R.out.reg_1_first_name);
		SELF.out.reg_1_middle_name := IF(reg1Found, L.out.reg_1_middle_name, R.out.reg_1_middle_name);
		SELF.out.reg_1_last_name := IF(reg1Found, L.out.reg_1_last_name, R.out.reg_1_last_name);
		SELF.out.reg_1_ssn := IF(reg1Found, L.out.reg_1_ssn, R.out.reg_1_ssn);
		SELF.out.reg_1_company_name := IF(reg1Found, L.out.reg_1_company_name, R.out.reg_1_company_name);
		SELF.out.reg_1_address := IF(reg1Found, L.out.reg_1_address, R.out.reg_1_address);
		SELF.out.reg_1_city := IF(reg1Found, L.out.reg_1_city, R.out.reg_1_city);
		SELF.out.reg_1_state := IF(reg1Found, L.out.reg_1_state, R.out.reg_1_state);
		SELF.out.reg_1_zip_code := IF(reg1Found, L.out.reg_1_zip_code, R.out.reg_1_zip_code);	

		SELF.out.reg_2_did := IF(reg1Found, R.out.reg_1_did, 0);
		SELF.out.reg_2_bdid := IF(reg1Found, R.out.reg_1_bdid, 0);
		SELF.out.reg_2_first_name := IF(reg1Found, R.out.reg_1_first_name, '');
		SELF.out.reg_2_middle_name := IF(reg1Found, R.out.reg_1_middle_name, '');
		SELF.out.reg_2_last_name := IF(reg1Found, R.out.reg_1_last_name, '');
		SELF.out.reg_2_ssn := IF(reg1Found, R.out.reg_1_ssn, '');
		SELF.out.reg_2_company_name := IF(reg1Found, R.out.reg_1_company_name, '');
		SELF.out.reg_2_address := IF(reg1Found, R.out.reg_1_address, '');
		SELF.out.reg_2_city := IF(reg1Found, R.out.reg_1_city, '');
		SELF.out.reg_2_state := IF(reg1Found, R.out.reg_1_state, '');
		SELF.out.reg_2_zip_code := IF(reg1Found, R.out.reg_1_zip_code, '');	

		SELF.out.First_Reg_Date := IF(L.out.First_Reg_Date != '', L.out.First_Reg_Date, R.out.First_Reg_Date);
		SELF.out.Earliest_Reg_Date := IF(L.out.Earliest_Reg_Date != '', L.out.Earliest_Reg_Date, R.out.Earliest_Reg_Date);
		SELF.out.Latest_Reg_Date := IF(L.out.Latest_Reg_Date != '', L.out.Latest_Reg_Date, R.out.Latest_Reg_Date);
		SELF.out.Expiration_Date := IF(L.out.Expiration_Date != '', L.out.Expiration_Date, R.out.Expiration_Date);
		SELF.out.Reg_Decal_Number := IF(L.out.Reg_Decal_Number != '', L.out.Reg_Decal_Number, R.out.Reg_Decal_Number);
		SELF.out.Reg_Status := IF(L.out.Reg_Status != '', L.out.Reg_Status, R.out.Reg_Status);
		SELF.out.Reg_Type := IF(L.out.Reg_Type != '', L.out.Reg_Type, R.out.Reg_Type);
		SELF.out.Title_Number := IF(L.out.Title_Number != '', L.out.Title_Number, R.out.Title_Number);
		SELF.out.Earliest_Title_Date := IF(L.out.Earliest_Title_Date != '', L.out.Earliest_Title_Date, R.out.Earliest_Title_Date);
		SELF.out.Title_Latest_Issue_Date := IF(L.out.Title_Latest_Issue_Date != '', L.out.Title_Latest_Issue_Date, R.out.Title_Latest_Issue_Date);
		SELF.out.Title_Status := IF(L.out.Title_Status != '', L.out.Title_Status, R.out.Title_Status);
		SELF.out.Tag_Number := IF(L.out.Tag_Number != '', L.out.Tag_Number, R.out.Tag_Number);
		SELF.out.Tag_State := IF(L.out.Tag_State != '', L.out.Tag_State, R.out.Tag_State);

		SELF := L;
	END;
	
	sortedOut1 := SORT(out1, rec.id, rec.vehKey, rec.iterKey, rec.seqKey);
  out2 := ROLLUP(sortedOut1, rollupRegistrations(LEFT, RIGHT), rec.id, rec.vehKey, rec.iterKey, rec.seqKey);
	
	LuxuryAssetTax.Layouts.outputRec extractMainFields(LuxuryAssetTax.Layouts.outputRec L, VehicleV2.Layout_Base_Main R) := TRANSFORM
		SELF.out.Id_Number := R.orig_vin;
		SELF.out.Year := R.orig_year;
		SELF.out.Make := IF(R.vina_make_desc != '', R.vina_make_desc, R.orig_make_desc);
		SELF.out.Model := IF(R.vina_model_desc != '', R.vina_model_desc, R.orig_model_desc);
		SELF.out.Body_Style := IF(R.orig_body_desc != '', R.orig_body_desc, R.vina_body_style_desc);
		SELF.out.Type_Description := R.orig_vehicle_type_desc;
		SELF.out.Color := R.orig_major_color_desc;
		SELF.out.Base_Price := R.VINA_price;
		SELF.out.Reg_State := R.state_origin;

		SELF := L;
	END;
	
	distOut2 := DISTRIBUTE(out2, HASH32(rec.vehKey));
	//LEFT/RIGHT intentionally reversed for performance.
	out3 := JOIN(distVehMain, 
							 distOut2, 
							 RIGHT.rec.vehKey = LEFT.Vehicle_Key AND 
							 RIGHT.rec.iterKey = LEFT.Iteration_Key, 
							 extractMainFields(RIGHT, LEFT), 
							 RIGHT OUTER, 
							 local);
	
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

	distOut3 := DISTRIBUTE(out3, HASH32(rec.id));

	//LEFT/RIGHT intentionally reversed for performance.
	// out4 := JOIN(distCorpData1, 
  						 // distOut3, 
  						 // RIGHT.rec.id = LEFT.bdid, 
							 // extractCorpFields(RIGHT, LEFT), 
							 // RIGHT OUTER,
							 // local);
	out4 := JOIN(distOut3, 
  						 distCorpData1, 
  						 LEFT.rec.id = RIGHT.bdid, 
							 extractCorpFields(LEFT, RIGHT), 
							 LEFT OUTER,
							 local);
							 
	out4a := JOIN(out4, 
  						 distCorpData1, 
							 LEFT.out.owner1_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.own_1_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);
	out4b := JOIN(out4a, 
  						 distCorpData1, 
							 LEFT.out.owner2_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.own_2_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);

	out4c := JOIN(out4b, 
  						 distCorpData1, 
							 LEFT.out.reg_1_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.reg_1_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);

	out4d := JOIN(out4c, 
  						 distCorpData1, 
							 LEFT.out.reg_2_bdid= RIGHT.bdid, 
							 TRANSFORM(Layouts.outputRec, SELF.out.reg_2_corp_key := RIGHT.corp_key; SELF := LEFT), 
							 LEFT OUTER);


	LuxuryAssetTax.Layouts.outputRec setFlags(LuxuryAssetTax.Layouts.outputRec L) := TRANSFORM
		compare_date := IF(L.out.First_Reg_Date <> '',
		                   L.out.First_Reg_Date,
											 IF(L.out.Earliest_Reg_Date <> '',
											    L.out.Earliest_Reg_Date,
													IF(L.out.Latest_Reg_Date <> '',
													   L.out.Latest_Reg_Date,
														 IF(L.out.Earliest_Title_Date <> '',
														    L.out.Earliest_Title_Date,
																IF(L.out.Title_Latest_Issue_Date <> '',
														       L.out.Title_Latest_Issue_Date,
																	 '')))));
														    
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
		//Default - will will be updated in expandContactInfo if applicated
		SELF.out.Contact_Owned := 'N';
		SELF := L;
	END;
	
	out5 := PROJECT(out4d, setFlags(LEFT));
	
	sortedOut5 := SORT(out5, rec.id, out.Id_Number, rec.vehKey, rec.seqKey, rec.iterKey);
	
 RETURN sortedOut5;
END;