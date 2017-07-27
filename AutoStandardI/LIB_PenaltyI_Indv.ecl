/*--LIBRARY--*/
// This library performs penalty calculations based on individual.
// All logic for performing the calculation should be based here.
import doxie,ut,AutoStandardI;
export LIB_PenaltyI_Indv(AutoStandardI.LIBIN.PenaltyI_Indv.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_Indv(args))
	EXPORT UNSIGNED val_addr := AutoStandardI.LIBCALL_PenaltyI_Addr.val(args);
	EXPORT UNSIGNED val_county := AutoStandardI.LIBCALL_PenaltyI_County.val(args);
	EXPORT UNSIGNED val_did := AutoStandardI.LIBCALL_PenaltyI_DID.val(args);
	EXPORT UNSIGNED val_dob := AutoStandardI.LIBCALL_PenaltyI_DOB.val(args);
	EXPORT UNSIGNED val_indv_name := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(args);
	EXPORT UNSIGNED val_phone := AutoStandardI.LIBCALL_PenaltyI_Phone.val(args);
	EXPORT UNSIGNED val_ssn := AutoStandardI.LIBCALL_PenaltyI_SSN.val(args);
	EXPORT UNSIGNED val := val_addr + val_county + val_did + val_dob + val_indv_name + val_phone + val_ssn;
END;