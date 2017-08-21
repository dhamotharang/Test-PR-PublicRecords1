IMPORT govdata, Business_Header, ut,mdr,address;

EXPORT fCA_Sales_Tax_As_Business_Linking (DATASET(Layout_CA_Sales_Tax) pBasefile) := FUNCTION

	f := pBasefile;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map Contact data to BH Layout_Business_Linking.Contact
	//////////////////////////////////////////////////////////////////////////////////////////////
	
	Business_Header.Layout_Business_Linking.Contact Translate_CST_To_BCF(Layout_CA_Sales_Tax l) := TRANSFORM
	  SELF.tmp_join_id_contact         := (STRING)L.account_number + (STRING)L.sub_account_number;
		SELF.contact_address_type        := 'C';
    SELF.is_contact                  := FALSE; 
		SELF.dt_first_seen_contact       := (UNSIGNED4)l.start_date;
		SELF.dt_last_seen_contact        := (UNSIGNED4)CA_Sales_Tax_File_Date;
		SELF.contact_name.title          := L.name_prefix;
		SELF.contact_name.fname          := L.name_first;
		SELF.contact_name.mname          := L.name_middle;
		SELF.contact_name.lname          := L.name_last;
		SELF.contact_name.name_suffix    := L.name_suffix;
		SELF.contact_name.name_score     := L.score;
		SELF.contact_job_title_raw       := 'OWNER';
		SELF                             := L;
		SELF                             := [];
	END;
		
	CA_ST_Contact := PROJECT(f(owner_name <> '', firm_name <> '',
			                    Address.Business.GetNameType(name_first + ' ' + name_middle + ' ' + name_last + ' ' + name_suffix) in ['P','D']
				                  AND datalib.CompanyClean(owner_name)[41..120] = '',
			                   (INTEGER)(Business_Header.CleanName(name_first, name_middle, name_last, name_suffix)[142]) < 3),
				                  Translate_CST_To_BCF(LEFT));	
		
	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map Company data to BH Layout_Business_Linking.Company_
	//////////////////////////////////////////////////////////////////////////////////////////////

	Business_Header.Layout_Business_Linking.Company_ Translate_CASalesTax_To_BLF(Layout_CA_Sales_Tax L, UNSIGNED1 CTR, UNSIGNED1 ntyp) := TRANSFORM, 
	                                    SKIP(L.mail_prim_name = '' AND L.mail_p_city_name = '' AND L.mail_st  = '' AND L.mail_zip = '')
	   SELF.tmp_join_id_company         := L.account_number + L.sub_account_number;
	   SELF.source                      := MDR.sourceTools.src_CA_Sales_Tax;
		 SELF.dt_first_seen               := (UNSIGNED4)L.start_date;
	   SELF.dt_last_seen                := (UNSIGNED4)CA_Sales_Tax_File_Date;
	   SELF.dt_vendor_first_reported    := (UNSIGNED4)L.start_date;
	   SELF.dt_vendor_last_reported     := (UNSIGNED4)CA_Sales_Tax_File_Date;
		 SELF.company_bdid                := L.bdid;
		 SELF.company_name                := CHOOSE(ntyp, stringlib.stringtouppercase(L.firm_name),
		                                                  stringlib.stringtouppercase(L.owner_name));
     SELF.company_address.prim_range  := CHOOSE(CTR, L.prim_range,L.mail_prim_range);
	   SELF.company_address.predir      := CHOOSE(CTR, L.predir, L.mail_predir);
	   SELF.company_address.prim_name   := CHOOSE(CTR, L.prim_name, L.mail_prim_name);
	   SELF.company_address.addr_suffix := CHOOSE(CTR, L.addr_suffix, L.mail_addr_suffix);
	   SELF.company_address.postdir     := CHOOSE(CTR, L.postdir, L.mail_postdir);
	   SELF.company_address.unit_desig  := CHOOSE(CTR, L.unit_desig, L.mail_unit_desig);
	   SELF.company_address.sec_range   := CHOOSE(CTR, L.sec_range, L.mail_sec_range);
		 SELF.company_address.p_city_name := CHOOSE(CTR, L.p_city_name, L.mail_p_city_name);
	   SELF.company_address.v_city_name := CHOOSE(CTR, L.v_city_name, L.mail_v_city_name);
	   SELF.company_address.st          := CHOOSE(CTR, L.st, L.mail_st);
	   SELF.company_address.zip         := CHOOSE(CTR, L.zip, L.mail_zip);
	   SELF.company_address.zip4        := CHOOSE(CTR, L.zip4,L.mail_zip4);	  
		 SELF.company_address.cart        := CHOOSE(CTR, L.cart, L.mail_cart);	
		 SELF.company_address.cr_sort_sz  := CHOOSE(CTR, L.cr_sort_sz, L.mail_cr_sort_sz);
		 SELF.company_address.lot         := CHOOSE(CTR, L.lot, L.mail_lot);
		 SELF.company_address.lot_order   := CHOOSE(CTR, L.lot_order, L.mail_lot_order);
		 SELF.company_address.dbpc        := CHOOSE(CTR, L.dpbc, L.mail_dpbc);
		 SELF.company_address.chk_digit   := CHOOSE(CTR, L.chk_digit, L.mail_chk_digit);
		 SELF.company_address.rec_type    := CHOOSE(CTR, L.record_type, L.mail_record_type);
		 SELF.company_address.fips_state  := CHOOSE(CTR, L.ace_fips_st, L.mail_ace_fips_st);
		 SELF.company_address.fips_county := CHOOSE(CTR, L.fipscounty, L.mail_fipscounty);
		 SELF.company_address.geo_lat     := CHOOSE(CTR, L.geo_lat, L.mail_geo_lat);
		 SELF.company_address.geo_long    := CHOOSE(CTR, L.geo_long, L.mail_geo_long);
		 SELF.company_address.msa         := CHOOSE(CTR, L.msa, L.mail_msa);
		 SELF.company_address.geo_blk     := CHOOSE(CTR, L.geo_blk, L.mail_geo_blk);
		 SELF.company_address.geo_match   := CHOOSE(CTR, L.geo_match, L.mail_geo_match);
		 SELF.company_address.err_stat    := CHOOSE(CTR, L.err_stat, L.mail_err_stat);
		 SELF.vl_id                       := 'CA' + L.account_number;
		 SELF.current                     := TRUE;
		 SELF.source_record_id						:= L.source_rec_id;
		 SELF                             := L;
		 SELF                             := [];
	END;
	
	CA_ST_Firms := NORMALIZE(f(firm_name <> ''), 2, Translate_CASalesTax_To_BLF(LEFT, COUNTER, 1));

	CA_ST_Owners := NORMALIZE(f((owner_name <> '' AND firm_name = '') or (owner_name <> '' AND firm_name <> '' AND
						 NOT (Address.Business.GetNameType(name_first + ' ' + name_middle + ' ' + name_last + ' ' + name_suffix) IN ['P','D']
						 AND datalib.CompanyClean(owner_name)[41..120] = ''))), 2, Translate_CASalesTax_To_BLF(LEFT, COUNTER, 2));

	CA_ST_Companies := CA_ST_Firms(company_name <> '', company_name[1..12] <> 'UNIDENTIFIED',
	                           NOT(company_address.prim_name='' AND company_address.p_city_name='' AND company_address.v_city_name='' AND company_address.st='' AND company_address.zip='')) +
					           CA_ST_Owners(company_name <> '', company_name[1..12] <> 'UNIDENTIFIED',
										         NOT(company_address.prim_name='' AND company_address.p_city_name='' AND company_address.v_city_name='' AND company_address.st='' AND company_address.zip=''));

	// Rollup
	Business_Header.Layout_Business_Linking.Company_ RollupCA_ST(Business_Header.Layout_Business_Linking.Company_ L, business_header.Layout_Business_Linking.Company_ R) := TRANSFORM
	  SELF.dt_first_seen                := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
			                                   ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                 := max(L.dt_last_seen,R.dt_last_seen);
		SELF.dt_vendor_first_reported     := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.dt_vendor_last_reported      := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	  SELF.company_name                 := IF(L.company_name = '', R.company_name, L.company_name);
	  SELF.company_address.prim_range   := IF(l.company_address.prim_range = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.prim_range, l.company_address.prim_range);
	  SELF.company_address.predir       := IF(l.company_address.predir = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.predir, l.company_address.predir);
	  SELF.company_address.prim_name    := IF(l.company_address.prim_name = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.prim_name, l.company_address.prim_name);
	  SELF.company_address.addr_suffix  := IF(l.company_address.addr_suffix = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.addr_suffix, l.company_address.addr_suffix);
	  SELF.company_address.postdir      := IF(l.company_address.postdir = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.postdir, l.company_address.postdir);
	  SELF.company_address.unit_desig   := IF(l.company_address.unit_desig = ''AND (INTEGER)l.company_address.zip4 = 0, r.company_address.unit_desig, l.company_address.unit_desig);
	  SELF.company_address.sec_range    := IF(l.company_address.sec_range = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.sec_range, l.company_address.sec_range);
	  SELF.company_address.p_city_name  := IF(l.company_address.p_city_name = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.p_city_name, l.company_address.p_city_name);
		SELF.company_address.v_city_name  := IF(l.company_address.v_city_name = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.v_city_name, l.company_address.v_city_name);
	  SELF.company_address.st           := IF(l.company_address.st = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.st, l.company_address.st);
	  SELF.company_address.zip          := IF((INTEGER)l.company_address.zip = 0 AND (INTEGER)l.company_address.zip4 = 0, r.company_address.zip, l.company_address.zip);
	  SELF.company_address.zip4         := IF((INTEGER)l.company_address.zip4 = 0, r.company_address.zip4, l.company_address.zip4);
		SELF.company_address.fips_state   := IF(l.company_address.fips_state = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.fips_state, l.company_address.fips_state);
	  SELF.company_address.fips_county  := IF(l.company_address.fips_county = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.fips_county, l.company_address.fips_county);
		SELF.company_address.geo_lat      := IF(l.company_address.geo_lat = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.geo_lat, l.company_address.geo_lat);
	  SELF.company_address.geo_long     := IF(l.company_address.geo_long = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.geo_long, l.company_address.geo_long);
	  SELF.company_address.msa          := IF(l.company_address.msa = '' AND (INTEGER)l.company_address.zip4 = 0, r.company_address.msa, l.company_address.msa);
	  SELF := L;
	END;

	CA_ST_Clean_Companies_Dist := DISTRIBUTE(CA_ST_Companies,
								   HASH(TRIM(vl_id), TRIM(company_address.zip), TRIM(company_address.prim_name), TRIM(company_address.prim_range), TRIM(source), TRIM(company_name)));
									 
	CA_ST_Clean_Companies_Sort := SORT(CA_ST_Clean_Companies_Dist, vl_id, company_address.zip, company_address.prim_range, 
	                                   company_address.prim_name, IF(company_address.sec_range <> '', 0, 1), company_address.sec_range, source, company_name, LOCAL);

																					 
	CA_ST_Clean_Companies_Rollup := ROLLUP(CA_ST_Clean_Companies_Sort,
	                                       LEFT.vl_id = RIGHT.vl_id AND
																				 LEFT.company_address.zip = RIGHT.company_address.zip AND
																				 LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
																				 LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
																				 LEFT.source = RIGHT.source AND
																				 LEFT.company_name = RIGHT.company_name AND
																				 (RIGHT.company_address.sec_range = '' OR LEFT.company_address.sec_range = RIGHT.company_address.sec_range),
																				 RollupCA_ST(LEFT, RIGHT), 					                              	
																				 LOCAL);
  
	//join the clean contacts with the companies
	ds_Contact := DISTRIBUTE(CA_ST_Contact,HASH(tmp_join_id_contact));
	ds_Company := DISTRIBUTE(CA_ST_Clean_Companies_Rollup,HASH(tmp_join_id_company));
	
 
	Business_Header.Layout_Business_Linking.Combined Comb_CA_ST(Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Contact R) := TRANSFORM
    SELF.company_address_type_raw := r.contact_address_type;  	
		SELF                          := l;
		SELF                          := r;
	END;
	
	j1 := JOIN(ds_company,ds_contact,
	           LEFT.tmp_join_id_company=RIGHT.tmp_join_id_contact,
						 Comb_CA_ST(LEFT,RIGHT),
						 LEFT OUTER,LOCAL);
	
  Business_Header.Layout_Business_Linking.Combined Comb_CA_ST2(Business_Header.Layout_Business_Linking.Combined L, Business_Header.Layout_Business_Linking.Contact R) := TRANSFORM
		SELF := l;
	  SELF := r;
	END;	
	
	j2 := JOIN(j1,ds_Contact,
					    	 LEFT.tmp_join_id_company=RIGHT.tmp_join_id_contact AND 
					    	 LEFT.contact_name.fname=RIGHT.contact_name.fname AND 
						     LEFT.contact_name.lname=RIGHT.contact_name.lname, 
						     Comb_CA_ST2(LEFT,RIGHT),LOCAL);

	ds_Combined      := j1+j2;
	
	CA_ST_dedup := DEDUP(PROJECT(ds_Combined,Business_Header.Layout_Business_Linking.Linking_Interface),RECORD,ALL);
	
	
  RETURN CA_ST_dedup;
		
END;