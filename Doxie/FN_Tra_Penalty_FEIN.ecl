import AutoStandardI;

export FN_Tra_Penalty_FEIN(string fein_field) := FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
	export fein_field := ^.fein_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmod);

END;
