export Addr :=
RECORD
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string4  addr_suffix ;
	string2  postdir ;
	string10 unit_desig ;
	string8  sec_range ;
	string25 v_city_name ;
	string2  st ;
	string5  zip5 ;
	string4  zip4 ;
	string2  addr_rec_type := '';
	string2  fips_state;
	string3  fips_county;
	string10 geo_lat ;
	string11 geo_long ;
	string4  cbsa ;
	string7  geo_blk ;
	string1  geo_match ;
	string4  err_stat;
END;