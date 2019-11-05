﻿IMPORT Address,BKForeclosure,codes,Property,STD,ut;
#option('multiplePersistInstances',FALSE);

EXPORT Fn_Map_BK2Foreclosure  := FUNCTION

  dReoBaseFile := BKForeclosure.File_BK_Foreclosure.fReo(Delete_flag <> 'DELETE' and ((seller1_fname <> '' or buyer1_fname <> '') or (prop_full_addr <> '' and prop_addr_city <> '' and prop_addr_state <> '')));
  dNodBaseFile := BKForeclosure.File_BK_Foreclosure.fNod(Delete_flag <> 'DELETE' and ((trustee_lname <> '' or borrower1_lname <> '') or (property_full_addr <> '' and prop_addr_city <> '' and prop_addr_state <> '')));
  dEmptyReo := ROW([], BKForeclosure.layout_BK.base_reo );
  dEmptyNod := ROW([], BKForeclosure.layout_BK.base_nod );

	// code_lkp := Address.County_Names;
	// StateCodes_dict	:= DICTIONARY(code_lkp, {state_code => state_alpha});
	// CountyCodes_dict := DICTIONARY(code_lkp, {county_code => county_name});
  // StCodeLkp(STRING code ) := StateCodes_dict[code].state_alpha;
	// CntyCodeLkp(STRING code ) := CountyCodes_dict[code].county_name;

  Property.Layout_Fares_Foreclosure_V2 tMapForeclosure(RECORDOF(DReoBaseFile ) lreo, RECORDOF(DNodBaseFile ) lnod, UNSIGNED uReoNod ) := TRANSFORM
    SELF.foreclosure_id := CHOOSE(uReoNod, lreo.foreclosure_id, lnod.foreclosure_id );
    SELF.State := CHOOSE(uReoNod, lreo.fips_cd[1..2], lnod.fips_cd[1..2] );
    SELF.County := CHOOSE(uReoNod, lreo.fips_cd[3..5], lnod.fips_cd[3..5] );
    SELF.deed_category := CHOOSE(uReoNod, 'U', 'N' );
    SELF.deed_desc := CHOOSE(uReoNod, 'Foreclosure', 'Notice of Default' );
    SELF.document_type := CHOOSE(uReoNod, lreo.doc_type_cd, lnod.doc_type );
    SELF.document_desc := CHOOSE(uReoNod, lreo.document_desc, lnod.document_desc );
    SELF.recording_date := CHOOSE(uReoNod, lreo.recording_date, lnod.recording_dt );
		SELF.document_year	:= Fn_get_document_date(CHOOSE(uReoNod, lreo.recording_doc_num, lnod.recording_doc_num ));
		TempDocNbr				:= CHOOSE(uReoNod, lreo.recording_doc_num, lnod.recording_doc_num );
    SELF.document_nbr := IF(LENGTH(STD.Str.Filter(TempDocNbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))>12 AND REGEXFIND('[^0-9]',STD.Str.Filter(TempDocNbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')[1..2]),
														STD.Str.Filter(TempDocNbr[7..],'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),
														IF(LENGTH(STD.Str.Filter(TempDocNbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))>12 AND REGEXFIND('^[0-9]',STD.Str.Filter(TempDocNbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')[1..2]),
															STD.Str.Filter(TempDocNbr[9..],'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),
															STD.Str.Filter(TempDocNbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')));
		TempDocBook					:= STD.Str.Filter(CHOOSE(uReoNod, lreo.recording_book_num, lnod.book_number ),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
    SELF.document_book	:= IF(LENGTH(TRIM(TempDocBook))>6 AND REGEXFIND('^[0]+',TempDocBook),ut.rmv_ld_zeros(TempDocBook),TempDocBook);
		TempDocPages				:= STD.Str.Filter(CHOOSE(uReoNod, lreo.recording_page_num, lnod.page_number ),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-');			 
    SELF.document_pages := IF(LENGTH(TRIM(TempDocPages))>6 AND REGEXFIND('^[0]+',TempDocPages),ut.rmv_ld_zeros(TempDocPages),TempDocPages);
    SELF.title_company_name := CHOOSE(uReoNod, lreo.title_co_name, '' );
		TempFirstBorrowerFirstName	:= CHOOSE(uReoNod, lreo.buyer1_fname, lnod.borrower1_fname );
		TempFirstBorrowerLastName		:= CHOOSE(uReoNod, IF(lreo.name1_first = '', '',lreo.buyer1_lname),
																									 IF(lnod.name1_first = '', '', lnod.borrower1_lname));
    SELF.first_defendant_borrower_owner_first_name := TempFirstBorrowerFirstName;
    SELF.first_defendant_borrower_owner_last_name := TempFirstBorrowerLastName;
		TempFirstBorrowerCompany		:= CHOOSE(uReoNod, IF( lreo.name1_first = '' AND lreo.buyer1_lname <> '' , lreo.buyer1_lname, '' ),
                                                      IF( lnod.name1_first = '' AND lnod.borrower1_lname <> '', lnod.borrower1_lname, '' ));
    SELF.first_defendant_borrower_company_name := TempFirstBorrowerCompany;
		TempSecondBorrowerFirstName	:= CHOOSE(uReoNod, lreo.buyer2_fname, lnod.borrower2_fname );
		TempSecondBorrowerLastName	:= CHOOSE(uReoNod, IF(lreo.name2_first = '', '', lreo.buyer2_lname), 
																									 IF(lnod.name2_first = '', '', lnod.borrower2_lname ));
    SELF.second_defendant_borrower_owner_first_name := IF(TRIM(TempFirstBorrowerFirstName) = TRIM(TempSecondBorrowerFirstName) AND 
																													TRIM(TempFirstBorrowerLastName) = TRIM(TempSecondBorrowerLastName),'',
																													TempSecondBorrowerFirstName);
    SELF.second_defendant_borrower_owner_last_name := IF(TRIM(TempFirstBorrowerFirstName) = TRIM(TempSecondBorrowerFirstName) AND 
																													TRIM(TempFirstBorrowerLastName) = TRIM(TempSecondBorrowerLastName),'',
																													TempSecondBorrowerLastName);
		TempSecondBorrowerCompany		:= CHOOSE(uReoNod,IF(lreo.name2_first = '' AND lreo.buyer2_lname <> '', lreo.buyer2_lname, ''),
                                                  IF( lnod.name2_first = '' AND lnod.borrower2_lname <> '', lnod.borrower2_lname, '' ));
    SELF.second_defendant_borrower_company_name := IF(TRIM(TempFirstBorrowerCompany) = TRIM(TempSecondBorrowerCompany),'',TempSecondBorrowerCompany);
    SELF.date_of_default := CHOOSE(uReoNod, '', lnod.as_of_dt );
    SELF.amount_of_default := CHOOSE(uReoNod, '', lnod.unpaid_balance );
    SELF.court_case_nbr := CHOOSE(uReoNod, '', lnod.case_number );
    SELF.plaintiff_1 := CHOOSE(uReoNod, IF( lreo.seller1_fname = '' AND lreo.seller1_lname <> '', lreo.seller1_lname, STD.Str.CleanSpaces(lreo.seller1_fname +' '+lreo.seller1_lname)  ), '' );
    SELF.plaintiff_2 := CHOOSE(uReoNod, IF( lreo.seller2_fname = '' AND lreo.seller2_lname <> '', lreo.seller2_lname, STD.Str.CleanSpaces(lreo.seller2_fname +' '+lreo.seller2_lname)  ), '' );
    SELF.auction_date := CHOOSE(uReoNod, '', lnod.auction_date );
    SELF.auction_time := CHOOSE(uReoNod, '', lnod.auction_time );
    SELF.street_address_of_auction_call := CHOOSE(uReoNod, '', lnod.auction_location );
    SELF.city_of_auction_call := CHOOSE(uReoNod, '',lnod.auction_city );
    SELF.opening_bid := CHOOSE(uReoNod, '', lnod.auction_min_bid_amt );
    SELF.sales_price := CHOOSE(uReoNod, lreo.sales_price, '');
    SELF.situs_address_indicator_1 := CHOOSE(uReoNod, lreo.situs1_record_type, lnod.situs1_record_type );
    SELF.situs_house_number_prefix_1 := CHOOSE(uReoNod, lreo.prop_addr_predir, ''); 
    SELF.situs_house_number_1 := CHOOSE(uReoNod, lreo.prop_addr_house_no, '' );
    SELF.situs_house_number_suffix_1 := CHOOSE(uReoNod, lreo.prop_addr_suffix, '' );	
    SELF.situs_street_name_1 := CHOOSE(uReoNod, lreo.prop_addr_street, lnod.property_full_addr );	
    SELF.situs_direction_1 := CHOOSE(uReoNod, lreo.prop_addr_postdir, '' );	
    SELF.apartment_unit := CHOOSE(uReoNod, lreo.prop_addr_unit_type+lreo.prop_addr_unit_no, lnod.prop_addr_unit_type+lnod.prop_addr_unit_no );	
    SELF.property_city_1 := CHOOSE(uReoNod, lreo.prop_addr_city, lnod.prop_addr_city );
    SELF.property_state_1 := CHOOSE(uReoNod, lreo.prop_addr_state, lnod.prop_addr_state );
    SELF.property_address_zip_code_1 := CHOOSE(uReoNod, lreo.prop_addr_zip5+lreo.prop_addr_zip4, lnod.prop_addr_zip5+lnod.prop_addr_zip4 );
    SELF.carrier_code := CHOOSE(uReoNod, lreo.prop_addr_carrier_rt, '' );	
    SELF.full_site_address_unparsed_1 := CHOOSE(uReoNod,lreo.prop_full_addr ,lnod.property_full_addr );
    SELF.lender_beneficiary_first_name := CHOOSE(uReoNod, '', '' ); 
    SELF.lender_beneficiary_last_name := CHOOSE(uReoNod, '', '' ); 
    SELF.lender_beneficiary_company_name := CHOOSE(uReoNod, lreo.concurrent_lender_name, lnod.curr_lender_name );
    SELF.trustee_name := CHOOSE(uReoNod, '', STD.Str.CleanSpaces(lnod.trustee_fname+' ' + lnod.trustee_lname) );
    SELF.trustee_mailing_address := CHOOSE(uReoNod, '', lnod.trustee_mail_full_addr );
    SELF.trustee_city := CHOOSE(uReoNod, '', lnod.trustee_mail_city );
    SELF.trustee_state := CHOOSE(uReoNod, '', lnod.trustee_mail_state );
    SELF.trustee_zip := CHOOSE(uReoNod, '', lnod.trustee_mail_zip5+lnod.trustee_mail_zip4 );
    SELF.trustee_phone := CHOOSE(uReoNod, '', lnod.trustee_telephone );
    SELF.trustee_sale_number := CHOOSE(uReoNod, '', lnod.trustee_sale_number );
    SELF.original_loan_date := CHOOSE(uReoNod, lreo.orig_contract_date, lnod.orig_contract_date );
    SELF.original_loan_recording_date := CHOOSE(uReoNod, '', lnod.loan_recording_date );
    SELF.original_loan_amount := CHOOSE(uReoNod, '', lnod.orig_loan_amt );
    SELF.original_document_number := CHOOSE(uReoNod, '', lnod.loan_doc_num );
    SELF.original_recording_book := CHOOSE(uReoNod, '', lnod.loan_book );
    SELF.original_recording_page := CHOOSE(uReoNod, '', lnod.loan_page );
    SELF.parcel_number_parcel_id := CHOOSE(uReoNod, STD.Str.CleanSpaces(lreo.APN), STD.Str.CleanSpaces(lnod.APN)); //extra spaces in APN causing duplication issue
    SELF.property_indicator := CHOOSE(uReoNod, lreo.property_use_cd, '' );
    SELF.property_desc := CHOOSE(uReoNod, lreo.property_desc, '' );
    SELF.use_code := CHOOSE(uReoNod, lreo.asses_land_use, '' );	
    SELF.use_desc := CHOOSE(uReoNod, lreo.use_desc, '' );
    SELF.section := CHOOSE(uReoNod, lreo.legal_section, '' );
    SELF.township := CHOOSE(uReoNod, lreo.Legal_Township, '' );
    SELF.lot_orig := CHOOSE(uReoNod, lreo.legal_lot_num, lnod.Legal_Lot_Num );
    SELF.block := CHOOSE(uReoNod, lreo.legal_block, lnod.legal_block );
    SELF.tract_subdivision_name := CHOOSE(uReoNod,lreo.legal_subdivision ,lnod.legal_subdivision_name );
    SELF.unit_nbr := CHOOSE(uReoNod, lreo.legal_unit, '' );
    SELF.expanded_legal := CHOOSE(uReoNod, lreo.legal_brief_desc, lnod.legal_brief_desc );
    SELF.name1_prefix := CHOOSE(uReoNod, lreo.name1_prefix , lnod.name1_prefix );
    SELF.name1_first := CHOOSE(uReoNod, lreo.name1_first, lnod.name1_first );
    SELF.name1_middle := CHOOSE(uReoNod, lreo.name1_middle, lnod.name1_middle );
    SELF.name1_last := CHOOSE(uReoNod, lreo.name1_last, lnod.name1_last );
    SELF.name1_suffix := CHOOSE(uReoNod, lreo.name1_suffix, lnod.name1_suffix );
    SELF.name1_company := CHOOSE(uReoNod, lreo.name1_company, lnod.name1_company );
    SELF.name1_did_score := CHOOSE(uReoNod, lreo.name1_did_score, lnod.name1_did_score );
    SELF.name1_did := CHOOSE(uReoNod, lreo.name1_did, lnod.name1_did );
    SELF.name1_bdid_score := CHOOSE(uReoNod, lreo.name1_bdid_score, lnod.name1_bdid_score );
    SELF.name1_bdid := CHOOSE(uReoNod, lreo.name1_bdid, lnod.name1_bdid );
    SELF.name1_ssn := CHOOSE(uReoNod, lreo.name1_ssn, lnod.name1_ssn );
    SELF.name2_prefix := CHOOSE(uReoNod, lreo.name2_prefix, lnod.name2_prefix );
    SELF.name2_first := CHOOSE(uReoNod, lreo.name2_first, lnod.name2_first );
    SELF.name2_middle := CHOOSE(uReoNod, lreo.name2_middle, lnod.name2_middle );
    SELF.name2_last := CHOOSE(uReoNod, lreo.name2_last, lnod.name2_last );
    SELF.name2_suffix := CHOOSE(uReoNod, lreo.name2_suffix, lnod.name2_suffix );
    SELF.name2_company := CHOOSE(uReoNod, lreo.name2_company, lnod.name2_company );
    SELF.name2_did_score := CHOOSE(uReoNod, lreo.name2_did_score, lnod.name2_did_score );
    SELF.name2_did := CHOOSE(uReoNod, lreo.name2_did, lnod.name2_did );
    SELF.name2_bdid_score := CHOOSE(uReoNod, lreo.name2_bdid_score, lnod.name2_bdid_score );
    SELF.name2_bdid	:= CHOOSE(uReoNod, lreo.name2_bdid, lnod.name2_bdid );
    SELF.name2_ssn := CHOOSE(uReoNod, lreo.name2_ssn, lnod.name2_ssn );
    SELF.name3_prefix := CHOOSE(uReoNod, lreo.name3_prefix, lnod.name3_prefix );
    SELF.name3_first := CHOOSE(uReoNod, lreo.name3_first, lnod.name3_first );
    SELF.name3_middle := CHOOSE(uReoNod, lreo.name3_middle, lnod.name3_middle );
    SELF.name3_last := CHOOSE(uReoNod, lreo.name3_last, lnod.name3_last );
    SELF.name3_suffix := CHOOSE(uReoNod, lreo.name3_suffix, lnod.name3_suffix );
    SELF.name3_ssn := CHOOSE(uReoNod, lreo.name3_ssn, lnod.name3_ssn );
    SELF.name4_prefix := CHOOSE(uReoNod, lreo.name4_prefix, lnod.name4_prefix );
    SELF.name4_first := CHOOSE(uReoNod, lreo.name4_first, lnod.name4_first );
    SELF.name4_middle := CHOOSE(uReoNod, lreo.name4_middle, lnod.name4_middle );
    SELF.name4_last := CHOOSE(uReoNod, lreo.name4_last, lnod.name4_last );
    SELF.name4_suffix := CHOOSE(uReoNod, lreo.name4_suffix, lnod.name4_suffix );
    SELF.name4_ssn := CHOOSE(uReoNod, lreo.name4_ssn, lnod.name4_ssn );
    SELF.name5_prefix := CHOOSE(uReoNod, lreo.name5_prefix, lnod.name5_prefix );
    SELF.name5_first := CHOOSE(uReoNod, lreo.name5_first, lnod.name5_first );
    SELF.name5_middle := CHOOSE(uReoNod, lreo.name5_middle, lnod.name5_middle );
    SELF.name5_last := CHOOSE(uReoNod, lreo.name5_last, lnod.name5_last );
    SELF.name5_suffix := CHOOSE(uReoNod, lreo.name5_suffix, lnod.name5_suffix );
    SELF.name5_company := CHOOSE(uReoNod, lreo.name5_company, lnod.name5_company );
    SELF.name5_did := CHOOSE(uReoNod, lreo.name5_did, lnod.name5_did );
    SELF.name5_bdid := CHOOSE(uReoNod, lreo.name5_bdid, lnod.name5_bdid );
    SELF.name5_ssn := CHOOSE(uReoNod, lreo.name5_ssn, lnod.name5_ssn );
    SELF.name6_prefix := CHOOSE(uReoNod, lreo.name6_prefix, lnod.name6_prefix );
    SELF.name6_first := CHOOSE(uReoNod, lreo.name6_first, lnod.name6_first );
    SELF.name6_middle := CHOOSE(uReoNod, lreo.name6_middle, lnod.name6_middle );
    SELF.name6_last := CHOOSE(uReoNod, lreo.name6_last, lnod.name6_last );
    SELF.name6_suffix := CHOOSE(uReoNod, lreo.name6_suffix, lnod.name6_suffix );
    SELF.name6_company := CHOOSE(uReoNod, lreo.name6_company, lnod.name6_company );
    SELF.name6_did := CHOOSE(uReoNod, lreo.name6_did, lnod.name6_did );
    SELF.name6_bdid := CHOOSE(uReoNod, lreo.name6_bdid, lnod.name6_bdid );
    SELF.name6_ssn := CHOOSE(uReoNod, lreo.name6_ssn, lnod.name6_ssn );
    SELF.name7_prefix := CHOOSE(uReoNod, lreo.name7_prefix, '' );
    SELF.name7_first := CHOOSE(uReoNod, lreo.name7_first, '' );
    SELF.name7_middle := CHOOSE(uReoNod, lreo.name7_middle, '' );
    SELF.name7_last := CHOOSE(uReoNod, lreo.name7_last, '' );
    SELF.name7_suffix := CHOOSE(uReoNod, lreo.name7_suffix, '' );
    SELF.name7_ssn := CHOOSE(uReoNod, lreo.name7_ssn, lnod.name7_ssn );
    SELF.name8_prefix := CHOOSE(uReoNod, lreo.name8_prefix, '' );
    SELF.name8_first := CHOOSE(uReoNod, lreo.name8_first, '' );
    SELF.name8_middle := CHOOSE(uReoNod, lreo.name8_middle, '' );
    SELF.name8_last := CHOOSE(uReoNod, lreo.name8_last, '' );
    SELF.name8_suffix := CHOOSE(uReoNod, lreo.name8_suffix, '' );
    SELF.name8_ssn := CHOOSE(uReoNod, lreo.name8_ssn, lnod.name8_ssn );
    SELF.situs1_RawAID := CHOOSE(uReoNod, lreo.situs1_RawAID, lnod.situs1_RawAID );
    SELF.situs1_prim_range := CHOOSE(uReoNod, lreo.situs1_prim_range, lnod.situs1_prim_range );	
    SELF.situs1_predir := CHOOSE(uReoNod, lreo.situs1_predir, lnod.situs1_predir );	
    SELF.situs1_prim_name := CHOOSE(uReoNod, lreo.situs1_prim_name, lnod.situs1_prim_name );	
    SELF.situs1_addr_suffix := CHOOSE(uReoNod, lreo.situs1_addr_suffix, lnod.situs1_addr_suffix );	
    SELF.situs1_postdir := CHOOSE(uReoNod, lreo.situs1_postdir, lnod.situs1_postdir );	
    SELF.situs1_unit_desig := CHOOSE(uReoNod, lreo.situs1_unit_desig, lnod.situs1_unit_desig );	
    SELF.situs1_sec_range := CHOOSE(uReoNod, lreo.situs1_sec_range, lnod.situs1_sec_range );	
    SELF.situs1_p_city_name := CHOOSE(uReoNod, lreo.situs1_p_city_name, lnod.situs1_p_city_name );	
    SELF.situs1_v_city_name := CHOOSE(uReoNod, lreo.situs1_v_city_name, lnod.situs1_v_city_name );	
    SELF.situs1_st := CHOOSE(uReoNod, lreo.situs1_st, lnod.situs1_st );	
    SELF.situs1_zip := CHOOSE(uReoNod, lreo.situs1_zip, lnod.situs1_zip );	
    SELF.situs1_zip4 := CHOOSE(uReoNod, lreo.situs1_zip4, lnod.situs1_zip4 );	
    SELF.situs1_cart := CHOOSE(uReoNod, lreo.situs1_cart, lnod.situs1_cart );	
    SELF.situs1_cr_sort_sz := CHOOSE(uReoNod, lreo.situs1_cr_sort_sz, lnod.situs1_cr_sort_sz );	
    SELF.situs1_lot := CHOOSE(uReoNod, lreo.situs1_lot, lnod.situs1_lot );	
    SELF.situs1_lot_order := CHOOSE(uReoNod, lreo.situs1_lot_order, lnod.situs1_lot_order );	
    SELF.situs1_dpbc := CHOOSE(uReoNod, lreo.situs1_dpbc, lnod.situs1_dpbc );	
    SELF.situs1_chk_digit := CHOOSE(uReoNod, lreo.situs1_chk_digit, lnod.situs1_chk_digit );	
    SELF.situs1_record_type := CHOOSE(uReoNod, lreo.situs1_record_type, lnod.situs1_record_type );	
    SELF.situs1_ace_fips_st := CHOOSE(uReoNod, lreo.situs1_ace_fips_st, lnod.situs1_ace_fips_st );	
    SELF.situs1_fipscounty := CHOOSE(uReoNod, lreo.situs1_fipscounty, lnod.situs1_fipscounty );	
    SELF.situs1_geo_lat := CHOOSE(uReoNod, lreo.situs1_geo_lat, lnod.situs1_geo_lat );	
    SELF.situs1_geo_long := CHOOSE(uReoNod, lreo.situs1_geo_long, lnod.situs1_geo_long );	
    SELF.situs1_msa := CHOOSE(uReoNod, lreo.situs1_msa, lnod.situs1_msa );	
    SELF.situs1_geo_blk := CHOOSE(uReoNod, lreo.situs1_geo_blk, lnod.situs1_geo_blk );	
    SELF.situs1_geo_match := CHOOSE(uReoNod, lreo.situs1_geo_match, lnod.situs1_geo_match );	
    SELF.situs1_err_stat := CHOOSE(uReoNod, lreo.situs1_err_stat, lnod.situs1_err_stat );
		SELF.source_rec_id	 := CHOOSE(uReoNod, lreo.record_id, lnod.record_id );
    SELF.Lender_type := CHOOSE(uReoNod, lreo.concurrent_lender_type, '' );
    SELF.lender_type_desc := CHOOSE(uReoNod, lreo.lender_type_desc, '' );
    SELF.loan_amount := CHOOSE(uReoNod, lreo.concurrent_loan_amt, '' );
    SELF.loan_type := CHOOSE(uReoNod, lreo.concurrent_loan_type, '' );
    SELF.loan_type_desc := CHOOSE(uReoNod, lreo.loan_type_desc, '' );
    SELF.source := CHOOSE(uReoNod, lreo.src, lnod.src );
		SELF.process_date := CHOOSE(uReoNod, lreo.process_date, lnod.process_date );
    SELF := lreo;
    SELF := lnod;
    SELF := []

  END;
  
  dReoBaseForeclosure := PROJECT(dReoBaseFile,tMapForeclosure(LEFT,dEmptyNod,1));
  dNodBaseForeclosure := PROJECT(dNodBaseFile,tMapForeclosure(dEmptyReo,LEFT,2));
  dBKasCLForeclosure := dReoBaseForeclosure+dNodBaseForeclosure : PERSIST('~thor_data400::base::BKForeclosure::foreclosure_basev2');
	
  RETURN dBKasCLForeclosure;

END;