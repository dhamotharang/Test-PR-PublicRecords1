/* 
Using new "L" match code value here. The "L" tells us that the DID was passed in to the query and used to 'match' a bankruptcy record, 
indicating that a 'deep dive' was used before the query to fetch the match.
*/

export mac_filter_matchcodes(ds_in, ds_out, matchcode_field, mc_str, mc_delim, order_dependent = true) := MACRO
  import STD, ut;

	#uniquename(mc_str_trim)
	%mc_str_trim% := trim(STD.Str.ToUpperCase(mc_str), ALL);

	#uniquename(mc_set)
	%mc_set% := STD.Str.SplitWords(%mc_str_trim%, mc_delim);

	// either record's matchcode is in the matchcode string (with or without an L)
	// or 'L' is in the match code string and an 'L' is present in the record's matchcode
	// if the match code string is empty, return everything
	#uniquename(ds_match_filt_order)
	%ds_match_filt_order%	:= ds_in((matchcode_field IN %mc_set%)
								OR	(STD.Str.FilterOut(matchcode_field, 'L') IN %mc_set%)
								OR 	(STD.Str.Contains(matchcode_field, 'L', FALSE) AND ('L' IN %mc_set%))
								OR	%mc_str_trim% = '');
	
	#uniquename(no_order_rec)
	%no_order_rec% := record
			ds_in;
			boolean is_Match := false;
	end;

	#uniquename(xfm_no_order)
	%no_order_rec% %xfm_no_order%(recordof(ds_in) L) := transform
			self.is_Match := ut.fn_WordMixMatcher(L.matchcode, %mc_set%);
			self := L;
	end;
	
	#uniquename(ds_match_filt_no_order)
	%ds_match_filt_no_order% := project(ds_in, %xfm_no_order%(left));
	
	#uniquename(ds_match_filt)
	%ds_match_filt% :=  project(%ds_match_filt_no_order%(is_match
																										OR	(STD.Str.FilterOut(matchcode_field, 'L') IN %mc_set%)
																										OR 	(STD.Str.Contains(matchcode_field, 'L', FALSE) AND ('L' IN %mc_set%))
																										OR	%mc_str_trim% = ''), recordof(%ds_match_filt_order%));

	#uniquename(xfm_strip_L)
	RECORDOF(ds_in) %xfm_strip_L%(RECORDOF(ds_in) L) := TRANSFORM
		SELF.matchcode_field := IF( (STD.Str.FilterOut(L.matchcode_field, 'L') IN %mc_set%) OR %mc_str_trim% = '' or not order_dependent, 
									 STD.Str.FilterOut(L.matchcode_field, 'L'), 
									 'L');
		SELF := L;
	END;

	ds_out := PROJECT(%ds_match_filt%, %xfm_strip_L%(LEFT));

ENDMACRO;