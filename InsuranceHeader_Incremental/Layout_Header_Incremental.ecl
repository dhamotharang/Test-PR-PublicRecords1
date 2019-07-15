EXPORT Layout_Header_Incremental := RECORD
	Layout_Header;
	UNSIGNED1 RecChangeType;
	UNSIGNED buildDateTimeStamp;
END;