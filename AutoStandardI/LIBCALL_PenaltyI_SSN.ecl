import AutoStandardI;
export LIBCALL_PenaltyI_SSN := module
	export val(AutoStandardI.LIBIN.PenaltyI_SSN.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_SSN',LIBOUT.PenaltyI_SSN(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_SSN(in_mod).val;
	end;
end;
