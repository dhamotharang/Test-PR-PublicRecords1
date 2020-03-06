import gong_Neustar, doxie, ut, NID;

input_recs := gong_Neustar.File_Gong_Full_Prepped_For_Keys((listing_type_res = 'R') AND (TRIM(name_last)<>'') AND (TRIM(name_first)<>''));

Layout_extra := RECORD
	STRING20	fname;
	STRING25	city;
	gong_Neustar.Layout_Gong_DID;			//CCPA-22 Add did/global_sid/record_sid fields
END;

Layout_extra addOrig(recordof(input_recs) l) := TRANSFORM
	SELF.fname := '';
	SELF.city := l.p_city_name;
	SELF := l;
END;

orig_cities := PROJECT(input_recs, addOrig(LEFT));

Layout_extra addExtra(recordof(input_recs) l, integer c) := TRANSFORM
	SELF.fname := '';
	SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
	SELF := l;
END;

extra_cities := NORMALIZE(input_recs(TRIM(z5)<>''),
							 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
					  	 addExtra(LEFT, COUNTER));

all_cities := DEDUP(SORT(orig_cities + extra_cities(TRIM(city)<>''), RECORD), RECORD);

Layout_extra addNames(Layout_extra l, integer c) := TRANSFORM
	SELF.fname := IF(c=1,l.name_first,NID.PreferredFirstNew(l.name_first));
	SELF := l;
END;

with_names := NORMALIZE(all_cities,
							 IF(NID.PreferredFirstNew(LEFT.name_first)<>LEFT.name_first,2,1),
					  	 addNames(LEFT, COUNTER));

export Key_st_lname_fname_city := 
       index(with_names,
             {string2 st := st;
							string20 lname := name_last;
						  string20 fname := fname;
							string25 city := city},
             {with_names},
		   '~thor_data400::key::gong_eda_st_lname_fname_city_' + doxie.Version_SuperKey);
