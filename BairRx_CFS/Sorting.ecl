import BairRx_Common;

EXPORT Sorting := MODULE
		
	SHARED STYPE_NUM := 0;	
	SHARED STYPE_STR := 1;	
	
	export isOfficerFID(unsigned fid) := fid=19 or fid=20 or fid=29 or fid=30 or (fid>=33 and fid<=35) or fid=38 or fid=40;
	export isCFSFID(unsigned fid) := not isOfficerFID(fid); 
	
	EXPORT tvalue(unsigned2 fID) := CHOOSE(fID,
		STYPE_STR, //  0  => R.EVENT_NUMBER               CFS
		STYPE_STR, //  1  => R.CALLER_ADDRESS             CFS
		STYPE_STR, //  2  => R.PLACE_NAME                 CFS
		STYPE_STR, //  3  => R.LOCATION_TYPE              CFS
		STYPE_STR, //  4  => R.DISTRICT                   CFS
		STYPE_STR, //  5  => R.BEAT                       CFS
		STYPE_STR, //  6  => R.HOW_RECEIVED               CFS
		STYPE_STR, //  7  => R.INITIAL_TYPE               CFS
		STYPE_STR, //  8  => R.FINAL_TYPE                 CFS
		STYPE_STR, //  9  => R.INCIDENT_CODE              CFS
		STYPE_STR, //  10 => R.INCIDENT_PROGRESS          CFS
		STYPE_STR, //  11 => R.CITY                       CFS
		STYPE_STR, //  12 => R.CONTACTING_OFFICER         CFS
		STYPE_STR, //  13 => R.COMPLAINANT                CFS
		STYPE_STR, //  14 => R.CURRENT_PHONE              CFS
		STYPE_STR, //  15 => R.STATUS                     CFS
		STYPE_STR, //  16 => R.APARTMENT_NUMBER           CFS
		STYPE_STR, //  17 => R.GEOCODED                   CFS
		STYPE_STR, //  18 => R.ACCURACY                   CFS
		STYPE_STR, //  19 => R.UNIT                       Officer
		STYPE_STR, //  20 => R.OFFICER_NAME               Officer
		STYPE_STR, //  21 => R.DATA_PROVIDER_NAME         CFS
		STYPE_NUM, //  22 => R.X_COORDINATE               CFS
		STYPE_NUM, //  23 => R.Y_COORDINATE               CFS
		STYPE_NUM, //  24 => R.COMPLAINANT_X_COORDINATE   CFS
		STYPE_NUM, //  25 => R.COMPLAINANT_Y_COORDINATE   CFS
		STYPE_NUM, //  26 => R.INITIAL_UCR_GROUP          CFS
		STYPE_NUM, //  27 => R.FINAL_UCR_GROUP            CFS
		STYPE_NUM, //  28 => R.TOTAL_MINUTES_ON_CALL      CFS
		STYPE_NUM, //  29 => R.MINUTES_ON_CALL            Officer
		STYPE_NUM, //  30 => R.MINUTES_RESPONSE           Officer
		STYPE_NUM, //  31 => R.DATE_TIME_RECEIVED         CFS
		STYPE_NUM, //  32 => R.DATE_TIME_ARCHIVED         CFS
		STYPE_NUM, //  33 => R.DATE_TIME_DISPATCHED       Officer
		STYPE_NUM, //  34 => R.DATE_TIME_CLEARED          Officer
		STYPE_NUM, //  35 => R.DATE_TIME_ENROUTE          Officer
		STYPE_STR, //  36 => R.PRIORITY1                  CFS
		STYPE_STR, //  37 => R.ADDRESS                    CFS
		STYPE_STR, //  38 => R.PRIMARY_OFFICER            Officer
		STYPE_STR, //  39 => R.CALL_TAKER                 CFS
		STYPE_NUM, //  40 => R.DATE_TIME_ARRIVED          Officer
		STYPE_STR, //  41 => R.COMPLAINANT_ADDRESS        CFS
		STYPE_STR, //  42 => R.DISPOSITION                CFS
		STYPE_STR, //  43 => R.REPORT_NUMBER              CFS
		STYPE_NUM, //  44 => dist                         CFS
		STYPE_NUM);


  //
	// String values for CFS key
	EXPORT svalueCFS(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			R.EVENT_NUMBER,          //  0 CFS
			R.CALLER_ADDRESS,        //  1 CFS
			R.PLACE_NAME,            //  2 CFS
			R.LOCATION_TYPE,         //  3 CFS
			R.DISTRICT,              //  4 CFS
			R.BEAT,                  //  5 CFS
			R.HOW_RECEIVED,          //  6 CFS
			R.INITIAL_TYPE,          //  7 CFS
			R.FINAL_TYPE,            //  8 CFS
			R.INCIDENT_CODE,         //  9 CFS
			R.INCIDENT_PROGRESS,     // 10 CFS
			R.CITY,                  // 11 CFS
			R.CONTACTING_OFFICER,    // 12 CFS
			R.COMPLAINANT,           // 13 CFS
			R.CURRENT_PHONE,         // 14 CFS
			R.STATUS,                // 15 CFS
			R.APARTMENT_NUMBER,      // 16 CFS
			R.GEOCODED,              // 17 CFS
			R.ACCURACY,              // 18 CFS
			'',                      // 19 Officer  
			'',                      // 20 Officer  
			R.DATA_PROVIDER_NAME,    // 21 CFS
			'',                      // 22 CFS      
			'',                      // 23 CFS      
			'',                      // 24 CFS   
			'',                      // 25 CFS
			'',                      // 26 CFS      
			'',                      // 27 CFS      
			'',                      // 28 CFS      
			'',                      // 29 Officer  
			'',                      // 30 Officer  
			'',                      // 31 CFS      
			'',                      // 32 Officer      
			'',                      // 33 Officer  
			'',                      // 34 Officer  
			'',                      // 35 Officer 
			R.PRIORITY1,             // 36 CFS
			R.ADDRESS,               // 37 CFS
			'',                      // 38 Officer
			R.CALL_TAKER,            // 39 CFS
			'',                      // 40 Officer
			R.COMPLAINANT_ADDRESS,   // 41 CFS
			R.DISPOSITION,           // 42 CFS
			R.REPORT_NUMBER,         // 43 CFS     
			'',                      // 44 CFS     
			'');                     //
	ENDMACRO;
		
		
	//
	// Numeric values for CFS key
	EXPORT nvalueCFS(fID, R, dist) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			0,          //  0 CFS
			0,          //  1 CFS
			0,          //  2 CFS
			0,          //  3 CFS
			0,          //  4 CFS
			0,          //  5 CFS
			0,          //  6 CFS
			0,          //  7 CFS
			0,          //  8 CFS
			0,          //  9 CFS
			0,          // 10 CFS
			0,          // 11 CFS
			0,          // 12 CFS
			0,          // 13 CFS
			0,          // 14 CFS
			0,          // 15 CFS
			0,          // 16 CFS
			0,          // 17 CFS
			0,          // 18 CFS
			0,          // 19 Officer  
			0,          // 20 Officer  
			0,          // 21 CFS
			R.X_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE,              // 22 CFS
			R.Y_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE,              // 23 CFS
			R.COMPLAINANT_X_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE,  // 24 CFS
			R.COMPLAINANT_Y_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE,  // 25 CFS
			R.INITIAL_UCR_GROUP,                                                   // 26 CFS
			R.FINAL_UCR_GROUP,                                                     // 27 CFS
			R.TOTAL_MINUTES_ON_CALL*BairRx_Common.Constants.REAL_TO_INT_SCALE,     // 28 CFS			
			0,          // 29 Officer  
			0,          // 30 Officer  
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.DATE_TIME_RECEIVED,''),             // 31 CFS   
			0,          // 32 Officer      
			0,          // 33 Officer  
			0,          // 34 Officer  
			0,          // 35 Officer 
			0,          // 36 CFS
			0,          // 37 CFS
			0,          // 38 Officer
			0,          // 39 CFS
			0,          // 40 Officer
			0,          // 41 CFS
			0,          // 42 CFS
			0,          // 43 CFS     
			dist,       // 44 CFS     
			0);         //
	ENDMACRO;
		

	//
	// String value for Officer key
	EXPORT svalueOfficer(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			'',                 //  0 CFS
			'',                 //  1 CFS
			'',                 //  2 CFS
			'',                 //  3 CFS
			'',                 //  4 CFS
			'',                 //  5 CFS
			'',                 //  6 CFS
			'',                 //  7 CFS
			'',                 //  8 CFS
			'',                 //  9 CFS
			'',                 // 10 CFS
			'',                 // 11 CFS
			'',                 // 12 CFS
			'',                 // 13 CFS
			'',                 // 14 CFS
			'',                 // 15 CFS
			'',                 // 16 CFS
			'',                 // 17 CFS
			'',                 // 18 CFS
			R.UNIT,             // 19 Officer  
			R.OFFICER_NAME,     // 20 Officer  
			'',                 // 21 CFS
			'',                 // 22 CFS      
			'',                 // 23 CFS      
			'',                 // 24 CFS   
			'',                 // 25 CFS
			'',                 // 26 CFS      
			'',                 // 27 CFS      
			'',                 // 28 CFS      
			'',                 // 29 Officer  
			'',                 // 30 Officer  
			'',                 // 31 CFS      
			'',                 // 32 Officer      
			'',                 // 33 Officer  
			'',                 // 34 Officer  
			'',                 // 35 Officer 
			'',                 // 36 CFS
			'',                 // 37 CFS
			R.PRIMARY_OFFICER,  // 38 Officer
			'',                 // 39 CFS
			'',                 // 40 Officer
			'',                 // 41 CFS
			'',                 // 42 CFS
			'',                 // 43 CFS     
			'',                 // 44 CFS     
			'');                //
	ENDMACRO;
		

	//
	// Numeric value for Officer key
	EXPORT nvalueOfficer(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			0,          //  0 CFS
			0,          //  1 CFS
			0,          //  2 CFS
			0,          //  3 CFS
			0,          //  4 CFS
			0,          //  5 CFS
			0,          //  6 CFS
			0,          //  7 CFS
			0,          //  8 CFS
			0,          //  9 CFS
			0,          // 10 CFS
			0,          // 11 CFS
			0,          // 12 CFS
			0,          // 13 CFS
			0,          // 14 CFS
			0,          // 15 CFS
			0,          // 16 CFS
			0,          // 17 CFS
			0,          // 18 CFS
			0,          // 19 Officer  
			0,          // 20 Officer  
			0,          // 21 CFS
			0,          // 22 CFS
			0,          // 23 CFS
			0,          // 24 CFS
			0,          // 25 CFS
			0,          // 26 CFS
			0,          // 27 CFS
			0,          // 28 CFS			
			R.MINUTES_ON_CALL*BairRx_Common.Constants.REAL_TO_INT_SCALE,  // 29 Officer  
			R.MINUTES_RESPONSE*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 30 Officer  
			0,          // 31 CFS   
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.DATE_TIME_ARRIVED,''),     // 32 Officer      
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.DATE_TIME_DISPATCHED,''),  // 33 Officer  
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.DATE_TIME_CLEARED,''),     // 34 Officer  
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.DATE_TIME_ENROUTE,''),     // 35 Officer 
			0,          // 36 CFS
			0,          // 37 CFS
			0,          // 38 Officer
			0,          // 39 CFS
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.DATE_TIME_ARRIVED,''),     // 40 Officer
			0,          // 41 CFS
			0,          // 42 CFS
			0,          // 43 CFS     
			0,          // 44 CFS     
			0);         //
	ENDMACRO;
		
// match to order in Bair.Build_GeoHash
		
END;
