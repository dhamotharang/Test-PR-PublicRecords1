import ut;
export fn_tra_penalty_name(
	gl_rewrites.penalty_interfaces.i__input_name in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_name in_found_parms) :=
		function
			RETURN MAP(in_input_parms.lname_wild and in_input_parms.allow_wildcard and stringlib.StringWildMatch(in_found_parms.lname_field, in_input_parms.lname_wild_val, true) => 0,
								 in_input_parms.lname_wild and in_input_parms.allow_wildcard => 10,
								 in_input_parms.lnameIn='' or in_found_parms.lname_field=in_input_parms.lnameIn => 0,
								 in_found_parms.lname_field='' => 3,
					 //namesimilar seems return either 0-6 or 99, so it is adjusted +3
					 //metaphone appears to have too many false positives, so penalty is
					 //calculated using both, with a cap of 10 for last name mismatch
								 
								 //strip non-alphas before comparing to lnameIn_clean
								 ut.imin2((datalib.namesimilar(ut.AlphasOnly(in_found_parms.lname_field),in_input_parms.lnameIn_clean,1)+ 3)/ 
					 IF(metaphonelib.DMetaPhone1(in_found_parms.lname_field)=metaphonelib.DMetaPhone1(in_input_parms.lnameIn),2,1),10)) + 
			MAP(in_input_parms.fname_wild and in_input_parms.allow_wildcard and stringlib.StringWildMatch(in_found_parms.fname_field, in_input_parms.fname_wild_val, true) => 0,
					in_input_parms.fname_wild and in_input_parms.allow_wildcard => 10,
					in_input_parms.fnameIn='' or in_found_parms.fname_field=in_input_parms.fnameIn => 0,
					datalib.preferredfirst(in_found_parms.fname_field)=datalib.preferredfirst(in_input_parms.fnameIn) => 1,
					in_found_parms.fname_field[1]=in_input_parms.fnameIn or in_found_parms.fname_field=in_input_parms.fnameIn[1] => 1,   
					in_found_parms.fname_field='' => 3,
					//strip non-alphas before comparing to fnameIn_clean
					ut.imin2((datalib.namesimilar(ut.AlphasOnly(in_found_parms.fname_field),in_input_parms.fnameIn_clean,1) + 3),10)) +
			MAP(in_input_parms.mname_value='' or in_found_parms.mname_field=in_input_parms.mname_value => 0,
					in_found_parms.mname_field[1]=in_input_parms.mname_value or in_found_parms.mname_field=in_input_parms.mname_value[1] => 2,
					in_found_parms.mname_field='' => 2,
					LENGTH(TRIM(in_input_parms.mname_value))=1 or in_input_parms.non_exclusion_value => 3,
					ut.imin2((datalib.namesimilar(in_found_parms.mname_field,in_input_parms.mname_value,1) * 3),10));
		end;
		