IMPORT Business_Header, ut, _validate, mdr;

EXPORT fABIUS_Company_As_Business_Linking(
       DATASET(InfoUSA.Layout_ABIUS_Company_Base_AID) pABIUS_Company):=  FUNCTION

	//*************************************************************************
	// Translate ABIUS Company file to Common Business Header Format
	//*************************************************************************
	abius_company_base := pABIUS_Company;

	Layout_abius_company_Local := RECORD
  	InfoUSA.Layout_ABIUS_Company_Base_AID -contact_name;
	END;

	//--------------------------------------------
	// Add unique record id to abius_company file
	//--------------------------------------------
	Layout_abius_company_Local DropContactName(InfoUSA.Layout_ABIUS_Company_Base_AID L) := TRANSFORM
	  SELF := L;
	END;

	abius_company_Init := PROJECT(abius_company_base, DropContactName(LEFT));

	bl_layout := business_header.Layout_Business_Linking.Linking_Interface;

	bl_layout Translate_abius_company_To_BHL(Layout_abius_company_Local L, INTEGER CTR) := TRANSFORM,
    SKIP((CTR = 2 AND (L.p_city_name2 + L.v_city_name2 + L.st2 + L.z52) = '') OR
         (CTR = 3 AND ut.CleanPhone(L.fax) = '') OR
         (CTR = 4 AND (ut.CleanPhone(L.fax) = '' OR (L.p_city_name2 + L.v_city_name2 + L.st2 + L.z52) = '')))
	  SELF.source                        := MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ; 
	  SELF.source_record_id              := L.source_rec_id;
    SELF.dt_first_seen                 := IF(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);  
	  SELF.dt_last_seen                  := IF(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);
	  SELF.dt_vendor_first_reported      := IF(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100,
                                             IF(_validate.date.fIsValid(L.PRODUCTION_DATE),
                                             (UNSIGNED4)L.PRODUCTION_DATE, 0));
	  SELF.dt_vendor_last_reported       := IF(_validate.date.fIsValid(L.PRODUCTION_DATE),
                                             (UNSIGNED4)L.PRODUCTION_DATE, 0);
    SELF.company_bdid                  := L.bdid;
	  SELF.company_name                  := L.company_name;
	  SELF.company_rawaid                := L.append_rawaid;
	  SELF.company_address.prim_range    := CHOOSE(CTR, L.prim_range, L.prim_range2, L.prim_range, L.prim_range2);
	  SELF.company_address.predir        := CHOOSE(CTR, L.predir, L.predir2, L.predir, L.predir2);
	  SELF.company_address.prim_name     := CHOOSE(CTR, L.prim_name, L.prim_name2, L.prim_name, L.prim_name2);
	  SELF.company_address.addr_suffix   := CHOOSE(CTR, L.addr_suffix, L.addr_suffix2, L.addr_suffix, L.addr_suffix2);
	  SELF.company_address.postdir       := CHOOSE(CTR, L.postdir, L.postdir2, L.postdir, L.postdir2);
	  SELF.company_address.unit_desig    := CHOOSE(CTR, L.unit_desig, L.unit_desig2, L.unit_desig, L.unit_desig2);
	  SELF.company_address.sec_range     := CHOOSE(CTR, L.sec_range, L.sec_range2, L.sec_range, L.sec_range2);
	  SELF.company_address.p_city_name   := CHOOSE(CTR, L.p_city_name,	L.p_city_name2, L.p_city_name,	L.p_city_name2);
	  SELF.company_address.v_city_name   := CHOOSE(CTR, L.v_city_name,	L.v_city_name2, L.v_city_name,	L.v_city_name2);
	  SELF.company_address.st            := CHOOSE(CTR, L.st, L.st2, L.st, L.st2);
	  SELF.company_address.zip           := CHOOSE(CTR, L.z5, L.z52, L.z5, L.z52);
	  SELF.company_address.zip4          := CHOOSE(CTR, L.zip4, L.zip42, L.zip4, L.zip42);
	  SELF.company_address.cart          := CHOOSE(CTR, L.cart, L.cart2, L.cart, L.cart2);
	  SELF.company_address.cr_sort_sz    := CHOOSE(CTR, L.cr_sort_sz, L.cr_sort_sz2, L.cr_sort_sz, L.cr_sort_sz2);
	  SELF.company_address.lot           := CHOOSE(CTR, L.lot, L.lot2, L.lot, L.lot2);
	  SELF.company_address.lot_order     := CHOOSE(CTR, L.lot_order, L.lot_order2, L.lot_order, L.lot_order2);
	  SELF.company_address.chk_digit     := CHOOSE(CTR, L.chk_digit, L.chk_digit2, L.chk_digit, L.chk_digit2);
	  SELF.company_address.rec_type      := CHOOSE(CTR, L.rec_type, L.rec_type2, L.rec_type, L.rec_type2);
	  SELF.company_address.fips_county   := CHOOSE(CTR, L.county[3..5], L.county2[3..5], L.county[3..5], L.county2[3..5]);
	  SELF.company_address.fips_state    := CHOOSE(CTR, L.county[1..2], L.county2[1..2], L.county[1..2], L.county2[1..2]);
	  SELF.company_address.geo_lat       := CHOOSE(CTR, L.geo_lat, L.geo_lat2, L.geo_lat, L.geo_lat2);
	  SELF.company_address.geo_long      := CHOOSE(CTR, L.geo_long, L.geo_long2, L.geo_long, L.geo_long2);
	  SELF.company_address.msa           := CHOOSE(CTR, L.msa, L.msa2, L.msa, L.msa2);
	  SELF.company_address.geo_blk       := CHOOSE(CTR, L.geo_blk, L.geo_blk2, L.geo_blk, L.geo_blk2);
	  SELF.company_address.geo_match     := CHOOSE(CTR, L.geo_match, L.geo_match2, L.geo_match, L.geo_match2);
	  SELF.company_address.err_stat      := CHOOSE(CTR, L.err_stat, L.err_stat2, L.err_stat, L.err_stat2);
	  SELF.company_phone                 := CHOOSE(CTR, ut.CleanPhone(L.phone), ut.CleanPhone(L.phone),
                                                      ut.CleanPhone(L.fax), ut.CleanPhone(L.fax));
	  SELF.phone_type                    := CHOOSE(CTR, IF(ut.CleanPhone(L.phone) = '', '', 'T'),
                                                      IF(ut.CleanPhone(L.phone) = '', '', 'T'),
                                                      IF(ut.CleanPhone(L.fax) = '', '', 'F'),
                                                      IF(ut.CleanPhone(L.fax) = '', '', 'F'));
	  SELF.company_sic_code1             := L.primary_sic;
	  SELF.company_sic_code2             := L.secondary_sic_1;
	  SELF.company_sic_code3             := L.secondary_sic_2;
	  SELF.company_sic_code4             := L.secondary_sic_3;
	  SELF.company_sic_code5             := L.secondary_sic_4;
	  SELF.company_ticker                := L.stock_ticker_symbol;
	  SELF.company_ticker_exchange       := L.stock_exchange;
	  SELF.company_foreign_domestic      := 'D';
	  SELF.event_filing_date             := (UNSIGNED4)L.production_date;
		SELF.vl_id                         := L.ABI_NUMBER;
		SELF.current                       := TRUE;
	  SELF.phone_score                   := CHOOSE(CTR, IF(ut.CleanPhone(L.phone) = '', 0, 1),
                                                      IF(ut.CleanPhone(L.phone) = '', 0, 1),
                                                      IF(ut.CleanPhone(L.fax) = '', 0, 1),
                                                      IF(ut.CleanPhone(L.fax) = '', 0, 1));
	  SELF.dt_first_seen_contact         := if(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);  
	  SELF.dt_last_seen_contact          := if(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);
	  SELF.contact_name.title            := L.title;
	  SELF.contact_name.fname            := L.fname;
	  SELF.contact_name.mname            := L.mname;
	  SELF.contact_name.lname            := L.lname;
	  SELF.contact_name.name_suffix      := L.name_suffix;
	  SELF.contact_name.name_score       := L.name_score;
	  SELF.contact_job_title_raw         := Decode_Professional_Title(stringlib.stringtouppercase(L.contact_title));
	  SELF.contact_phone                 := CHOOSE(CTR, ut.CleanPhone(L.phone), ut.CleanPhone(L.phone),
                                                      ut.CleanPhone(L.fax), ut.CleanPhone(L.fax));
	  SELF                               := L;
	  SELF                               := [];
	END;

	//--------------------------------------------
	// Normalize on address and phone/fax
	//--------------------------------------------  
	from_abius_company_norm	:= NORMALIZE(abius_company_Init, 4, Translate_abius_company_To_BHL(LEFT, COUNTER));
   
	//--------------------------------------------
	// Dedup the records
	//--------------------------------------------
	from_abius_company_norm_dist := DISTRIBUTE(from_abius_company_norm,
                                             HASH(vl_id, ut.CleanCompany(company_name)));

  from_abius_company_sort := SORT(from_abius_company_norm_dist, 
                                  EXCEPT company_rawaid, contact_name.name_score,
                                  LOCAL);
  
  from_abius_company_dedup := DEDUP(from_abius_company_sort, 
                                    EXCEPT company_rawaid, contact_name.name_score,
                                    LOCAL);
  
  RETURN from_abius_company_dedup;
END;
 
