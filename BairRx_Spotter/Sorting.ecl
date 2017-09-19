import BairRx_Common;

EXPORT Sorting := MODULE
	
	SHARED STYPE_NUM := 0;	
	SHARED STYPE_STR := 1;	
	
	EXPORT tvalue(unsigned2 fID) := CHOOSE(fID,
		STYPE_NUM,   // 0      R.SHOT_ID
		STYPE_STR,   // 1      R.ADDRESS
		STYPE_NUM,   // 2      R.SHOTS
		STYPE_STR,   // 3      R.BEAT
		STYPE_STR,   // 4      R.DISTRICT
		STYPE_STR,   // 5      R.SOURCE
		STYPE_NUM,   // 6      R.SHOT_INCIDENT_TYPE
		STYPE_STR,   // 7      R.SHOT_INCIDENT_STATUS
		STYPE_NUM,   // 8      R.SHOT_DATETIME
		STYPE_NUM,   // 9      R.X_COORDINATE
		STYPE_NUM,   // 10     R.Y_COORDINATE
		STYPE_NUM,   // 11     R.RAIDS_RECORD_ID
		STYPE_NUM,   // 12     R.DISTANCE
		0);
	
	EXPORT svalue(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			'',                      // 0  R.shot_id,
			R.address,               // 1
			'',                      // 2   R.shots,
			R.beat,                  // 3
			R.district,              // 4
			R.shot_source,           // 5
			'',                      // 6   R.shot_incident_type,
			R.shot_incident_status,  // 7
			'',                      // 8   R.shot_datetime
			'',                      // 9   R.x_coordinate
			'',                      // 10  R.y_coordinate
			'',                      // 11  R.raids_record_id,
			'',                      // 12  dist
			'');
	ENDMACRO;
		
	EXPORT nvalue(fID, R, dist) := FUNCTIONMACRO 
		RETURN CHOOSE(fID, 
			(integer) R.shot_id,            // 0
			0,                              // 1  R.ADDRESS
			R.shots,                        // 2
			0,                              // 3  R.beat
			0,                              // 4  R.district
			0,                              // 5  R.shot_sourtce
			R.shot_incident_type,           // 6
			0,                              // 7  R.shot_incident_status
			(UNSIGNED)REGEXREPLACE('[^0-9]',R.shot_datetime,''),         // 8
			R.x_coordinate*BairRx_Common.Constants.REAL_TO_INT_SCALE,    // 9
			R.y_coordinate*BairRx_Common.Constants.REAL_TO_INT_SCALE,    // 10
			R.raids_record_id,              // 11 
			dist,                           // 12
			0);
	ENDMACRO;

END;

/*
(BAIR.Types.t_FieldStr)LEFT.shot_id,
(BAIR.Types.t_FieldStr)LEFT.address,
(BAIR.Types.t_FieldStr)LEFT.shots,
(BAIR.Types.t_FieldStr)LEFT.beat,
(BAIR.Types.t_FieldStr)LEFT.district,
(BAIR.Types.t_FieldStr)LEFT.shot_source,
(BAIR.Types.t_FieldStr)LEFT.shot_incident_type,
(BAIR.Types.t_FieldStr)LEFT.shot_incident_status,
(BAIR.Types.t_FieldStr)LEFT.str_shot_datetime,
(BAIR.Types.t_FieldStr)LEFT.str_longitude,
(BAIR.Types.t_FieldStr)LEFT.str_latitude,
(BAIR.Types.t_FieldStr)LEFT.str_raids_record_id'
*/