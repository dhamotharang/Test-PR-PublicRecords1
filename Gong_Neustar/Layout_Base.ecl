EXPORT Layout_Base := RECORD
		Layout_Gong;
		unsigned6		did;
		//CCPA-22 CCPA new fields
		UNSIGNED4 global_sid := 0;
		UNSIGNED8 record_sid := 0;
END;