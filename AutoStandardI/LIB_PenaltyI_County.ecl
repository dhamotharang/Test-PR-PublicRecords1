/*--LIBRARY--*/
// This library performs penalty calculations based on county.
// All logic for performing the calculation should be based here.
import ut,AutoStandardI;
export LIB_PenaltyI_County(AutoStandardI.LIBIN.PenaltyI_County.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_County(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_county_value := AutoStandardI.InterfaceTranslator.county_value.val(args);
		RETURN MAP(
			temp_county_value='' or args.county_field=temp_county_value => 0,
			args.county_field='' => 3,
			ut.stringsimilar(args.county_field,temp_county_value)<3 => 1,
			10);
	END;
END;