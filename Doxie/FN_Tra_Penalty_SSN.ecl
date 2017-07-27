import AutoStandardI;

export FN_Tra_Penalty_SSN(string ssn_field, boolean IsFCRA = FALSE) := 
FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
	export ssn_field := ^.ssn_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmod);

END;