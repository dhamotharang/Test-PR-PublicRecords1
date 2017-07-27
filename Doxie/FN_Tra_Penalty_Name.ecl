import AutoStandardI;

export FN_Tra_Penalty_Name(string fname_field,string mname_field,string lname_field, 
                           boolean allow_wildcard = false, boolean isFCRA = false) := FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
	export fname_field := ^.fname_field;
	export mname_field := ^.mname_field;
	export lname_field := ^.lname_field;
	export allow_wildcard := ^.allow_wildcard;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmod);
END;