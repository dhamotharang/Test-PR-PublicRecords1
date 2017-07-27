export LIBCALL_PenaltyI_Biz_Name := module
	export val(LIBIN.PenaltyI_Biz_Name.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_Biz_Name',LIBOUT.PenaltyI_Biz_Name(in_mod)).val;
		return LIB_PenaltyI_Biz_Name(in_mod).val;
	end;
end;
