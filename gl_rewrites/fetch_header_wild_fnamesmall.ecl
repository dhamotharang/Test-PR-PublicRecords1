import doxie,ut;
export Fetch_Header_Wild_FnameSmall(
	gl_rewrites.person_interfaces.i__fetch_header_wild_fnamesmall in_parms) :=
		function
			i := doxie.Key_Header_Wild_FnameSmall;
										
			first_fil := in_parms.lname_wild_val='' AND in_parms.fname_wild_val<>'' AND in_parms.ssn_value='';

			Mac_Header_Indexing.gen_withdobfilt(i,gen_fil,TRUE)

			state_fil := i.st='' OR i.st=in_parms.state_value OR in_parms.state_value='';
			zip_fil := i.zip=0 OR in_parms.zip_value=[] OR i.zip IN in_parms.zip_value;
			pname_fil := i.prim_name='' OR in_parms.pname_wild_val='' OR stringlib.StringWildMatch(i.prim_name, in_parms.pname_wild_val, true);


			refcount :=
			RECORD
				doxie.layout_references;
				i.fname_count;
			END;

			index_Lev1(boolean keyedcount) := project(i(first_fil,
													keyed(fname[1..3]=in_parms.fname_wild_val[1..3]) AND
													stringlib.StringWildMatch(fname, in_parms.fname_wild_val, true),
													keyed(state_fil) AND
													keyed(zip_fil) AND
													nofold(pname_fil) AND
													gen_fil), refcount);

			Fetch_Lev1_fail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev1_nofail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, SKIP, keyed)
													, doxie.Limit_FetchUnkeyed  , SKIP);

			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev1_nofail, Fetch_Lev1_fail)(did<>0);

			// Would be better if the fail were in the transform, but Roxie bug
			doxie.layout_references check_count(refcount le) :=
			TRANSFORM
				SELF.did := IF(le.fname_count>20000,SKIP,le.did);
			END;
				
			p_final := PROJECT(Fetch_Lev1, check_count(LEFT));
			return IF(COUNT(Fetch_Lev1) > COUNT(p_final),
																									FAIL(doxie.layout_references,11,doxie.ErrorCodes(11)),
																									p_final);

																							
		END;