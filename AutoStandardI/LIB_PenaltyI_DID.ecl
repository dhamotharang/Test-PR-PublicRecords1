/*--LIBRARY--*/
// This library performs penalty calculations based on DID.
// All logic for performing the calculation should be based here.
import AutoStandardI;
export LIB_PenaltyI_DID(AutoStandardI.LIBIN.PenaltyI_DID.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_DID(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_did_value := AutoStandardI.InterfaceTranslator.did_value.val(args);
		RETURN MAP(
			(UNSIGNED8)temp_did_value=0 OR (UNSIGNED8)args.did_field = (UNSIGNED8)temp_did_value => 0 , 
			10);
	END;
END;