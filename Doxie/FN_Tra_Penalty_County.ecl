import AutoStandardI;
export FN_Tra_Penalty_County(string county_field) := FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_County.full,opt))
	export county_field := ^.county_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_County.val(tempmod);
END;
