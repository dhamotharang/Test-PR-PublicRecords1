/*--LIBRARY--*/
// This library performs penalty calculations based on BDID.
// All logic for performing the calculation should be based here.
export LIB_PenaltyI_BDID(LIBIN.PenaltyI_BDID.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI_BDID(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_bdid_value := InterfaceTranslator.bdid_value.val(args);
		RETURN MAP(
			(UNSIGNED8)temp_bdid_value=0 or (UNSIGNED8)args.bdid_field = (UNSIGNED8)temp_bdid_value => 0 , 
			10);
	END;
END;