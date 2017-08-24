import BairRx_Common;

EXPORT Sorting := MODULE
	
	SHARED STYPE_NUM := 0;	
	SHARED STYPE_STR := 1;	
	
	EXPORT tvalue(unsigned2 fID) := CHOOSE(fID,
		STYPE_STR, // 0 R.PLATE
		STYPE_NUM, // 1 R.CAPTUREDATETIME
		STYPE_NUM, // 2 R.X_COORDINATE 
		STYPE_NUM, // 3 R.Y_COORDINATE
		STYPE_NUM, // 4 DISTANCE
		0);
	
	EXPORT svalue(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID, 
		R.PLATE,            // 0
		'',                 // 1 R.CAPTUREDATETIME
		'',                 // 2 R.X_COORDINATE
		'',                 // 3 R.Y_COORDINATE
		'',                 // 4 DISTANCE
		'');
	ENDMACRO;
		
	EXPORT nvalue(fID, R, dist) := FUNCTIONMACRO 
		RETURN CHOOSE(fID, 
		0,    // R.PLATE
		(UNSIGNED8)REGEXREPLACE('[^0-9]',R.capturedatetime,''),
		R.x_coordinate*BairRx_Common.Constants.REAL_TO_INT_SCALE,
		R.y_coordinate*BairRx_Common.Constants.REAL_TO_INT_SCALE,
		dist,
		0);
	ENDMACRO;

END;