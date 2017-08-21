export FN_Tra_Penalty_DID(
	gl_rewrites.penalty_interfaces.i__input_did in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_did in_found_parms) :=
		function
			return MAP(
				(unsigned8)in_input_parms.did_value = 0 or
				(unsigned8)in_found_parms.did_field = (unsigned8)in_input_parms.did_value =>
					0,
				10);
		end;
		