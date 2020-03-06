EXPORT layout_PAS0868 := MODULE
	export active := 
			RECORD
				STRING20 	RECORD_NUM, //lICENSE NUMBER
				STRING40 	FIRST_NAME,
				STRING30 	MIDDLE_NAME,
				STRING40 	LAST_NAME,
				STRING10 	SUFFIX,
				STRING100 FULL_NAME,
				STRING100 ADDRESS1,
				STRING100 ADDRESS2,
				STRING100 ADDRESS3,
				STRING50 	CITY_1,					//Containg City State info
				STRING2		STATE,
				STRING10	ZIP,
				STRING40	COUNTY,
				STRING10 	ISSUE_DATE,			//License Date, fmt MM/DD/YYYY
				STRING10	EXP_DATE,			  //License expiration date, fmt MM/DD/YYYY
				// STRING		ID,
				// STRING		TYP,
				STRING		STATUS
			END;

	//inactive_1 - id_900_type_12001_inactive_format_B
	//           id_900_type_12005_inactive_format_B
	//           id_900_type_12010_inactive_format_B
	//           id_900_type_12030_inactive_format_B
	export inactive_1 := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING40 	FIRST_NAME,
				STRING30 	MIDDLE_NAME,
				STRING40 	LAST_NAME,
				STRING10 	SUFFIX,
				STRING50 	CITY_1,					//Containg City State info
				STRING2		STATE,
				STRING10	ZIP,
				STRING40	COUNTY,
				STRING10 	ISSUE_DATE,			//License Date, fmt MM/DD/YYYY
				STRING10	EXP_DATE,			  //License expiration date, fmt MM/DD/YYYY
				STRING		ID,
				STRING		TYP,
				STRING		STATUS
			END;
			

  //inactive_2 - id_1200_type_12001_inactive_format_B
	//             id_1200_type_12270_A-E_inactive_format_B
	//             id_1200_type_12270_F-J_inactive_format_B
	//             id_1200_type_12270_K-N_inactive_format_B
	//             id_1200_type_12270_O-T_inactive_format_B
	//             id_1200_type_12270_U-Z_inactive_format_B
	//             id_1200_type_12310_inactive_format_B
				export inactive_2 := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING40 	FIRST_NAME,
				STRING30 	MIDDLE_NAME,
				STRING40 	LAST_NAME,
				STRING10 	SUFFIX,
				STRING100 ORG_NAME,
				STRING50 	CITY_1,					//Containg City State info
				STRING2		STATE,
				STRING10	ZIP,
				STRING40	COUNTY,
				STRING10 	ISSUE_DATE,			//License Date, fmt MM/DD/YYYY
				STRING10	EXP_DATE,			  //License expiration date, fmt MM/DD/YYYY
				STRING		ID,
				STRING		TYP,
				STRING		STATUS
			END;
	
		//inactive_3 - id_1200_type_12190_inactive_format_A
				export inactive_3 := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING100	FULL_NAME,		//first m last
				STRING50 	CITY_1,					//Containg City State info
				STRING2		STATE,
				STRING10	ZIP,
				STRING40	COUNTY,
				STRING10 	ISSUE_DATE,			//License Date, fmt MM/DD/YYYY
				STRING10	EXP_DATE,			  //License expiration date, fmt MM/DD/YYYY
				STRING		ID,
				STRING		TYP,
				STRING		STATUS
			END;		

	//inactive_3 - id_1200_type_12150_inactive_format_A
	//             id_1200_type_12200_inactive_format_A
	export inactive_4 := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING100 ORG_NAME,
				STRING50 	CITY_1,					//Containg City State info
				STRING2		STATE,
				STRING10	ZIP,
				STRING40	COUNTY,
				STRING10 	ISSUE_DATE,			//License Date, fmt MM/DD/YYYY
				STRING10	EXP_DATE,			  //License expiration date, fmt MM/DD/YYYY
				STRING		ID,
				STRING		TYP,
				STRING		STATUS
			END;
			
	export common := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING40 	FIRST_NAME,
				STRING30 	MIDDLE_NAME,
				STRING40 	LAST_NAME,
				STRING10 	SUFFIX,
				STRING100	FULL_NAME,			//first m last
				STRING100 ORG_NAME,
				STRING100 ADDRESS1,
				STRING100 ADDRESS2,
				STRING100 ADDRESS3,
				STRING50 	CITY_1,					//Containg City State info
				STRING2		STATE,
				STRING10	ZIP,
				STRING40	COUNTY,
				STRING10 	ISSUE_DATE,			//License Date, fmt MM/DD/YYYY
				STRING10	EXP_DATE,			  //License expiration date, fmt MM/DD/YYYY
				STRING		ID,
				STRING		TYP,
				STRING		STATUS
			END;
			
END;