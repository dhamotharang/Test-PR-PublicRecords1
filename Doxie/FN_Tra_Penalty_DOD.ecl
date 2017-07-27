import AutoStandardI;

export FN_Tra_Penalty_DOD(string dod_field) := FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DOD.full,opt))
	export dod_field := ^.dod_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_DOD.val(tempmod);

END;
