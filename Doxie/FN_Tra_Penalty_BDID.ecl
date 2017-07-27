import AutoStandardI;

export FN_Tra_Penalty_bdid(string bdid_field) := 

FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
	export bdid_field := ^.bdid_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmod);

END;