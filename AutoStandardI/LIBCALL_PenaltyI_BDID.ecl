export LIBCALL_PenaltyI_BDID := module
	export val(LIBIN.PenaltyI_BDID.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_BDID',LIBOUT.PenaltyI_BDID(in_mod)).val;
		return LIB_PenaltyI_BDID(in_mod).val;
	end;
end;
