/* construct an initial dataset from three different datasets and transfer it into a dataset with  Layout_Property_DM_Extract
*/
import LN_PropertyV2, text_search, Codes, ut,LN_PropertyV2_Services;

	EXPORT File_Property_DM_Extract(boolean isFast) := FUNCTION
	
	deed_mortg := if(isFast,LN_PropertyV2_Fast.Files.base.deed_mortg,LN_Propertyv2.File_Deed);
	addl_frs_d := if(isFast,LN_PropertyV2_Fast.Files.base.addl_frs_d,LN_PropertyV2.File_addl_fares_deed);
	

	ds_deed := SORT(deed_mortg(ln_fares_id <> ' '),ln_fares_id);
	ds_addl := SORT(addl_frs_d(ln_fares_id <> ' '),ln_fares_id);	
	ds_search := SORT(LN_PropertyV2_Fast.File_Property_DMCleanName(isFast)(ln_fares_id <> ' '),ln_fares_id);
			
	main_rec := record(LN_PropertyV2.layout_deed_mortgage_common_model_base)
		string5 source_code;
		LN_PropertyV2.Layout_Property_DM_Extract.legal_lot_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.document_type_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.hawaii_condo_cpr_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.sales_price_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.assessment_match_land_use_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.property_use_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.condo_desc_in;
		LN_PropertyV2.Layout_Property_DM_Extract.first_td_lender_type_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.second_td_lender_type_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.first_td_loan_type_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.record_type_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.type_financing_desc;		
		LN_PropertyV2.Layout_Property_DM_Extract.buyer_vesting_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.buyer_1_id_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.buyer_2_id_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.borrower_vesting_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.borrower_1_id_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.borrower_2_id_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.seller_1_id_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.seller_2_id_desc;
	end;
		
	main_rec proj_main(ds_deed l) := transform
		self.source_code := LN_PropertyV2_Services.fn_vendor_source(l.vendor_source_flag);
		self := l;
		self := [];
	end;
	ds_main := project(ds_deed,proj_main(left));
	
  ut.Mac_Convert_Codes_To_Desc(ds_main,main_rec,legal_lot_ds,'FARES_1080',
																					'LEGAL_LOT_CODE',legal_lot_desc,
																					legal_lot_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(legal_lot_ds,main_rec,owner_ds,'FARES_1080',
																					'DOCUMENT_TYPE',document_type_desc,
																					document_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(owner_ds,main_rec,stand_ds,'FARES_1080',
																					'HAWAII_CONDO_CPR_CODE',hawaii_condo_cpr_desc,
																					HAWAII_CONDO_CPR_CODE,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(stand_ds,main_rec,ml_ds,'FARES_1080',
																					'SALE_CODE',sales_price_desc,
																					SALES_PRICE_CODE,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(ml_ds,main_rec,mlen_ds,'FARES_1080',
																					'LAND_USE',assessment_match_land_use_desc,
																					assessment_match_land_use_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(mlen_ds,main_rec,t1_ds,'FARES_1080',
																					'PROPERTY_INDICATOR_CODE',property_use_desc,
																					property_use_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t1_ds,main_rec,t2_ds,'FARES_1080',
																					'CONDO_CODE',condo_desc_in,
																					condo_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t2_ds,main_rec,t3_ds,'FARES_1080',
																					'FIRST_TD_LENDER_TYPE_CODE',first_td_lender_type_desc,
																					first_td_lender_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t3_ds,main_rec,t4_ds,'FARES_1080',
																					'FIRST_TD_LENDER_TYPE_CODE',second_td_lender_type_desc,
																					second_td_lender_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(t4_ds,main_rec,n1_ds,'FARES_1080',
																					'MORTGAGE_LOAN_TYPE_CODE',first_td_loan_type_desc,
																					first_td_loan_type_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n1_ds,main_rec,n2_ds,'FARES_1080',
																					'RECORD_TYPE',record_type_desc,
																					RECORD_TYPE,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n2_ds,main_rec,n3_ds,'FARES_1080',
																					'TYPE_FINANCING',type_financing_desc,
																					TYPE_FINANCING,source_code,true);
	// Bug # 36150
	ut.Mac_Convert_Codes_To_Desc(n3_ds,main_rec,n4_ds,'FARES_1080',
																					'BUYER_VESTING_CODE',buyer_vesting_desc,
																					vesting_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n4_ds,main_rec,n5_ds,'FARES_1080',
																					'BUYER1_ID_CODE',buyer_1_id_desc,
																					name1_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n5_ds,main_rec,n6_ds,'FARES_1080',
																					'BUYER2_ID_CODE',buyer_2_id_desc,
																					name2_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n6_ds,main_rec,n7_ds,'FARES_1080',
																					'BORROWER_VESTING_CODE',BORROWER_vesting_desc,
																					vesting_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n7_ds,main_rec,n8_ds,'FARES_1080',
																					'BORROWER1_ID_CODE',BORROWER_1_id_desc,
																					name1_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n8_ds,main_rec,n9_ds,'FARES_1080',
																					'BORROWER2_ID_CODE',BORROWER_2_id_desc,
																					name2_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n9_ds,main_rec,n10_ds,'FARES_1080',
																					'SELLER1_ID_CODE',SELLER_1_id_desc,
																					seller1_id_code,source_code,true);
	ut.Mac_Convert_Codes_To_Desc(n10_ds,main_rec,n_ds,'FARES_1080',
																					'SELLER2_ID_CODE',SELLER_2_id_desc,
																					seller2_id_code,source_code,true);
																				


	ds_addl_rec := record
		LN_PropertyV2.layout_addl_fares_deed;
		typeof(ds_main.vendor_source_flag) vendor_source_flag;
		LN_PropertyV2.Layout_Property_DM_Extract.mortgage_deed_type_desc;
		LN_PropertyV2.Layout_Property_DM_Extract.fares_transaction_type_desc;
		STRING5 lookup_tbl_source;
	end;
	
	ds_addl_rec join_addl_recs(ds_main l,ds_addl r) := transform
		self.vendor_source_flag := l.vendor_source_flag;
		self.lookup_tbl_source := LN_PropertyV2_Services.fn_vendor_source(l.vendor_source_flag);
		self := r;
		self := [];
	end;
	
	ds_addl_flag := join(ds_main,ds_addl,
							left.ln_fares_id = right.ln_fares_id,
							join_addl_recs(left,right),
							NOSORT);
  
	// Ensure that ds_addl_flag is still sorted on ln_fares_id, fail if not.
	ds_addl_rec check_sort(ds_addl_rec prev, ds_addl_rec curr) := TRANSFORM
			ASSERT (prev.ln_fares_id <= curr.ln_fares_id,'Recs not sorted on ln_fares_id, prev:'+prev.ln_fares_id+': curr:'+curr.ln_fares_id,FAIL);
			SELF := curr;
	END;
	ds_addl_flag_checked := ITERATE(ds_addl_flag,check_sort(left,right),local);
	
	// explode mortgage deed type 	
	ut.Mac_Convert_Codes_To_Desc(ds_addl_flag_checked,ds_addl_rec,deed_type_ds,'FARES_1080',
																	'MORTGAGE_DEED_TYPE',mortgage_deed_type_desc,
																		fares_mortgage_deed_type,lookup_tbl_source,true);
																		
	// explode fares transaction type 	
	ut.Mac_Convert_Codes_To_Desc(deed_type_ds,ds_addl_rec,trans_type_ds,'FARES_1080',
																	'TRANSACTION_TYPE',fares_transaction_type_desc,
																		fares_transaction_type,lookup_tbl_source,true);
	
  ds_main_out := project(n_ds, transform(LN_PropertyV2.Layout_Property_DM_Extract, self:=left, self:=[]));
	ds_addl_out := project(trans_type_ds, transform(LN_PropertyV2.Layout_Property_DM_Extract, self:=left, self:=[]));
	ds_search_out := project(ds_search, transform(LN_PropertyV2.Layout_Property_DM_Extract, self:=left, self:=[]));

	ret := MERGE(ds_main_out,ds_addl_out,ds_search_out,SORTED(ln_fares_id)):INDEPENDENT;
	RETURN ret;
END;