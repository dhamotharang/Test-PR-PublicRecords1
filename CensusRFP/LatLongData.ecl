import	Advo;

advo_file := Advo.Files().File_Cleaned_Base;

rLatLong := RECORD
		string2	 st;
		STRING5  zip;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  predir;
		STRING2  postdir;
		STRING10 prim_range;
		string10      geo_lat;
		string11      geo_long;
END;

EXPORT LatLongData :=
				PROJECT(
					advo_file,
					TRANSFORM(
					rLatLong,
					SELF.geo_lat := LEFT.geo_lat,
					SELF.geo_long := LEFT.geo_long,
					SELF := LEFT
				)
			 ) : PERSIST('~thor::census_rfp::latlong');
