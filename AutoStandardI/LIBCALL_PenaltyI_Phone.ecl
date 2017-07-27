import AutoStandardI;
export LIBCALL_PenaltyI_Phone := module
	export val(AutoStandardI.LIBIN.PenaltyI_Phone.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_Phone',LIBOUT.PenaltyI_Phone(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_Phone(in_mod).val;
	end;
end;
