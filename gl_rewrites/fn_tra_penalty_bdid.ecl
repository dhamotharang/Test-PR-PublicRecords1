export FN_Tra_Penalty_bdid(
	gl_rewrites.penalty_interfaces.i__input_bdid in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_bdid in_found_parms) :=
		function
			return
				map(
					(unsigned8)in_input_parms.bdid_value = 0 or
					(unsigned8)in_found_parms.bdid_field = (unsigned8)in_input_parms.bdid_value =>
						0,
					10);
		end;
