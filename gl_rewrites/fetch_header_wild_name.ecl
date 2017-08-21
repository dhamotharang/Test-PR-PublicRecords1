import doxie,ut;
export Fetch_Header_Wild_Name(
	gl_rewrites.person_interfaces.i__fetch_header_wild_name in_parms) :=
		function
			i := doxie.Key_Header_Wild_Name;
										
			first_fil := (in_parms.lname_wild_val<>'') AND 
										// To Prevent extra work
										(in_parms.zip_value=[] AND length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND
										in_parms.phone_value='' AND in_parms.city_value='' AND in_parms.state_value='');

			Mac_Header_Indexing.gen_withdobfilt(i,gen_fil,TRUE)
			Mac_Header_Indexing.mname_yob_ssn4(i,mname_fil,yob_fil,ssn4_fil)

			lname_fil := keyed(i.lname[1..3]=in_parms.lname_wild_val[1..3]) and 
									 stringlib.StringWildMatch(i.lname, in_parms.lname_wild_val, true);
			fname_fil := in_parms.fname_wild_val='' or 
									 stringlib.StringWildMatch(i.fname, in_parms.fname_wild_val, true);

			index_Lev1(boolean keyedcount) := project(i(first_fil,
													lname_fil,
													fname_fil, 
													keyedcount OR nofold(mname_fil),
													keyedcount OR nofold(yob_fil),
													keyedcount OR nofold(ssn4_fil or in_parms.ssn_value=''),
													keyedcount OR nofold(gen_fil)), doxie.layout_references);



			Fetch_Lev1_fail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)))
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));

											
			Fetch_Lev1_nofail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, SKIP)
													, doxie.Limit_FetchUnkeyed  , SKIP);
																		
			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev1_nofail, Fetch_Lev1_fail);
										
			return Fetch_Lev1;							
										
		END;