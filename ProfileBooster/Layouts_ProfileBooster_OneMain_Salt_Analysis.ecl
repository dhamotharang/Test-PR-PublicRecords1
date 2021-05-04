EXPORT Layouts_ProfileBooster_OneMain_Salt_Analysis := MODULE

EXPORT Alerts_Layout := RECORD
	STRING Alert;
END;

EXPORT Length_Layout := RECORD
	UNSIGNED2 len;
	UNSIGNED  cnt;
	REAL pcnt;	
END;

EXPORT Words_Layout := RECORD
	UNSIGNED2 words;
	UNSIGNED  cnt;
	REAL pcnt;	
END;
	
EXPORT Character_Layout := RECORD
	STRING1 c;
	UNSIGNED cnt;
	REAL pcnt;	
END;	
	
EXPORT Pattern_Layout := RECORD
	STRING data_pattern {maxlength(200000)};
	UNSIGNED cnt;
	REAL pcnt;
END;
	
EXPORT Value_Layout := RECORD
	STRING val {maxlength(200000)};
	UNSIGNED cnt;
	REAL pcnt;
END;

EXPORT alerting := RECORD
	DATASET(Alerts_Layout) Alerts;
END;

EXPORT Value_Layout_Enhanced := RECORD
	STRING val {maxlength(200000)};
	UNSIGNED cnt_old;
	UNSIGNED cnt_new;
	REAL cnt_diff;
	REAL cnt_percent_change;
	REAL pcnt_old;
	REAL pcnt_new;
	alerting;
END;

EXPORT ProfileLayout := RECORD
	UNSIGNED2 FldNo;
	STRING FieldName;
	UNSIGNED Cardinality;
	STRING30 MinVal30;
	STRING30 MaxVal30;
	DATASET(Length_Layout) Len;
	DATASET(Words_Layout) Words;
	DATASET(Character_Layout) Characters;
	DATASET(Pattern_Layout) Patterns;
	DATASET(Value_Layout) Frequent_Terms;
END;

EXPORT EnhancedProfileLayout := RECORD
	UNSIGNED2 FldNo;
	STRING FieldName;
	UNSIGNED Cardinality;
	STRING30 MinVal30;
	STRING30 MaxVal30;
	DATASET(Value_Layout_Enhanced) Frequent_Terms;
	alerting;
END;

END;