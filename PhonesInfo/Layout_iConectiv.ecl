IMPORT dx_PhonesInfo;

EXPORT Layout_iConectiv := MODULE

	EXPORT Daily := RECORD
		string1   action_code;		//A-Add for incremental, bulk
															//U-Updt for incremental, bulk
															//D-Delete for incremental only (Not Applicable for bulk)
														
		string3   country_code; 	//Country Code (CC), variable length up to 3 digits
		
		string12  phone;					//Dial Code (nationally significant TN or NDC), excludes CC, variable length up to 12 digits
		
		string1   dial_type;			//Dial Code Type (DCT)
															//For Country Code CC = “1”:
															//T, a North American 1+10-digit TN.
															//B, a North American 1+7-digit 1000s Block code.
															//N, a North American 1+6-digit NPA-NXX code.
														
															//For Country Code (CC) other than “1”:
															//E, an international TN, CC+NN, variable length up to 15 digits.
															//C, an international NDC, CC+NDC, variable length, typically 4-7 digits.
														
		string6   spid;						//Telecordia Mobile Id Provider Id for the company serving the queried TN
		
		string1   service_type;		//Type of Service (TOS)
															//G – Geographic (or fixed line)
															//M – Mobile
															//O – Other
															//U - Unknown
														
		string10  routing_code;		//Routing Prefix - if available; otherwise empty field, variable length, typically up to 8 digits, for U.S. and Canada, the Routing Code is the LRN of 10 digits.
		
		string    porting_dt;			//Date and Time of Porting
		
		string2   country_abbr;		//Country Code, two-letter ISO abbreviation for country name
		
		string255 filename{virtual (logicalfilename)}; //Logical File Name (Must Force to Thor to View)
	END;
	
	EXPORT PortData_Validate_In := RECORD	
	  string jsonData; 
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT PortData_Validate_History := RECORD	
	  string jsonData; 
		string255 filename;
	END;
	
	EXPORT PortData_Validate_Json := RECORD
	  string 		tid 			{XPATH('tid')}; 		//Transaction Identifier: is a sequence number that uniquely identifies a transaction
		string 		action 		{XPATH('action')}; 	//Action: identifies the action that caused one of the SALT fields to change
																							//Allowed values:
																							//u - update for TNs or blocks
																							//d - delete for TNs, blocks, or codes
																							//m - migrate for TNs, blocks or codes
		string 		actTs			{XPATH('actTs')}; 	//Activity Timestamp: identifies the action that caused one of the SALT fields to change	
		string 		digits 		{XPATH('digits')}; 	//Digits: contains a 10-digit telephone number, a 7-digit block, or a 6-digit code	
		string 		spid 			{XPATH('spid')}; 		//Spid: contains 4 alphanumeric characters that identify the network Service Provider of the TN, block or code object
		string 		altSpid 	{XPATH('altSpid')}; //altSpid: contains 4 alphanumeric characters that identify the current Alternative Service Provider of the TN or block object	
		string 		lAltSpid 	{XPATH('lAltSpid')}; //lAltSpid: contains 4 alphanumeric characters that identify the current Last Alternative Service Provider of the TN or block object
		string 		lineType 	{XPATH('lineType')}; //lineType: includes the current line type of the TN or block object
																							//The Line Type will be non-null when there is a Line Type associated with the TN or block object. 
																							//It will always be null for delete and code transactions.
																								//Allowed values:
																								//0 for Wireline
																								//1 for Wireless
																								//2 for Class 2 Interconnected VoIP
																								//3 for VoWIFI
																								//4 for Prepaid Wireless
																								//5 for Class 1 Interconnected VoIP provider and Class 2 interconnected VoIP provider, eligible for direct assignment of
																								//              NANP numbering resources from the NANPA and PA.
																								//6 for SV Type 6
																								//7 for SV Type 7
																								//8 for SV Type 8
																								//9 for SV Type 9	
		string255 filename;
	END;
	
	EXPORT PortData_Validate_History_Raw := RECORD
	  string 		tid ; 		//Transaction Identifier: is a sequence number that uniquely identifies a transaction
		string 		action; 	//Action: identifies the action that caused one of the SALT fields to change
																							//Allowed values:
																							//u - update for TNs or blocks
																							//d - delete for TNs, blocks, or codes
																							//m - migrate for TNs, blocks or codes
		string 		actTs; 		//Activity Timestamp: identifies the action that caused one of the SALT fields to change	
		string 		digits; 	//Digits: contains a 10-digit telephone number, a 7-digit block, or a 6-digit code	
		string 		spid; 		//Spid: contains 4 alphanumeric characters that identify the network Service Provider of the TN, block or code object
		string 		altSpid; 	//altSpid: contains 4 alphanumeric characters that identify the current Alternative Service Provider of the TN or block object	
		string 		lAltSpid; //lAltSpid: contains 4 alphanumeric characters that identify the current Last Alternative Service Provider of the TN or block object
		string 		lineType; //lineType: includes the current line type of the TN or block object
																							//The Line Type will be non-null when there is a Line Type associated with the TN or block object. 
																							//It will always be null for delete and code transactions.
																								//Allowed values:
																								//0 for Wireline
																								//1 for Wireless
																								//2 for Class 2 Interconnected VoIP
																								//3 for VoWIFI
																								//4 for Prepaid Wireless
																								//5 for Class 1 Interconnected VoIP provider and Class 2 interconnected VoIP provider, eligible for direct assignment of
																								//              NANP numbering resources from the NANPA and PA.
																								//6 for SV Type 6
																								//7 for SV Type 7
																								//8 for SV Type 8
																								//9 for SV Type 9	
		string255 filename{virtual (logicalfilename)}; 
	END;	
	
	EXPORT PortData_Validate_Historical := RECORD
	  string 		tid ; 		//Transaction Identifier: is a sequence number that uniquely identifies a transaction
		string 		action; 	//Action: identifies the action that caused one of the SALT fields to change
																							//Allowed values:
																							//u - update for TNs or blocks
																							//d - delete for TNs, blocks, or codes
																							//m - migrate for TNs, blocks or codes
		string 		actTs; 		//Activity Timestamp: identifies the action that caused one of the SALT fields to change	
		string 		digits; 	//Digits: contains a 10-digit telephone number, a 7-digit block, or a 6-digit code	
		string 		spid; 		//Spid: contains 4 alphanumeric characters that identify the network Service Provider of the TN, block or code object
		string 		altSpid; 	//altSpid: contains 4 alphanumeric characters that identify the current Alternative Service Provider of the TN or block object	
		string 		lAltSpid; //lAltSpid: contains 4 alphanumeric characters that identify the current Last Alternative Service Provider of the TN or block object
		string 		lineType; //lineType: includes the current line type of the TN or block object
																							//The Line Type will be non-null when there is a Line Type associated with the TN or block object. 
																							//It will always be null for delete and code transactions.
																								//Allowed values:
																								//0 for Wireline
																								//1 for Wireless
																								//2 for Class 2 Interconnected VoIP
																								//3 for VoWIFI
																								//4 for Prepaid Wireless
																								//5 for Class 1 Interconnected VoIP provider and Class 2 interconnected VoIP provider, eligible for direct assignment of
																								//              NANP numbering resources from the NANPA and PA.
																								//6 for SV Type 6
																								//7 for SV Type 7
																								//8 for SV Type 8
																								//9 for SV Type 9	
		string255 filename; 
	END;
	
	EXPORT Intermediate := RECORD
	  unsigned  groupid			:= 0;
		string1   action_code := '';			
		string3   country_code;
		string10  phone;
		string1   dial_type;
		string6   spid;
		string1   service_type;
		string10  routing_code;
		string    porting_dt;
		string2   country_abbr;
		string255 filename;											//Original File Name Received
		string		file_dt_time;									//File Name Date and Time - Sort Files
		string		vendor_first_reported_dt;			//File Date First Added
		string		vendor_last_reported_dt;			//File Date Last Updated
		string		port_start_dt;								//Port Start Date
		string	 	port_end_dt;									//Port End Date (Last Update)
		string 		remove_port_dt;								//Disconnect Date
		boolean		is_ported := false;
		string    alt_spid;
		string    lalt_spid;
	END;
	
	EXPORT Intermediate_Temp := RECORD
		Intermediate;
		integer uniqueid;
		string ocn;
	END;
	
	EXPORT Intermediate_PortData_Validate := RECORD
	  unsigned  groupid			:= 0;
		string1   action_code := '';			
		string3   country_code;
		string10  phone;
		string1   dial_type;
		string6   spid;
		string 		alt_spid;
		string 		lalt_spid;
		string 		line_type;
		string1   service_type;
		string10  routing_code;
		string    porting_dt;
		string2   country_abbr;
		string255 filename;											//Original File Name Received
		string		file_dt_time;									//File Name Date and Time - Sort Files
		string		vendor_first_reported_dt;			//File Date First Added
		string		vendor_last_reported_dt;			//File Date Last Updated
		string		port_start_dt;								//Port Start Date
		string	 	port_end_dt;									//Port End Date (Last Update)
		string 		remove_port_dt;								//Disconnect Date
		boolean		is_ported := false;
	END;
	
	EXPORT Main := RECORD
		string3   country_code;
		string10  phone;
		string1   dial_type;
		string6   spid;
		string		service_provider;
		string1   service_type;
		string10  routing_code;
		string    porting_dt;
		string2   country_abbr;
		string255 filename;											//Original File Name Received
		string		file_dt_time;									//File Name Date and Time - Sort Files
		string		vendor_first_reported_dt;			//File Date First Added
		string		vendor_last_reported_dt;			//File Date Last Updated
		string		port_start_dt;								//Port Start Date
		string	 	port_end_dt;									//Port End Date (Last Update)
		string 		remove_port_dt;								//Disconnect Date
		boolean		is_ported;										//Latest Active Record
		string 		alt_spid;
		string 		lalt_spid;
	END;
	
	EXPORT Main_PortData_Validate := RECORD
		string3   country_code;
		string10  phone;
		string1   dial_type;
		string6   spid;
		string		service_provider;
		string1   service_type;
		string 		alt_spid;
		string60  alt_service_provider;
		string 		lalt_spid;	
		string60  lalt_service_provider;
		string 		line_type;
		string10  routing_code;
		string    porting_dt;
		string2   country_abbr;
		string255 filename;											//Original File Name Received
		string		file_dt_time;									//File Name Date and Time - Sort Files
		string		vendor_first_reported_dt;			//File Date First Added
		string		vendor_last_reported_dt;			//File Date Last Updated
		string		port_start_dt;								//Port Start Date
		string	 	port_end_dt;									//Port End Date (Last Update)
		string 		remove_port_dt;								//Disconnect Date
		boolean		is_ported;										//Latest Active Record
	END;

	EXPORT Phones_Transaction_Main_PDV := RECORD
		dx_PhonesInfo.Layouts.Phones_Transaction_Main-[alt_spid, lalt_spid];
		string 		alt_spid;
		string 		lalt_spid;
		string 		line_type;
	END;

	EXPORT History := RECORD
		string1   action_code;	
		string3   country_code; 
		string10  phone;		
		string1   dial_type;		
		string6   spid;					
		string1   service_type;	
		string10  routing_code;	
		string    porting_dt;	
		string2   country_abbr;
		string255 filename;
	END;
	
	EXPORT SPID := RECORD
		string		spid;
		string		country_code;
		string		operator_fullname;
		string		iso2;
		string		data_type;					//B - Both
																	//R - Range
																	//P - Port
		string 		dt_time_entered;
	END;

END;