// Shared layout in which stats can be optionally generated from various processes
EXPORT Layout_Stats_Standard := MODULE

	EXPORT Examples := RECORD
		STRING val;
		UNSIGNED8 cnt;
		REAL8 pcnt;
	END;
	
	EXPORT Main := RECORD
		UNSIGNED6 dateTimeStamp;
		STRING20 wuid;
		STRING20 source;
		STRING10 statCategory;
		STRING20 statCategory_More;
		STRING30 field;
		STRING15 ruleType;
		STRING10 measureType;
		STRING50 statDesc;
		REAL8 statValue;
		STRING100 statDetail;
		DATASET(Examples) dsExamples;
	END;

END;