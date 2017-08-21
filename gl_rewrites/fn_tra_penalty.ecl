export FN_Tra_Penalty(
	gl_rewrites.penalty_interfaces.i__input in_input_parms,
	gl_rewrites.penalty_interfaces.i__found in_found_parms) :=
		function
			return
				gl_rewrites.fn_tra_penalty_name(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_cname(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_addr(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_ssn(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_fein(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_did(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_bdid(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_county(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_phone(in_input_parms,in_found_parms) +
				gl_rewrites.fn_tra_penalty_dob(in_input_parms,in_found_parms);
		end;
		