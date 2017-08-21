import doxie,ut;
export Fetch_Header_Name(
	gl_rewrites.person_interfaces.i__fetch_header_name in_parms) :=
		function
			i := doxie.Key_Header_Name;
			wi := doxie.Key_Header_Wild_Name;
			i2:=doxie.Key_Header_Name_alt;

			first_fil := (in_parms.lname_value<>'') AND 
										// To Prevent extra work
										(in_parms.zip_value=[] AND length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND
										in_parms.phone_value='' AND in_parms.city_value='' AND in_parms.state_value='');

			boolean just_name := in_parms.other_lname_value1 = '' and 
							 in_parms.rel_fname_value1 = '' and
							 in_parms.find_year_low = 0 and 
							 in_parms.find_year_high = 0  and 
							 in_parms.ssn_value = '';

			maxres := if(just_name, 1000, doxie.Limit_FetchUnkeyed);

			Mac_Header_indexing.gen_withdobfilt(wi,gen_fil_w,TRUE)
			Mac_Header_Indexing.lname_fname(wi,lname_fil_w,fname_fil_w)
			Mac_Header_Indexing.mname_yob_ssn4(wi,mname_fil_w,yob_fil_w,ssn4_fil_w)


			index_Lev1(boolean keyedcount) := project(wi(first_fil,
																									keyed(lname_fil_w),
																									keyed(fname_fil_w), 
																									keyedcount OR nofold(mname_fil_w),
																									keyedcount OR nofold(yob_fil_w),
																									keyedcount OR nofold(ssn4_fil_w or  in_parms.ssn_value=''),
																									keyedcount OR nofold(gen_fil_w)), doxie.layout_references);

			Fetch_Lev1_fail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev1_nofail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, SKIP, keyed)
													, doxie.Limit_FetchUnkeyed  , SKIP);
													
													
			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev1_nofail, Fetch_Lev1_fail);

			Mac_Header_indexing.gen_withdobfilt(i,gen_fil)
			Mac_Header_indexing.pref(i,pref_fil)
			Mac_Header_Indexing.phon(i,phon_fil)
			Mac_Header_Indexing.lname_fname(i,lname_fil,fname_fil)
			Mac_Header_Indexing.mname_yob_ssn4(i,mname_fil,yob_fil,ssn4_fil)

			temp_found_mod := module(gl_rewrites.penalty_interfaces.i__found_name)
				export lname_field := i.lname;
				export fname_field := i.fname;
				export mname_field := i.minit;
			end;
			no_phonetics_index_Lev2 := project(
										 i(first_fil,
										keyed(phon_fil),
										keyed(lname_fil),
										keyed(pref_fil OR LENGTH(TRIM(in_parms.fname_value))<2),
										WILD(fname),
										WILD(minit),
			// need to weed out records in advance that won't meet the score threshold on name parameters only									
										(in_parms.Nicknames OR fname_fil), 
										nofold(mname_fil),
										FN_Tra_Penalty_Name(in_parms,temp_found_mod) < in_parms.score_threshold_value,
										nofold(yob_fil),
										nofold(ssn4_fil or  in_parms.ssn_value=''),
										nofold(gen_fil))
												, doxie.layout_references);
												

			Mac_Header_indexing.gen_withdobfilt(i2,gen_fil2)
			Mac_Header_indexing.pref(i2,pref_fil2)
			Mac_Header_Indexing.phon (i2,phon_fil2)
			Mac_Header_Indexing.lname_fname(i2,lname_fil2,fname_fil2)
			Mac_Header_Indexing.mname_yob_ssn4(i2,mname_fil2,yob_fil2,ssn4_fil2)

			temp_found_mod2 := module(gl_rewrites.penalty_interfaces.i__found_name)
				export lname_field := i2.lname;
				export fname_field := i2.fname;
				export mname_field := i2.minit;
			end;
			phonetics_index_Lev2 := project(
										 i2(first_fil,
										keyed(phon_fil2),
										keyed(pref_fil2 OR LENGTH(TRIM(in_parms.fname_value))<2),
										WILD(fname),
										WILD(lname),
										WILD(minit),
			// need to weed out records in advance that won't meet the score threshold on name parameters only									
										(in_parms.Nicknames OR fname_fil2), 
										nofold(mname_fil2),
										FN_Tra_Penalty_Name(in_parms,temp_found_mod2) < in_parms.score_threshold_value,
										nofold(yob_fil2),
										nofold(ssn4_fil2 or  in_parms.ssn_value=''),
										nofold(gen_fil2))
												, doxie.layout_references);
												
			no_phonetics_Fetch_Lev2 := doxie.fn_FetchLimitLimitSkipFail(no_phonetics_index_Lev2,100000,doxie.Limit_FetchLev2Unkeyed,exists(Fetch_Lev1) or in_parms.noFail,203,
																										 in_parms.ln_branded_value);
			phonetics_Fetch_Lev2 := doxie.fn_FetchLimitLimitSkipFail(phonetics_index_Lev2,100000,doxie.Limit_FetchLev2Unkeyed,exists(Fetch_Lev1) or in_parms.noFail,203,
																										 in_parms.ln_branded_value);

			return	
				choosen(Fetch_Lev1 &
							 if(~in_parms.isCRS and in_parms.Phonetics and LENGTH(TRIM(in_parms.fname_value))>1,phonetics_fetch_lev2,if(
									~in_parms.isCRS and (in_parms.Nicknames and in_parms.fname_value!=''),no_phonetics_fetch_lev2))
								,doxie.Limit_FetchUnkeyed);
		END;