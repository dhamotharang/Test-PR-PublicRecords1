/*--LIBRARY--*/
// This library performs penalty calculations.
// All logic for performing the calculation should be based here.
import doxie,ut;
export LIB_PenaltyI(LIBIN.PenaltyI.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI(args))
	EXPORT UNSIGNED val_addr := LIBCALL_PenaltyI_Addr.val(args);
	EXPORT UNSIGNED val_bdid := LIBCALL_PenaltyI_BDID.val(args);
	EXPORT UNSIGNED val_biz_name := LIBCALL_PenaltyI_Biz_Name.val(args);
	EXPORT UNSIGNED val_county := LIBCALL_PenaltyI_County.val(args);
	EXPORT UNSIGNED val_did := LIBCALL_PenaltyI_DID.val(args);
	EXPORT UNSIGNED val_dob := LIBCALL_PenaltyI_DOB.val(args);
	EXPORT UNSIGNED val_fein := LIBCALL_PenaltyI_FEIN.val(args);
	EXPORT UNSIGNED val_indv_name := LIBCALL_PenaltyI_Indv_Name.val(args);
	EXPORT UNSIGNED val_phone := LIBCALL_PenaltyI_Phone.val(args);
	EXPORT UNSIGNED val_ssn := LIBCALL_PenaltyI_SSN.val(args);
	EXPORT UNSIGNED val_biz := val_addr + val_bdid + val_biz_name + val_county + val_fein + val_phone;
	EXPORT UNSIGNED val_indv := val_addr + val_county + val_did + val_dob + val_indv_name + val_phone + val_ssn;
	EXPORT UNSIGNED val := val_addr + val_bdid + val_biz_name + val_county + val_did + val_dob + val_fein + val_indv_name + val_phone + val_ssn;
END;