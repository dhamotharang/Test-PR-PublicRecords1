import doxie,ut;
export fetch_header_stcityflname(
	gl_rewrites.person_interfaces.i__fetch_header_stcityflname in_parms) :=
		function
			i := doxie.Key_Header_StCityLFName;
			wi := doxie.Key_Header_Wild_StCityLFName;

			first_fil := (in_parms.city_value != '' AND in_parms.lname_value != '') AND
										// To Prevent extra work
										(in_parms.zip_value=[] AND length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND
										in_parms.phone_value='');


			Mac_Header_Indexing.Gen_withdobfilt(wi,gen_fil,FALSE)
			Mac_Header_Indexing.lname_fname(wi,lname_fil,fname_fil)
			Mac_Header_Indexing.state(wi,state_fil)
			city_fil := wi.city_code=hash((qstring25)in_parms.city_value);

			index_lev1(boolean keyedcount) := PROJECT(wi(first_fil,
																									keyed(city_fil),
																									keyed(state_fil),   
																									keyed(lname_fil),
																									keyed(fname_fil),   
																									keyedcount OR gen_fil),doxie.layout_references);


			Fetch_lev1 := LIMIT(LIMIT(index_lev1(false)
															, 100000, FAIL(203, doxie.ErrorCodes(203)), keyed),
													doxie.Limit_FetchUnkeyed,   FAIL(203, doxie.ErrorCodes(203)));

			Mac_Header_Indexing.Gen_withdobfilt(i,gen_fil2,FALSE)
			Mac_Header_Indexing.phon(i,phon_fil2)
			Mac_Header_Indexing.lname_fname(i,lname_fil2,fname_fil2)
			Mac_Header_Indexing.pref(i,pref_fil2)
			Mac_Header_Indexing.state(i,state_fil2)
			city_fil2 := i.city_code=hash((qstring25)in_parms.city_value);
					 
			index_Lev2 := project(
								i(first_fil,
									keyed(city_fil2),
									keyed(state_fil2),   
									keyed(phon_fil2),// OR lname_value=''),
									WILD(lname),
									WILD(pfname),
									WILD(fname),
									(lname<>in_parms.lname_value),
									(pref_fil2 OR LENGTH(TRIM(in_parms.fname_value))<2),
									(fname_fil2 OR in_parms.nicknames),
									nofold(gen_fil2)),doxie.layout_references);
				
			Fetch_Lev2 := doxie.fn_FetchLimitLimitSkipFail(index_Lev2,100000,doxie.Limit_FetchLev2Unkeyed,exists(Fetch_Lev1),203);
				
			return
				choosen(Fetch_Lev1 &
								IF(~in_parms.isCRS AND in_parms.phonetics,
									 Fetch_Lev2),
								doxie.Limit_FetchUnkeyed);					
		end;