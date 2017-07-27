
EXPORT Functions := MODULE

	EXPORT fn_format_name(Experian_Phones_Services.layouts.batch_in_plus le) :=
		trim(le.name_first) + if( trim(le.name_middle) != '', ' ' + trim(le.name_middle), '' ) + ' ' + trim(le.name_last); 

	EXPORT fn_get_phone_fdbk_result(STRING8 dt = '', UNSIGNED1 res) :=
		FUNCTION
			c := Experian_Phones_Services.Constants;
			
			STRING1 feedback_result := 
				MAP(
					res IN 
						[
							c.RIGHT_PARTY_CONTACT,
							c.RELATIVE_OR_ASSOCIATE_RIGHT_PARTY_CONTACT,
							c.POTENTIAL_WRONG_PARTY_CLAIM,
							c.POTENTIAL_TEMPORARY_DISCONNECT,
							c.NO_FEEDBACK_REPORTED
						]        => (STRING1)res,
					res = 99   => (STRING1)c.NO_FEEDBACK_REPORTED,
					/* default */ ''
				);
			
			RETURN feedback_result; 
		END;
					
	// .......................... temp layout ..........................
	// ..........................    |||||    ..........................
	// ..........................    vvvvv    ..........................
	export ToFinalBatchOut( DATASET(Experian_Phones_Services.layouts.batch_out_plus) ds_out) := function
				
		RETURN ds_out;
	end;
	
END;