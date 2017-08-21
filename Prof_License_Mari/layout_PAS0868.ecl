EXPORT layout_PAS0868 := MODULE

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
			
	export active := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING40 	FIRST_NAME,
				STRING30 	MIDDLE_NAME,
				STRING40 	LAST_NAME,
				STRING10 	SUFFIX,
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

	export inactive := 
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

	export active_1 := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING40 	FIRST_NAME,
				STRING30 	MIDDLE_NAME,
				STRING40 	LAST_NAME,
				STRING10 	SUFFIX,
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
			
	export inactive_1 := 
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

	export active_2 := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING100	FULL_NAME,		//first m last
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
			
	export inactive_2 := 
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

	export active_3 := 
			RECORD
				STRING20 	RECORD_NUM,
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
			
	export inactive_3 := 
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
			
	export inactive_4 := 
			RECORD
				STRING20 	RECORD_NUM,
				STRING100	FULL_NAME,			//first m last
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
			
END;