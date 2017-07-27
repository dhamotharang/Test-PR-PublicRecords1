import LN_PropertyV2, Codes;

export keys_2 := module

	// lookup
	export assessor(boolean isFCRA = false)		:= LN_PropertyV2.key_assessor_fid(isFCRA);
	export addl_fares_t		                    := LN_PropertyV2.key_addl_fares_tax_fid;
	export addl_legal(boolean isFCRA = false)	:= LN_PropertyV2.key_addl_legal_fid(isFCRA);
	
	export search(boolean isFCRA = false)			:= LN_PropertyV2.key_search_fid(isFCRA);
	
	export deed(boolean isFCRA = false)				:= LN_PropertyV2.key_deed_fid(isFCRA);
	export addl_fares_d		                    := LN_PropertyV2.key_addl_fares_deed_fid;
	
	export county(boolean isFCRA = false)     := LN_PropertyV2.key_county_fid(isFCRA);
	export addl_names(boolean isFCRA = false) := LN_PropertyV2.key_addl_names(isFCRA);
	
	export codes := Codes.Key_Codes_V3;
	
	// search
	export search_did(boolean isFCRA = false)			:= LN_PropertyV2.key_Property_did(isFCRA);
	export search_bdid		:= LN_PropertyV2.key_search_bdid;
	export search_pnum_a	:= LN_PropertyV2.key_assessor_parcelnum;
	export search_pnum_d	:= LN_PropertyV2.key_deed_parcelnum;
	export search_addr		:= LN_PropertyV2.key_addr_fid;
	// export ownership			:= LN_PropertyV2.key_prop_ownership; // Is this used anywhere?

end;