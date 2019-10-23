EXPORT Layout_Stats := RECORD
	STRING30 wuid;
	STRING30 version;
	UNSIGNED2 iteration;
	UNSIGNED8 timeStamp;
	STRING50 src;
	STRING50 statName;
	REAL8 statValue;
	BOOLEAN ignore;
END;