/*--LIBRARY--*/
// This library performs penalty calculations based on SSN.
// All logic for performing the calculation should be based here.
import ut,AutoStandardI;

export LIB_PenaltyI_SSN(AutoStandardI.LIBIN.PenaltyI_SSN.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_SSN(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(args);
		last4 := args.ssn_field[LENGTH(TRIM(args.ssn_field))-3..];
		first5 := args.ssn_field[1..5];

    useSSnPartialFetch := AutoStandardI.InterfaceTranslator.ssnfallback_value.val(project(args,AutoStandardI.InterfaceTranslator.ssnfallback_value.params));
    
		return 
		MAP(
			temp_ssn_value='' or args.ssn_field=temp_ssn_value 	=> 0,
			args.ssn_field='' => 3,
			useSSNPartialFetch and  length(trim(temp_ssn_value))=9 and (temp_ssn_value[6..9] = last4 
			                    OR temp_ssn_value[1..5] = first5 ) =>1,
      length(trim(temp_ssn_value))=4 and temp_ssn_value=last4 => 0,
			length(trim(temp_ssn_value))=4 
			=> MIN(ut.stringsimilar(last4,temp_ssn_value)-1,AutoStandardI.Constants.DEFAULT_THRESHOLD-1),
			length(trim(temp_ssn_value))=5 and temp_ssn_value=first5 => 0,
			length(trim(temp_ssn_value))=5 
			=> MIN(ut.stringsimilar(first5,temp_ssn_value)-1,AutoStandardI.Constants.DEFAULT_THRESHOLD-1),
			IF(
				ut.stringsimilar(args.ssn_field,temp_ssn_value)>4,
				AutoStandardI.Constants.DEFAULT_THRESHOLD-1,
				ut.stringsimilar(args.ssn_field,temp_ssn_value)
			)
		);
	END;
END;