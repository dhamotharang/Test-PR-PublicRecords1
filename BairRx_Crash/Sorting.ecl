import BairRx_Common;

EXPORT Sorting := MODULE

	SHARED STYPE_NUM := 0;
	SHARED STYPE_STR := 1;

	EXPORT IsIncidentFID(unsigned fid) := (fid >= 0 and fid <= 23) or (fid >= 48 and fid <= 51) or (fid in [53,54,56]);
	EXPORT IsVehicleFID(unsigned fid) := (fid >= 37 and fid <= 47) or (fid = 24);
	EXPORT IsPersonFID(unsigned fid) := (fid >= 25 and fid <= 36) or (fid = 52); 
	
	EXPORT tvalue(unsigned2 fID) := CHOOSE(fID, 
		STYPE_STR,  // 0, R.CASE_NUMBER            i          
		STYPE_STR,  // 1, R.REPORTNUMBER           i
		STYPE_NUM,  // 2, R.REPORT_DATE            i
		STYPE_STR,  // 3, R.ADDRESS                i
		STYPE_STR,  // 4, R.COUNTY                 i
		STYPE_STR,  // 5, R.CRASH_CITY             i
		STYPE_STR,  // 6, R.CRASH_STATE            i
		STYPE_STR,  // 7, R.HITANDRUN              i
		STYPE_STR,  // 8, R.INTERSECTIONRELATED    i
		STYPE_STR,  // 9, R.OFFICERNAME            i
		STYPE_STR,  // 10 R.CRASHTYPE              i
		STYPE_STR,  // 11 R.LOCATIONTYPE           i
		STYPE_STR,  // 12 R.ACCIDENTCLASS          i
		STYPE_STR,  // 13 R.SPECIALCIRCUMSTANCE1   i
		STYPE_STR,  // 14 R.SPECIALCIRCUMSTANCE2   i
		STYPE_STR,  // 15 R.SPECIALCIRCUMSTANCE3   i 
		STYPE_STR,  // 16 R.LIGHTCONDITION         i    
		STYPE_STR,  // 17 R.WEATHERCONDITION       i
		STYPE_STR,  // 18 R.SURFACETYPE            i
		STYPE_STR,  // 19 R.ROADSPECIALFEATURE1    i
		STYPE_STR,  // 20 R.ROADSPECIALFEATURE2    i
		STYPE_STR,  // 21 R.ROADSPECIALFEATURE3    i
		STYPE_STR,  // 22 R.SURFACECONDITION       i
		STYPE_STR,  // 23 R.TRAFFICCONTROLPRESENT  i
		STYPE_NUM,  // 24 R.VEH_ID                 v
		STYPE_STR,  // 25 R.DRIVER                 i
		STYPE_STR,  // 26 R.FIRST_NAME             p
		STYPE_STR,  // 27 R.LAST_NAME              p
		STYPE_STR,  // 28 R.LICENSENUMBER          i
		STYPE_STR,  // 29 R.LICENSESTATE           i
		STYPE_STR,  // 30 R.RACE                   p
		STYPE_STR,  // 31 R.SEX                    p 
		STYPE_STR,  // 32 R.PER_CITY               p
		STYPE_STR,  // 33 R.PER_STATE              p
		STYPE_NUM,  // 34 R.AGE                    p
		STYPE_STR,  // 35 R.AIRBAG                 p
		STYPE_STR,  // 36 R.SEATBELT               i
		STYPE_STR,  // 37 R.VIN                    v
		STYPE_STR,  // 38 R.PLATE                  v
		STYPE_STR,  // 39 R.PLATESTATE             v
		STYPE_STR,  // 40 R.YEAR                   v
		STYPE_STR,  // 41 R.MAKE                   v
		STYPE_STR,  // 42 R.MODEL                  v
		STYPE_STR,  // 43 R.TOWED                  v
		STYPE_STR,  // 44 R.VEHICLE_TYPE           v
		STYPE_STR,  // 45 R.DAMAGE                 v               
		STYPE_STR,  // 46 R.SEQUENCE               v
		STYPE_STR,  // 47 R.DRIVERIMPAIRMENT       v
		STYPE_STR,  // 48 R.DATA_PROVIDER_NAME     i
		STYPE_STR,  // 49 R.REPORT_DATE            i
		STYPE_NUM,  // 50 R.X                      i    // not sortable (remove?)           
		STYPE_NUM,  // 51 R.Y                      i      
		STYPE_NUM,  // 52 R.PERSONVEHICLEID              p    // persons vehicleid
		STYPE_NUM,  // 53 R.X                      i    // these are str versions of X, Y above
		STYPE_NUM,  // 54 R.Y                      i    
		STYPE_STR,  // 55 R.ACTION                 i
		STYPE_NUM,  // 56 R.DISTANCE
		0);


		EXPORT svalueCRA(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
		R.CASE_NUMBER,            // 0,                 
		R.REPORTNUMBER,           // 1, 
		'',                       // 2, R.REPORT_DATE
		R.ADDRESS,                // 3, 
		R.COUNTY,                 // 4, 
		R.CRASH_CITY,             // 5, 
		R.CRASH_STATE,            // 6, 
		R.HITANDRUN,              // 7, 
		R.INTERSECTIONRELATED,    // 8, 
		R.OFFICERNAME,            // 9, 
		R.CRASHTYPE,              // 10 
		R.LOCATIONTYPE,           // 11 
		R.ACCIDENTCLASS,          // 12 
		R.SPECIALCIRCUMSTANCE1,   // 13 
		R.SPECIALCIRCUMSTANCE2,   // 14 
		R.SPECIALCIRCUMSTANCE3,   // 15 
		R.LIGHTCONDITION,         // 16 
		R.WEATHERCONDITION,       // 17 
		R.SURFACETYPE,            // 18 
		R.ROADSPECIALFEATURE1,    // 19 
		R.ROADSPECIALFEATURE2,    // 20 
		R.ROADSPECIALFEATURE3,    // 21 
		R.SURFACECONDITION,       // 22 
		R.TRAFFICCONTROLPRESENT,  // 23 
		'',                       // 24 R.VEH_ID
		'',		//R.DRIVER,                 // 25
		'',		//R.FIRST_NAME,             // 26 
		'',		//R.LAST_NAME,              // 27
		'',		//R.LICENSENUMBER,          // 28
		'',		//R.LICENSESTATE,           // 29
		'',		//R.RACE,                   // 30 
		'',		//R.SEX,                    // 31 
		'',		//R.PER_CITY,               // 32 
		'',		//R.PER_STATE,              // 33 
		'',                       // 34 R.AGE
		'',		//R.AIRBAG,                 // 35 
		'',		//R.SEATBELT,               // 36 
		'',		//R.VIN,                    // 37 
		'',		//R.PLATE,                  // 38 
		'',		//R.PLATESTATE,             // 39 
		'',		//R.YEAR,                   // 40 
		'',		//R.MAKE,                   // 41 
		'',		//R.MODEL,                  // 42 
		'',		//R.TOWED,                  // 43 
		'',		//R.VEHICLE_TYPE,           // 44 
		'',		//R.DAMAGE,                 // 45 
		'',		//R.SEQUENCE,               // 46 
		'',		//R.DRIVERIMPAIRMENT,       // 47 
		R.DATA_PROVIDER_NAME,     // 48 
		R.REPORT_DATE,            // 49 
		'',                       // 50 R.X
		'',                       // 51 R.Y
		'',                       // 52 R.VEHICLEID  
		'',                       // 53 R.X
		'',                       // 54 R.Y
		'',		//R.ACTION,                 // 55  
		'',                       // 56  dist
		'');
	ENDMACRO;
		
	EXPORT nvalueCRA(fID, R, dist) := FUNCTIONMACRO 
	RETURN CHOOSE(fID,
		0, // R.CASE_NUMBER,            // 0
		0, // R.REPORTNUMBER,						// 1
		(UNSIGNED8)REGEXREPLACE('[^0-9]',R.REPORT_DATE,''), // 2
		0, // R.ADDRESS,                // 3
		0, // R.COUNTY,                 // 4, 
		0, // R.CRASH_CITY,             // 5, 
		0, // R.CRASH_STATE,            // 6, 
		0, // R.HITANDRUN,              // 7, 
		0, // R.INTERSECTIONRELATED,    // 8, 
		0, // R.OFFICERNAME,            // 9, 
		0, // R.CRASHTYPE,              // 10 
		0, // R.LOCATIONTYPE,           // 11 
		0, // R.ACCIDENTCLASS,          // 12 
		0, // R.SPECIALCIRCUMSTANCE1,   // 13 
		0, // R.SPECIALCIRCUMSTANCE2,   // 14 
		0, // R.SPECIALCIRCUMSTANCE3,   // 15 
		0, // R.LIGHTCONDITION,         // 16 
		0, // R.WEATHERCONDITION,       // 17 
		0, // R.SURFACETYPE,            // 18 
		0, // R.ROADSPECIALFEATURE1,    // 19 
		0, // R.ROADSPECIALFEATURE2,    // 20 
		0, // R.ROADSPECIALFEATURE3,    // 21 
		0, // R.SURFACECONDITION,       // 22 
		0, // R.TRAFFICCONTROLPRESENT,  // 23 
		0, //R.VEH_ID,									// 24
		0, // R.DRIVER,                 // 25
		0, // R.FIRST_NAME,             // 26 
		0, // R.LAST_NAME,              // 27
		0, // R.LICENSENUMBER,          // 28
		0, // R.LICENSESTATE,           // 29
		0, // R.RACE,                   // 30 
		0, // R.SEX,                    // 31 
		0, // R.PER_CITY,               // 32 
		0, // R.PER_STATE,              // 33 
		0, //R.AGE,											// 34
		0, // R.AIRBAG,                 // 35 
		0, // R.SEATBELT,               // 36 
		0, // R.VIN,                    // 37 
		0, // R.PLATE,                  // 38 
		0, // R.PLATESTATE,             // 39 
		0, // R.YEAR,                   // 40 
		0, // R.MAKE,                   // 41 
		0, // R.MODEL,                  // 42 
		0, // R.TOWED,                  // 43 
		0, // R.VEHICLE_TYPE,           // 44 
		0, // R.DAMAGE,                 // 45 
		0, // R.SEQUENCE,               // 46 
		0, // R.DRIVERIMPAIRMENT,       // 47 
		0, // R.DATA_PROVIDER_NAME,     // 48 
		0, // R.REPORT_DATE,            // 49 
		R.X*BairRx_Common.Constants.REAL_TO_INT_SCALE,
		R.Y*BairRx_Common.Constants.REAL_TO_INT_SCALE,
		0, // R.VEHICLEID,							// 52
		R.X*BairRx_Common.Constants.REAL_TO_INT_SCALE,
		R.Y*BairRx_Common.Constants.REAL_TO_INT_SCALE,		
		0, // R.ACTION,                 // 55  
		dist,
		0);
	ENDMACRO;
	
	EXPORT svaluePE(fID, R) := FUNCTIONMACRO 	
	RETURN CHOOSE(fID,
		'',            // 0, R.CASE_NUMBER                
		'',           // 1, R.REPORTNUMBER
		'',           // 2, R.REPORT_DATE
		'',                // 3, R.ADDRESS
		'',                 // 4, R.COUNTY
		'',             // 5, R.CRASH_CITY
		'',            // 6, R.CRASH_STATE
		'',              // 7, R.HITANDRUN
		'',    // 8, R.INTERSECTIONRELATED
		'',            // 9, R.OFFICERNAME
		'',              // 10 R.CRASHTYPE
		'',           // 11 R.LOCATIONTYPE
		'',          // 12 R.LOCATIONTYPER.ACCIDENTCLASS
		'',   // 13 R.SPECIALCIRCUMSTANCE1
		'',   // 14 R.SPECIALCIRCUMSTANCE2
		'',   // 15 R.SPECIALCIRCUMSTANCE3
		'',         // 16 R.LIGHTCONDITION
		'',       // 17 R.WEATHERCONDITION
		'',            // 18 R.SURFACETYPE
		'',    // 19 R.ROADSPECIALFEATURE1
		'',    // 20 R.ROADSPECIALFEATURE2
		'',    // 21 R.ROADSPECIALFEATURE3
		'',       // 22 R.SURFACECONDITION
		'',  // 23 R.TRAFFICCONTROLPRESENT
		'',                       // 24 R.VEH_ID
		R.DRIVER,                 // 25
		R.FIRST_NAME,             // 26 
		R.LAST_NAME,              // 27
		R.LICENSENUMBER,          // 28
		R.LICENSESTATE,           // 29
		R.RACE,                   // 30 
		R.SEX,                    // 31 
		R.CITY,               // 32 
		R.STATE,              // 33 
		'',                       // 34 R.AGE
		R.AIRBAG,                 // 35 
		R.SEATBELT,               // 36 
		'',                    // 37 R.VIN
		'',                  // 38 R.PLATE
		'',             // 39 R.PLATESTATE
		'',                   // 40 R.YEAR
		'',                   // 41 R.MAKE
		'',                  // 42 R.MODEL
		'',                  // 43 R.TOWED
		'',           // 44 R.VEHICLE_TYPE
		'',                 // 45 R.DAMAGE
		'',               // 46 R.SEQUENCE
		'',       // 47 R.DRIVERIMPAIRMENT
		'',     // 48 R.DATA_PROVIDER_NAME
		'',            // 49 R.REPORT_DATE
		'',                       // 50 R.X
		'',                       // 51 R.Y
		'',                       // 52 R.VEHICLEID  
		'',                       // 53 R.X
		'',                       // 54 R.Y
		'',                 // 55  R.ACTION
		'',                       // 56  dist
		'');
	ENDMACRO;
	
	EXPORT nvaluePE(fID, R) := FUNCTIONMACRO 
	RETURN CHOOSE(fID,
		0, // R.CASE_NUMBER,            // 0
		0, // R.REPORTNUMBER,						// 1
		0,// (UNSIGNED8)REGEXREPLACE('[^0-9]',R.REPORT_DATE,''), // 2
		0, // R.ADDRESS,                // 3
		0, // R.COUNTY,                 // 4, 
		0, // R.CRASH_CITY,             // 5, 
		0, // R.CRASH_STATE,            // 6, 
		0, // R.HITANDRUN,              // 7, 
		0, // R.INTERSECTIONRELATED,    // 8, 
		0, // R.OFFICERNAME,            // 9, 
		0, // R.CRASHTYPE,              // 10 
		0, // R.LOCATIONTYPE,           // 11 
		0, // R.ACCIDENTCLASS,          // 12 
		0, // R.SPECIALCIRCUMSTANCE1,   // 13 
		0, // R.SPECIALCIRCUMSTANCE2,   // 14 
		0, // R.SPECIALCIRCUMSTANCE3,   // 15 
		0, // R.LIGHTCONDITION,         // 16 
		0, // R.WEATHERCONDITION,       // 17 
		0, // R.SURFACETYPE,            // 18 
		0, // R.ROADSPECIALFEATURE1,    // 19 
		0, // R.ROADSPECIALFEATURE2,    // 20 
		0, // R.ROADSPECIALFEATURE3,    // 21 
		0, // R.SURFACECONDITION,       // 22 
		0, // R.TRAFFICCONTROLPRESENT,  // 23 
		0,	//R.VEH_ID,												// 24
		0, // R.DRIVER,                 // 25
		0, // R.FIRST_NAME,             // 26 
		0, // R.LAST_NAME,              // 27
		0, // R.LICENSENUMBER,          // 28
		0, // R.LICENSESTATE,           // 29
		0, // R.RACE,                   // 30 
		0, // R.SEX,                    // 31 
		0, // R.PER_CITY,               // 32 
		0, // R.PER_STATE,              // 33 
		R.AGE,													// 34
		0, // R.AIRBAG,                 // 35 
		0, // R.SEATBELT,               // 36 
		0, // R.VIN,                    // 37 
		0, // R.PLATE,                  // 38 
		0, // R.PLATESTATE,             // 39 
		0, // R.YEAR,                   // 40 
		0, // R.MAKE,                   // 41 
		0, // R.MODEL,                  // 42 
		0, // R.TOWED,                  // 43 
		0, // R.VEHICLE_TYPE,           // 44 
		0, // R.DAMAGE,                 // 45 
		0, // R.SEQUENCE,               // 46 
		0, // R.DRIVERIMPAIRMENT,       // 47 
		0, // R.DATA_PROVIDER_NAME,     // 48 
		0, // R.REPORT_DATE,            // 49 
		0, // R.X*BairRx_Common.Constants.REAL_TO_INT_SCALE //50
		0, // R.Y*BairRx_Common.Constants.REAL_TO_INT_SCALE, //51
		R.PERSONVEHICLEID, //52
		0, // R.X*BairRx_Common.Constants.REAL_TO_INT_SCALE, //53
		0, // R.Y*BairRx_Common.Constants.REAL_TO_INT_SCALE,	//54
		0, // R.ACTION,                 // 55  
		0, // dist, //56
		0);
	ENDMACRO;
	
	EXPORT svalueVE(fID, R) := FUNCTIONMACRO 	
	RETURN CHOOSE(fID,
		'',            // 0, R.CASE_NUMBER                
		'',           // 1, R.REPORTNUMBER
		'',           // 2, R.REPORT_DATE
		'',                // 3, R.ADDRESS
		'',                 // 4, R.COUNTY
		'',             // 5, R.CRASH_CITY
		'',            // 6, R.CRASH_STATE
		'',              // 7, R.HITANDRUN
		'',    // 8, R.INTERSECTIONRELATED
		'',            // 9, R.OFFICERNAME
		'',              // 10 R.CRASHTYPE
		'',           // 11 R.LOCATIONTYPE
		'',          // 12 R.LOCATIONTYPER.ACCIDENTCLASS
		'',   // 13 R.SPECIALCIRCUMSTANCE1
		'',   // 14 R.SPECIALCIRCUMSTANCE2
		'',   // 15 R.SPECIALCIRCUMSTANCE3
		'',         // 16 R.LIGHTCONDITION
		'',       // 17 R.WEATHERCONDITION
		'',            // 18 R.SURFACETYPE
		'',    // 19 R.ROADSPECIALFEATURE1
		'',    // 20 R.ROADSPECIALFEATURE2
		'',    // 21 R.ROADSPECIALFEATURE3
		'',       // 22 R.SURFACECONDITION
		'',  // 23 R.TRAFFICCONTROLPRESENT
		'',                       // 24 R.VEH_ID
		'',  //R.DRIVER,                 // 25
		'',  //R.FIRST_NAME,             // 26 
		'',  //R.LAST_NAME,              // 27
		'',  //R.LICENSENUMBER,          // 28
		'',  //R.LICENSESTATE,           // 29
		'',  //R.RACE,                   // 30 
		'',  //R.SEX,                    // 31 
		'',  //R.PER_CITY,               // 32 
		'',  //R.PER_STATE,              // 33 
		'',                       // 34 R.AGE
		'',  //R.AIRBAG,                 // 35 
		'',  //R.SEATBELT,               // 36 
		R.VIN,                    // 37 
		R.PLATE,                  // 38 
		R.PLATESTATE,             // 39 
		R.YEAR,                   // 40 
		R.MAKE,                   // 41 
		R.MODEL,                  // 42 
		R.TOWED,                  // 43 
		R.VEHICLE_TYPE,           // 44 
		R.DAMAGE,                 // 45 
		'',               // 46 R.SEQUENCE
		R.DRIVERIMPAIRMENT,       // 47 
		'',     // 48 R.DATA_PROVIDER_NAME
		'',            // 49 R.REPORT_DATE
		'',                       // 50 R.X
		'',                       // 51 R.Y
		'',                       // 52 R.VEHICLEID  
		'',                       // 53 R.X
		'',                       // 54 R.Y
		R.ACTION,                 // 55 
		'',                       // 56  dist
		'');
	ENDMACRO;
	
	EXPORT nvalueVE(fID, R) := FUNCTIONMACRO 
	RETURN CHOOSE(fID,
		0, // R.CASE_NUMBER,            // 0
		0, // R.REPORTNUMBER,						// 1
		0,// (UNSIGNED8)REGEXREPLACE('[^0-9]',R.REPORT_DATE,''), // 2
		0, // R.ADDRESS,                // 3
		0, // R.COUNTY,                 // 4, 
		0, // R.CRASH_CITY,             // 5, 
		0, // R.CRASH_STATE,            // 6, 
		0, // R.HITANDRUN,              // 7, 
		0, // R.INTERSECTIONRELATED,    // 8, 
		0, // R.OFFICERNAME,            // 9, 
		0, // R.CRASHTYPE,              // 10 
		0, // R.LOCATIONTYPE,           // 11 
		0, // R.ACCIDENTCLASS,          // 12 
		0, // R.SPECIALCIRCUMSTANCE1,   // 13 
		0, // R.SPECIALCIRCUMSTANCE2,   // 14 
		0, // R.SPECIALCIRCUMSTANCE3,   // 15 
		0, // R.LIGHTCONDITION,         // 16 
		0, // R.WEATHERCONDITION,       // 17 
		0, // R.SURFACETYPE,            // 18 
		0, // R.ROADSPECIALFEATURE1,    // 19 
		0, // R.ROADSPECIALFEATURE2,    // 20 
		0, // R.ROADSPECIALFEATURE3,    // 21 
		0, // R.SURFACECONDITION,       // 22 
		0, // R.TRAFFICCONTROLPRESENT,  // 23 
		R.VEHICLEID,												// 24
		0, // R.DRIVER,                 // 25
		0, // R.FIRST_NAME,             // 26 
		0, // R.LAST_NAME,              // 27
		0, // R.LICENSENUMBER,          // 28
		0, // R.LICENSESTATE,           // 29
		0, // R.RACE,                   // 30 
		0, // R.SEX,                    // 31 
		0, // R.PER_CITY,               // 32 
		0, // R.PER_STATE,              // 33 
		0, //R.AGE,													// 34
		0, // R.AIRBAG,                 // 35 
		0, // R.SEATBELT,               // 36 
		0, // R.VIN,                    // 37 
		0, // R.PLATE,                  // 38 
		0, // R.PLATESTATE,             // 39 
		0, // R.YEAR,                   // 40 
		0, // R.MAKE,                   // 41 
		0, // R.MODEL,                  // 42 
		0, // R.TOWED,                  // 43 
		0, // R.VEHICLE_TYPE,           // 44 
		0, // R.DAMAGE,                 // 45 
		0, // R.SEQUENCE,               // 46 
		0, // R.DRIVERIMPAIRMENT,       // 47 
		0, // R.DATA_PROVIDER_NAME,     // 48 
		0, // R.REPORT_DATE,            // 49 
		0, // R.X*BairRx_Common.Constants.REAL_TO_INT_SCALE //50
		0, // R.Y*BairRx_Common.Constants.REAL_TO_INT_SCALE, //51
		0, //R.VEHICLEID, //  //52
		0, // R.X*BairRx_Common.Constants.REAL_TO_INT_SCALE, //53
		0, // R.Y*BairRx_Common.Constants.REAL_TO_INT_SCALE,	//54
		0, // R.ACTION,                 // 55  
		0, // dist, //56
		0);
	ENDMACRO;
	
	

END;
