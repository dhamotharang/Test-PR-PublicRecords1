import doxie, ut;
export fetch_header_wild_ssn_partial(
	gl_rewrites.person_interfaces.i__fetch_header_wild_ssn_partial in_parms) :=
		function
			i4 := doxie.Key_Header_SSN4;
			i5 := doxie.Key_Header_SSN5;

			is_ssn4 := length(trim(in_parms.ssn_value))=4;
			is_ssn5 := length(trim(in_parms.ssn_value))=5;

			max_person := ut.limits.DID_PER_PERSON * 2;

			ds4 := project(limit(i4(is_ssn4 and (in_parms.lname_value<>'' or in_parms.fname_value<>''),
													 keyed(ssn4=trim(in_parms.ssn_value)),
										 in_parms.lname_wild_val='' OR stringlib.StringWildMatch(lname,in_parms.lname_wild_val,true),
										 in_parms.fname_wild_val='' OR stringlib.StringWildMatch(fname,in_parms.fname_wild_val,true)),
							 max_person, skip), doxie.layout_references);

			ds5 := project(limit(i5(is_ssn5 and (in_parms.lname_value<>'' or in_parms.fname_value<>''),
													 keyed(ssn5=trim(in_parms.ssn_value)),
							 in_parms.lname_wild_val='' OR stringlib.StringWildMatch(lname,in_parms.lname_wild_val,true),
										 in_parms.fname_wild_val='' OR stringlib.StringWildMatch(fname,in_parms.fname_wild_val,true)),
										 max_person, skip), doxie.layout_references);
																			
			return map(is_ssn4 => ds4, is_ssn5 => ds5, dataset([],doxie.layout_references));
		end;