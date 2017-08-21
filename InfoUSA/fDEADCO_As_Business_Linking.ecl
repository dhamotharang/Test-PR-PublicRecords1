IMPORT business_header, infousa, ut, address,mdr;

EXPORT fDEADCO_As_Business_Linking(DATASET(Layout_Deadco_Base_AID) pDEADCO) :=  FUNCTION

	DEADCO_IN := pDEADCO;
	
	//--------------------------------------------
	// Remove contact name from the layout
	//--------------------------------------------
	Layout_Deadco_Local := RECORD
  	Layout_Deadco_Base_AID -contact_name;
	END;

	Layout_Deadco_Local DropContactName(Layout_Deadco_Base_AID L) := TRANSFORM
	  SELF := L;
	END;

	Deadco_Init := PROJECT(DEADCO_IN, DropContactName(LEFT));
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map data to BH Layout_Business_Linking.Combined
	//////////////////////////////////////////////////////////////////////////////////////////////
	
	Business_Header.Layout_Business_Linking.Combined Translate_Deadco_To_BL(Layout_Deadco_Local L) := TRANSFORM,
	                                     SKIP(L.prim_name = '' AND L.p_city_name = '' AND L.st  = '' AND L.zip5 = '')
	   SELF.source                      := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES;
		 SELF.source_record_id						:= L.source_rec_id;
		 SELF.dt_first_seen               := IF((UNSIGNED)L.dt_first_seen < 300000, (UNSIGNED)L.dt_first_seen * 100, (UNSIGNED)L.dt_first_seen);
		 SELF.dt_last_seen                := IF((UNSIGNED)L.dt_last_seen < 300000, (UNSIGNED)L.dt_last_seen * 100, (UNSIGNED)L.dt_last_seen);
		 SELF.dt_vendor_first_reported    := IF((UNSIGNED)L.dt_vendor_first_reported < 300000, (UNSIGNED)L.dt_vendor_first_reported * 100, (UNSIGNED)L.dt_vendor_first_reported);
	   SELF.dt_vendor_last_reported     := IF((UNSIGNED)L.dt_vendor_last_reported < 300000, (UNSIGNED)L.dt_vendor_last_reported * 100, (UNSIGNED)L.dt_vendor_last_reported);
		 SELF.company_bdid                := L.bdid;
		 SELF.company_name                := Stringlib.StringToUpperCase(L.company_name);
		 SELF.company_address_type_raw    := 'CC';
		 SELF.company_rawaid              := L.Append_RawAID;
		 SELF.company_address.prim_range  := L.prim_range;
	   SELF.company_address.predir      := L.predir;
	   SELF.company_address.prim_name   := L.prim_name;
	   SELF.company_address.addr_suffix := L.addr_suffix;
	   SELF.company_address.postdir     := L.postdir;
	   SELF.company_address.unit_desig  := L.unit_desig;
	   SELF.company_address.sec_range   := L.sec_range;
		 SELF.company_address.p_city_name := L.p_city_name;
	   SELF.company_address.v_city_name := L.v_city_name;
	   SELF.company_address.st          := L.st;
	   SELF.company_address.zip         := L.zip5;
	   SELF.company_address.zip4        := L.zip4;	  
		 SELF.company_address.cart        := L.cart;	
		 SELF.company_address.cr_sort_sz  := L.cr_sort_sz;
		 SELF.company_address.lot         := L.lot;
		 SELF.company_address.lot_order   := L.lot_order;
		 SELF.company_address.dbpc        := L.dpbc;
		 SELF.company_address.chk_digit   := L.chk_digit;
		 SELF.company_address.rec_type    := L.rec_type;
		 SELF.company_address.fips_state  := L.ace_fips_st;
		 SELF.company_address.fips_county := L.ace_fips_county;
		 SELF.company_address.geo_lat     := L.geo_lat;
		 SELF.company_address.geo_long    := L.geo_long;
		 SELF.company_address.msa         := L.msa;
		 SELF.company_address.geo_blk     := L.geo_blk;
		 SELF.company_address.geo_match   := L.geo_match;
		 SELF.company_address.err_stat    := L.err_stat;
		 SELF.company_phone               := Business_Header.CleanPhone(L.Phone);
		 SELF.phone_type                  := IF((INTEGER)SELF.company_phone = 0, '','T');
		 SELF.company_sic_code1           := L.primary_sic;
		 SELF.company_sic_code2           := L.secondary_sic_1;
		 SELF.company_sic_code3           := L.secondary_sic_2;
		 SELF.company_sic_code4           := L.secondary_sic_3;
		 SELF.company_sic_code5           := L.secondary_sic_4;
		 SELF.vl_id                       := L.ABI_NUMBER + L.production_date;
		 SELF.phone_score                 := IF((INTEGER)SELF.company_phone = 0, 0, 1);
		 SELF.current                     := TRUE;
		 SELF.is_contact                  := FALSE; 
		 SELF.dt_first_seen_contact       := IF((UNSIGNED)L.dt_first_seen < 300000, (UNSIGNED)L.dt_first_seen * 100, (UNSIGNED)L.dt_first_seen);
		 SELF.dt_last_seen_contact        := IF((UNSIGNED)L.dt_last_seen < 300000, (UNSIGNED)L.dt_last_seen * 100, (UNSIGNED)L.dt_last_seen);
		 SELF.contact_name.title          := L.title;
		 SELF.contact_name.fname          := L.fname;
		 SELF.contact_name.mname          := L.mname;
		 SELF.contact_name.lname          := L.lname;
		 SELF.contact_name.name_suffix    := L.name_suffix;
		 SELF.contact_name.name_score     := IF((SELF.contact_name.fname = '') AND (SELF.contact_name.lname = ''), '',
		                                         Business_Header.CleanName(L.fname,L.mname,L.lname,L.name_suffix)[142]);
		 SELF.contact_job_title_raw       := IF((SELF.contact_name.fname <> '') OR (SELF.contact_name.lname <> ''), 'OWNER','');
		 SELF                             := L;
     SELF                             := [];
	END;

  deadco_header := PROJECT(Deadco_Init,Translate_Deadco_To_BL(LEFT));

	deadco_dist   := DISTRIBUTE(deadco_header, HASH(TRIM(vl_id), TRIM(company_name)));

	deadco_sort   := SORT(deadco_dist,
	                    vl_id, company_name, contact_name.fname, contact_name.mname, contact_name.lname, 
											contact_name.name_suffix, contact_name.title, company_phone, 
											IF((INTEGER)company_address.zip <> 0, 0, 1), company_address.zip, 
											company_address.prim_name, company_address.prim_range, LOCAL);
											
  Business_Header.Layout_Business_Linking.Combined RollupDEADCONorm(Business_Header.Layout_Business_Linking.Combined L, Business_Header.Layout_Business_Linking.Combined R) := TRANSFORM
	  SELF := L;
	END;
	
	deadco_rollup := ROLLUP(deadco_sort,
								   LEFT.vl_id = RIGHT.vl_id AND
								   LEFT.company_name = RIGHT.company_name AND
								   LEFT.contact_name.fname= RIGHT.contact_name.fname AND
								   LEFT.contact_name.mname = RIGHT.contact_name.mname AND
								   LEFT.contact_name.lname = RIGHT.contact_name.lname AND
								   LEFT.contact_name.name_suffix = RIGHT.contact_name.name_suffix AND
								   LEFT.contact_name.title = RIGHT.contact_name.title AND
								   ((LEFT.company_address.zip = RIGHT.company_address.zip AND
								   LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
								   LEFT.company_address.prim_range = RIGHT.company_address.prim_range) OR
								   ((INTEGER)LEFT.company_address.zip <> 0 AND (INTEGER)RIGHT.company_address.zip = 0)),
									 RollupDEADCONorm(LEFT, RIGHT),
								   LOCAL);

  deadco_dedup := DEDUP(PROJECT(deadco_rollup,Business_Header.Layout_Business_Linking.Linking_Interface),RECORD,ALL);
														 
	RETURN deadco_dedup(company_name <> '');
	
END;