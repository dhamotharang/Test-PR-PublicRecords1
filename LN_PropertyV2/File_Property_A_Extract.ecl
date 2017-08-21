	/* construct an initial dataset from four different datasets and transfer it into a dataset with  Layout_Property_A_Extract
	*/
	import LN_PropertyV2, text_search, Codes, ut,LN_PropertyV2_Services;
	
	ds_asse := SORT(LN_PropertyV2.File_Assessment(ln_fares_id <>''),ln_fares_id);
	ds_tax := SORT(LN_PropertyV2.File_addl_Fares_tax(ln_fares_id <>''),ln_fares_id);
	ds_leg := SORT(LN_PropertyV2.File_addl_legal(ln_fares_id <>''),ln_fares_id);	
 	//Parsed, cleaned, enhanced data of interest
	ds_search := SORT(LN_PropertyV2.File_Property_ACleanName,ln_fares_id);
	
	main_rec := record
		ds_asse;
		string5 source_code;
		Layout_Property_A_Extract.legal_lot_desc;
		Layout_Property_A_Extract.ownership_type_desc;
		Layout_Property_A_Extract.standardized_land_use_desc;
		Layout_Property_A_Extract.mortgage_loan_type_desc;
		Layout_Property_A_Extract.mortgage_lender_type_desc;
		Layout_Property_A_Extract.tax_exemption1_desc;
		Layout_Property_A_Extract.tax_exemption2_desc;
		Layout_Property_A_Extract.tax_exemption3_desc;
		Layout_Property_A_Extract.tax_exemption4_desc;
		Layout_Property_A_Extract.neighborhood_desc;
		Layout_Property_A_Extract.document_type_desc;
		Layout_Property_A_Extract.sales_price_desc;
	end;
	
	main_rec proj_main(ds_asse l) := transform
		self.source_code := LN_PropertyV2_Services.fn_vendor_source(l.vendor_source_flag);		
		self := l;
		self := [];
	end;
	ds_main := project(ds_asse,proj_main(left));
	
  ut.Mac_Convert_Codes_To_Desc(ds_main,main_rec,legal_lot_ds,'FARES_2580',
																					'LEGAL_LOT_CODE',legal_lot_desc,
																					legal_lot_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(legal_lot_ds,main_rec,owner_ds,'FARES_2580',
																					'OWNERSHIP_TYPE_CODE',ownership_type_desc,
																					ownership_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(owner_ds,main_rec,stand_ds,'FARES_2580',
																					'LAND_USE',standardized_land_use_desc,
																					standardized_land_use_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(stand_ds,main_rec,ml_ds,'FARES_2580',
																					'MORTGAGE_LOAN_TYPE_CODE',mortgage_loan_type_desc,
																					mortgage_loan_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(ml_ds,main_rec,mlen_ds,'FARES_2580',
																					'MORTGAGE_LENDER_TYPE_CODE',mortgage_lender_type_desc,
																					mortgage_lender_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(mlen_ds,main_rec,t1_ds,'FARES_2580',
																					'TAX_EXEMPTION1_CODE',tax_exemption1_desc,
																					tax_exemption1_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t1_ds,main_rec,t2_ds,'FARES_2580',
																					'TAX_EXEMPTION2_CODE',tax_exemption2_desc,
																					tax_exemption2_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t2_ds,main_rec,t3_ds,'FARES_2580',
																					'TAX_EXEMPTION3_CODE',tax_exemption3_desc,
																					tax_exemption3_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t3_ds,main_rec,t4_ds,'FARES_2580',
																					'TAX_EXEMPTION4_CODE',tax_exemption4_desc,
																					tax_exemption4_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t4_ds,main_rec,t5_ds,'FARES_2580',
																					'NEIGHBORHOOD_CODE',neighborhood_desc,
																					neighborhood_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t5_ds,main_rec,t6_ds,'FARES_2580',
																					'DOCUMENT_TYPE_CODE',document_type_desc,
																					document_type,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t6_ds,main_rec,n_ds,'FARES_2580',
																					'SALE_CODE',sales_price_desc,
																					SALES_PRICE_CODE,source_code,true);
	ds_main_out := project(n_ds, transform(Layout_Property_A_Extract, self:=left, self:=[]));
	ds_tax_out := project(ds_tax, transform(Layout_Property_A_Extract, self:=left, self:=[]));
	ds_leg_out := project(ds_leg, transform(Layout_Property_A_Extract, self:=left, self:=[]));
	ds_search_out := PROJECT(ds_search, transform(Layout_Property_A_Extract, self.phone_num := left.phone_number, self:=left, self:=[]));
	
	//the whole dataset
	export File_Property_A_Extract  := MERGE(ds_main_out,ds_tax_out,ds_leg_out,ds_search_out,SORTED(ln_fares_id)):INDEPENDENT;
	
  