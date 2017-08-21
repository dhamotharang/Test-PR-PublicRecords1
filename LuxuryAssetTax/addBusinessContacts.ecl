import Corp2, Business_Header, Address;

export addBusinessContacts(DATASET(LuxuryAssetTax.Layouts.ContactPairRec) foundContactPairings, 
                           DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) corpData,
													 DATASET(Business_Header.Layout_Business_Contact_Full_new) foundBHContacts, 
													 DATASET(Corp2.Layout_Corporate_Direct_Cont_Base) foundUniqueCorpContacts) := FUNCTION

  //InitializeRecords
	LuxuryAssetTax.Layouts.outputRec initializeContactRccords(LuxuryAssetTax.Layouts.ContactPairRec L) := TRANSFORM
	  SELF.rec.id := L.bdid;
		SELF.rec.corp_key := L.corp_key;
		SELF.out.reg_1_did := L.did; //using this field to hold the contact did - data will be later stripped.
		SELF.rec.sort1 := '0000000000';
		SELF.rec.sort2 := '0000000000';
		SELF.out.Process_Flag := 'WC';
		
		SELF := [];
	END;
	
	out1 := PROJECT(foundContactPairings, initializeContactRccords(LEFT));
	
	//Add Corp Information
 	distCorpData := DISTRIBUTE(corpData, HASH32(corp_key));
	distCorpData1 := DEDUP(SORT(distCorpData, corp_key, record_type, -dt_vendor_last_reported, local), corp_key, local);
	
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
		SELF.out.corp_addr := Address.Addr1FromComponents(R.corp_addr1_prim_range, 
															                        R.corp_addr1_predir, 
																											R.corp_addr1_prim_name,
																											R.corp_addr1_addr_suffix, 
																											R.corp_addr1_postdir, 
																											R.corp_addr1_unit_desig, 
																											R.corp_addr1_sec_range) + ' ' 
												  + IF(R.corp_addr1_p_city_name<>'',trim(R.corp_addr1_p_city_name)+', ','') 
													+ IF(R.corp_addr1_state<>'',trim(R.corp_addr1_state)+' ','') 
													+ IF(R.corp_addr1_zip5<>'',trim(R.corp_addr1_zip5),'') 
													+ IF(trim(R.corp_addr1_zip4)<>'','-'+ trim(R.corp_addr1_zip4),'');
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
	
	distOut1 := DISTRIBUTE(out1, HASH32(rec.corp_key));
	//LEFT/RIGHT intentionally reversed for performance.
	out2 := JOIN(distCorpData1, 
  						 distOut1, 
							 RIGHT.rec.corp_key  = LEFT.corp_key, 
							 extractCorpFields(RIGHT, LEFT), 
							 RIGHT OUTER,
							 local);

	//Add BHContact Information
  LuxuryAssetTax.Layouts.outputRec addBHContactInfo(LuxuryAssetTax.Layouts.outputRec L, Business_Header.Layout_Business_Contact_Full_new R) := TRANSFORM
		SELF.out.contact_name := IF(R.title<>'',trim(R.title)+' ','') +
															  IF(R.fname<>'',trim(R.fname)+' ','') +
															  IF(R.mname<>'',trim(R.mname)+' ','') +
															  IF(R.lname<>'',trim(R.lname)+' ','') +
															  IF(R.name_suffix<>'',trim(R.name_suffix)+' ','');
		SELF.out.contact_addr := Address.Addr1FromComponents(R.prim_range, 
																												 R.predir, 
																											 	 R.prim_name,
																												 R.addr_suffix, 
																												 R.postdir, 
																												 R.unit_desig, 
																												 R.sec_range) 
														 + IF(R.city<>'',trim(R.city)+' ','') 
														 + IF(R.state<>'',trim(R.state)+' ','') 
														 + IF(R.zip<>0,(STRING5) R.zip,'') 
														 + IF(R.zip4<>0,'-'+ (STRING4) R.zip4,'');
		SELF.out.reg_1_first_name := 'BH CONTACT';
		SELF := L;
	END;
	
	out3 := JOIN(out2, 
	             foundBHContacts, 
							 LEFT.rec.id = RIGHT.bdid 
							 AND LEFT.out.reg_1_did = RIGHT.did, 
							 addBHContactInfo(LEFT, RIGHT));

	//Add CorpContact Information
  LuxuryAssetTax.Layouts.outputRec addCorpContactInfo(LuxuryAssetTax.Layouts.outputRec L, Corp2.Layout_Corporate_Direct_Cont_Base R) := TRANSFORM
		SELF.out.contact_name := IF(R.cont_title<>'',trim(R.cont_title)+' ','') 
		                         + IF(R.cont_fname<>'',trim(R.cont_fname)+' ','') 
														 + IF(R.cont_mname<>'',trim(R.cont_mname)+' ','')
														 + IF(R.cont_lname<>'',trim(R.cont_lname)+' ','') 
														 + IF(R.cont_name_suffix<>'',trim(R.cont_name_suffix)+' ','');
		SELF.out.contact_addr := Address.Addr1FromComponents(R.cont_prim_range, 
																												 R.cont_predir, 
																												 R.cont_prim_name,
																												 R.cont_addr_suffix, 
																												 R.cont_postdir, 
																												 R.cont_unit_desig, 
																												 R.cont_sec_range)
											       + IF(R.cont_p_city_name<>'',trim(R.cont_p_city_name)+', ','')
														 + IF(R.cont_state<>'',trim(R.cont_state)+' ','') 
														 + IF(R.cont_zip5<>'',R.cont_zip5,'') 
														 + IF(R.cont_zip4<>'','-'+ R.cont_zip4,'');	  
		SELF.out.reg_1_first_name := 'CORP CONTACT';
		SELF := L;
	END;
	out3a := JOIN(out2, 
	             foundUniqueCorpContacts, 
							 LEFT.rec.corp_key = RIGHT.corp_key 
							 AND LEFT.out.reg_1_did = RIGHT.did, 
							 addCorpContactInfo(LEFT, RIGHT));
	
	out4 := out3 + out3a;
	//DEDUP dids on corpkey
	out5 := DEDUP(SORT(out4, rec.corp_key, out.reg_1_did, rec.id), rec.corp_key, out.reg_1_did);
	
	//Add Best Information
	out6 := LuxuryAssetTax.addBestAddrInfo(out5);
	
	//Remove placeholder reg_1_did data.
	out7 := PROJECT(out6, TRANSFORM(LuxuryAssetTax.Layouts.outputRec, 
	                                SELF.out.reg_1_did := 0; 
																	SELF.out.reg_1_first_name := ''; 
																	SELF := LEFT));
  /*
  output(count(out1), named('out1Count'));
	output(out1, named('out1'));
  output(count(out2), named('out2Count'));
	output(out2, named('out2'));
  output(count(out3), named('out3Count'));
	output(out3, named('out3'));
	output(count(out3a), named('out3aCount'));
	output(out3a, named('out3a'));  
  output(count(out4), named('out4Count'));
	output(out4, named('out4'));
  output(count(out5), named('out5Count'));
	output(out5, named('out5'));
	output(count(out6), named('out6Count'));
	output(out6, named('out6'));
	output(count(out7), named('out7Count'));
	output(out7, named('out7'));
  /* */
  return out7;
END;