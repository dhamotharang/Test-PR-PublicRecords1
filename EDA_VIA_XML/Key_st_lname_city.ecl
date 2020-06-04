import gong_Neustar, doxie, ut;

input_recs := gong_Neustar.File_Gong_Full_Prepped_For_Keys((listing_type_res = 'R') AND (TRIM(name_last)<>''));

Layout_extra_city := RECORD
	STRING25	city;
	gong_Neustar.Layout_Gong_DID;			//CCPA-22 Add did/global_sid/record_sid fields
END;

Layout_extra_city addOrig(recordof(input_recs) l) := TRANSFORM
	SELF.city := l.p_city_name;
	SELF := l;
END;

orig_cities := PROJECT(input_recs, addOrig(LEFT));

Layout_extra_city addExtra(recordof(input_recs) l, integer c) := TRANSFORM
	SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
	SELF := l;
END;

extra_cities := NORMALIZE(input_recs(TRIM(z5)<>''),
							 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
					  	 addExtra(LEFT, COUNTER));

all_cities := DEDUP(SORT(orig_cities + extra_cities(TRIM(city)<>''), RECORD), RECORD);

export Key_st_lname_city := 
       index(all_cities,
             {string2 st := st,
						  string20 lname := name_last,
							string25 city := city},
             {all_cities},
		   '~thor_data400::key::gong_eda_st_lname_city_' + doxie.Version_SuperKey);
