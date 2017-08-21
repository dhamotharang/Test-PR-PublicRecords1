import doxie,ut;
export Fetch_Header_Zip(
	gl_rewrites.person_interfaces.i__fetch_header_zip in_parms) :=
		function
			i := doxie.Key_Header_Zip;
			wi := doxie.Key_Header_Wild_Zip;

			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=datalib.preferredfirst(r);


			first_fil := (in_parms.lname_value<>'' AND in_parms.zip_value<>[]) AND
										// To Prevent extra work
										(length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND in_parms.phone_value='');


			Mac_Header_Indexing.gen_withdobfilt(wi,gen_fil,TRUE)
			Mac_Header_Indexing.Zip(wi,zip_fil)
			Mac_Header_Indexing.lname_fname(wi,lname_fil,fname_fil)
			Mac_Header_Indexing.mname_yob_ssn4(wi,mname_fil,yob_fil,ssn4_fil)
			zip1_fil := wi.zip = (integer4)in_parms.zip_val OR wi.zip = (integer4)in_parms.city_zip_value;

			index_Lev1(boolean keyedcount) := PROJECT(wi(
				first_fil,
				keyed(zip1_fil),
				keyed(lname_fil),
				keyed(fname_fil), 
				keyed(mname_fil),
				keyed(yob_fil),
				keyed(ssn4_fil or in_parms.ssn_value=''),
				keyedcount OR gen_fil), doxie.layout_references);


			Fetch_Lev1_fail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
													, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev1_nofail := LIMIT(LIMIT(index_Lev1(false)
														, 100000, SKIP, keyed)
													, doxie.Limit_FetchUnkeyed  , SKIP);

			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev1_nofail, Fetch_Lev1_fail);

			Mac_Header_Indexing.gen_withdobfilt(i,gen_fil2,TRUE)
			Mac_Header_Indexing.pref(i,pref_fil2)
			Mac_Header_Indexing.Zip(i,zip_fil2)
			Mac_Header_Indexing.phon(i,phon_fil2)
			Mac_Header_Indexing.lname_fname(i,lname_fil2,fname_fil2)
			Mac_Header_Indexing.mname_yob_ssn4(i,mname_fil2,yob_fil2,ssn4_fil2)

			index_Lev2(boolean keyedcount) := PROJECT(i(
				first_fil,
				keyed(zip_fil2 AND zip <> (integer4)in_parms.zip_val),
				keyed(phon_fil2),
				keyed(lname_fil2),
				keyed(pref_fil2 OR LENGTH(TRIM(in_parms.fname_value))<2),
				keyed(fname_fil2 OR in_parms.nicknames), 
				keyed(mname_fil2),
				keyed(yob_fil2),
				keyed(ssn4_fil2 or in_parms.ssn_value=''),
				keyedcount OR gen_fil2), doxie.layout_references);

												
			Fetch_Lev2 := doxie.fn_FetchLimitLimitSkipFail(index_Lev2(false),100000,doxie.Limit_FetchLev2Unkeyed,exists(Fetch_Lev1) or in_parms.noFail,203);

			Fetch_Lev3 := project(LIMIT(LIMIT(
										 i(first_fil,
										keyed(zip_fil2),
										keyed(phon_fil2),
										WILD(lname),
										WILD(pfname),
										WILD(fname),
										WILD(minit),
										(lname<>in_parms.lname_val),
										(pref_fil2 OR LENGTH(TRIM(in_parms.fname_value))<2),
										(fname_fil2 OR in_parms.nicknames), 
										(mname_fil2),
										nofold(yob_fil2),
										nofold(ssn4_fil2 or in_parms.ssn_value=''),
										nofold(gen_fil2)
													 ) , 100000, SKIP, keyed, count)
													, doxie.Limit_FetchLev2Unkeyed  , SKIP)
												, doxie.layout_references);

			RETURN 	
				choosen(Fetch_Lev1 &
								IF(~in_parms.isCRS AND in_parms.zipradius_value<>0,
									 Fetch_Lev2) &
								IF(~in_parms.isCRS AND in_parms.phonetics,
									 Fetch_Lev3),
								doxie.Limit_FetchUnkeyed);		 

		END;
				 