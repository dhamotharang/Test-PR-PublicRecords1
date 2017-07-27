/*--LIBRARY--*/
// This library performs penalty calculations based on Phone.
// All logic for performing the calculation should be based here.
import ut,AutoStandardI;
export LIB_PenaltyI_Phone(AutoStandardI.LIBIN.PenaltyI_Phone.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_Phone(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(args);
		temp_score_threshold_value := AutoStandardI.InterfaceTranslator.score_threshold_value.val(args);
		RETURN MAP(
			temp_phone_value='' or args.phone_field=temp_phone_value or args.phone_field[4..10]=temp_phone_value => 0 ,
			args.phone_field=temp_phone_value[4..10] => 1,
			args.phone_field[4..10]=temp_phone_value[4..10] => 2,
			args.phone_field='' =>3, AutoStandardI.Constants.DEFAULT_THRESHOLD-1);
	END;
END;