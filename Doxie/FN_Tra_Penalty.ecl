import AutoStandardI;

export FN_Tra_Penalty(string fname_field,string mname_field,string lname_field,
    string ssn_field,string dob_field,string did_field,
    string predir_field,string prange_field,string pname_field,string suffix_field,string postdir_field,
		string sec_range_field,string city_field,string county_field,string state_field,string zip_field,
    string phone_field, boolean allow_wildcard = false) := FUNCTION
		
tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
	export allow_wildcard := ^.allow_wildcard;
	export city_field := ^.city_field;
	export city2_field := '';
	export county_field := ^.county_field;
	export did_field := ^.did_field;
	export dob_field := ^.dob_field;
	export fname_field := ^.fname_field;
	export lname_field := ^.lname_field;
	export mname_field := ^.mname_field;
	export phone_field := ^.phone_field;
	export pname_field := ^.pname_field;
	export postdir_field := ^.postdir_field;
	export prange_field := ^.prange_field;
	export sec_range_field := ^.sec_range_field;
	export predir_field := ^.predir_field;
	export ssn_field := ^.ssn_field;
	export state_field := ^.state_field;
	export suffix_field := ^.suffix_field;
	export zip_field := ^.zip_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmod);
END;