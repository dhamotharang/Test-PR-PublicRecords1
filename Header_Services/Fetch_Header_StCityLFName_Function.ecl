import doxie, dx_header, NID;
i := dx_header.key_StCityLFName();

doxie.layout_references xt(i r) := TRANSFORM
                                        SELF := r;
                                 END;
pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);
 
export Fetch_Header_StCityLFName_Function(string20 fname_value
												 ,string20 lname_value
												 ,boolean phonetics
												 ,boolean nicknames
												 ,string2 state_value
												 ,string25 city_value
													) 
:= MODULE
	shared ids := i(city_code in doxie.Make_CityCodes(city_value).rox,
			st = state_value, 
			(dph_lname=metaphonelib.DMetaPhone1(lname_value)),
			((lname=(STRING20)lname_value OR phonetics)),
			(pfe(pfname,fname_value) OR pfname[1..length(trim(fname_value))]=(STRING20)fname_value OR fname_value =''),
			(fname[1..length(trim(fname_value))]=fname_value OR nicknames OR fname_value = '') 
		   );

	shared idsp := project(LIMIT(LIMIT(ids , 100000, SKIP, keyed), 9000, SKIP), xt(LEFT));
	EXPORT lafn := if(count(idsp) != 0
						, false
  					, if(count(ids) = 0
							, false
							, true
							)
						);
	EXPORT outrec := idsp;

	END;
  