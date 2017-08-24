﻿EXPORT Debug := MODULE
	SHARED UNSIGNED LEVEL_OFF := 0;
	SHARED UNSIGNED LEVEL_MIN := 1;
	SHARED UNSIGNED LEVEL_MED := 5;
	SHARED UNSIGNED LEVEL_MAX := 10;
	EXPORT GetLevel() := FUNCTION
		UNSIGNED DebugLvl := 0 : STORED('Debug');
		RETURN DebugLvl;
	END;	
	EXPORT IsOff() := GetLevel()  = LEVEL_OFF;
	EXPORT IsMax() := GetLevel() >= LEVEL_MAX;	
	EXPORT IsMed() := GetLevel() >= LEVEL_MED;		
	EXPORT IsMin() := GetLevel() >= LEVEL_MIN;				
END;