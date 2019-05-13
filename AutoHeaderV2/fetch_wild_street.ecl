import ut,doxie,dx_header,AutoheaderV2,lib_stringlib,lib_ziplib;

export fetch_wild_street (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function
	_row := ds_search[1];
	_options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

	temp_isCRS := _options.isCRS;
	temp_fname_wild_val := _row.tname.fname;
	temp_lname_value := _row.tname.lname;
	temp_lname_wild_val := _row.tname.lname; //same as temp_lname_value
	temp_prange_value := _row.taddress.prim_range;
	temp_prange_beg_value := _row.taddress.prange_beg;
	temp_prange_end_value := _row.taddress.prange_end;
	temp_prange_wild_value := _row.taddress.prange_wild;
	temp_pname_value := _row.taddress.prim_name;
	temp_pname_wild_val := _row.taddress.prim_name;
	temp_addr_range := _row.taddress._range;
	temp_addr_wild := _row.taddress._wild;
	temp_addr_loose := temp_addr_range or temp_addr_wild;
	temp_zip_val := _row.taddress.zip5;
	temp_zip_value := _row.taddress.zip_set;
	temp_zipradius_value := _row.taddress.zip_radius;
	temp_city_zip_value := ziplib.CityToZip5(_row.taddress.state, _row.taddress.city);
	temp_phone_value := _row.tphone.phone10;
	temp_did_value := _row.did;
	temp_ssn_value := _row.tssn.ssn;
	temp_prev_state_val1 := _row.taddress.state_prev_1;
	temp_prev_state_val2 := _row.taddress.state_prev_2;
	temp_other_lname_value1 := _row.tname.lname_other;
	temp_other_city_value := _row.taddress.city_other;
	temp_rel_fname_value1 := _row.tname.fname_rel_1;
	temp_rel_fname_value2 := _row.tname.fname_rel_2;
	temp_lookup_value := _options._lookup;	

	i := dx_header.key_wild_StreetZipName();

	boolean just_addr := temp_lname_wild_val = '' and temp_fname_wild_val = '';
	ec := 	if(just_addr, 11, 203);

	first_fil := (temp_pname_value<>'' AND temp_zip_value<>[]) AND
								// To Prevent extra work
								(length(trim(temp_ssn_value))<>9 AND temp_did_value=0 AND temp_phone_value='');
	
	gen_fil := AutoheaderV2.MAC_indexing.gen_filt(i) AND (temp_lookup_value=0 OR ut.bit_test(i.lookups, temp_lookup_value));
	AutoheaderV2.MAC_indexing.zip1(i,zip1_fil)
	AutoheaderV2.MAC_indexing.zip(i,zip_fil)

	pname_fil := keyed(i.prim_name[1..3]=temp_pname_wild_val[1..3]) and 
										 stringlib.StringWildMatch(i.prim_name, temp_pname_wild_val, true);
	lname_fil := temp_lname_wild_val='' OR stringlib.StringWildMatch(i.lname, temp_lname_wild_val, true);
	fname_fil := temp_fname_wild_val='' OR stringlib.StringWildMatch(i.fname, temp_fname_wild_val, true);
	prange_fil := temp_prange_value='' OR temp_addr_loose OR i.prim_range=temp_prange_value;
	prange_postfil := ((~temp_addr_range OR (INTEGER)i.prim_range >= temp_prange_beg_value AND (INTEGER)i.prim_range <= temp_prange_end_value) AND
						 not temp_addr_wild OR Stringlib.StringWildMatch(i.prim_range, temp_prange_wild_value, TRUE));

	index_Lev1 := PROJECT(i(
												pname_fil,
												keyed(zip1_fil),
												lname_fil,
												fname_fil, 
												keyed(prange_fil),
												prange_postfil,
												gen_fil), 
												transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_STREET));

	maxres := if(just_addr, ut.limits.FETCH_JUST_ADDR, ut.limits.FETCH_UNKEYED);

	Fetch_Lev1 := AutoheaderV2.functions.FetchConstraints(index_Lev1,ut.limits.FETCH_KEYED,maxRes,no_fail,203,,AutoheaderV2.Constants.FetchHit.W_STREET);

	index_Lev2 := PROJECT(i(
												pname_fil,
												keyed(zip_fil AND zip NOT IN [(integer4)temp_zip_val,(integer4)temp_city_zip_value]),
												lname_fil,
												fname_fil, 
												keyed(prange_fil),
												prange_postfil,
												gen_fil), 
												transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_STREET));

	maxres2 := if(just_addr, ut.limits.FETCH_JUST_ADDR, ut.limits.FETCH_LEV2_UNKEYED);

	Fetch_Lev2 := AutoheaderV2.functions.FetchConstraints(index_Lev2(false),ut.limits.FETCH_KEYED,maxres2,exists(Fetch_Lev1) or no_fail,ec,,AutoheaderV2.Constants.FetchHit.W_STREET);
		//here we are going to fail (rather than skip) when lev1 = 0 and lev2 exceeds

	zips := dataset(temp_zip_value,{unsigned3 z});
	boolean tooloose := count(zips) > 250 and temp_lname_value = '' and temp_prange_value = '';//RR in big zip radius with no lname gave problems
	loosefail := Fail(Fetch_Lev2, 11, doxie.ErrorCodes(11));

	res := choosen(Fetch_Lev1 &
								IF(~temp_isCRS AND temp_zipradius_value<>0,
									 if(tooloose, if(not EXISTS(Fetch_Lev1), loosefail), Fetch_Lev2)),
								ut.limits.FETCH_UNKEYED);
	
	final_res := if(first_fil,
									 if(exists(res),
											res,
											AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_STREET, AutoheaderV2.Constants.STATUS._NOT_FOUND)),
									AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_STREET, AutoheaderV2.Constants.Status._DATA));
	return final_res;					
end;
