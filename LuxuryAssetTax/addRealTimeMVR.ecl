IMPORT VehicleV2_Services, Corp2, Business_Header, Address;

EXPORT addRealTimeMVR(DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairings,
											DATASET(Business_Header.Layout_Business_Contact_Full_new) foundBHContacts,
											DATASET(Corp2.Layout_Corporate_Direct_Cont_Base) foundUniqueCorpContacts,
											DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) corpData,
											UNSIGNED1 DPPA_Purpose,
											UNSIGNED1 GLB_Purpose,
											STRING realTimePermissableUse ) := FUNCTION	

	distCorpData := DEDUP(SORT(DISTRIBUTE(corpData, HASH32(bdid)), bdid, record_type, dt_vendor_last_reported, local), bdid, local);
	//***********************************************************
	//  Set Input record for SOAP Call
	//**************************************
	/*
	EXPORT RealTime_InLayout := RECORD
		doxie.layout_inBatchMaster.acctNo;  //string20
		STRING120 name_full;
		doxie.layout_inBatchMaster.name_first; //string20
		doxie.layout_inBatchMaster.name_middle; //string20
		doxie.layout_inBatchMaster.name_last; //string20
		doxie.layout_inBatchMaster.name_suffix; //string5
		Autokey_batch.Layouts.rec_inBatchMaster.comp_name; //STRING120
		STRING200 addr1;
		STRING100 addr2;
		doxie.layout_inBatchMaster.p_city_name; //string25
		doxie.layout_inBatchMaster.st; //string2
		doxie.layout_inBatchMaster.z5; //string5
		Layout_VKeysWithInput.year; //STRING4
		Layout_VKeysWithInput.make; //STRING36
		Layout_VKeysWithInput.model; //STRING36
		STRING17 vinIn;
		doxie.layout_inBatchMaster.plate; //String10
		doxie.layout_inBatchMaster.plateState; //String2
		Autokey_batch.Layouts.rec_inBatchMaster.date; //STRING8
	END;
	*/
	VehicleV2_Services.Batch_Layout.RealTime_InLayout extractBHContactInfo(
										 Business_Header.Layout_Business_Contact_Full_new L,
										 LuxuryAssetTax.Layouts.ContactPairRec R) := TRANSFORM

		SELF.acctno := (STRING20) R.did;
		SELF.name_first := L.fname;
		SELF.name_middle := L.mname;
		SELF.name_last := L.lname;
		SELF.name_suffix := L.name_suffix;
		SELF.addr1 := Address.Addr1FromComponents(L.prim_range, 
																							L.predir, 
																							L.prim_name,
																							L.addr_suffix, 
																							L.postdir, 
																							L.unit_desig, 
																							L.sec_range);
		SELF.p_city_name := L.city;
		SELF.st := L.state;
		SELF.z5 := (STRING5)L.zip;

		SELF := [];
	END;

	VehicleV2_Services.Batch_Layout.RealTime_InLayout extractCorpContactInfo(
										 Corp2.Layout_Corporate_Direct_Cont_Base L,
										 LuxuryAssetTax.Layouts.ContactPairRec R) := TRANSFORM

		SELF.acctno := (STRING20) R.did;
		SELF.name_first := L.cont_fname;
		SELF.name_middle := L.cont_mname;
		SELF.name_last := L.cont_lname;
		SELF.name_suffix := L.cont_name_suffix;
		SELF.addr1 := Address.Addr1FromComponents(L.cont_prim_range, 
																							L.cont_predir, 
																							L.cont_prim_name,
																							L.cont_addr_suffix, 
																							L.cont_postdir, 
																							L.cont_unit_desig, 
																							L.cont_sec_range);
		SELF.p_city_name := L.cont_p_city_name;
		SELF.st := L.cont_state;
		SELF.z5 := (STRING5)L.cont_zip5;

		SELF := [];
	END;

  BHContactIn := JOIN(foundBHContacts, totalFoundPairings, LEFT.did = RIGHT.did, extractBHContactInfo(LEFT, RIGHT));
	CorpContactIn := JOIN(foundUniqueCorpContacts, totalFoundPairings, LEFT.did = RIGHT.did, extractCorpContactInfo(LEFT, RIGHT));

	Polk_input_initial := BHContactIn + CorpContactIn;
	Polk_in := DEDUP(SORT(Polk_input_initial, acctno), acctno);
	// Polk_in := CHOOSEN(DEDUP(SORT(Polk_input_initial, acctno), acctno), 4);
								 
	polk_data :=  rpc_for_polk_RTMVR(Polk_in, DPPA_Purpose, GLB_Purpose, realTimePermissableUse);

	LuxuryAssetTax.Layouts.outputRec extractRTMVRInfo(LuxuryAssetTax.Layouts.PolkOutLayout L, Layouts.ContactPairRec R) := TRANSFORM
		SELF.rec.id := R.bdid;
		SELF.rec.corp_key := R.corp_key;
		SELF.rec.vehKey := L.vin;
		SELF.rec.iterKey := (STRING15) L.seq;
		SELF.rec.sort1 := (STRING30) L.seq;
		
		SELF.out.Process_Flag := 'WC';
		SELF.out.contact_name := IF(L.name_first<>'',trim(L.name_first)+' ','') +
														 IF(L.name_middle<>'',trim(L.name_middle)+' ','') +
														 IF(L.name_last<>'',trim(L.name_last)+' ','') +
														 IF(L.name_suffix<>'',trim(L.name_suffix)+' ','');
		SELF.out.contact_addr := Address.Addr1FromComponents(L.prim_range, 
																												L.predir, 
																												L.prim_name,
																												L.addr_suffix, 
																												L.postdir, 
																												L.unit_desig, 
																												L.sec_range) +
															  IF(L.p_city_name<>'',trim(L.p_city_name)+' ','') +
															  IF(L.st<>'',trim(L.st)+' ','') +
															  IF(L.z5<>'',trim(L.z5),'');
		
		SELF.out.owner1_did := (UNSIGNED6) L.own_1_did;
		SELF.out.owner1_bdid := (UNSIGNED6) L.own_1_bdid;
		SELF.out.owner1_first_name := L.own_1_fname;
		SELF.out.owner1_middle_name := L.own_1_mname;
		SELF.out.owner1_last_name := L.own_1_lname;
		SELF.out.owner1_SSN := L.own_1_ssn;
		SELF.out.owner1_company_name := L.own_1_company_name;
		SELF.out.owner1_address := L.own_1_addr1 + IF(L.own_1_addr2 <> '', ' ' + L.own_1_addr2, L.own_1_addr2);
		SELF.out.owner1_city := L.own_1_city;
		SELF.out.owner1_state := L.own_1_state;
		SELF.out.owner1_zip_code := L.own_1_zip;
		
		SELF.out.owner2_did := (UNSIGNED6) L.own_2_did;
		SELF.out.owner2_bdid := (UNSIGNED6) L.own_2_bdid;
		SELF.out.owner2_first_name := L.own_2_fname;
		SELF.out.owner2_middle_name := L.own_2_mname;
		SELF.out.owner2_last_name := L.own_2_lname;
		SELF.out.owner2_SSN := L.own_2_ssn;
		SELF.out.owner2_company_name := L.own_2_company_name;
		SELF.out.owner2_address := L.own_2_addr1 + IF(L.own_2_addr2 <> '', ' ' + L.own_2_addr2, L.own_2_addr2);
		SELF.out.owner2_city := L.own_2_city;
		SELF.out.owner2_state := L.own_2_state;
		SELF.out.owner2_zip_code := L.own_2_zip;
		
		SELF.out.reg_1_did := (UNSIGNED6) L.reg_1_did;
		SELF.out.reg_1_bdid := (UNSIGNED6) L.reg_1_bdid;
		SELF.out.reg_1_first_name := L.reg_1_fname;
		SELF.out.reg_1_middle_name := L.reg_1_mname;
		SELF.out.reg_1_last_name := L.reg_1_lname;
		SELF.out.reg_1_SSN := L.reg_1_ssn;
		SELF.out.reg_1_company_name := L.reg_1_company_name;
		SELF.out.reg_1_address := L.reg_1_addr1 + IF(L.reg_1_addr2 <> '', ' ' + L.reg_1_addr2, L.reg_1_addr2);
		SELF.out.reg_1_city := L.reg_1_city;
		SELF.out.reg_1_state := L.reg_1_state;
		SELF.out.reg_1_zip_code := L.reg_1_zip;

		SELF.out.reg_2_did := (UNSIGNED6) L.reg_2_did;
		SELF.out.reg_2_bdid := (UNSIGNED6) L.reg_2_bdid;
		SELF.out.reg_2_first_name := L.reg_2_fname;
		SELF.out.reg_2_middle_name := L.reg_2_mname;
		SELF.out.reg_2_last_name := L.reg_2_lname;
		SELF.out.reg_2_SSN := L.reg_2_ssn;
		SELF.out.reg_2_company_name := L.reg_2_company_name;
		SELF.out.reg_2_address := L.reg_2_addr1 + IF(L.reg_2_addr2 <> '', ' ' + L.reg_2_addr2, L.reg_2_addr2);
		SELF.out.reg_2_city := L.reg_2_city;
		SELF.out.reg_2_state := L.reg_2_state;
		SELF.out.reg_2_zip_code := L.reg_2_zip;
		
		SELF.out.Type_Flag := 'RT';
		
		SELF.out.Id_Number := L.vin;
		SELF.out.Year := L.model_year;
		SELF.out.Make := L.make_desc;
		SELF.out.Model := L.model_desc;
		SELF.out.Body_Style := L.body_style_desc;
		SELF.out.Type_Description := L.vehicle_type_desc;
		SELF.out.Color := L.major_color_desc;
		SELF.out.Reg_State := L.state_origin;
		
		SELF.out.First_Reg_Date := L.Reg_First_Date;
		SELF.out.Earliest_Reg_Date := L.Reg_Earliest_Effective_Date;
		SELF.out.Latest_Reg_Date := L.Reg_Latest_Effective_Date;
		SELF.out.Expiration_Date := L.Reg_Latest_Expiration_Date;
		SELF.out.Reg_Decal_Number := L.Reg_Decal_Number;
		SELF.out.Reg_Type := L.Reg_License_Plate_Type_Desc;
		SELF.out.Title_Number := L.Ttl_Number;
		SELF.out.Earliest_Title_Date := L.Ttl_Earliest_Issue_Date;
		SELF.out.Title_Latest_Issue_Date := L.Ttl_Latest_Issue_Date;
		SELF.out.Title_Status := L.Ttl_Status_Desc;
		SELF.out.Tag_Number := L.Reg_License_Plate;
		SELF.out.Tag_State := L.Reg_License_State;
		
		SELF := [];
	END;
	
	validPolkData := polk_data(hit_flag = 'IN');

	out := JOIN(validPolkData, totalFoundPairings, (UNSIGNED) LEFT.acctno = RIGHT.did, extractRTMVRInfo(LEFT, RIGHT));

	LuxuryAssetTax.Layouts.outputRec extractCorpFields(LuxuryAssetTax.Layouts.outputRec L, Corp2.Layout_Corporate_Direct_Corp_Base R) := TRANSFORM
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
	
	distOut := DISTRIBUTE(out, HASH32(rec.id));
	out1 := JOIN(distOut, 
  						 distCorpData, 
							 LEFT.rec.id = RIGHT.bdid, 
							 extractCorpFields(LEFT, RIGHT), 
							 LEFT OUTER,
							 local);

  out2 := LuxuryAssetTax.addBestAddrInfo(out1);
	
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
		//The source of all RT MVR registrations are contacts
		SELF.out.Business_Owned := 'N';
		SELF.out.Contact_Owned := 'Y';

		SELF := L;
	END;
	
	out3 := PROJECT(out2, setFlags(LEFT));
	
	inCount := COUNT(Polk_in);
  #stored('LuxuryAssetTaxRTInCount', inCount);
	outCount := COUNT(validPolkData);
	#stored('LuxuryAssetTaxRTOutCount', outCount);
	OUTPUT(Polk_in, NAMED('POLK_Request'));
	OUTPUT(polk_data, NAMED('POLK_Response'));

	RETURN out3;
END;