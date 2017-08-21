import ut;
export FN_Tra_Penalty_FEIN(
	gl_rewrites.penalty_interfaces.i__input_fein in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_fein in_found_parms) :=
		function
			return
				map(
					in_input_parms.fein_val = '' or
					in_found_parms.fein_field = in_input_parms.fein_val =>
						0,
					in_found_parms.fein_field = '' =>
						3,
					if(
						ut.StringSimilar(in_found_parms.fein_field,in_input_parms.fein_val) > 4,
						in_input_parms.score_threshold_value - 1,
						ut.StringSimilar(in_found_parms.fein_field,in_input_parms.fein_val)));
		end;
