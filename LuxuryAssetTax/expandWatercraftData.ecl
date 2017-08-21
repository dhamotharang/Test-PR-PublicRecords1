import watercraft, Corp2, Address;

export expandWatercraftData( DATASET(LuxuryAssetTax.Layouts.IdVehicleRec) input, 
                   DATASET(watercraft.Layout_Watercraft_Search_Base) watercraftSearch,
                   DATASET(watercraft.Layout_Watercraft_Main_Base) watercraftMain,
									 DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) corpData,
									 BOOLEAN contactData = false) := FUNCTION

  distInput := DISTRIBUTE(input, HASH32(vehKey));
	distWatercraftSearch := DISTRIBUTE(watercraftSearch, HASH32(watercraft_key));
	distWatercraftMain := DISTRIBUTE(watercraftMain, HASH32(watercraft_key));
	distCorpData := DISTRIBUTE(corpData, HASH32(bdid));
	distCorpData1 := DEDUP(SORT(distCorpData, bdid, record_type, -dt_vendor_last_reported, local), bdid, local);
	
	LuxuryAssetTax.Layouts.outputRec extractSearchFields(LuxuryAssetTax.Layouts.IdVehicleRec L, watercraft.Layout_Watercraft_Search_Base R) := TRANSFORM
		SELF.rec.seqKey := R.sequence_key;
		SELF.rec.sort1 := L.vehKey;
		SELF.rec.sort2 := L.seqKey;
		SELF.rec := L;

		SELF.out.Process_Flag := IF(contactData, 'WC', 'WOC');
		
		SELF.out.reg_1_did := (unsigned6) R.did;
		SELF.out.reg_1_bdid := (unsigned6) R.bdid;
		SELF.out.reg_1_first_name := R.fname;
		SELF.out.reg_1_middle_name := R.mname;
		SELF.out.reg_1_last_name := R.lname;
		SELF.out.reg_1_ssn := IF(R.orig_ssn != '', R.orig_ssn, R.ssn);
		SELF.out.reg_1_company_name := R.company_name;
		SELF.out.reg_1_address := IF(R.orig_address_2 <> '', 
		                             trim(R.orig_address_1) + ' ' + trim(R.orig_address_2), 
																 R.orig_address_1);
		SELF.out.reg_1_city := R.orig_city;
		SELF.out.reg_1_state := R.orig_state;
		SELF.out.reg_1_zip_code := R.orig_zip;
		SELF.out.Type_Flag := 'WC';
		
		SELF.out := [];
	END;

	out1 := JOIN(distInput, 
							 distWatercraftSearch, 
							 LEFT.vehKey = RIGHT.watercraft_key, 
							 extractSearchFields(LEFT, RIGHT), local);

	LuxuryAssetTax.Layouts.outputRec extractMainFields(LuxuryAssetTax.Layouts.outputRec L, watercraft.Layout_Watercraft_Main_Base R) := TRANSFORM
		SELF.out.Id_Number := R.hull_number;
		SELF.out.Year := R.model_year;
		SELF.out.Make := R.watercraft_make_description;
		SELF.out.Model := R.watercraft_model_description;
		SELF.out.Body_Style := R.hull_type_description;
		SELF.out.Type_Description := R.vehicle_type_description;
		SELF.out.Color := R.watercraft_color_1_description;
		SELF.out.Base_Price := R.purchase_price;
		SELF.out.Watercraft_Name := R.watercraft_name;
		SELF.out.Reg_State := R.st_registration;
		SELF.out.Latest_Reg_Date := R.registration_date;
		SELF.out.Expiration_Date := R.registration_expiration_date;
		SELF.out.Reg_Decal_Number := R.decal_number;
		SELF.out.Reg_Status := R.registration_status_description;
		SELF.out.Title_Number := R.title_number;
    SELF.out.Title_Latest_Issue_Date := R.title_issue_date;
    SELF.out.Title_Status := R.title_status_description;

		SELF := L;
	END;
	
	out2 := JOIN(out1, 
							 distWatercraftMain, 
							 LEFT.rec.vehKey = RIGHT.watercraft_key AND 
							 LEFT.rec.seqKey = RIGHT.sequence_key, 
							 extractMainFields(LEFT, RIGHT), local);
	

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

	distOut2 := DISTRIBUTE(out2, HASH32(rec.id));

	out3 := JOIN(distOut2, 
							 distCorpData1, 
							 LEFT.rec.id = RIGHT.bdid, 
							 extractCorpFields(LEFT, RIGHT), local);
	sortedOut3 := SORT(out3, rec.vehKey, rec.seqKey);
	
	LuxuryAssetTax.Layouts.outputRec rollupRegistrations(LuxuryAssetTax.Layouts.outputRec L, LuxuryAssetTax.Layouts.outputRec R) := TRANSFORM
		SELF.out.reg_2_did := R.out.reg_1_did;
		SELF.out.reg_2_bdid := R.out.reg_1_bdid;
		SELF.out.reg_2_first_name := R.out.reg_1_first_name;
		SELF.out.reg_2_middle_name := R.out.reg_1_middle_name;
		SELF.out.reg_2_last_name := R.out.reg_1_last_name;
		SELF.out.reg_2_ssn := R.out.reg_1_ssn;
		SELF.out.reg_2_company_name := R.out.reg_1_company_name;
		SELF.out.reg_2_address := R.out.reg_1_address;
		SELF.out.reg_2_city := R.out.reg_1_city;
		SELF.out.reg_2_state := R.out.reg_1_state;
		SELF.out.reg_2_zip_code := R.out.reg_1_zip_code;

		SELF := L;
	END;

	out4 := ROLLUP(sortedOut3, rollupRegistrations(LEFT, RIGHT), rec.vehKey, rec.seqKey);
	
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
		compare_date := IF(L.out.Latest_Reg_Date <> '',
		                   L.out.Latest_Reg_Date,
											 IF(L.out.Title_Latest_Issue_Date <> '',
											    L.out.Title_Latest_Issue_Date,
													''));
														    
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
	
	sortedOut5 := SORT(out5, rec.id, out.id_number, out.Expiration_Date);
	
  RETURN sortedOut5;
END;