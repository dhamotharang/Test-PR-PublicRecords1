EXPORT Layout_TCPA := MODULE

	EXPORT Daily := RECORD
			string10 	phone;
			string1		lf;
			string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT History := RECORD
			string10 	phone;
			string1		lf;
			string255 filename;
	END;	
	
	export Main := record
	//Phonesplus_v2.Layout_Neustar_History;
		string10		phone;
		string2 		phoneType;
		boolean 		is_ported;
		unsigned8 	vendor_first_reported_dt;
		unsigned8 	vendor_last_reported_dt;
		unsigned8		port_start_dt;
		unsigned8		port_end_dt;
	end;
	
	EXPORT Historical := RECORD
		 //string 	record_id;
			string10 	phone;
			string 		add_date;
			string1 	action_code;
			string 		phonetype;
	END;

END;