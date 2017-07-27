import AutoStandardI;
export LIBCALL_PenaltyI_DID := module
	export val(AutoStandardI.LIBIN.PenaltyI_DID.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_DID',LIBOUT.PenaltyI_DID(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_DID(in_mod).val;
	end;
end;
