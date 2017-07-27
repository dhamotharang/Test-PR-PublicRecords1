IMPORT Business_Header, mdr, _Validate, ut;

EXPORT fIRS5500_As_Business_Linking(DATASET(Layout_IRS5500_AID) pIRRS5500)
 :=  FUNCTION

  ffixedDateIRS := ffixedDate(pIRRS5500);
		
	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map Contact data to BH Layout_Business_Linking.Contacts
	//////////////////////////////////////////////////////////////////////////////////////////////
  Business_Header.Layout_Business_Linking.Contact Translate_IRS_To_BLCon(ffixedDateIRS L) := TRANSFORM 	
     SELF.tmp_join_id_contact         := L.document_locator_number;
 		 SELF.contact_address_type        := 'C';
		 SELF.is_contact                  := FALSE; 
		 SELF.dt_first_seen_contact       := IF(_Validate.Date.fIsValid(L.form_plan_year_begin_date),(UNSIGNED4)L.form_plan_year_begin_date, 0);
		 SELF.dt_last_seen_contact        := IF(_Validate.Date.fIsValid(L.trans_date),(UNSIGNED4)L.trans_date, 0);
		 SELF.contact_name.title          := L.spons_sign_title;
		 SELF.contact_name.fname          := L.spons_sign_fname;
		 SELF.contact_name.mname          := L.spons_sign_mname;
		 SELF.contact_name.lname          := L.spons_sign_lname;
		 SELF.contact_name.name_suffix    := L.spons_sign_suffix;
		 SELF.contact_name.name_score     := (STRING)L.spons_sign_name_score;
		 SELF.contact_job_title_raw       := 'OWNER';  	
		 SELF                             := L;
		 SELF                             := [];
	END;
	
	IRS_Contacts := PROJECT(ffixedDateIRS, Translate_IRS_To_BLCon(LEFT));
	
	fIRS5500 := pIRRS5500;
	
  //////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map Company data to BH Layout_Business_Linking.Company_
	//////////////////////////////////////////////////////////////////////////////////////////////	
	
	Business_Header.Layout_Business_Linking.Company_ Translate_IRS_To_BLCmp(fIRS5500 L) := TRANSFORM, 
	                                    SKIP(L.spons_p_city_name = '' AND L.spons_st  = '' AND L.spons_zip5 = '')
	   SELF.tmp_join_id_company         := L.document_locator_number;
		 SELF.source                      := MDR.sourceTools.src_IRS_5500;
		 // trans_date only exists for old data and date_received only exists for the newer data
		 the_date := IF(l.trans_date != '', l.trans_date, l.date_received);
		 SELF.dt_first_seen               := IF(_Validate.Date.fIsValid(the_date),(UNSIGNED4) the_date,0);
	   SELF.dt_last_seen                := IF(_Validate.Date.fIsValid(the_date),(UNSIGNED4) the_date,0);
	   SELF.dt_vendor_first_reported    := IF(_Validate.Date.fIsValid(the_date),(UNSIGNED4) the_date,0);
	   SELF.dt_vendor_last_reported     := IF(_Validate.Date.fIsValid(the_date),(UNSIGNED4) the_date,0);
		 SELF.company_bdid                := L.bdid;
		 SELF.company_name                := stringlib.stringtouppercase(L.sponsor_dfe_name);
     SELF.company_rawaid              := L.raw_aid; 
		 SELF.company_address.prim_range  := L.spons_prim_range;
	   SELF.company_address.predir      := L.spons_predir;
	   SELF.company_address.prim_name   := L.spons_prim_name;
	   SELF.company_address.addr_suffix := L.spons_addr_suffix;
	   SELF.company_address.postdir     := L.spons_postdir;
	   SELF.company_address.unit_desig  := L.spons_unit_desig;
	   SELF.company_address.sec_range   := L.spons_sec_range;
		 SELF.company_address.p_city_name := L.spons_p_city_name;
		 SELF.company_address.v_city_name := L.spons_v_city_name;
	   SELF.company_address.st          := L.spons_st;
	   SELF.company_address.zip         := L.spons_zip5;
	   SELF.company_address.zip4        := L.spons_zip4;	  
		 SELF.company_address.cart        := L.spons_cart;	
		 SELF.company_address.cr_sort_sz  := L.spons_cr_sort_sz;
		 SELF.company_address.lot         := L.spons_lot;
		 SELF.company_address.lot_order   := L.spons_lot_order;
		 SELF.company_address.dbpc        := L.spons_dpbc;
		 SELF.company_address.chk_digit   := L.spons_chk_digit;
		 SELF.company_address.rec_type    := L.spons_rec_type;
		 SELF.company_address.fips_state  := L.spons_county[1..2];
		 SELF.company_address.fips_county := L.spons_county[3..5];
		 SELF.company_address.geo_lat     := L.spons_geo_lat;
		 SELF.company_address.geo_long    := L.spons_geo_long;
		 SELF.company_address.msa         := L.spons_msa;
		 SELF.company_address.geo_blk     := L.spons_geo_blk;
		 SELF.company_address.geo_match   := L.spons_geo_match;
		 SELF.company_address.err_stat    := L.spons_err_stat;
		 SELF.company_fein                := L.ein;
		 SELF.company_phone               := ut.CleanPhone(L.spon_dfe_phone_num);
		 SELF.phone_type                  := IF((INTEGER)SELF.company_phone = 0, '','T');
		 SELF.vl_id                       := L.document_locator_number;
		 SELF.current                     := TRUE;
		 SELF.source_record_id            := l.source_rec_id;
		 SELF.phone_score                 := IF((INTEGER)SELF.company_phone = 0, 0, 1);
		 SELF                             := L;
		 SELF                             := [];
	END;
	
	IRS_Companies := PROJECT(fIRS5500, Translate_IRS_To_BLCmp(LEFT));
	
	//join the contacts with the companies
	ds_Company := DISTRIBUTE(IRS_Companies, HASH(tmp_join_id_company));
	ds_Contact := DISTRIBUTE(IRS_Contacts, HASH(tmp_join_id_contact));
	
	Business_Header.Layout_Business_Linking.Combined Comb_IRS(Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Contact R) := TRANSFORM
    SELF.company_address_type_raw := R.contact_address_type;  	
	  SELF                          := L;
		SELF                          := R;
	END;
	
	jIRS := JOIN(ds_Company, ds_Contact,
	             LEFT.tmp_join_id_company = RIGHT.tmp_join_id_contact,
							 Comb_IRS(LEFT,RIGHT),
							 LEFT OUTER, LOCAL);
							 
	IRS_dedup := DEDUP(PROJECT(jIRS,Business_Header.Layout_Business_Linking.Linking_Interface),RECORD,ALL);
	
	RETURN IRS_dedup(company_name <> '');
	
END;