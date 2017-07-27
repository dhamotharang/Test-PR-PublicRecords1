export LIBCALL_PenaltyI_Biz := module
	// templib(LIBIN.PenaltyI_Biz.full in_mod) := library('AutoStandardI.LIB_PenaltyI_Biz',LIBOUT.PenaltyI_Biz(in_mod));
	shared templib(LIBIN.PenaltyI_Biz.full in_mod) := LIB_PenaltyI_Biz(in_mod);
	export val(LIBIN.PenaltyI_Biz.full in_mod) := templib(in_mod).val;
	export val_addr(LIBIN.PenaltyI_Biz.full in_mod) := templib(in_mod).val_addr;
	export val_bdid(LIBIN.PenaltyI_Biz.full in_mod) := templib(in_mod).val_bdid;
	export val_biz_name(LIBIN.PenaltyI_Biz.full in_mod) := templib(in_mod).val_biz_name;
	export val_county(LIBIN.PenaltyI_Biz.full in_mod) := templib(in_mod).val_county;
	export val_fein(LIBIN.PenaltyI_Biz.full in_mod) := templib(in_mod).val_fein;
	export val_phone(LIBIN.PenaltyI_Biz.full in_mod) := templib(in_mod).val_phone;
end;
