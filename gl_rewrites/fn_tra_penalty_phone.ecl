export Fn_Tra_Penalty_Phone(
	gl_rewrites.penalty_interfaces.i__input_phone in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_phone in_found_parms) := function
		return MAP(
			in_input_parms.phone_value='' or in_found_parms.phone_field=in_input_parms.phone_value or in_found_parms.phone_field[4..10]=in_input_parms.phone_value => 0 ,
			in_found_parms.phone_field=in_input_parms.phone_value[4..10] => 1,
			in_found_parms.phone_field[4..10]=in_input_parms.phone_value[4..10] => 2,
			in_found_parms.phone_field='' =>3, in_input_parms.score_threshold_value-1 );
		end;