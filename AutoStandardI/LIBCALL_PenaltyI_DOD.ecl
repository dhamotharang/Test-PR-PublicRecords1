import AutoStandardI;
export LIBCALL_PenaltyI_DOD := module
	export val(AutoStandardI.LIBIN.PenaltyI_DOD.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_DOD',LIBOUT.PenaltyI_DOD(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_DOD(in_mod).val;
	end;
end;
