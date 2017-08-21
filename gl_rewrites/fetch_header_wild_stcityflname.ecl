import doxie,ut;
export fetch_header_wild_stcityflname(
	gl_rewrites.person_interfaces.i__fetch_header_wild_stcityflname in_parms) :=
		function
			i := doxie.Key_Header_Wild_StCityLFName;

			first_fil := (in_parms.city_value != '' AND in_parms.lname_value != '') AND
										// To Prevent extra work
										(in_parms.zip_value=[] AND length(trim(in_parms.ssn_value))<>9 AND in_parms.did_value='' AND
										in_parms.phone_value='');

			Mac_Header_Indexing.Gen_withdobfilt(i,gen_fil,FALSE)

			city_fil := i.city_code=hash((qstring25)in_parms.city_value);
			state_fil := i.st=in_parms.state_value OR in_parms.state_value='';
			lname_fil := keyed(i.lname[1..3]=in_parms.lname_value[1..3]) and 
									 stringlib.StringWildMatch(i.lname, in_parms.lname_wild_val, true);
			fname_fil := in_parms.fname_wild_val = '' OR
									 stringlib.StringWildMatch(i.fname, in_parms.fname_wild_val, true); 

			index_lev1(boolean keyedcount) := PROJECT(i(first_fil,
																									keyed(city_fil),
																									keyed(state_fil),  
																									lname_fil,
																									fname_fil,   
																									keyedcount OR gen_fil),doxie.layout_references);


			Fetch_lev1 := LIMIT(LIMIT(index_lev1(false)
															, 100000, FAIL(203, doxie.ErrorCodes(203))),
													doxie.Limit_FetchUnkeyed,   FAIL(203, doxie.ErrorCodes(203)));
					 
				
			return 
					choosen(Fetch_Lev1, doxie.Limit_FetchUnkeyed);					
		end;