import AutoStandardI;

export FN_Tra_Penalty_DOB(string dob_field) := FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DOB.full,opt))
	export dob_field := ^.dob_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_DOB.val(tempmod);

END;