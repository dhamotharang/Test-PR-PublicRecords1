import AutoStandardI;

export FN_Tra_Penalty_CName(string cname_field) := 
FUNCTION

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
	export cname_field := ^.cname_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmod);

END;