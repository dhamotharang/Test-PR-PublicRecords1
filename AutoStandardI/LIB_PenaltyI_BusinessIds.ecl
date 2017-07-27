/*--LIBRARY--*/
// This library performs penalty calculations based on Business Ids.
// All logic for performing the calculation should be based here.
export LIB_PenaltyI_BusinessIds(LIBIN.PenaltyI_BusinessIds.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI_BusinessIds(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_ultid_value 	:= InterfaceTranslator.ultid_value.val(args);
		temp_orgid_value 	:= InterfaceTranslator.orgid_value.val(args);
		temp_seleid_value	:= InterfaceTranslator.seleid_value.val(args);
		temp_proxid_value := InterfaceTranslator.proxid_value.val(args);
		temp_powid_value 	:= InterfaceTranslator.powid_value.val(args);
		temp_empid_value 	:= InterfaceTranslator.empid_value.val(args);
		temp_dotid_value 	:= InterfaceTranslator.dotid_value.val(args);
		
		RETURN MAP(
			(temp_ultid_value = 0 AND temp_orgid_value = 0 AND temp_seleid_value = 0) OR
			// Check penalty at SELE level.
      (args.ultid_field = temp_ultid_value AND args.orgid_field = temp_orgid_value AND 
					args.seleid_field = temp_seleid_value)  => 0,
			10);
		END;
END;