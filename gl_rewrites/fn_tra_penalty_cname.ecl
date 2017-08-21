import ut;
export FN_Tra_Penalty_CName(
	gl_rewrites.penalty_interfaces.i__input_cname in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_cname in_found_parms) :=
		function
			return
				if(
					in_input_parms.comp_name_value = '',
					0,
					ut.CompanySimilar(
						in_found_parms.cname_field,
						in_input_parms.comp_name_value));
END;