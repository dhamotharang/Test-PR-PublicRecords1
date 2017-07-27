import AutoStandardI;
export LIBCALL_PenaltyI_Addr := module
	export val(AutoStandardI.LIBIN.PenaltyI_Addr.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_Addr',LIBOUT.PenaltyI_Addr(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_Addr(in_mod).val;
	end;
end;
