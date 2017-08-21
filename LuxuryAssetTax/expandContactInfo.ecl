import Corp2, Business_Header, Address;

export expandContactInfo( DATASET(LuxuryAssetTax.Layouts.outputRec) input, 
                   DATASET(Business_Header.Layout_Business_Contact_Full_new) BhContactData,
									 DATASET(Corp2.Layout_Corporate_Direct_Cont_Base) CorpOnlyContactData) := FUNCTION

	LuxuryAssetTax.Layouts.outputRec extractBHContactFields(LuxuryAssetTax.Layouts.outputRec L, Business_Header.Layout_Business_Contact_Full_new R, BOOLEAN contactHit) := TRANSFORM
		SELF.out.contact_name := IF(L.out.contact_name <> '', 
		                            L.out.contact_name, 
																IF(R.title<>'',trim(R.title)+' ','') +
															  IF(R.fname<>'',trim(R.fname)+' ','') +
															  IF(R.mname<>'',trim(R.mname)+' ','') +
															  IF(R.lname<>'',trim(R.lname)+' ','') +
															  IF(R.name_suffix<>'',trim(R.name_suffix)+' ',''));
		SELF.out.contact_addr := IF(L.out.contact_addr <> '', 
		                            L.out.contact_addr, 
																Address.Addr1FromComponents(R.prim_range, 
																												R.predir, 
																												R.prim_name,
																												R.addr_suffix, 
																												R.postdir, 
																												R.unit_desig, 
																												R.sec_range) +
															  IF(R.city<>'',trim(R.city)+' ','') +
															  IF(R.state<>'',trim(R.state)+' ','') +
															  IF(R.zip<>0,(STRING5) R.zip,'') +
															  IF(R.zip4<>0,'-'+ (STRING4) R.zip4,''));
		SELF.out.Contact_Owned := IF(contactHit, 'Y', L.out.Contact_Owned);
		SELF := L;
	END;

	out1 := JOIN(input, 
							 BhContactData, 
							 LEFT.rec.id = RIGHT.bdid AND
							 LEFT.out.owner1_did = RIGHT.did, 
							 extractBHContactFields(LEFT, RIGHT, LEFT.rec.id = RIGHT.bdid AND LEFT.out.owner1_did = RIGHT.did), 
							 LEFT OUTER);
							 
	out1a := JOIN(out1, 
							 BhContactData, 
							 LEFT.rec.id = RIGHT.bdid AND
							 LEFT.out.owner2_did = RIGHT.did, 
							 extractBHContactFields(LEFT, RIGHT, LEFT.rec.id = RIGHT.bdid AND LEFT.out.owner2_did = RIGHT.did), 
							 LEFT OUTER);
	out1b := JOIN(out1a, 
							 BhContactData, 
							 LEFT.rec.id = RIGHT.bdid AND
							 LEFT.out.reg_1_did = RIGHT.did, 
							 extractBHContactFields(LEFT, RIGHT, LEFT.rec.id = RIGHT.bdid AND LEFT.out.reg_1_did = RIGHT.did), 
							 LEFT OUTER);
							 
	out1c := JOIN(out1b, 
							 BhContactData, 
							 LEFT.rec.id = RIGHT.bdid AND
							 LEFT.out.reg_2_did = RIGHT.did, 
							 extractBHContactFields(LEFT, RIGHT, LEFT.rec.id = RIGHT.bdid AND LEFT.out.reg_2_did = RIGHT.did), 
							 LEFT OUTER);
	
	LuxuryAssetTax.Layouts.outputRec extractCorpContactFields(LuxuryAssetTax.Layouts.outputRec L, Corp2.Layout_Corporate_Direct_Cont_Base R, BOOLEAN contactHit) := TRANSFORM
		SELF.out.contact_name := IF(L.out.contact_name <> '', 
		                            L.out.contact_name, 
															  IF(R.cont_title<>'',trim(R.cont_title)+' ','') +
															  IF(R.cont_fname<>'',trim(R.cont_fname)+' ','') +
															  IF(R.cont_mname<>'',trim(R.cont_mname)+' ','') +
															  IF(R.cont_lname<>'',trim(R.cont_lname)+' ','') +
															  IF(R.cont_name_suffix<>'',trim(R.cont_name_suffix)+' ',''));
		SELF.out.contact_addr := IF(L.out.contact_addr <> '', 
		                            L.out.contact_addr, 
																Address.Addr1FromComponents(R.cont_prim_range, 
																												R.cont_predir, 
																												R.cont_prim_name,
																												R.cont_addr_suffix, 
																												R.cont_postdir, 
																												R.cont_unit_desig, 
																												R.cont_sec_range) +
															  IF(R.cont_p_city_name<>'',trim(R.cont_p_city_name)+', ','') +
															  IF(R.cont_state<>'',trim(R.cont_state)+' ','') +
															  IF(R.cont_zip5<>'',R.cont_zip5,'') +
															  IF(R.cont_zip4<>'','-'+ R.cont_zip4,''));
		SELF.out.Contact_Owned := IF(contactHit, 'Y', L.out.Contact_Owned);
		SELF := L;
	END;
	
  out2 := JOIN(out1c, 
							 CorpOnlyContactData, 
							 LEFT.out.owner1_did = RIGHT.did AND
							 LEFT.rec.corp_key = RIGHT.corp_key,
							 extractCorpContactFields(LEFT, RIGHT, LEFT.out.owner1_did = RIGHT.did AND LEFT.rec.corp_key = RIGHT.corp_key), 
							 LEFT OUTER);
							 
  out2a := JOIN(out2, 
							 CorpOnlyContactData, 
							 LEFT.out.owner2_did = RIGHT.did AND
							 LEFT.rec.corp_key = RIGHT.corp_key, 
							 extractCorpContactFields(LEFT, RIGHT, LEFT.out.owner2_did = RIGHT.did AND LEFT.rec.corp_key = RIGHT.corp_key), 
							 LEFT OUTER);
							 
  out2b := JOIN(out2a, 
							 CorpOnlyContactData, 
							 LEFT.out.reg_1_did = RIGHT.did AND
							 LEFT.rec.corp_key = RIGHT.corp_key, 
							 extractCorpContactFields(LEFT, RIGHT, LEFT.out.reg_1_did = RIGHT.did AND LEFT.rec.corp_key = RIGHT.corp_key), 
							 LEFT OUTER);

  out2c := JOIN(out2b, 
							 CorpOnlyContactData, 
							 LEFT.out.reg_2_did = RIGHT.did AND
							 LEFT.rec.corp_key = RIGHT.corp_key, 
							 extractCorpContactFields(LEFT, RIGHT, LEFT.out.reg_2_did = RIGHT.did AND LEFT.rec.corp_key = RIGHT.corp_key), 
							 LEFT OUTER);

  RETURN out2c;
END;