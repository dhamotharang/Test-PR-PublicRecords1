export LIBCALL_PenaltyI_BusinessIds := module
	export val(LIBIN.PenaltyI_BusinessIds.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_BusinessIds',LIBOUT.PenaltyI_BusinessIds(in_mod)).val;
		return LIB_PenaltyI_BusinessIds(in_mod).val;
	end;
end;
