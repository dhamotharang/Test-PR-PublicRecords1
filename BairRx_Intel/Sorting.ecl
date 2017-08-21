import BairRx_Common;

EXPORT Sorting := MODULE
	
	SHARED STYPE_NUM := 0;	
	SHARED STYPE_STR := 1;	
	
	EXPORT tvalue(unsigned2 fID) := CHOOSE(fID,
		STYPE_STR,   // 0    R.SOURCE_RELIABILITY
		STYPE_STR,   // 1    R.CASE_NUMBER
		STYPE_STR,   // 2    R.CALL_CASE_NUMBER
		STYPE_NUM,   // 3    R.INCIDENT_DATE
		STYPE_STR,   // 4    R.INCIDENT_TYPE
		STYPE_STR,   // 5    R.INCIDENT_ADDRESS
		STYPE_STR,   // 6    R.INCIDENT_CITY
		STYPE_STR,   // 7    R.INCIDENT_STATE
		STYPE_STR,   // 8    R.INCIDENT_ZIP
		STYPE_STR,   // 9    R.LOCATION_TYPE
		STYPE_STR,   // 10   R.INCIDENT_CONTENT_VALIDITY
		STYPE_NUM,   // 11   R.INCIDENT_ENTRY_DATE
		STYPE_NUM,   // 12   R.INCIDENT_PURGE_DATE
		STYPE_STR,   // 13   R.REPORTING_OFFICER_FIRST_NAME
		STYPE_STR,   // 14   R.REPORTING_OFFICER_LAST_NAME
		STYPE_STR,   // 15   R.INCIDENT_DATE
		STYPE_NUM,   // 16   R.X
		STYPE_NUM,   // 17   R.Y
		STYPE_NUM,   // 18   R.INCIDENT_ID
		STYPE_NUM,   // 19   R.INCIDENT_TIME
		STYPE_NUM,   // 20   R.INCIDENT_SOURCE_SCORE
		STYPE_STR,   // 21   R.VEHICLE_COLOR_SECONDARY
		STYPE_STR,   // 22   R.VEHICLE_VIN
		STYPE_STR,   // 23   R.UPDATE_DATE
		STYPE_STR,   // 24   R.PURGEDATE_COMPUTED
		STYPE_STR,   // 25   R.DURATION_SINCE
		STYPE_NUM,   // 26   R.DISTANCE
		0);
	
	EXPORT svalue(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			R.SOURCE_RELIABILITY,            // 0     
			R.CASE_NUMBER,                   // 1    
			R.CALL_CASE_NUMBER,              // 2    
			'',                              // 3    R.INCIDENT_DATE
			R.INCIDENT_TYPE,                 // 4    
			R.INCIDENT_ADDRESS,              // 5    
			R.INCIDENT_CITY,                 // 6    
			R.INCIDENT_STATE,                // 7    
			R.INCIDENT_ZIP,                  // 8    
			R.LOCATION_TYPE,                 // 9    
			R.INCIDENT_CONTENT_VALIDITY,     // 10   
			'',                              // 11   R.INCIDENT_ENTRY_DATE
			'',                              // 12   R.INCIDENT_PURGE_DATE
			R.REPORTING_OFFICER_FIRST_NAME,  // 13   
			R.REPORTING_OFFICER_LAST_NAME,   // 14   
			'',                              // 15   R.INCIDENT_DATE
			'',                              // 16   R.X
			'',                              // 17   R.Y
			'',                              // 18   R.INCIDENT_ID
			'',                              // 19   R.INCIDENT_TIME
			'',                              // 20   R.INCIDENT_SOURCE_SCORE
			R.VEHICLE_COLOR_SECONDARY,       // 21
			R.VEHICLE_VIN,                   // 22
			R.UPDATE_DATE,                   // 23
			R.PURGEDATE_COMPUTED,            // 24
			R.DURATION_SINCE,                // 25
			'',                              // 26   R.DISTANCE
			'');
	ENDMACRO;
		
	EXPORT nvalue(fID, R, dist) := FUNCTIONMACRO 
		RETURN CHOOSE(fID, 
			0,                                                         // 0    R.SOURCE_RELIABILITY
			0,                                                         // 1    R.CASE_NUMBER
			0,                                                         // 2    R.CALL_CASE_NUMBER
			(UNSIGNED)REGEXREPLACE('[^0-9]',R.INCIDENT_DATE,''),       // 3    
			0,                                                         // 4    R.INCIDENT_TYPE
			0,                                                         // 5    R.INCIDENT_ADDRESS
			0,                                                         // 6    R.INCIDENT_CITY
			0,                                                         // 7    R.INCIDENT_STATE
			0,                                                         // 8    R.INCIDENT_ZIP
			0,                                                         // 9    R.LOCATION_TYPE
			0,                                                         // 10   R.INCIDENT_CONTENT_VALIDITY
			(UNSIGNED)REGEXREPLACE('[^0-9]',R.INCIDENT_ENTRY_DATE,''), // 11   
			(UNSIGNED)REGEXREPLACE('[^0-9]',R.INCIDENT_PURGE_DATE,''), // 12   
			0,                                                         // 13   R.REPORTING_OFFICER_FIRST_NAME
			0,                                                         // 14   R.REPORTING_OFFICER_LAST_NAME
			(UNSIGNED)REGEXREPLACE('[^0-9]',R.INCIDENT_DATE,''),       // 15   R.INCIDENT_DATE
			R.X*BairRx_Common.Constants.REAL_TO_INT_SCALE,             // 16   
			R.Y*BairRx_Common.Constants.REAL_TO_INT_SCALE,             // 17   
			R.INCIDENT_ID,                                             // 18   
			R.INCIDENT_TIME,                                           // 19   
			R.INCIDENT_SOURCE_SCORE,                                   // 20  
			0,                                                         // 21   R.VEHICLE_COLOR_SECONDARY
			0,                                                         // 22   R.VEHICLE_VIN
			0,                                                         // 23   R.UPDATE_DATE
			0,                                                         // 24   R.PURGEDATE_COMPUTED
			0,                                                         // 25   R.DURATION_SINCE			
			dist,                                                      // 26   
		  0);
	ENDMACRO;

