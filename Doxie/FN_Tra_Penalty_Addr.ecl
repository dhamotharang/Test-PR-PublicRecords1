import AutoStandardI;

export FN_Tra_Penalty_Addr(
    string predir_field,string prange_field,string pname_field,string suffix_field,
		string postdir_field,string sec_range_field,string city_field,string state_field,
		string zip_field, boolean allow_wildcard = false, string city2_field='') := FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
	export allow_wildcard := ^.allow_wildcard;
	export city_field := ^.city_field;
	export city2_field := ^.city2_field;
	export pname_field := ^.pname_field;
	export postdir_field := ^.postdir_field;
	export prange_field := ^.prange_field;
	export predir_field := ^.predir_field;
	export state_field := ^.state_field;
	export suffix_field := ^.suffix_field;
	export zip_field := ^.zip_field;
	export sec_range_field := ^.sec_range_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod);
END;