import Codes, LN_PropertyV2;

k_codes			:= keys.codes;

l_raw				:= layouts.deeds.raw_source;
l_fid				:= layouts.fid;
l_tmp				:= layouts.deeds.result.tmp;
l_rolled		:= layouts.deeds.result.rolled_tmp;

max_deeds		:= consts.max_deeds;
code_file		:= consts.deeds_codefile;

// Abstract Codes.KeyCodes calls to simplify somewhat...
varstring GetCode(
	string field_name_value, 
	string field_name2_value = '',
	string code_value
) := function
	return Codes.KeyCodes(code_file, field_name_value, field_name2_value, code_value, true);
end;


export dataset(l_rolled) fn_get_deeds(
  dataset(l_raw) ds_raw
) := function
	
	// add computed fields
	l_tmp addValue(ds_raw L) := transform
	
		// Date -------------------------------------------
		self.sortby_date := Raw.deed_recency(L);
		
		// Penalty ----------------------------------------
		self.penalt := 0;
		self.cPenalt := 0;
		// We only need a placeholder since searchable data is all in the parties section
		
		// Type ----------------------------------------
		ft := LN_PropertyV2.fn_fid_type(L.ln_fares_id);
		self.fid_type				:= ft;
		self.fid_type_desc	:= fn_fid_type_desc(ft);
		
		// Vendor
		vsource := fn_vendor_source(L.vendor_source_flag);
		self.vendor_source_desc := vsource;
		self.vendor_source_flag := fn_vendor_source_obscure(L.vendor_source_flag);
		
		// Buyer/Borrower -----------------------------------
		bb := L.buyer_or_borrower_ind;
		
		buyer1_id										:= if(bb='O', L.name1_id_code,				'');
		buyer2_id										:= if(bb='O', L.name2_id_code,				'');
		buyer_vesting								:= if(bb='O', L.vesting_code,					'');
		buyer_addendum							:= if(bb='O', L.addendum_flag,				'');
		borrower1_id								:= if(bb='B', L.name1_id_code,				'');
		borrower2_id								:= if(bb='B', L.name2_id_code,				'');
		borrower_vesting						:= if(bb='B', L.vesting_code,					'');
		
		self.buyer1_id_code					:= buyer1_id;
		self.buyer2_id_code					:= buyer2_id;
		self.buyer_vesting_code			:= buyer_vesting;
		self.buyer_addendum_flag		:= buyer_addendum;
		self.borrower1_id_code			:= borrower1_id;
		self.borrower2_id_code			:= borrower2_id;
		self.borrower_vesting_code	:= borrower_vesting;
		
		// Lookup Codes -----------------------------------
		
		self.document_type_desc := GetCode(
			'DOCUMENT_TYPE', vsource, L.document_type_code);
		self.legal_lot_desc := GetCode(
			'LEGAL_LOT_CODE', vsource, L.legal_lot_code);
		
		/* NOTE: These two do not exist in CodesV3 - omission here is not an oversight.
		self.complete_legal_description_desc := GetCode(
			'COMPLETE_LEGAL_DESCRIPTION_CODE', vsource, L.complete_legal_description_code);
		self.hawaii_condo_cpr_desc := GetCode(
			'HAWAII_CONDO_CPR_CODE', vsource, L.hawaii_condo_cpr_code); */
		
		self.sales_price_desc := GetCode(
			'SALE_CODE', vsource, L.sales_price_code);
		self.property_use_desc := GetCode(
			'PROPERTY_INDICATOR_CODE', vsource, L.property_use_code);
		self.assessment_match_land_use_desc := Codes.KeyCodes(consts.assess_codefile,
			'LAND_USE', vsource, L.assessment_match_land_use_code, true);
  	self.condo_desc := GetCode(
			'CONDO_CODE', vsource, L.condo_code);
		self.first_td_loan_type_desc := GetCode(
			'MORTGAGE_LOAN_TYPE_CODE', vsource, L.first_td_loan_type_code);
		self.first_td_lender_type_desc := GetCode(
			'FIRST_TD_LENDER_TYPE_CODE', vsource, L.first_td_lender_type_code);
		self.second_td_lender_type_desc := GetCode(
			'FIRST_TD_LENDER_TYPE_CODE', vsource, L.second_td_lender_type_code); // NOTE: 'FIRST' is not a typo
		self.buyer1_id_desc := GetCode(
			'BUYER1_ID_CODE', vsource, buyer1_id);
		self.buyer2_id_desc := GetCode(
			'BUYER2_ID_CODE', vsource, buyer2_id);
		self.buyer_vesting_desc := GetCode(
			'BUYER_VESTING_CODE', vsource, buyer_vesting);
			
		self.borrower1_id_desc := GetCode(
			'BORROWER1_ID_CODE', vsource, borrower1_id);
		self.borrower2_id_desc := GetCode(
			'BORROWER2_ID_CODE', vsource, borrower2_id);
		self.borrower_vesting_desc := GetCode(
			'BORROWER_VESTING_CODE', vsource, borrower_vesting);
			
		self.seller1_id_desc := GetCode(
			'SELLER1_ID_CODE', vsource, L.seller1_id_code);
		self.seller2_id_desc := GetCode(
			'SELLER2_ID_CODE', vsource, L.seller2_id_code);
