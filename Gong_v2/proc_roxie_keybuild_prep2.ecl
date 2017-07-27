import Address, Gong_v2;

Address.MAC_Multi_City(Gong_v2.proc_roxie_keybuild_prep,p_city_name,z5,multiCityfile);

Layout_extra := record
multiCityfile;
string20 fname;

end;

Layout_extra addNames(multiCityfile l, integer c) := TRANSFORM
	SELF.fname := IF(c=1,l.name_first,datalib.preferredFirst(l.name_first));
	SELF := l;
END;

outfile := NORMALIZE(multiCityfile,
							 IF(datalib.preferredFirst(LEFT.name_first)<>LEFT.name_first,2,1),
					  	 addNames(LEFT, COUNTER)): persist(Gong_v2.thor_cluster +'temp::roxie_keyprep');

export proc_roxie_keybuild_prep2 := outfile;