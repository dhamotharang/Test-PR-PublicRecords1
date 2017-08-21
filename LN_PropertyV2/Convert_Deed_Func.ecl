import ut,LN_Propertyv2,text_search,Codes,LN_PropertyV2_Services;

export Convert_Deed_Func := function

	ds_in := distribute(LN_Propertyv2.File_Deed,hash(ln_fares_id));
	fares_ds := distribute(LN_PropertyV2.File_addl_fares_deed,hash(ln_fares_id));
	
	main_rec := record
		ds_in;
		string5 source_code;
	end;
	
	main_rec proj_main(ds_in l) := transform
		self.source_code := LN_PropertyV2_Services.fn_vendor_source(l.vendor_source_flag);
		self := l;
	end;
	
	ds := project(ds_in,proj_main(left));
	
	ds_addl_rec := record
		LN_PropertyV2.layout_addl_fares_deed;
		typeof(ds.vendor_source_flag) vendor_source_flag;
	end;

	ds_addl_rec join_addl_recs(ds l,fares_ds r) := transform
		self.vendor_source_flag := l.vendor_source_flag;
		self := r;
	end;
	
	ds_addl_out := join(ds,fares_ds,
							left.ln_fares_id = right.ln_fares_id,
							join_addl_recs(left,right),
							local);
	
	myrec := record
		ds;
		string330 legal_lot_desc := '';
		string330 document_type_desc := '';
		string330 hawaii_condo_cpr_desc := '';
		string330 sales_price_desc := '';
		string330 assessment_match_land_use_desc := '';
		string330 property_use_desc := '';
		string330 condo_desc := '';
		string330 first_td_lender_type_desc := '';
		string330 second_td_lender_type_desc := '';
		string330 first_td_loan_type_desc := '';
		string330 record_type_desc := '';
		string330 type_financing_desc := '';
		
		string330 buyer_vesting_desc := '';
   string330 buyer_1_id_desc := '';
   string330 buyer_2_id_desc := '';
	 string330 borrower_vesting_desc := '';
   string330 borrower_1_id_desc := '';
   string330 borrower_2_id_desc := '';
	 string330 seller_1_id_desc := '';
   string330 seller_2_id_desc := '';

	end;

	// Convert Court Codes

	ut.Mac_Convert_Codes_To_Desc(ds,myrec,legal_lot_ds,'FARES_1080',
																					'LEGAL_LOT_CODE',legal_lot_desc,
																					legal_lot_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(legal_lot_ds,myrec,owner_ds,'FARES_1080',
																					'DOCUMENT_TYPE',document_type_desc,
																					document_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(owner_ds,myrec,stand_ds,'FARES_1080',
																					'HAWAII_CONDO_CPR_CODE',hawaii_condo_cpr_desc,
																					HAWAII_CONDO_CPR_CODE,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(stand_ds,myrec,ml_ds,'FARES_1080',
																					'SALE_CODE',sales_price_desc,
																					SALES_PRICE_CODE,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(ml_ds,myrec,mlen_ds,'FARES_1080',
																					'LAND_USE',assessment_match_land_use_desc,
																					assessment_match_land_use_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(mlen_ds,myrec,t1_ds,'FARES_1080',
																					'PROPERTY_INDICATOR_CODE',property_use_desc,
																					property_use_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t1_ds,myrec,t2_ds,'FARES_1080',
																					'CONDO_CODE',condo_desc,
																					condo_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t2_ds,myrec,t3_ds,'FARES_1080',
																					'FIRST_TD_LENDER_TYPE_CODE',first_td_lender_type_desc,
																					first_td_lender_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t3_ds,myrec,t4_ds,'FARES_1080',
																					'FIRST_TD_LENDER_TYPE_CODE',second_td_lender_type_desc,
																					second_td_lender_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t4_ds,myrec,n1_ds,'FARES_1080',
																					'MORTGAGE_LOAN_TYPE_CODE',first_td_loan_type_desc,
																					first_td_loan_type_code,source_code,true);

	ut.Mac_Convert_Codes_To_Desc(n1_ds,myrec,n2_ds,'FARES_1080',
																					'RECORD_TYPE',record_type_desc,
																					RECORD_TYPE,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n2_ds,myrec,n3_ds,'FARES_1080',
																					'TYPE_FINANCING',type_financing_desc,
																					TYPE_FINANCING,source_code,true);
	// Bug # 36150
	ut.Mac_Convert_Codes_To_Desc(n3_ds,myrec,n4_ds,'FARES_1080',
																					'BUYER_VESTING_CODE',buyer_vesting_desc,
																					vesting_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n4_ds,myrec,n5_ds,'FARES_1080',
																					'BUYER1_ID_CODE',buyer_1_id_desc,
																					name1_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n5_ds,myrec,n6_ds,'FARES_1080',
																					'BUYER2_ID_CODE',buyer_2_id_desc,
																					name2_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n6_ds,myrec,n7_ds,'FARES_1080',
																					'BORROWER_VESTING_CODE',BORROWER_vesting_desc,
																					vesting_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n7_ds,myrec,n8_ds,'FARES_1080',
																					'BORROWER1_ID_CODE',BORROWER_1_id_desc,
																					name1_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n8_ds,myrec,n9_ds,'FARES_1080',
																					'BORROWER2_ID_CODE',BORROWER_2_id_desc,
																					name2_id_code,source_code,true);

	ut.Mac_Convert_Codes_To_Desc(n9_ds,myrec,n10_ds,'FARES_1080',
																					'SELLER1_ID_CODE',SELLER_1_id_desc,
																					seller1_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n10_ds,myrec,n_ds,'FARES_1080',
																					'SELLER2_ID_CODE',SELLER_2_id_desc,
																					seller2_id_code,source_code,true);
																				
																					
	// Begin Boolean Conversion
		
	
	Layout_Deed_Record := record(Text_Search.Layout_Document)
		string12 ln_fares_id;
	end;
	
	Layout_deed_record proj_rec(n_ds l) := transform
		self.ln_fares_id := l.ln_fares_id;
		self.docref.src := (unsigned2)l.vendor_source_flag;
		self.docref.doc := 0;
		self.segs := dataset([
		{1,0,l.state},
		{2,0,l.county_transfer_tax},
		{3,0,l.apnt_or_pin_number},
		{4,0,if (l.buyer_or_borrower_ind = 'O',l.name1 + ';' + l.name2,'')},
		{5,0,if (l.buyer_or_borrower_ind = 'B',';' + l.name1 + ';' + l.name2,'')},
		{6,0,';' + l.seller1 + ';' + l.seller2},
		{7,0,';' + l.lender_name + ';' + l.lender_dba_aka_name},
		{8,0,l.phone_number},
		{9,0,if (l.buyer_or_borrower_ind = 'O',l.mailing_street + ' ' + l.mailing_unit_number + ' ' + l.mailing_csz,'')},
		{10,0,if (l.buyer_or_borrower_ind = 'B',';' + l.mailing_street + ' ' + l.mailing_unit_number + ' ' + l.mailing_csz,'')},
		{11,0,';' + l.seller_mailing_full_street_address + ' ' + l.seller_mailing_address_unit_number + ' ' + l.seller_mailing_address_citystatezip},
		{12,0,';' + l.property_full_street_address + ' ' + l.property_address_unit_number + ' ' + l.property_address_citystatezip},
		{13,0,';' + l.lender_full_street_address + ' ' + l.lender_address_unit_number + ' ' + l.lender_address_citystatezip},
		{14,0,if (l.legal_lot_desc <> '','LOT DESC:' + l.legal_lot_desc,'')},
		{15,0,if (l.legal_lot_number <> '','; LOT NUMBER:' + l.legal_lot_number,'')},
		{18,0,if (l.legal_land_lot <> '','; LAND LOT:' + l.legal_land_lot,'')},
		{16,0,if (l.legal_block <> '','; BLOCK:' + l.legal_block,'')},
		{17,0,if (l.legal_section <> '','; SECTION:' + l.legal_section,'')},
		{35,0,if (l.legal_district <> '','; DISTRICT:' + l.legal_district,'')},
		{19,0,if (l.legal_unit <> '','; UNIT:' + l.legal_unit,'')},
		{20,0,if (l.legal_subdivision_name <> '','; SUBDIVISION:' + l.legal_subdivision_name,'')},
		{21,0,if (l.legal_phase_number <> '','; PHASE:' + l.legal_phase_number,'')},
		{22,0,if (l.legal_tract_number <> '','; TRACT:' + l.legal_tract_number + if (l.hawaii_tct <> '','; HAWAII TRACT:' + l.hawaii_tct,''),'')},
		{23,0,l.legal_brief_description},
		{24,0,l.contract_date},
		{25,0,l.recording_date},
		{26,0,l.document_number},
		{27,0,l.record_type_desc},
		{28,0,l.loan_number},
		{29,0,l.recorder_book_number + '/' + l.recorder_page_number},
		{30,0,l.condo_desc + ';' + l.hawaii_condo_cpr_desc},
		{31,0,l.hawaii_condo_name},
		{32,0,l.sales_price},
		{33,0,l.sales_price_desc},
		{34,0,l.city_transfer_tax},
		//{55,0,l.county_transfer_tax},
		{36,0,l.total_transfer_tax},
		{37,0,l.excise_tax_number},
		{38,0,l.assessment_match_land_use_desc},
		{39,0,l.property_use_desc},
		{40,0,l.timeshare_flag},
		{41,0,l.rate_change_frequency},
		{42,0,l.change_index},
		{43,0,l.adjustable_rate_index},
		{44,0,if(l.adjustable_rate_rider <> '','ADJUSTABLE_RATE_RIDER:'+l.adjustable_rate_rider,'') + if(l.graduated_payment_rider <> '','GRADUATED_PAYMENT_RIDER:'+l.graduated_payment_rider,'')
					+ if(l.balloon_rider <> '','BALLOON_RIDER:'+l.balloon_rider,'') + if(l.fixed_step_rate_rider <> '','FIRST_STEP_RATE_RIDER:'+l.fixed_step_rate_rider,'') 
					+ if(l.condominium_rider <> '','CONDOMINIUM_RIDER:'+l.condominium_rider,'') + if(l.planned_unit_development_rider <> '','PLANNED_UNIT_DEVELOPMENT_RIDER:'+l.planned_unit_development_rider,'')
					+ if(l.rate_improvement_rider <> '','RATE_IMPROVEMENT_RIDER:'+l.rate_improvement_rider,'') + if(l.assumability_rider <> '','ASSUMABILITY_RIDER:'+l.assumability_rider,'') 
					+ if(l.prepayment_rider <> '','PREPAYMENT_RIDER:'+l.prepayment_rider,'') + if(l.one_four_family_rider <> '','1-4_FAMILY_RIDER:'+l.one_four_family_rider,'') 
					+ if(l.biweekly_payment_rider <> '','BIWEEKLY_PAYMENT_RIDER:'+l.biweekly_payment_rider,'') + if(l.second_home_rider <> '','SECOND_HOME_RIDER:'+l.second_home_rider,'')},
		{45,0,l.first_td_loan_amount},
		{46,0,l.second_td_loan_amount},
		{47,0,l.first_td_lender_type_desc + ';' + l.second_td_lender_type_desc},
		{48,0,';' + l.first_td_loan_type_desc},
		{49,0,';' + l.type_financing_desc},
		{50,0,l.first_td_interest_rate},
		{51,0,l.first_td_due_date},
		{52,0,l.title_company_name},
		{53,0,l.partial_interest_transferred},
		{54,0,if(l.loan_term_months <> '','MONTHS:' + l.loan_term_months + ' ' + if ( l.loan_term_years <> '','YEARS:' + l.loan_term_years,''),'')},
		{65,0,l.document_type_desc},
		{90,0,l.county_name},
		//{91,0,l.census_tract},
								{92,0,l.legal_city_municipality_township},
								{93,0,l.legal_sec_twn_rng_mer},
								{249,0,l.process_date}
	
		],text_search.Layout_Segment);
	end;
	
	proj_out_1 := project(n_ds,proj_rec(left));
	
	// Bug # 32855
	
	addlrec := record
		ds_addl_out;
		string330 mortgage_deed_type_desc := '';
	end;
	
	// explode mortgage deed type 
	
	ut.Mac_Convert_Codes_To_Desc(ds_addl_out,addlrec,addl_ds,'FARES_1080',
																	'MORTGAGE_DEED_TYPE',mortgage_deed_type_desc,
																		fares_mortgage_deed_type,vendor_source_flag,true);

		
	Layout_Deed_Record proj_rec_2(addl_ds l) := transform
		self.ln_fares_id := l.ln_fares_id;
		self.docref.src := (unsigned2)l.vendor_source_flag;
		self.docref.doc := 0;
		self.segs := dataset([
								{56,0,l.fares_mortgage_date},
								{65,0,';' + l.mortgage_deed_type_desc},
								{57,0,l.fares_mortgage_term}
			],text_search.Layout_Segment);
	end;
	
	proj_out_2 := project(addl_ds,proj_rec_2(left));
	
	proj_out := proj_out_1 + proj_out_2;
	
	layout_deed_flat := record(text_search.Layout_DocSeg)
		string12 ln_fares_id;
	end;
	
	layout_deed_Flat flatten_deed(layout_deed_record l, text_search.layout_segment r) := transform
		self.docref := l.docref;
		self.ln_fares_id := l.ln_fares_id;
		self := r;
	end;
	
	norm_full := normalize(proj_out,left.segs,flatten_deed(left,right));
	
	sort_full := sort(norm_full,ln_fares_id,segment,local);
	
	layout_deed_flat iterate_deed(layout_deed_flat l,layout_deed_flat r) := transform
		self.docref.doc := if(l.ln_fares_id = r.ln_fares_id,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.ln_fares_id <> r.ln_fares_id or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	itr_full := iterate(sort_full,iterate_deed(left,right),local);
	
	// External key
	
	layout_deed_flat MakeKeySegs( itr_full l, unsigned2 segno ) := TRANSFORM
		self.ln_fares_id := l.ln_fares_id;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := l.ln_fares_id;
        self.sect := 1;
    END;

    segkeys := PROJECT(itr_full(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := itr_full(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;
	
	
	

end : DEPRECATED('Use Property_DMBooleanSearch instead.  DO NOT USE!');