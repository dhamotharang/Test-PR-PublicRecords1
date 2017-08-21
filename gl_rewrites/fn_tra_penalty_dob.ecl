import ut;
export FN_Tra_Penalty_DOB(
	gl_rewrites.penalty_interfaces.i__input_dob in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_dob in_found_parms) :=
		function
			RETURN MAP(in_input_parms.find_month = 0 or ((unsigned8)in_found_parms.dob_field div 100) % 100 = in_input_parms.find_month => 0,
						(unsigned8)in_found_parms.dob_field=0 => 1,
						in_found_parms.dob_field[5..6] IN ['00','01'] => 1,	// like a null
						10 ) +
						MAP ( in_input_parms.find_day = 0 or (unsigned8)in_found_parms.dob_field % 100 = in_input_parms.find_day => 0,
						(unsigned8)in_found_parms.dob_field=0 => 1,
						in_found_parms.dob_field[7..8] IN ['00','01'] => 1,	// like a null
						10 ) +
						MAP ( ( in_input_parms.find_year_high = 0 or in_input_parms.find_year_high >= (unsigned8)in_found_parms.dob_field div 10000 ) and 
							( in_input_parms.find_year_low = 0 or in_input_parms.find_year_low <= (unsigned8)in_found_parms.dob_field div 10000 )  => 0,
						(unsigned8)in_found_parms.dob_field=0 => 3,
						10 ) + 
						MAP ((in_input_parms.AgeLow_val <> 0 or in_input_parms.AgeHigh_val <> 0) and (unsigned8)in_found_parms.dob_field=0 => 2,   //only penalize more if age range requested and field is empty        
						(in_input_parms.AgeLow_val = 0 or 
								map(((unsigned8)in_found_parms.dob_field div 100) % 100 = 0 
										=> ((unsigned8)in_found_parms.dob_field div 10000)*10000 + 101, 
							(unsigned8)in_found_parms.dob_field % 100 = 0 
							=> ((unsigned8)in_found_parms.dob_field div 100)*100 + 1, 
							(unsigned8)in_found_parms.dob_field) <= 
							(unsigned8)(StringLib.getdateYYYYMMDD())-in_input_parms.AgeLow_val*10000) 
							and
						(in_input_parms.AgeHigh_val = 0 or 
							map(((unsigned8)in_found_parms.dob_field div 100) % 100 = 0 
									=> ((unsigned8)in_found_parms.dob_field div 10000)*10000 + 1231, 
							(unsigned8)in_found_parms.dob_field % 100 = 0
									=> ((unsigned8)in_found_parms.dob_field div 100)*100 + 
											 ut.Month_Days((unsigned8)in_found_parms.dob_field div 100),
							(unsigned8)in_found_parms.dob_field) >
								 (unsigned8)(StringLib.getdateYYYYMMDD())-(in_input_parms.AgeHigh_val+1)*10000) 
				 => 0,
				10);

		END;