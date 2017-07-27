/*--LIBRARY--*/
// This library performs penalty calculations based on business.
// All logic for performing the calculation should be based here.
import doxie,ut;
export LIB_PenaltyI_Biz(LIBIN.PenaltyI_Biz.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI_Biz(args))
	EXPORT UNSIGNED val_addr := LIBCALL_PenaltyI_Addr.val(args);
	EXPORT UNSIGNED val_bdid := LIBCALL_PenaltyI_BDID.val(args);
	EXPORT UNSIGNED val_biz_name := LIBCALL_PenaltyI_Biz_Name.val(args);
	EXPORT UNSIGNED val_county := LIBCALL_PenaltyI_County.val(args);
	EXPORT UNSIGNED val_fein := LIBCALL_PenaltyI_FEIN.val(args);
	EXPORT UNSIGNED val_phone := LIBCALL_PenaltyI_Phone.val(args);
	EXPORT UNSIGNED val := val_addr + val_bdid + val_biz_name + val_county + val_fein + val_phone;
END;