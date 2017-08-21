EXPORT layout_CleanedBLJRec
	:=
		RECORD
			string2   state_cd;											//STATE - Two char state code
			string3   cnty_cd;											//FIPS_CODE - Last three chars of fips_cd
			string18  county_name;									//COUNTY_NAME
			string30	muni_cd;											//Not sure what to make of this?
			string45  apn_num;											//APNT_OR_PIN_NUMBER
			string80  buyer;												//BUYER
			string76  str_info;											//PROPERTY_FULL_STREET_ADDRESS+PROPERTY_ADDRESS_UNIT_NUMBER
			string41  str_city;											//property_address_citystatezip
			string10	str_zip9;											//property_address_citystatezip
			string182 clean_address;								//Address Returned from cleaner
		END
		;