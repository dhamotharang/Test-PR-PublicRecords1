import AutoStandardI;
export LIBCALL_PenaltyI_Indv := module
	// templib(LIBIN.PenaltyI_Indv.full in_mod) := library('AutoStandardI.LIB_PenaltyI_Indv',LIBOUT.PenaltyI_Indv(in_mod));
	shared templib(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := AutoStandardI.LIB_PenaltyI_Indv(in_mod);
	export val(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val;
	export val_addr(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val_addr;
	export val_county(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val_county;
	export val_did(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val_did;
	export val_dob(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val_dob;
	export val_indv_name(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val_indv_name;
	export val_phone(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val_phone;
	export val_ssn(AutoStandardI.LIBIN.PenaltyI_Indv.full in_mod) := templib(in_mod).val_ssn;
end;
