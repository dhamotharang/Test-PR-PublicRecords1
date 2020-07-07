import Codes, LN_PropertyV2, _Control, LN_PropertyV2_Services;

k_codes			:= LN_PropertyV2_Services.keys_2.codes;

l_raw				:= LN_PropertyV2_Services.layouts.deeds.raw_source;
l_fid				:= LN_PropertyV2_Services.layouts.fid;
l_tmp				:= LN_PropertyV2_Services.layouts.deeds.result.tmp;
l_rolled		:= LN_PropertyV2_Services.layouts.deeds.result.rolled_tmp;

max_deeds		:= LN_PropertyV2_Services.consts.max_deeds;
code_file		:= LN_PropertyV2_Services.consts.deeds_codefile;

// Abstract Codes.KeyCodes calls to simplify somewhat...
varstring GetCode(
	string field_name_value, 
	string field_name2_value = '',
	string code_value
) := function
	return Codes.KeyCodes(code_file, field_name_value, field_name2_value, code_value, true);
end;


export dataset(l_rolled) fn_get_deeds_2(
  dataset(l_raw) ds_raw,
	LN_PropertyV2_Services.interfaces.Iinput_report in_mod
) := function
	
	// add computed fields
	l_tmp addOnlyALittleValue(ds_raw L) := transform
	
		// Date -------------------------------------------
		self.sortby_date := LN_PropertyV2_Services.Raw_2(in_mod.lookupVal, in_mod.partyType, in_mod.faresID).deed_recency_raw(L);
		
		// Penalty ----------------------------------------
		self.penalt := 0;
		self.cPenalt := 0;
		// We only need a placeholder since searchable data is all in the parties section
		
		// Type ----------------------------------------
		ft := LN_PropertyV2.fn_fid_type(L.ln_fares_id);
		self.fid_type				:= ft;
		self.fid_type_desc	:= fn_fid_type_desc(ft);
		
		// Vendor
		vsource := LN_PropertyV2_Services.fn_vendor_source(L.vendor_source_flag);
		self.vendor_source_desc := vsource;
		self.vendor_source_flag := LN_PropertyV2_Services.fn_vendor_source_obscure(L.vendor_source_flag);
		
		// Buyer/Borrower -----------------------------------
		bb := L.buyer_or_borrower_ind;
		
		self.buyer1_id_code					:= if(bb='O', L.name1_id_code, '');
		self.buyer2_id_code					:= if(bb='O', L.name2_id_code, '');
		self.buyer_vesting_code			:= if(bb='O', L.vesting_code , '');
		self.buyer_addendum_flag		:= if(bb='O', L.addendum_flag, '');
		self.borrower1_id_code			:= if(bb='B', L.name1_id_code, '');
		self.borrower2_id_code			:= if(bb='B', L.name2_id_code, '');
		self.borrower_vesting_code	:= if(bb='B', L.vesting_code , '');
		
		// Lookup Codes -----------------------------------
		self.fares_transaction_type_desc := GetCode('TRANSACTION_TYPE', vsource, L.fares_transaction_type);

		self := L;
		self := [];
	end;
	
	ds_value := project(ds_raw, addOnlyALittleValue(left));

	
#IF(_Control.Environment.OnThor) 
	ds_value_distributed := distribute(ds_value, hash64(ln_fares_id));
	
	// sort & dedup
	ds_sort := 
		DEDUP(
			SORT(
				ds_value_distributed, 
				ln_fares_id, search_did, -sortby_date, fid_type, vendor_source_flag, buyer1_id_code, borrower1_id_code, fares_transaction_type_desc, local 
			), // this sort is costly--consider using a dedup(all, hash)
		ln_fares_id, search_did, sortby_date, fid_type, vendor_source_flag, buyer1_id_code, borrower1_id_code, fares_transaction_type_desc, local
	);
#ELSE
	// sort & dedup
	ds_sort := 
		DEDUP(
			SORT(
				ds_value, 
				ln_fares_id, search_did, -sortby_date, fid_type, vendor_source_flag, buyer1_id_code, borrower1_id_code, fares_transaction_type_desc 
			), // this sort is costly--consider using a dedup(all, hash)
		ln_fares_id, search_did, sortby_date, fid_type, vendor_source_flag, buyer1_id_code, borrower1_id_code, fares_transaction_type_desc
	);
#END
  
  
	
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

	return ds_rolled;
end;