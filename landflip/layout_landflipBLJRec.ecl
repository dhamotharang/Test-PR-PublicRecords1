EXPORT layout_landflipBLJRec
	:=
		RECORD
			string2   state_cd;											//STATE - Two char state code
			string3   cnty_cd;											//FIPS_CODE - Last three chars of fips_cd
			string18  county_name;									//COUNTY_NAME
			string30	muni_cd;											//Not sure what to make of this?
			string45  apn_num;											//APNT_OR_PIN_NUMBER
			string80  buyer;												//BUYER
			string10	str_num;											//PRIM_RANGE
			string2		str_dir;											//
			string30	str_name;
			string10	str_suffix;
			string5		str_post_dir;
			string6		str_unit;
			string41  str_city;											//property_address_citystatezip
			string10	str_zip9;											//property_address_citystatezip
			string4		str_zip_4;
		END
		;