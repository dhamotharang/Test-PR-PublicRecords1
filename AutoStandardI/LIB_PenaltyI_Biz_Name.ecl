/*--LIBRARY--*/
// This library performs penalty calculations based on business name.
// All logic for performing the calculation should be based here.
import ut;
export LIB_PenaltyI_Biz_Name(LIBIN.PenaltyI_Biz_Name.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI_Biz_Name(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_comp_name_value := InterfaceTranslator.comp_name_value.val(args);
		RETURN IF(temp_comp_name_value = '', 0, ut.companysimilar(args.cname_field,temp_comp_name_value,true));
	END;
END;