import AutoStandardI;

export Fn_Tra_Penalty_Phone(string phone_field) := Function

tempmod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
	export phone_field := ^.phone_field;
end;		
RETURN AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmod);
	
end;