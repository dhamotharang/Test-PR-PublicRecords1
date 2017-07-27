import AutoStandardI;
export LIBCALL_PenaltyI_DOB := module
	export val(AutoStandardI.LIBIN.PenaltyI_DOB.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_DOB',LIBOUT.PenaltyI_DOB(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_DOB(in_mod).val;
	end;
end;
