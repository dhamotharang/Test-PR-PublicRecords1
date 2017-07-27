import LN_PropertyV2, text_search, Codes, ut;


export Convert_Assess_Func := function
	ds_main := distribute(LN_PropertyV2.File_Assessment,hash(ln_fares_id));
	ds_addl := distribute(LN_PropertyV2.File_addl_Fares_tax,hash(ln_fares_id));
	ds_leg := distribute(LN_PropertyV2.File_addl_legal,hash(ln_fares_id));
	
	ds_addl_rec := record
		LN_PropertyV2.layout_addl_fares_tax;
		typeof(ds_main.vendor_source_flag) vendor_source_flag;
	end;

	ds_addl_rec join_addl_recs(ds_main l,ds_addl r) := transform
		self.vendor_source_flag := l.vendor_source_flag;
		self := r;
	end;
	
	ds_addl_out := join(ds_main,ds_addl,
							left.ln_fares_id = right.ln_fares_id,
							join_addl_recs(left,right),
							local);

	ds_leg_rec := record
		LN_PropertyV2.layout_addl_legal;
		typeof(ds_main.vendor_source_flag) vendor_source_flag;
	end;

	ds_leg_rec join_leg_recs(ds_main l,ds_leg r) := transform
		self.vendor_source_flag := l.vendor_source_flag;
		self := r;
	end;
	
	ds_leg_out := join(ds_main,ds_leg,
							left.ln_fares_id = right.ln_fares_id,
							join_leg_recs(left,right),
							local);


	// Convert all codes to descriptions
	
	myrec := record
		ds_main;
		string50 legal_lot_desc := '';
		string50 ownership_type_desc := '';
		string50 standardized_land_use_desc := '';
		string50 mortgage_loan_type_desc := '';
		string50 mortgage_lender_type_desc := '';
		string50 tax_exemption1_desc := '';
		string50 tax_exemption2_desc := '';
		string50 tax_exemption3_desc := '';
		string50 tax_exemption4_desc := '';
		string50 neighborhood_desc := '';
	end;
	
	ut.Mac_Convert_Codes_To_Desc(ds_main,myrec,legal_lot_ds,'FARES_2580',
																					'LEGAL_LOT_CODE',legal_lot_desc,
																					legal_lot_code);
	ut.Mac_Convert_Codes_To_Desc(legal_lot_ds,myrec,owner_ds,'FARES_2580',
																					'OWNERSHIP_TYPE_CODE',ownership_type_desc,
																					ownership_type_code);
	ut.Mac_Convert_Codes_To_Desc(owner_ds,myrec,stand_ds,'FARES_2580',
																					'STANDARDIZED_LAND_USE_CODE',standardized_land_use_desc,
																					standardized_land_use_code);
	ut.Mac_Convert_Codes_To_Desc(stand_ds,myrec,ml_ds,'FARES_2580',
																					'MORTGAGE_LOAN_TYPE_CODE',mortgage_loan_type_desc,
																					mortgage_loan_type_code);
	ut.Mac_Convert_Codes_To_Desc(ml_ds,myrec,mlen_ds,'FARES_2580',
																					'MORTGAGE_LENDER_TYPE_CODE',mortgage_lender_type_desc,
																					mortgage_lender_type_code);
	ut.Mac_Convert_Codes_To_Desc(mlen_ds,myrec,t1_ds,'FARES_2580',
																					'TAX_EXEMPTION1_CODE',tax_exemption1_desc,
																					tax_exemption1_code);
	ut.Mac_Convert_Codes_To_Desc(t1_ds,myrec,t2_ds,'FARES_2580',
																					'TAX_EXEMPTION2_CODE',tax_exemption2_desc,
																					tax_exemption2_code);
	ut.Mac_Convert_Codes_To_Desc(t2_ds,myrec,t3_ds,'FARES_2580',
																					'TAX_EXEMPTION3_CODE',tax_exemption3_desc,
																					tax_exemption3_code);
	ut.Mac_Convert_Codes_To_Desc(t3_ds,myrec,t4_ds,'FARES_2580',
																					'TAX_EXEMPTION4_CODE',tax_exemption4_desc,
																					tax_exemption4_code);
	ut.Mac_Convert_Codes_To_Desc(t4_ds,myrec,n_ds,'FARES_2580',
																					'NEIGHBORHOOD_CODE',neighborhood_desc,
																					neighborhood_code);

	// -------- Code conversion complete -------------------
	
	Layout_Assess_Record := record(Text_search.Layout_Document)
		string12 ln_fares_id;
	end;
	
	Layout_Assess_Record proj_rec_1(n_ds l) := transform
		self.ln_fares_id := l.ln_fares_id;
		self.docref.src := (unsigned2)l.vendor_source_flag;
		self.docref.doc := 0;
		self.segs := dataset([
								{1,0,l.state_code},
								{2,0,l.county_name},
								{3,0,l.apna_or_pin_number},
								{4,0,l.certification_date},
								{5,0,l.assessee_name + ';' + l.second_assessee_name + ';' + l.contract_owner
											/*+ ';' + l.fares_non_parsed_assessee_name + ';' + l.fares_non_parsed_second_assessee_name*/},
								{6,0,l.assessee_phone_number},
								{7,0,l.mailing_full_street_address + ' ' + l.mailing_unit_number + ' ' +
											l.mailing_city_state_zip},
								{8,0,';' + l.property_full_street_address + ' ' + l.property_unit_number + ' ' +
											l.property_city_state_zip},
								{9,0,if (l.legal_lot_desc <> '','LOT DESC:' + l.legal_lot_desc,'')},
							{10,0,if (l.legal_lot_number <> '','; LOT NUMBER:' + l.legal_lot_number,'')},
		{11,0,if (l.legal_land_lot <> '','; LAND LOT:' + l.legal_land_lot,'')},
		{12,0,if (l.legal_block <> '','; BLOCK:' + l.legal_block,'')},
		{13,0,if (l.legal_section <> '','; SECTION:' + l.legal_section,'')},
		{14,0,if (l.legal_district <> '','; DISTRICT:' + l.legal_district,'')},
		{15,0,if (l.legal_unit <> '','; UNIT:' + l.legal_unit,'')},
		{16,0,if (l.legal_subdivision_name <> '','; SUBDIVISION:' + l.legal_subdivision_name,'')},
		{17,0,if (l.legal_phase_number <> '','; PHASE:' + l.legal_phase_number,'')},
		{18,0,if (l.legal_tract_number <> '','; TRACT:' + l.legal_tract_number,'')},
		{19,0,l.legal_brief_description /*+ ';' + l.addl_legal*/},
								{20,0,l.ownership_type_desc},
								{21,0,l.standardized_land_use_desc /*+ ';' + l.fares_land_use*/},
								{22,0,l.zoning},
								{23,0,l.owner_occupied},
								{24,0,l.recorder_document_number},
								{25,0,l.recorder_book_number + '/' + l.recorder_page_number},
								{26,0,l.transfer_date},
								{27,0,l.recording_date},
								{28,0,l.document_type},
								{29,0,';' + l.sale_date},
								{30,0,l.sales_price + ';' + l.prior_sales_price},
								{31,0,l.mortgage_loan_amount},
								{32,0,l.mortgage_loan_type_desc},
								{33,0,l.mortgage_lender_name},
								{34,0,l.mortgage_lender_type_desc},
								{35,0,l.assessed_land_value /*+ ';' + l.fares_calculated_land_value*/},
								{36,0,l.assessed_improvement_value},
								{37,0,l.assessed_total_value},
								{38,0,l.assessed_value_year},
								{39,0,l.market_land_value},
								{40,0,l.market_improvement_value /*+ ';' + l.fares_calculated_improvement_value*/},
								{41,0,l.market_total_value /*+ ';' + l.fares_calculated_total_value*/},
								{42,0,l.market_value_year},
								{43,0,'HOMESTEAD HOMEOWNER EXEMPTION:' + l.homestead_homeowner_exemption /*+ ';' + 
												'CALIFORNIA HOMEOWNER EXEMPTION:' + l.california_homeowner_exemption*/},
								{44,0,l.tax_exemption1_desc + ';' + l.tax_exemption2_desc + ';' +
											l.tax_exemption3_desc + ';' + l.tax_exemption4_desc},
								{45,0,l.tax_rate_code_area},
								{46,0,l.tax_amount},
								{47,0,l.tax_year},
								{48,0,'; YEAR BUILT:' + l.year_built},
								{49,0,'; EFFECTIVE YEAR BUILT:' + l.effective_year_built},
								//{50,0,'; NEIGHBORHOOD DESCRIPTION:' + l.neighbor_desc},
								{51,0,'; CONDO PROJECT NAME:' + l.condo_project_name},
								{52,0,'; BUILDING NAME:' + l.building_name}
								
		],text_search.Layout_Segment);
	end;
	
	proj_out_1 := project(n_ds,proj_rec_1(left));
	
	Layout_Assess_Record proj_rec_2(ds_addl_out l) := transform
		self.ln_fares_id := l.ln_fares_id;
		self.docref.src := (unsigned2)l.vendor_source_flag;
		self.docref.doc := 0;
		self.segs := dataset([
								{5,0,';' + l.fares_non_parsed_assessee_name + ';' + l.fares_non_parsed_second_assessee_name},
								{21,0,';' + l.fares_land_use},
								{35,0,';' + l.fares_calculated_land_value},
								{40,0,';' + l.fares_calculated_improvement_value},
								{41,0,';' + l.fares_calculated_total_value}
		],text_search.Layout_Segment);
	end;
	
	proj_out_2 := project(ds_addl_out,proj_rec_2(left));
	
	Layout_Assess_Record proj_rec_3(ds_leg_out l) := transform
		self.ln_fares_id := l.ln_fares_id;
		self.docref.src := (unsigned2)l.vendor_source_flag;
		self.docref.doc := 0;
		self.segs := dataset([
								{19,0,';' + l.addl_legal}
		],text_search.Layout_Segment);
	end;
	
	proj_out_3 := project(ds_leg_out,proj_rec_3(left));
	
	
	proj_out := proj_out_1 + proj_out_2 + proj_out_3;
	
	layout_Assess_flat := record(text_search.Layout_DocSeg)
		string12 ln_fares_id;
	end;
	
	layout_Assess_Flat flatten_assess(layout_Assess_record l, text_search.layout_segment r) := transform
		self.docref := l.docref;
		self.ln_fares_id := l.ln_fares_id;
		self := r;
	end;
	
	norm_full := normalize(proj_out,left.segs,flatten_assess(left,right));
	
	sort_full := sort(norm_full,ln_fares_id,segment,local);
	
	layout_assess_flat iterate_assess(layout_assess_flat l,layout_assess_flat r) := transform
		self.docref.doc := if(l.ln_fares_id = r.ln_fares_id,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.ln_fares_id <> r.ln_fares_id or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	itr_full := iterate(sort_full,iterate_assess(left,right),local);
	
	return itr_full(trim(content) <> '' and trim(content) <> ';');

end;