END;

/*
(BAIR.Types.t_FieldStr)LEFT.source_reliability,
(BAIR.Types.t_FieldStr)LEFT.case_number,
(BAIR.Types.t_FieldStr)LEFT.call_case_number,
(BAIR.Types.t_FieldStr)LEFT.incident_date,
(BAIR.Types.t_FieldStr)LEFT.incident_type,
(BAIR.Types.t_FieldStr)LEFT.incident_address,
(BAIR.Types.t_FieldStr)LEFT.incident_city,
(BAIR.Types.t_FieldStr)LEFT.incident_state,
(BAIR.Types.t_FieldStr)LEFT.incident_zip,
(BAIR.Types.t_FieldStr)LEFT.location_type,
(BAIR.Types.t_FieldStr)LEFT.incident_content_validity,
(BAIR.Types.t_FieldStr)LEFT.incident_entry_date,
(BAIR.Types.t_FieldStr)LEFT.incident_purge_date,
(BAIR.Types.t_FieldStr)LEFT.reporting_officer_first_name,
(BAIR.Types.t_FieldStr)LEFT.reporting_officer_last_name,
(BAIR.Types.t_FieldStr)LEFT.str_datetime,
(BAIR.Types.t_FieldStr)LEFT.str_longitude,
(BAIR.Types.t_FieldStr)LEFT.str_latitude,
(BAIR.Types.t_FieldStr)LEFT.str_incident_id,
(BAIR.Types.t_FieldStr)LEFT.str_incident_time,
(BAIR.Types.t_FieldStr)LEFT.str_incident_source_score
*/