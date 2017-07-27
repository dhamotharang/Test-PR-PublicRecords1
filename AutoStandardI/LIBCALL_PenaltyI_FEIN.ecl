export LIBCALL_PenaltyI_FEIN := module
	export val(LIBIN.PenaltyI_FEIN.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_FEIN',LIBOUT.PenaltyI_FEIN(in_mod)).val;
		return LIB_PenaltyI_FEIN(in_mod).val;
	end;
end;
