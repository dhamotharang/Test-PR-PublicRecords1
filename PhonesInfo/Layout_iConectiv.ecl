EXPORT Layout_iConectiv := MODULE

	EXPORT Daily := RECORD
		string1   action_code;		//A-Add for incremental, bulk
															//U-Updt for incremental, bulk
															//D-Delete for incremental only (Not Applicable for bulk)
														
		string3   country_code; 	//Country Code (CC), variable length up to 3 digits
		
		string12  phone;					//Dial Code (nationally significant TN or NDC), excludes CC, variable length up to 12 digits
		
		string1   dial_type;			//Dial Code Type (DCT)
															//For Country Code CC = Ã¢â‚¬Å“1Ã¢â‚¬Â:
															//T, a North American 1+10-digit TN.
															//B, a North American 1+7-digit 1000s Block code.
															//N, a North American 1+6-digit NPA-NXX code.
														
															//For Country Code (CC) other than Ã¢â‚¬Å“1Ã¢â‚¬Â:
															//E, an international TN, CC+NN, variable length up to 15 digits.
															//C, an international NDC, CC+NDC, variable length, typically 4-7 digits.
														
		string6   spid;						//Telecordia Mobile Id Provider Id for the company serving the queried TN
		
		string1   service_type;		//Type of Service (TOS)
															//G Ã¢â‚¬â€œ Geographic (or fixed line)
															//M Ã¢â‚¬â€œ Mobile
															//O Ã¢â‚¬â€œ Other
															//U - Unknown
														
		string10  routing_code;		//Routing Prefix - if available; otherwise empty field, variable length, typically up to 8 digits, for U.S. and Canada, the Routing Code is the LRN of 10 digits.
		
		string    porting_dt;			//Date and Time of Porting
		
		string2   country_abbr;		//Country Code, two-letter ISO abbreviation for country name
		
		string255 filename{virtual (logicalfilename)}; //Logical File Name (Must Force to Thor to View)
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
	END;
	
	EXPORT Intermediate_Temp := RECORD
		Intermediate;
		integer uniqueid;
		string ocn;
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
	END;
	
	EXPORT PatchMain := record
		integer num;
		Main;
	end;

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