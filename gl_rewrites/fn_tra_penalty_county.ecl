import ut;
export FN_Tra_Penalty_County(
	gl_rewrites.penalty_interfaces.i__input_county in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_county in_found_parms) := FUNCTION
		RETURN MAP (
			in_input_parms.county_value='' or in_found_parms.county_field=in_input_parms.county_value => 0, 
				in_found_parms.county_field='' => 3,
				ut.stringsimilar(in_found_parms.county_field,in_input_parms.county_value)<3 => 1,	 
				10 );
		END;
