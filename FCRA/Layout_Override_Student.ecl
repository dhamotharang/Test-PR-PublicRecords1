export Layout_Override_Student := RECORD
	INTEGER8  KEY;
	STRING9   SSN;
	UNSIGNED6 DID;
	STRING8   PROCESS_DATE;
	STRING8   DATE_FIRST_SEEN;
	STRING8   DATE_LAST_SEEN;
	STRING8   DATE_VENDOR_FIRST_REPORTED;
	STRING8   DATE_VENDOR_LAST_REPORTED;
	STRING40  FULL_NAME;
	STRING20  FIRST_NAME;
	STRING20  LAST_NAME;
	STRING30  ADDRESS_1;
	STRING30  ADDRESS_2;
	STRING16  CITY;
	STRING2   STATE;
	STRING5   ZIP;
	STRING4   ZIP_4;
	STRING4   CRRT_CODE;
	STRING2   DELIVERY_POINT_BARCODE;
	STRING1   ZIP4_CHECK_DIGIT;
	STRING1   ADDRESS_TYPE_CODE;
	STRING30  ADDRESS_TYPE;
	STRING3   COUNTY_NUMBER;
	STRING9   COUNTY_NAME;
	STRING1   GENDER_CODE;
	STRING6   GENDER;
	STRING2   AGE;
	STRING6   BIRTH_DATE;
	STRING8   DOB_FORMATTED;
	STRING10  TELEPHONE;
	STRING2   CLASS;
	STRING2   COLLEGE_CLASS;
	STRING50  COLLEGE_NAME;
	STRING1		COLLEGE_MAJOR;
	STRING1   COLLEGE_CODE;
	STRING20  COLLEGE_CODE_EXPLODED;
	STRING1   COLLEGE_TYPE;
	STRING25  COLLEGE_TYPE_EXPLODED;
	STRING11  HEAD_OF_HOUSEHOLD_FIRST_NAME;
	STRING1   HEAD_OF_HOUSEHOLD_GENDER_CODE;
	STRING6   HEAD_OF_HOUSEHOLD_GENDER;
	STRING1   INCOME_LEVEL_CODE;
	STRING20  INCOME_LEVEL;
	STRING1   FILE_TYPE;
	STRING5   title;
	STRING20  fname;
	STRING20  mname;
	STRING20  lname;
	STRING5   name_suffix;
	STRING3   name_score;
	STRING10  prim_range;
	STRING2   predir;
	STRING28  prim_name;
	STRING4   addr_suffix;
	STRING2   postdir;
	STRING10  unit_desig;
	STRING8   sec_range;
	STRING25  p_city_name;
	STRING25  v_city_name;
	STRING2   st;
	STRING5   z5;
	STRING4   zip4;
	STRING4   cart;
	STRING1   cr_sort_sz;
	STRING4   lot;
	STRING1   lot_order;
	STRING2   dpbc;
	STRING1   chk_digit;
	STRING2   rec_type;
	STRING2   ace_fips_st;
	STRING3   fips_county;
	STRING10  geo_lat;
	STRING11  geo_long;
	STRING4   msa;
	STRING7   geo_blk;
	STRING1   geo_match;
	STRING4   err_stat;
	STRING20  flag_file_id;
END;