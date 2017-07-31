﻿IMPORT AID;
export layout_american_student_base_v2 := record

	integer8        KEY;
	string9					SSN;
	unsigned6       DID;
	string8         PROCESS_DATE;
	string8         DATE_FIRST_SEEN;
	string8         DATE_LAST_SEEN;
	string8         DATE_VENDOR_FIRST_REPORTED;
	string8         DATE_VENDOR_LAST_REPORTED;
	string1					HISTORICAL_FLAG;
	string60        FULL_NAME;
	string25        FIRST_NAME;
	string25        LAST_NAME;
	string64        ADDRESS_1;
	string64        ADDRESS_2;
	string26        CITY;
	string2         STATE;
	string5         ZIP;
	string4         ZIP_4;
	string4         CRRT_CODE;
	string2         DELIVERY_POINT_BARCODE;
	string1         ZIP4_CHECK_DIGIT;
	string1         ADDRESS_TYPE_CODE;
	string30        ADDRESS_TYPE;
	string3         COUNTY_NUMBER;
	string26        COUNTY_NAME;
	string1         GENDER_CODE;
	string10				GENDER;
	string2         AGE;
	string6         BIRTH_DATE;
	string8					DOB_FORMATTED;
	string10        TELEPHONE;
	string2         CLASS;
	string2         COLLEGE_CLASS;
	string50        COLLEGE_NAME;
	string50        LN_COLLEGE_NAME;
	string1					COLLEGE_MAJOR;
	string4					NEW_COLLEGE_MAJOR;
	string1         COLLEGE_CODE;
	string20  			COLLEGE_CODE_EXPLODED;
	string1         COLLEGE_TYPE;
	string25				COLLEGE_TYPE_EXPLODED;
	string40        HEAD_OF_HOUSEHOLD_FIRST_NAME;
	string1         HEAD_OF_HOUSEHOLD_GENDER_CODE;
	string10				HEAD_OF_HOUSEHOLD_GENDER;
	string1         INCOME_LEVEL_CODE;
	string20				INCOME_LEVEL;
	string1         NEW_INCOME_LEVEL_CODE;
	string20				NEW_INCOME_LEVEL;
	string1         FILE_TYPE;

	string1					tier;
	string1					school_size_code;
	string1					competitive_code;
	string1					tuition_code;
	
	string5 				title;
	string20 				fname;
	string20 				mname;
	string20 				lname;
	string5 				name_suffix;
	string3 				name_score;
	AID.Common.xAID	RawAID;
	string10  			prim_range;
	string2   			predir;
	string28  			prim_name;
	string4   			addr_suffix;
	string2   			postdir;
	string10  			unit_desig;
	string8   			sec_range;
	string25  			p_city_name;
	string25  			v_city_name;
	string2   			st;
	string5   			z5;
	string4   			zip4;
	string4   			cart;
	string1   			cr_sort_sz;
	string4   			lot;
	string1   			lot_order;
	string2   			dpbc;
	string1   			chk_digit;
	string2   			rec_type;
	string5 				county;
	string2   			ace_fips_st;
	string3					fips_county;
	string10  			geo_lat;
	string11  			geo_long;
	string4   			msa;
	string7   			geo_blk;
	string1   			geo_match;
	string4   			err_stat;
	//Added for Shell 5.0 project 6/3/13
	STRING5					tier2;
	//Added for OKC Student List 7/10/17 DF-19691
	STRING5					CollegeID := '';
	STRING4					CollegeUpdate := '';
	string2					source := '';

end;