import gong, doxie;

input_recs := gong.file_daily_full((listing_type_res = 'R') AND (TRIM(name_last)<>'') AND (TRIM(name_first)<>''));

Layout_extra := RECORD
	STRING20	fname;
	STRING25	city;
	gong.Layout_bscurrent_raw;
END;

Layout_extra addOrig(gong.Layout_bscurrent_raw l) := TRANSFORM
	SELF.fname := '';
	SELF.city := l.p_city_name;
	SELF := l;
END;

orig_cities := PROJECT(input_recs, addOrig(LEFT));

Layout_extra addExtra(gong.Layout_bscurrent_raw l, integer c) := TRANSFORM
	SELF.fname := '';
	SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
	SELF := l;
END;

extra_cities := NORMALIZE(input_recs(TRIM(z5)<>''),
							 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
					  	 addExtra(LEFT, COUNTER));

all_cities := DEDUP(SORT(orig_cities + extra_cities(TRIM(city)<>''), RECORD), RECORD);

Layout_extra addNames(Layout_extra l, integer c) := TRANSFORM
	SELF.fname := IF(c=1,l.name_first,datalib.preferredFirst(l.name_first));
	SELF := l;
END;

with_names := NORMALIZE(all_cities,
							 IF(datalib.preferredFirst(LEFT.name_first)<>LEFT.name_first,2,1),
					  	 addNames(LEFT, COUNTER));

export Key_st_lname_fname_city_add := 
       index(with_names,
             {string2 st := st;
							string20 lname := name_last;
						  string20 fname := fname;
							string25 city := city},
             {with_names},
		   '~thor_data400::key::gong_eda_st_lname_fname_city_add_' + doxie.Version_SuperKey, OPT);
