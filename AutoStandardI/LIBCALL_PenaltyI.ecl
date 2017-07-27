export LIBCALL_PenaltyI := module
	// templib(LIBIN.PenaltyI.full in_mod) := library('AutoStandardI.LIB_PenaltyI',LIBOUT.PenaltyI(in_mod));
	shared templib(LIBIN.PenaltyI.full in_mod) := LIB_PenaltyI(in_mod);
	export val(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val;
	export val_addr(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_addr;
	export val_bdid(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_bdid;
	export val_biz(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_biz;
	export val_biz_name(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_biz_name;
	export val_county(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_county;
	export val_did(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_did;
	export val_dob(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_dob;
	export val_fein(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_fein;
	export val_indv(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_indv;
	export val_indv_name(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_indv_name;
	export val_phone(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_phone;
	export val_ssn(LIBIN.PenaltyI.full in_mod) := templib(in_mod).val_ssn;
end;
