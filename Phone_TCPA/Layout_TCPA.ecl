EXPORT Layout_TCPA := MODULE
	
	EXPORT Daily := RECORD
		string10 	cellphone;
		string4   end_range;
		string1		lf;
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT Daily_NoRange := RECORD
		string10 	cellphone;
		string1		lf;
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT History := RECORD
		string10 	cellphone;
		string4		end_range;
		string1		lf;
		string255 filename;
	END;
	
	EXPORT History_NoRange := RECORD
		string10 	cellphone;
		string1		lf;
		string255 filename;
	END;	
	
	EXPORT Main := RECORD
		integer		num;
		string10	phone;
		string4		end_range;
		string10	expand_end_range;
		integer		expand_range_max_count;
		string10	expand_phone;
		boolean		is_current;
		unsigned8 dt_first_seen;
		unsigned8 dt_last_seen;
		string1		phone_type;
	END;
	
END;