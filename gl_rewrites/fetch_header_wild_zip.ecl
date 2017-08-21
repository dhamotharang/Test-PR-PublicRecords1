import doxie,ut;
export Fetch_Header_Wild_Zip(
	gl_rewrites.person_interfaces.i__fetch_header_wild_zip in_parms) :=
		function
			i := doxie.Key_Header_Wild_Zip;

			first_fil := (in_parms.lname_wild_val<>'' AND in_parms.zip_value<>[]) AND
										// To Prevent extra work
										(length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND in_parms.phone_value='');

			Mac_Header_Indexing.gen_withdobfilt(i,gen_fil,TRUE)
			Mac_Header_Indexing.mname_yob_ssn4(i,mname_fil,yob_fil,ssn4_fil)

			zip1_fil := i.zip = (integer4)in_parms.zip_val OR i.zip = (integer4)in_parms.city_zip_value;
			zip_fil := i.zip IN in_parms.zip_value;
			lname_fil := keyed(i.lname[1..3]=in_parms.lname_wild_val[1..3]) and 
									 stringlib.StringWildMatch(i.lname, in_parms.lname_wild_val, true);
			fname_fil := in_parms.fname_wild_val = '' or 
									 stringlib.StringWildMatch(i.fname, in_parms.fname_wild_val, true);

			index_Lev1(boolean keyedcount) := PROJECT(i(
				first_fil,
				keyed(zip1_fil),
				lname_fil,
				fname_fil, 
				mname_fil,
				yob_fil,
				ssn4_fil or in_parms.ssn_value='',
				keyedcount OR gen_fil), doxie.layout_references);


			Fetch_Lev1_fail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)))
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev1_nofail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, SKIP)
													, doxie.Limit_FetchUnkeyed  , SKIP);

			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev1_nofail, Fetch_Lev1_fail);

			index_Lev2(boolean keyedcount) := PROJECT(i(
				first_fil,
				keyed(zip_fil AND zip <> (integer4)in_parms.zip_val),
				lname_fil,
				fname_fil, 
				mname_fil,
				yob_fil,
				ssn4_fil,
				keyedcount OR gen_fil), doxie.layout_references);

												
			Fetch_Lev2_fail := LIMIT(LIMIT(index_Lev2(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)))
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev2_nofail := LIMIT(LIMIT(index_Lev2(false)
														, 100000, SKIP)
													, doxie.Limit_FetchUnkeyed  , SKIP);

			Fetch_Lev2 := IF(in_parms.noFail, Fetch_Lev2_nofail, Fetch_Lev2_fail);

			RETURN 	
				choosen(Fetch_Lev1 &
								IF(~in_parms.isCRS AND in_parms.zipradius_value<>0,
									 Fetch_Lev2),
								doxie.Limit_FetchUnkeyed);		 

		END;
				 