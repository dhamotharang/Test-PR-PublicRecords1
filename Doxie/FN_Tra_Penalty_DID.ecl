import AutoStandardI;

export FN_Tra_Penalty_DID(string did_field) := 

FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
	export did_field := ^.did_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(tempmod);

END;