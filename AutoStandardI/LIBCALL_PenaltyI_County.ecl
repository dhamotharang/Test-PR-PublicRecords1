import AutoStandardI;
export LIBCALL_PenaltyI_County := module
	export val(AutoStandardI.LIBIN.PenaltyI_County.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_County',LIBOUT.PenaltyI_County(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_County(in_mod).val;
	end;
end;
