import Address, AutoStandardI, BatchServices, doxie, iesp, NID, Standard, STD;

export Functions := module
	
	SHARED rec_name := RECORD
		STRING name;
		BOOLEAN is_mname := FALSE;
		BOOLEAN is_input := FALSE;
		SET OF UNSIGNED1 group_nums := [];
	END;
		
	SHARED rec_names := RECORD
		rec_name;
		STRING name_2;
	END;
	
	SHARED rec_w_match := RECORD
		STRING in_name;
		STRING best_name;
		BOOLEAN is_in_mname := FALSE;
		BOOLEAN is_best_mname := FALSE;
		SET OF UNSIGNED1 in_group_nums := [];  
		SET OF UNSIGNED1 best_group_nums := [];
		BOOLEAN is_match := FALSE;
	END;
	
	export penalize_ssn_dob(BatchServices.Layouts.layout_batch_in_for_penalties l, 
													 BatchShare.Layouts.SharePII r) :=
		function				
			ssns_to_compare :=  
				module(project(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_SSN.full, opt))	
					// The 'input' ssn:
					export ssn := l._ssn;   
					// The ssn in the matching record:
					export ssn_field := r.ssn; 
				end;			
			dobs_to_compare :=  
				module(project(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_DOB.full, opt))	
					// The 'input' dob:
					export dob := (unsigned8) l._dob;   
					// The ssn in the matching record:
					export dob_field := r.dob; 
				end;			
				return AutoStandardI.LIBCALL_PenaltyI_SSN.val(ssns_to_compare) + AutoStandardI.LIBCALL_PenaltyI_DOB.val(dobs_to_compare);
		end;
	
	export penalize_fullname(BatchServices.Layouts.layout_batch_in_for_penalties l, 
													 BatchShare.Layouts.ShareName r) :=
		function				
			names_to_compare :=  
				module(project(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))	
						
					// The 'input' name:
					export lastname       := l._name_last;   
					export middlename     := l._name_middle; 
					export firstname      := l._name_first;  

					// The name in the matching record:
					export lname_field    := r.name_first; 
					export mname_field    := r.name_middle; 
					export fname_field    := r.name_last; 					
					
					export allow_wildcard := FALSE;
				end;			
				return AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(names_to_compare);
		end;
	
		export penalize_address(BatchServices.Layouts.layout_batch_in_for_penalties l, 
														BatchShare.Layouts.ShareAddress r) :=
		function		
				addresses_to_compare := 
					module(project(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
					
						// The 'input' address:
						export predir         := l._predir;
						export prim_name      := l._prim_name;
						export prim_range     := l._prim_range;
						export postdir        := l._postdir;
						export addr_suffix    := l._addr_suffix;
						export sec_range      := l._sec_range;
						export p_city_name    := l._p_city_name;
						export st             := l._st;
						export z5             := l._z5;					
						
						// The address in the matching record:						
						export allow_wildcard := FALSE;					
						export city_field     := r.p_city_name;
						export city2_field    := '';
						export pname_field    := r.prim_name;
						export postdir_field  := r.postdir;
						export prange_field   := r.prim_range;
						export predir_field   := r.predir;
						export state_field    := r.st;
						export suffix_field   := r.addr_suffix;
						export zip_field      := r.z5;
						
						export useGlobalScope := FALSE;
					end;			
			return AutoStandardI.LIBCALL_PenaltyI_Addr.val(addresses_to_compare);
		end;	
		
	export appendBest(dataset(BatchShare.Layouts.ShareBest) ds_in) := 
	function
	
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
		dids 					:= dedup(sort(project(ds_in(did>0), doxie.layout_references), did));
		ds_best_recs 	:= doxie.best_records(dids, modAccess := mod_access);					

		BatchShare.Layouts.ShareBest xt_append_best(BatchShare.Layouts.ShareBest l, doxie.layout_best r) := 
		transform
			_validSubj 			:= r.did<>0;
			_addrSubj  			:= Address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name, r.suffix, r.postdir, r.unit_desig, r.sec_range);						
			self.did 				:= l.did,
			self.best_name	:= if(_validSubj, Address.NameFromComponents(r.fname, r.mname, r.lname, r.name_suffix), ''),							
			self.best_addr 	:= if(_validSubj, _addrSubj, ''),
			self.best_city 	:= if(_validSubj, r.city_name, ''),
			self.best_state := if(_validSubj, r.st, ''),
			self.best_zip  	:= if(_validSubj, r.zip, ''),
			self.best_dob 	:= if(_validSubj, r.dob, 0),
			self.best_ssn 	:= if(_validSubj, r.ssn, ''),
			self						:= l
		end;

		ds_in_with_best :=  join(ds_in, ds_best_recs, left.did = right.did,	
														 xt_append_best(left, right),
														 left outer, 
														 keep(1), limit(0));
														 
		return ds_in_with_best;			
	end;

  export integer GetPicklistErrors (iesp.person_picklist.t_PersonPickListResponse res_row) := function
	  exc := res_row._Header.Exceptions; // exceptions
	  msg := res_row.Messages;
    res_err := if (res_row.SubjectTotalCount = 0, Standard.errors.SEARCH.DID_NOT_FOUND, 0) |
               if (res_row.SubjectTotalCount > 1, Standard.errors.SEARCH.DID_MULTIPLE, 0) |
               if (exists (exc (code = 203)), Standard.errors.SEARCH.DID_TOO_MANY, 0) |
               if (exists (exc (code = 305)), Standard.errors.SEARCH.DID_RI_INPUT, 0) |
               if (exists (exc (code = -6)), Standard.errors.SEARCH.TIMEOUT, 0) |
               if (exists (msg (code = '305')), Standard.errors.SEARCH.DID_RI_OUTPUT, 0) |
               if (exists (msg (code = '306')), Standard.errors.SEARCH.DID_INPUT_DID, 0);

    res_general := if (exists (exc (code not in [-6, 203, 305])), Standard.errors.SEARCH.DID_GENERAL, 0);

    return  res_err | res_general;
  end;
	
	////////////////////////////////////////////////////////////////////////////////////////
	// Create the dataset of name, compound names, and name variations.
	////////////////////////////////////////////////////////////////////////////////////////
	SHARED fn_GetName(STRING name, BOOLEAN is_input, BOOLEAN is_mname, BOOLEAN do_pref, INTEGER i) := FUNCTION
	
		rec_name norm_names(rec_names le, INTEGER c, BOOLEAN is_input) := TRANSFORM
			SELF.name := CHOOSE(c, le.name, IF(le.name_2 <> '', le.name_2, SKIP));
			SELF.group_nums := le.group_nums;
			SELF.is_input := is_input;
		END;
		
		////////////////////////////////////////////////////////////////////////////////////////
		// Create a dataset of names and variations of the names.
		////////////////////////////////////////////////////////////////////////////////////////
		rec_names xform_names(rec_name le, 
													rec_name ri, 
													BOOLEAN is_input, 
													BOOLEAN is_mname, 
													BOOLEAN do_pref) := TRANSFORM
													
			name_1 := STD.Str.CleanSpaces(le.name);
			name_2 := STD.Str.CleanSpaces(ri.name);

			SELF.name := name_1 + name_2;
			// If do_pref is TRUE, the function was called to create first names (and middle names),
			// so we want to also create an entry for "preferred" name at the same time.  If
			// do_pref is FALSE, the function was called to create last names, so skip the 
			// step to get "preferred" names.
			SELF.name_2 := IF(do_pref, NID.PreferredFirstVersionedStr(name_1 + name_2, 2), '');
				
			SELF.is_mname := is_mname;
			SELF.is_input := is_input;
		  SELF.group_nums := [le.group_nums + ri.group_nums];
		END;		
		
		//////////// End Local transforms /////////////////////////////////////////////
		
		name_no_hyph := StringLib.StringToUpperCase(StringLib.StringFindReplace(name, '-', ' '));
				
		ds_name_exact := PROJECT(DATASET(StringLib.SplitWords(name_no_hyph,' ', FALSE),{string name}),
												TRANSFORM(rec_name,
													SELF.name := LEFT.name,
													SELF.is_mname := is_mname;
													// Keep a collection of group_nums that that represent all
													// of the name parts that make up a name.  Later when we concatenate
													// names, there will be more than one group_num in the set of 
													// group_nums.
													SELF.is_input := is_input;
													SELF.group_nums := [COUNTER + i]));				
											
		ds_name_pref := PROJECT(ds_name_exact,
											TRANSFORM(rec_name,
												// If do_pref is TRUE, we are working with first names and will need
												// to create nickname variations.  If do_pref is FALSE, we are working 
												// with last names and will need to create phonetic variations. 
												SELF.name := IF(do_pref, NID.PreferredFirstVersionedStr(STD.Str.CleanSpaces(LEFT.name), 2),
																				metaphonelib.DMetaPhone1(LEFT.name));
												SELF.is_mname := is_mname;
												SELF.is_input := is_input;
												SELF.group_nums := [LEFT.group_nums]));
																							
			// When names are concatenated, we need a dataset with exact names and with preferred 
			// (or phonetic) names.  If we use one or the other, we will end up with false non-hits.  
			// For example, 'MaryEllen' and 'Mary Ellen' won't match because the preferred name for 
			// 'MaryEllen' is 'MaryEllen', but the preferred name for 'Mary Ellen' is 'Mary Eleanor' 
			// when both name parts are run through the preferred name function separately.
			ds_names := ds_name_exact + ds_name_pref;
			ds_names_dedup := DEDUP(SORT(ds_names, name, group_nums), name);		
			
			////////////////////////////////////////////////////////////////////////////////////////
			// After concatenating, we will have a dataset containing exact names, variations of
			// names, and for compound names we will also have all combinations:
			//
			// name_1 exact
			// name_2 exact
			// name_1 exact + name_2 exact
			// name_2 exact + name_1 exact
			// name_1 variation
			// name_2 variation
			// name_1 variation + name_2 variation
			// name_2 variation + name_1 variation
			// name_1 exact + name_2 variation
			// name_1 variation + name_2 exact
			// name_2 exact + name_1 variation
			// name_2 variation + name_1 exact
			////////////////////////////////////////////////////////////////////////////////////////
			ds_name_concat := JOIN(ds_names_dedup, ds_names_dedup,
													LEFT.group_nums <> RIGHT.group_nums AND
													// Both names should be either exactly one character in
													// length, or both names should be greater than one 
													// character in length.  For example, we want to be able
													// to match on "DJ" & "D J", but we want to avoid concatenating
													// names like "D Joseph" because "JosephD" would be a match to
													// "Joseph" when compared using fn_PrefFirstMatch(). 
													(LENGTH(STD.Str.CleanSpaces(LEFT.name)) > 1 AND LENGTH(STD.Str.CleanSpaces(RIGHT.name)) > 1) OR
													(LENGTH(STD.Str.CleanSpaces(LEFT.name)) = 1 AND LENGTH(STD.Str.CleanSpaces(RIGHT.name)) = 1),
													xform_names(LEFT, RIGHT, is_input, is_mname, do_pref), ALL);

			ds_name_norm := NORMALIZE(ds_name_concat, 2, norm_names(LEFT, COUNTER, is_input));
			ds_name_norm_dedup := DEDUP(SORT(ds_name_norm, name, group_nums), name);

			// Eliminate matches for a first initial.  If ds_in_fname_exact is empty, there won't be
			// any matches for input fname.
			is_name_initial := LENGTH(STD.Str.CleanSpaces(name)) = 1;
			
			RETURN IF(is_name_initial, DATASET([], rec_name), ds_names_dedup + ds_name_norm_dedup);
		
	END;
	
	////////////////////////////////////////////////////////////////////////////////////////
	// Returns TRUE if all parts of an input fname are found in best fname or best mname, OR
	// if all parts of a best fname are found in input fname or input mname.
	//
	// Each name "part" will be assigned a group_num, and each name will have an associated
	// set of group_num that specify which group_num (name part) is contained within the 
	// name.  Compound names will have more than one group_num in their set of group_num.
	//
	// For example, the dataset of first names for the name "Mary Ann" would look something
	// like this:
	//
	// Mary, 1
	// Ann, 2
	// MaryAnn, 1,2
	// AnnMary, 2,1
	////////////////////////////////////////////////////////////////////////////////////////
	EXPORT fn_FuzzyFirstNameMatch(STRING in_fname, 
																STRING in_mname,
																STRING best_fname, 
																STRING best_mname) := FUNCTION
		////////////////////////////////////////////////////////////////////////////////////////
		// Copied from AutoKeyI.Functions.PrefFirsMatch() and modified to check both arguments
		// with one function call and to eliminate a first initial as a match.
		////////////////////////////////////////////////////////////////////////////////////////
		fn_PrefFirstMatch(STRING20 l, STRING20 r) := FUNCTION
			len_l := LENGTH(STD.Str.CleanSpaces(l));
			len_r := LENGTH(STD.Str.CleanSpaces(r));
			RETURN	(len_l > 1 AND len_r > 1) AND
							((NID.mod_PFirstTools.SubLinPFR(l, r) OR l[1..len_r] = r[1..len_l]) OR
							(NID.mod_pFirstTools.SubLinPFR(r, l) ));
		END;								 
		
		////////////////////////////////////////////////////////////////////////////////////////
		// Create all the input fname datasets
		////////////////////////////////////////////////////////////////////////////////////////
		ds_in_fname := fn_GetName(in_fname, TRUE, FALSE, TRUE, 0);
			
		ds_in_fname_match_groups := PROJECT(ds_in_fname,
																	TRANSFORM({UNSIGNED1 group_num}, 
																	SELF.group_num := LEFT.group_nums[1]));
																		
		ds_in_fname_match_groups_dedup := DEDUP(SORT(ds_in_fname_match_groups, -group_num), group_num);
			
		// Get the largest "group_num" that we have after creating a dataset of first names so when
		// we add middle names, the group_num will start at the next number.
		ds_in_fname_num := CHOOSEN(ds_in_fname_match_groups_dedup, 1)[1].group_num;
			
		ds_in_mname := fn_GetName(in_mname, TRUE, TRUE, TRUE, ds_in_fname_num);
		ds_best_fname := fn_GetName(best_fname, FALSE, FALSE, TRUE, 0);
			
		ds_best_fname_match_groups := PROJECT(ds_best_fname,
																		TRANSFORM({UNSIGNED1 group_num}, 
																		SELF.group_num := LEFT.group_nums[1]));
																		
		ds_best_fname_match_groups_dedup := DEDUP(SORT(ds_best_fname_match_groups, -group_num), group_num);
		ds_best_fname_num := CHOOSEN(ds_best_fname_match_groups_dedup, 1)[1].group_num;
			
		ds_best_mname := fn_GetName(best_mname, FALSE, TRUE, TRUE, ds_best_fname_num);

		ds_in_name_combos := ds_in_fname + ds_in_mname;
		ds_in_name_combos_dedup := DEDUP(SORT(ds_in_name_combos, name, group_nums), name);
			
		ds_best_name_combos := ds_best_fname + ds_best_mname;
		ds_best_name_combos_dedup := DEDUP(SORT(ds_best_name_combos, name, group_nums), name);
	
		////////////////////////////////////////////////////////////////////////////////////////
		// Combine the dataset of all variations of input fname & input mname (preferred name,
		// compound name, etc) with the dataset for every variation of best fname & best mname,
		// looking for matches.  mname is included because it's considered a match if input fname
		// matches best mname or input mname matches best fname.  
		////////////////////////////////////////////////////////////////////////////////////////

		ds_name_all_combos := JOIN(ds_in_name_combos_dedup, ds_best_name_combos_dedup,
														LEFT.name = RIGHT.name,
															TRANSFORM(rec_w_match,
																SELF.in_name := LEFT.name,
																SELF.best_name := RIGHT.name,
																SELF.is_in_mname := LEFT.is_mname;
																SELF.is_best_mname := RIGHT.is_mname;
																SELF.in_group_nums := [LEFT.group_nums],
																SELF.best_group_nums := [RIGHT.group_nums],
																SELF.is_match :=  LEFT.name <> '' AND RIGHT.name <> '' AND
																									// It's not a match if mname matches mname.
																									// mname must match a first name.
																									~(LEFT.is_mname AND RIGHT.is_mname)), FULL OUTER);
	
		////////////////////////////////////////////////////////////////////////////////////////
		// Now apply the PrefFirstName function to all non-matches.  This is done separately
		// because PrefFirstName() takes two names and returns a boolean, rather than simply
		// returning a name variation.
		////////////////////////////////////////////////////////////////////////////////////////
		ds_name_all_combos_2 := JOIN(ds_name_all_combos, ds_name_all_combos,
															LEFT.in_name <> RIGHT.best_name AND
															LEFT.in_name <> '' AND RIGHT.best_name <> '' AND
															COUNT(LEFT.in_group_nums) <= 1 AND COUNT(LEFT.best_group_nums) <= 1 AND
															COUNT(RIGHT.in_group_nums) <= 1 AND COUNT(RIGHT.best_group_nums) <= 1,
																TRANSFORM(rec_w_match,
																	SELF.in_name := LEFT.in_name,
																	SELF.best_name := RIGHT.best_name,
																	SELF.is_in_mname := LEFT.is_in_mname;
																	SELF.is_best_mname := RIGHT.is_best_mname;
																	SELF.in_group_nums := [LEFT.in_group_nums],
																	SELF.best_group_nums := [RIGHT.best_group_nums],
																	SELF.is_match := (fn_PrefFirstMatch(LEFT.in_name, RIGHT.best_name) AND
																									 ~(LEFT.is_in_mname AND RIGHT.is_best_mname) AND
																									 LEFT.in_name <> '' AND RIGHT.best_name <> '')), ALL);
			
		ds_name_all_combos_final := ds_name_all_combos + ds_name_all_combos_2;
		ds_matched := ds_name_all_combos_final(is_match = TRUE);
		
		////////////////////////////////////////////////////////////////////////////////////////
		// For all of the matches, check that all fname parts have been found or all mname 
		// parts have been found.  All name parts must be found in the other name (eg. 
		// if input fname = "mary ann", both "mary" and "ann" must be found to have a fuzzy
		// match.  This is done by looking for the group numbers in the dataset of matches.
		// To have a match, the group numbers of all fname parts of the input fname or all
		// parts of the best fname must be found in the matched records.
		////////////////////////////////////////////////////////////////////////////////////////

		// dataset of group_nums of input fname parts
		ds_in_fname_matches := JOIN(ds_in_fname_match_groups_dedup, ds_matched,
															LEFT.group_num IN RIGHT.in_group_nums,
															LEFT ONLY, ALL);
		
		// dataset of group_nums of input mname parts
		ds_in_mname_match_groups := PROJECT(ds_in_mname, 
																	TRANSFORM({UNSIGNED1 group_num}, 
																		SELF.group_num := LEFT.group_nums[1]));
																			
		ds_in_mname_match_groups_dedup := DEDUP(SORT(ds_in_mname_match_groups, -group_num), group_num);

		ds_in_mname_matches := JOIN(ds_in_mname_match_groups_dedup, ds_matched,
															LEFT.group_num IN RIGHT.in_group_nums,
															LEFT ONLY, ALL);
														
		// dataset of group_nums of best fname parts	
		ds_best_fname_matches := JOIN(ds_best_fname_match_groups_dedup, ds_matched,
															LEFT.group_num IN RIGHT.best_group_nums,
															LEFT ONLY, ALL);
																
		// dataset of group_nums of best mname parts		
		ds_best_mname_match_groups := PROJECT(ds_best_mname, 
																		TRANSFORM({UNSIGNED1 group_num}, 
																			SELF.group_num := LEFT.group_nums[1]));
																				
		ds_best_mname_match_groups_dedup := DEDUP(SORT(ds_best_mname_match_groups, -group_num), group_num);
			
		ds_best_mname_matches := JOIN(ds_best_mname_match_groups_dedup, ds_matched,
																LEFT.group_num IN RIGHT.best_group_nums,
																LEFT ONLY, ALL);
			
		// If no dataset exists after we have searched for the group_num(s) in the other 
		// names, and the dataset from which the group_num(s) were derived from, we have
		// a match.
		is_match := (EXISTS(ds_in_fname) AND ~EXISTS(ds_in_fname_matches)) OR 
								(EXISTS(ds_in_mname) AND ~EXISTS(ds_in_mname_matches)) OR
								(EXISTS(ds_best_fname) AND ~EXISTS(ds_best_fname_matches)) OR
								(EXISTS(ds_best_mname) AND ~EXISTS(ds_best_mname_matches));					
								
		RETURN is_match;
			
	END;
	
	////////////////////////////////////////////////////////////////////////////////////////
	// Returns TRUE if all parts of an input lname are found in best lname or best mname, OR
	// if all parts of a best lname are found in input lname or input mname.
	//
	// Each name "part" will be assigned a group_num, and each name will have an associated
	// set of group_num that specify which group_num (name part) is contained within the 
	// name.  Compound names will have more than one group_num in their set of group_num.
	//
	// For example, the dataset of first names for the name "Mary Ann" would look something
	// like this:
	//
	// Jones, 1
	// Smith, 2
	// JonesSmith, 1,2
	// SmithJones, 2,1
	////////////////////////////////////////////////////////////////////////////////////////
	EXPORT fn_FuzzyLastNameMatch(STRING in_mname,
															 STRING in_lname,
															 STRING best_mname,
															 STRING best_lname) := FUNCTION
										
		ds_in_lname := fn_GetName(in_lname, TRUE, FALSE, FALSE, 0);
			
		ds_in_lname_match_groups := PROJECT(ds_in_lname,
																	TRANSFORM({UNSIGNED1 group_num}, 
																	SELF.group_num := LEFT.group_nums[1]));
																		
		ds_in_lname_match_groups_dedup := DEDUP(SORT(ds_in_lname_match_groups, -group_num), group_num);
			
		// Get the largest "group_num" that we have after creating a dataset of last names so when
		// we add middle names, the group_num will start at the next number.
		ds_in_lname_num := CHOOSEN(ds_in_lname_match_groups_dedup, 1)[1].group_num;
			
		ds_in_mname := fn_GetName(in_mname, TRUE, TRUE, FALSE, ds_in_lname_num);
		ds_best_lname := fn_GetName(best_lname, FALSE, FALSE, FALSE, 0);
			
		ds_best_lname_match_groups := PROJECT(ds_best_lname,
																		TRANSFORM({UNSIGNED1 group_num}, 
																		SELF.group_num := LEFT.group_nums[1]));
																		
		ds_best_lname_match_groups_dedup := DEDUP(SORT(ds_best_lname_match_groups, -group_num), group_num);
		ds_best_lname_num := CHOOSEN(ds_best_lname_match_groups_dedup, 1)[1].group_num;
			
		ds_best_mname := fn_GetName(best_mname, FALSE, TRUE, FALSE, ds_best_lname_num);

		ds_in_name_combos := ds_in_lname + ds_in_mname;
		ds_in_name_combos_dedup := DEDUP(SORT(ds_in_name_combos, name, group_nums), name);
			
		ds_best_name_combos := ds_best_lname + ds_best_mname;
		ds_best_name_combos_dedup := DEDUP(SORT(ds_best_name_combos, name, group_nums), name);
			
		////////////////////////////////////////////////////////////////////////////////////////
		// Combine the dataset of all variations of input lname & input mname (phonetic name,
		// compound name, etc) with the dataset for every variation of best lname & best mname,
		// looking for matches.  mname is included because it's considered a match if input lname
		// matches best mname or input mname matches best lname.  
		////////////////////////////////////////////////////////////////////////////////////////

		ds_name_all_combos := JOIN(ds_in_name_combos, ds_best_name_combos,
														LEFT.name = RIGHT.name,
															TRANSFORM(rec_w_match,
																SELF.in_name := LEFT.name,
																SELF.best_name := RIGHT.name,
																SELF.is_in_mname := LEFT.is_mname;
																SELF.is_best_mname := RIGHT.is_mname;
																SELF.in_group_nums := [LEFT.group_nums],
																SELF.best_group_nums := [RIGHT.group_nums],
																SELF.is_match :=  LEFT.name <> '' AND RIGHT.name <> '' AND
																									// It's not a match if mname matches mname.
																									// mname must match a first name.
																									~(LEFT.is_mname AND RIGHT.is_mname)), FULL OUTER);
	
		ds_matched := ds_name_all_combos(is_match = TRUE);

		////////////////////////////////////////////////////////////////////////////////////////
		// For all of the matches, check that all lname parts have been found or all mname 
		// parts have been found.  All name parts must be found in the other name (eg. 
		// if input fname = "mary ann", both "mary" and "ann" must be found to have a fuzzy
		// match.  This is done by looking for the group numbers in the dataset of matches.
		// To have a match, the group numbers of all fname parts of the input fname or all
		// parts of the best fname must be found in the matched records.
		////////////////////////////////////////////////////////////////////////////////////////
			
		// dataset of group_nums of input lname parts
		ds_in_lname_matches := JOIN(ds_in_lname_match_groups_dedup, ds_matched,
															LEFT.group_num IN RIGHT.in_group_nums,
															LEFT ONLY, ALL);
		
		// dataset of group_nums of input mname parts
		ds_in_mname_match_groups := PROJECT(ds_in_mname, 
																	TRANSFORM({UNSIGNED1 group_num}, 
																		SELF.group_num := LEFT.group_nums[1]));
																			
		 ds_in_mname_match_groups_dedup := DEDUP(SORT(ds_in_mname_match_groups, -group_num), group_num);

		ds_in_mname_matches := JOIN(ds_in_mname_match_groups_dedup, ds_matched,
															LEFT.group_num IN RIGHT.in_group_nums,
															LEFT ONLY, ALL);
														
		// dataset of group_nums of best fname parts	
		ds_best_lname_matches := JOIN(ds_best_lname_match_groups_dedup, ds_matched,
																LEFT.group_num IN RIGHT.best_group_nums,
																LEFT ONLY, ALL);
																
		// dataset of group_nums of best mname parts		
		ds_best_mname_match_groups := PROJECT(ds_best_mname, 
																		TRANSFORM({UNSIGNED1 group_num}, 
																			SELF.group_num := LEFT.group_nums[1]));
																				
		ds_best_mname_match_groups_dedup := DEDUP(SORT(ds_best_mname_match_groups, -group_num), group_num);
			
		ds_best_mname_matches := JOIN(ds_best_mname_match_groups_dedup, ds_matched,
																LEFT.group_num IN RIGHT.best_group_nums,
																LEFT ONLY, ALL);

		// If no dataset exists after we have searched for the group_num(s) in the other 
		// names, and the dataset from which the group_num(s) were derived from, we have
		// a match.
		is_match := (EXISTS(ds_in_lname) AND ~EXISTS(ds_in_lname_matches)) OR 
								(EXISTS(ds_in_mname) AND ~EXISTS(ds_in_mname_matches)) OR
								(EXISTS(ds_best_lname) AND ~EXISTS(ds_best_lname_matches)) OR
								(EXISTS(ds_best_mname) AND ~EXISTS(ds_best_mname_matches));					
				
		RETURN is_match;
		
	END;
end;