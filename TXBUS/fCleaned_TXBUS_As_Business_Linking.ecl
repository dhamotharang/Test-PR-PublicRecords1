IMPORT Business_Header,ut,mdr,_Validate;

EXPORT fCleaned_TXBUS_As_Business_Linking(DATASET(Layouts_Txbus.Layout_Base) pTXBUS) := FUNCTION

	fTXBUS := pTXBUS;
	
  //////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map data to BH Layout_Business_Linking.Combined
	//////////////////////////////////////////////////////////////////////////////////////////////
	
	Business_Header.Layout_Business_Linking.Combined Translate_TXBUS_To_BLF(Layouts_Txbus.Layout_Base L, INTEGER CTR) := TRANSFORM,
	                                      SKIP(L.Taxpayer_prim_name = '' AND L.Taxpayer_p_city_name = '' AND L.Taxpayer_st  = '' AND L.Taxpayer_zip5 = '')
	   SELF.source                      := MDR.sourceTools.src_TXBUS;
		 SELF.dt_first_seen               := IF(_Validate.Date.fIsValid(L.dt_first_seen),(UNSIGNED6) L.dt_first_seen, 0);
	   SELF.dt_last_seen                := IF(_Validate.Date.fIsValid(L.dt_last_seen),(UNSIGNED6) L.dt_last_seen, 0);
		 SELF.dt_vendor_first_reported    := IF(_Validate.Date.fIsValid(L.Process_Date),(UNSIGNED6) L.Process_Date, 0);
	   SELF.dt_vendor_last_reported     := IF(_Validate.Date.fIsValid(L.Process_Date),(UNSIGNED6) L.Process_Date, 0);
		 SELF.company_bdid                := L.bdid;
		 SELF.company_name                := Stringlib.StringToUpperCase(IF(TRIM(L.Taxpayer_lname) = '',
	                                       CHOOSE(CTR, L.Taxpayer_Name, L.Outlet_Name), L.Outlet_Name));
		 SELF.company_address_type_raw    := 'CC';																		 
		 SELF.company_address.prim_range  := CHOOSE(CTR, L.Taxpayer_prim_range,L.Outlet_prim_range);
	   SELF.company_address.predir      := CHOOSE(CTR, L.Taxpayer_predir, L.Outlet_predir);
	   SELF.company_address.prim_name   := CHOOSE(CTR, L.Taxpayer_prim_name, L.Outlet_prim_name);
	   SELF.company_address.addr_suffix := CHOOSE(CTR, L.Taxpayer_addr_suffix, L.Outlet_addr_suffix);
	   SELF.company_address.postdir     := CHOOSE(CTR, L.Taxpayer_postdir, L.Outlet_postdir);
	   SELF.company_address.unit_desig  := CHOOSE(CTR, L.Taxpayer_unit_desig, L.Outlet_unit_desig);
	   SELF.company_address.sec_range   := CHOOSE(CTR, L.Taxpayer_sec_range, L.Outlet_sec_range);
		 SELF.company_address.p_city_name := CHOOSE(CTR, L.Taxpayer_p_city_name, L.Outlet_p_city_name);
	   SELF.company_address.v_city_name := CHOOSE(CTR, L.Taxpayer_v_city_name, L.Outlet_v_city_name);
	   SELF.company_address.st          := CHOOSE(CTR, L.Taxpayer_st, L.Outlet_st);
	   SELF.company_address.zip         := CHOOSE(CTR, L.Taxpayer_zip5, L.Outlet_zip5);
	   SELF.company_address.zip4        := CHOOSE(CTR, L.Taxpayer_zip4,L.Outlet_zip4);	  
		 SELF.company_address.cart        := CHOOSE(CTR, L.Taxpayer_cart, L.Outlet_cart);	
		 SELF.company_address.cr_sort_sz  := CHOOSE(CTR, L.Taxpayer_cr_sort_sz, L.Outlet_cr_sort_sz);
		 SELF.company_address.lot         := CHOOSE(CTR, L.Taxpayer_lot, L.Outlet_lot);
		 SELF.company_address.lot_order   := CHOOSE(CTR, L.Taxpayer_lot_order, L.Outlet_lot_order);
		 SELF.company_address.dbpc        := CHOOSE(CTR, L.Taxpayer_dpbc, L.Outlet_dpbc);
		 SELF.company_address.chk_digit   := CHOOSE(CTR, L.Taxpayer_chk_digit, L.Outlet_chk_digit);
		 SELF.company_address.rec_type    := CHOOSE(CTR, L.Taxpayer_addr_rec_type, L.Outlet_addr_rec_type);
		 SELF.company_address.fips_state  := CHOOSE(CTR, L.Taxpayer_fips_state, L.Outlet_fips_state);
		 SELF.company_address.fips_county := CHOOSE(CTR, L.Taxpayer_fips_county, L.Outlet_fips_county);
		 SELF.company_address.geo_lat     := CHOOSE(CTR, L.Taxpayer_geo_lat, L.Outlet_geo_lat);
		 SELF.company_address.geo_long    := CHOOSE(CTR, L.Taxpayer_geo_long, L.Outlet_geo_long);
		 SELF.company_address.msa         := CHOOSE(CTR, L.Taxpayer_cbsa, L.Outlet_cbsa);
		 SELF.company_address.geo_blk     := CHOOSE(CTR, L.Taxpayer_geo_blk, L.Outlet_geo_blk);
		 SELF.company_address.geo_match   := CHOOSE(CTR, L.Taxpayer_geo_match, L.Outlet_geo_match);
		 SELF.company_address.err_stat    := CHOOSE(CTR, L.Taxpayer_err_stat, L.Outlet_err_stat);
		 SELF.company_phone               := Business_Header.CleanPhone(CHOOSE(CTR, L.Taxpayer_Phone, L.Outlet_Phone));
		 SELF.phone_type                  := IF((INTEGER)SELF.company_phone = 0, '','T');
		 SELF.company_org_structure_raw   := L.Taxpayer_org_type_desc;
		 SELF.company_naics_code1         := L.Outlet_NAICS_Code;
		 SELF.vl_id                       := L.Taxpayer_number;
		 SELF.source_record_id            := L.source_rec_id;
		 SELF.phone_score                 := IF((INTEGER)SELF.company_phone = 0, 0, 1);
		 SELF.current                     := TRUE;
		 SELF.is_contact                  := FALSE; 
		 SELF.dt_first_seen_contact       := IF(_Validate.Date.fIsValid(l.dt_first_seen),(UNSIGNED6) l.dt_first_seen, 0);
		 SELF.dt_last_seen_contact        := IF(_Validate.Date.fIsValid(l.dt_last_seen), (UNSIGNED6) l.dt_last_seen, 0);
		 SELF.contact_name.title          := L.Taxpayer_title;
		 SELF.contact_name.fname          := L.Taxpayer_fname;
		 SELF.contact_name.mname          := L.Taxpayer_mname;
		 SELF.contact_name.lname          := L.Taxpayer_lname;
		 SELF.contact_name.name_suffix    := L.Taxpayer_name_suffix;
		 SELF.contact_name.name_score     := L.Taxpayer_name_score;
		 SELF.contact_job_title_raw       := IF((SELF.contact_name.fname <> '') OR (SELF.contact_name.lname <> ''), 'OWNER','');
		 SELF                             := L;
		 SELF                             := [];
	END;
	
	TXBUS_Norm        := NORMALIZE(fTXBUS, 2, Translate_TXBUS_To_BLF(LEFT, COUNTER));

	TXBUS_Norm_Filter := TXBUS_Norm(company_name <> '');

	TXBUS_Norm_Dist   := DISTRIBUTE(TXBUS_Norm_Filter, HASH(vl_id,company_name,company_address.zip));

	TXBUS_Norm_Sort   := SORT(TXBUS_Norm_Dist,
										   vl_id,
										   company_name,
										   -company_address.zip,
										   -company_address.st,
										   -company_address.p_city_name,
										   LOCAL);

	Business_Header.Layout_Business_Linking.Combined RollupTXBUSNorm(Business_Header.Layout_Business_Linking.Combined L, Business_Header.Layout_Business_Linking.Combined R) := TRANSFORM
	  SELF := L;
	END;

	TXBUS_Comp_Rollup := ROLLUP(TXBUS_Norm_Sort,
											   LEFT.company_name                   = RIGHT.company_name AND
											   ((LEFT.company_address.zip          = RIGHT.company_address.zip AND
											   LEFT.company_address.prim_name      = RIGHT.company_address.prim_name AND
											   LEFT.company_address.prim_range     = RIGHT.company_address.prim_range AND
											   LEFT.company_address.p_city_name    = RIGHT.company_address.p_city_name AND
											   LEFT.company_address.st             = RIGHT.company_address.st) OR
											   ((INTEGER)RIGHT.company_address.zip = 0 AND
											   RIGHT.company_address.prim_name     = '' AND
											   RIGHT.company_address.prim_range    = '' AND
											   RIGHT.company_address.p_city_name   = '' AND
												 RIGHT.company_address.st            = '')),
											   RollupTXBUSNorm(LEFT, RIGHT),
											   LOCAL);
												 
	TXBUS_dedup := DEDUP(PROJECT(TXBUS_Comp_Rollup,Business_Header.Layout_Business_Linking.Linking_Interface),RECORD,ALL);
		
  RETURN TXBUS_dedup;

END;