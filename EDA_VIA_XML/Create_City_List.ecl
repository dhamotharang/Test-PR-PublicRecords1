export Create_City_List(string25 city, string3 st, string5 zip, unsigned2 radius) := FUNCTION

STRING5 centroid_zip := MAP(TRIM(zip)<>'' => zip,
														ZipLib.CityToZip5(st, city));

zip_list := DATASET(ZipLib.ZipsWithinRadius(centroid_zip, radius), RECORD INTEGER4 zip END);

EDA_VIA_XML.Layout_City_List getCities(RECORD INTEGER4 zip END l, INTEGER c) := TRANSFORM
	SELF.city := StringLib.StringExtract(ZipLib.ZipToCities((STRING)l.zip),c+1);
	SELF.st := ZipLib.ZipToState2((STRING)l.zip);
END;

cities_list := NORMALIZE(zip_list,
												 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities((STRING)LEFT.zip),1),
												 getCities(LEFT, COUNTER));

return MAP(st='ALL' => EDA_VIA_XML.All_States,
				   TRIM(centroid_zip)='' => DATASET([{city, st}], EDA_VIA_XML.Layout_City_List),
					 DEDUP(SORT(cities_list, RECORD), RECORD));

END;