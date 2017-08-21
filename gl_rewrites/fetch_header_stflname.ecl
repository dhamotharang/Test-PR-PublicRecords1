import doxie,ut;
export Fetch_Header_StFLName(
	gl_rewrites.person_interfaces.i__fetch_header_stflname in_parms) :=
		function
			i := doxie.Key_Header_StFnameLname;
			// use wild key for level 1 fetch 
			wi := doxie.Key_Header_Wild_StFnameLname;

			first_fil := (in_parms.lname_value != '') AND
										// To Prevent extra work
										(in_parms.zip_value=[] AND length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND
										in_parms.phone_value='' AND in_parms.city_value='');

			Mac_Header_Indexing.gen_withdobfilt(wi,gen_fil,TRUE)
			Mac_Header_Indexing.state(wi,state_fil)
			Mac_Header_Indexing.lname_fname(wi,lname_fil,fname_fil)
			Mac_Header_Indexing.mname_yob_ssn4(wi,mname_fil,yob_fil,ssn4_fil)


			index_lev1(boolean keyedcount) := PROJECT(wi(first_fil,
																									keyed(state_fil),   
																									keyed(lname_fil),
																									keyed(fname_fil),
																									keyed(mname_fil or in_parms.non_exclusion_value),
																									keyed(yob_fil),
																									keyed(ssn4_fil or LENGTH(TRIM(in_parms.ssn_value))<>4),
																									keyedcount OR gen_fil),doxie.layout_references);

			Fetch_Lev1_fail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev1_nofail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, SKIP, keyed)
													, doxie.Limit_FetchUnkeyed  , SKIP);
													
			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev1_nofail, Fetch_Lev1_fail);

			index_lev1_noMN(boolean keyedcount) := PROJECT(wi(first_fil,
																									keyed(state_fil),   
																									keyed(lname_fil),
																									keyed(fname_fil),
																									WILD(minit),
																									keyed(yob_fil),
																									keyed(ssn4_fil or LENGTH(TRIM(in_parms.ssn_value))<>4),
																									keyedcount OR gen_fil),doxie.layout_references);
																									
			Fetch_Lev1_noMN := LIMIT(LIMIT(index_Lev1_noMN(false)
														, 100000, SKIP, keyed)
													, doxie.Limit_FetchUnkeyed  , SKIP);

			Mac_Header_Indexing.gen_withdobfilt(i,gen_fil2,TRUE)
			Mac_Header_Indexing.pref(i,pref_fil2)
			Mac_Header_Indexing.state(i,state_fil2)
			Mac_Header_Indexing.phon(i,phon_fil2)
			Mac_Header_Indexing.lname_fname(i,lname_fil2,fname_fil2)
			Mac_Header_Indexing.mname_yob_ssn4(i,mname_fil2,yob_fil2,ssn4_fil2)
				 
			index_Lev2 := project(
								i(first_fil,
									keyed(state_fil2),   
									keyed(phon_fil2),
									WILD(lname),
									WILD(pfname),
									WILD(fname),
									WILD(minit),
									(lname<>in_parms.lname_value),
									(pref_fil2 OR LENGTH(TRIM(in_parms.fname_value))<2),
									(fname_fil2 OR in_parms.nicknames),
									(mname_fil2 OR in_parms.non_exclusion_value),
									nofold(yob_fil2),
									nofold(ssn4_fil2 or LENGTH(TRIM(in_parms.ssn_value))<>4),
									nofold(gen_fil2)), doxie.layout_references);

			// only do the contingent fetch if necessary						
			Fetch_Lev1_cont := IF(~exists(Fetch_Lev1) and ~in_parms.non_exclusion_value, Fetch_Lev1_noMN);
			// output a message indicating that removal of MN would produce header results
			IF(exists(Fetch_Lev1_cont), ut.outputMessage(ut.constants_MessageCodes.REMOVE_MNAME));

			// only fail the Fetch_Lev2 if neither Fetch_Lev1 nor the contingent Fetch produce results
			Fetch_Lev2 := doxie.fn_FetchLimitLimitSkipFail(index_Lev2,100000,doxie.Limit_FetchLev2Unkeyed,exists(Fetch_Lev1) or exists(Fetch_Lev1_cont) or in_parms.noFail,203);
														 
			return choosen(Fetch_Lev1 & IF(~in_parms.isCRS AND in_parms.Phonetics, Fetch_Lev2), doxie.Limit_FetchUnkeyed);			
		END;