/* The record_type of M and Z have been used for 2 different purposes in the deed file. We need to diffrentiate to find out which M or Z lable we need to use.
   Only assignments and releases have document_type_code populated while the other deed records with record_type of M and Z deed types do not have document_type_code populated.  
*/      
		modified_record_type := 
     map(
          trim(vsource) = 'OKCTY' and trim(L.record_type) = 'M' and trim(L.document_type_code) <> '' => 'M-A',
          trim(vsource) = 'OKCTY' and trim(L.record_type) = 'Z' and trim(L.document_type_code) <> '' => 'Z-A',
          L.record_type
         );	
                               
		self.record_type_desc := GetCode('RECORD_TYPE', vsource, modified_record_type);   
		self.property_address_desc := Codes.KeyCodes(consts.assess_codefile,
			'PROPERTY_ADDRESS_CODE', vsource, L.property_address_code, true);
		
		self.type_financing_desc := GetCode(
			'TYPE_FINANCING', vsource, L.type_financing);
		self.rate_change_frequency_desc := GetCode(
			'RATE_CHANGE_FREQUENCY', vsource, L.rate_change_frequency);
		self.adjustable_rate_index_desc := GetCode(
			'ADJUSTABLE_RATE_INDEX', vsource, L.adjustable_rate_index);
		self.fixed_step_rate_rider_desc := GetCode(
			'FIXED_STEP_RATE_RIDER', vsource, L.fixed_step_rate_rider);

		self.fares_transaction_type_desc := GetCode(
			'TRANSACTION_TYPE', vsource, L.fares_transaction_type);
		self.fares_mortgage_deed_type_desc := GetCode(
			'MORTGAGE_DEED_TYPE', vsource, L.fares_mortgage_deed_type);
		self.fares_mortgage_term_code_desc := GetCode(
			'MORTGAGE_TERM_CODE', vsource, L.fares_mortgage_term_code);
		self.fares_foreclosure_desc := GetCode(
			'FORECLOSURE', vsource, L.fares_foreclosure);
		self.fares_refi_flag_desc := GetCode(
			'REFI_FLAG', vsource, L.fares_refi_flag);
		self.fares_equity_flag_desc := GetCode(
			'EQUITY_FLAG', vsource, L.fares_equity_flag);		
		
		self.fares_prior_sales_desc := GetCode(
			'PRIOR_SALES_CODE', vsource, L.fares_prior_sales_code);
		
		self := L;
	end;
	ds_value := project(ds_raw, addValue(left));
	
	// sort & dedup
	ds_sort := dedup(
		sort(ds_value, ln_fares_id, search_did, record ),
		record
	);
	
	// rollup
	l_rolled xf_roll_deeds(l_tmp L, dataset(l_tmp) R) := transform
		self.deeds	:= choosen(R,max_deeds);
		self				:= L;
	end;
	ds_rolled := rollup(
		group( ds_sort, ln_fares_id, search_did ),
		group,
		xf_roll_deeds(left,rows(left))
	);
	// DEBUG
	// output(ds_raw1,		named('ds_raw1'));
	// output(ds_raw2,		named('ds_raw2'));
	// output(ds_value,		named('ds_value'));
	// output(ds_sort,		named('ds_sort'));
	// output(ds_rolled,	named('ds_rolled'));
	return ds_rolled;
end;