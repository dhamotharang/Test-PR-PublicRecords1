import ut;
export FN_Tra_Penalty_SSN(
	gl_rewrites.penalty_interfaces.i__input_ssn in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_ssn in_found_parms) :=
		function
			last4 := in_found_parms.ssn_field[LENGTH(TRIM(in_found_parms.ssn_field))-3..];
			return MAP(in_input_parms.ssn_value='' or in_found_parms.ssn_field=in_input_parms.ssn_value => 0,
					in_found_parms.ssn_field='' => 3,
					length(trim(in_input_parms.ssn_value))=4 and in_input_parms.ssn_value=last4 => 0,
					length(trim(in_input_parms.ssn_value))=4 => ut.imin2(ut.stringsimilar(last4,in_input_parms.ssn_value)-1,in_input_parms.score_threshold_value-1),
					IF(ut.stringsimilar(in_found_parms.ssn_field,in_input_parms.ssn_value)>4,in_input_parms.score_threshold_value-1,ut.stringsimilar(in_found_parms.ssn_field,in_input_parms.ssn_value)));
		end;
		