import doxie,ut;
export Fetch_Header_Wild_Street(
	gl_rewrites.person_interfaces.i__fetch_header_wild_street in_parms) :=
		FUNCTION
			i := doxie.Key_Header_Wild_StreetZipName;

			boolean just_addr := in_parms.lname_wild_val = '' and in_parms.fname_wild_val = '';
			ec := 	if(just_addr, 11, 203);

			first_fil := (in_parms.pname_value<>'' AND in_parms.zip_value<>[]) AND
										// To Prevent extra work
										(length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND in_parms.phone_value='');

			Mac_Header_Indexing.gen_nodobfilt(i,gen_fil)
			Mac_Header_Indexing.zip1(i,zip1_fil)
			Mac_Header_Indexing.zip(i,zip_fil)

			pname_fil := keyed(i.prim_name[1..3]=in_parms.pname_wild_val[1..3]) and 
												 stringlib.StringWildMatch(i.prim_name, in_parms.pname_wild_val, true);
			lname_fil := in_parms.lname_wild_val='' OR stringlib.StringWildMatch(i.lname, in_parms.lname_wild_val, true);
			fname_fil := in_parms.fname_wild_val='' OR stringlib.StringWildMatch(i.fname, in_parms.fname_wild_val, true);
			prange_fil := in_parms.prange_value='' OR in_parms.addr_loose OR i.prim_range=in_parms.prange_value;
			prange_postfil := ((~in_parms.addr_range OR (INTEGER)i.prim_range >= in_parms.prange_beg_value AND (INTEGER)i.prim_range <= in_parms.prange_end_value) AND
								 not in_parms.addr_wild OR Stringlib.StringWildMatch(i.prim_range, in_parms.prange_wild_value, TRUE));

			index_Lev1(boolean keyedcount) := PROJECT(i(
				first_fil,
				pname_fil,
				keyed(zip1_fil),
				lname_fil,
				fname_fil, 
				keyed(prange_fil),
				keyedcount OR prange_postfil,
				keyedcount OR gen_fil), doxie.layout_references);

			maxres := if(just_addr, 1000, doxie.Limit_FetchUnkeyed);


			Fetch_Lev1_fail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev1_nofail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, SKIP, keyed)
													, doxie.Limit_FetchUnkeyed  , SKIP);

			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev1_nofail, Fetch_Lev1_fail);

			index_Lev2(boolean keyedcount) := PROJECT(i(
				first_fil,
				pname_fil,
				keyed(zip_fil AND zip NOT IN [(integer4)in_parms.zip_val,(integer4)in_parms.city_zip_value]),
				lname_fil,
				fname_fil, 
				keyed(prange_fil),
				keyedcount OR prange_postfil,
				keyedcount OR gen_fil), doxie.layout_references);

			maxres2 := if(just_addr, 1000, doxie.Limit_FetchLev2Unkeyed);

			Fetch_Lev2 := doxie.fn_FetchLimitLimitSkipFail(index_Lev2(false),100000,maxres2,exists(Fetch_Lev1) or in_parms.noFail,ec);
				//here we are going to fail (rather than skip) when lev1 = 0 and lev2 exceeds

			zips := dataset(in_parms.zip_value,{unsigned3 z});
			boolean tooloose := count(zips) > 250 and in_parms.lname_value = '' and in_parms.prange_value = '';//RR in big zip radius with no lname gave problems
			loosefail := Fail(Fetch_Lev2, 11, doxie.ErrorCodes(11));

			return	
				choosen(Fetch_Lev1 &
								IF(~in_parms.isCRS AND in_parms.zipradius_value<>0,
									 if(tooloose, loosefail, Fetch_Lev2)),
								doxie.Limit_FetchUnkeyed);
								
		END;
				