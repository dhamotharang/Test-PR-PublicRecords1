import AutoStandardI;
export LIBCALL_PenaltyI_Indv_Name := module
	export val(AutoStandardI.LIBIN.PenaltyI_Indv_Name.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_Indv_Name',LIBOUT.PenaltyI_Indv_Name(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_Indv_Name(in_mod).val;
	end;
end;
