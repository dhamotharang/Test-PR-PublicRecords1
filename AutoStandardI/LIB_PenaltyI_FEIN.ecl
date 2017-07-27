/*--LIBRARY--*/
// This library performs penalty calculations based on FEIN.
// All logic for performing the calculation should be based here.
import ut;
export LIB_PenaltyI_FEIN(LIBIN.PenaltyI_FEIN.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI_FEIN(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_fein_val := InterfaceTranslator.fein_val.val(args);
		RETURN MAP(
			temp_fein_val='' or args.fein_field=temp_fein_val => 0,
			args.fein_field='' => 3,
			IF(ut.stringsimilar(args.fein_field,temp_fein_val)>4,
				Constants.DEFAULT_THRESHOLD-1,
				ut.stringsimilar(args.fein_field,temp_fein_val)));
	END;
END;