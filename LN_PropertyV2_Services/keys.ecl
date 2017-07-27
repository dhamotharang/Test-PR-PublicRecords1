import LN_PropertyV2, Codes;

export keys := module

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
	
	// key availability tests
	export testkeys := macro
		output(LN_PropertyV2_Services.keys.assessor,			named('assessor'));
		output(LN_PropertyV2_Services.keys.addl_fares_t,	named('addl_fares_t'));
		output(LN_PropertyV2_Services.keys.addl_legal,		named('addl_legal'));
		output(LN_PropertyV2_Services.keys.search,				named('search'));
		output(LN_PropertyV2_Services.keys.deed,					named('deed'));
		output(LN_PropertyV2_Services.keys.addl_fares_d,	named('addl_fares_d'));
		output(LN_PropertyV2_Services.keys.county,				named('county'));
		output(LN_PropertyV2_Services.keys.addl_names,		named('addl_names'));
		output(LN_PropertyV2_Services.keys.codes,					named('codes'));
		output(LN_PropertyV2_Services.keys.search_did,		named('search_did'));
		output(LN_PropertyV2_Services.keys.search_bdid,		named('search_bdid'));
		output(LN_PropertyV2_Services.keys.search_pnum_a,	named('search_pnum_a'));
		output(LN_PropertyV2_Services.keys.search_pnum_d,	named('search_pnum_d'));
		output(LN_PropertyV2_Services.keys.search_addr,		named('search_addr'));
	endmacro;
end;