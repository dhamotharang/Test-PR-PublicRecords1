IMPORT Address, AID, BIPV2;

EXPORT Layouts := MODULE

	////////////////////////////////////////////////////////////////////////
	// -- Input Layout 
	////////////////////////////////////////////////////////////////////////
  EXPORT Sprayed_Input := RECORD
		string10	PID	;										// Infutor Persistent Record ID
		string20	record_id	;							// Record ID - First 3 digits are main source then unique number
		string9		ein	;										// Electronic ID Number
		string100	Busname	;								// Company Name
		string75	TradeName	;							// Company Trade Name
		string20	House	;									// Address Street Number 
		string12	PreDirection	;					// Address Pre Direction
		string80	Street	;								// Address Street Name
		string14	StrType	;								// Address Street Suffix
		string12	PostDirection	;				  // Address Post Direction
		string14	AptType	;								// Address Unit Type
		string12	AptNbr	;								// Address Unit Number
		string50	city	;									// Address City
		string2		state	;									// Address State
		string5		zip5	;									// Address Zip 5
		string4		zipLast4	;							// Address Zip 4
		string3		Dpc	;										// Address Delivery Point Code with Check Digit
		string4		carrier_route	;					// Address Carrier Route: B, C, G, H, R then followed by three digits
		string1		address_type_code	;			// Address Type:  F, G, H, P, R, S
		string1		DPV_Code	;							// Address Delivery Point Validation Code: Y, D, S, N, or blank
		string1		Mailable	;							// Address Mailable: Y or N
		string3		county_code	;						// Address FIPS County Code
		string6		CensusTract	;						// Address Census Tract
		string1		CensusBlockGroup	;			// Address Census Block Group
		string4		CensusBlock	;						// Address Census Block
		string2		congress_code	;					// Address Congressional Code representing congressional district
		string4		msacode	;								// Address Metropolitan Statistical Area code
		string2		timezonecode	;					// Address Timezone code 
		string20	latitude	;							// Address Latititude
		string20	longitude	;							// Address Longtitude
		string500	url	;										// Company URL/Websites separated by semicolons (;)
		string10	telephone	;							// Telephone Number
		string10	toll_free_number	;			// Toll Free Number
		string10	fax	;										// Fax Number
		string8		SIC1	;									// Standard Industry Classification 1
		string8		SIC2	;									// Standard Industry Classification 2
		string8		SIC3	;									// Standard Industry Classification 3	
		string8		SIC4	;									// Standard Industry Classification 4
		string8		SIC5	;									// Standard Industry Classification 5	
		string1		STDClass	;							// Industry Code of first 2 positions of the first SIC
		string100	Heading1	;							// Business Classification Heading 1
		string100	Heading2	;							// Business Classification Heading 2
		string100	Heading3	;							// Business Classification Heading 3
		string100	Heading4	;							// Business Classification Heading 4
		string100	Heading5	;							// Business Classification Heading 5
		string50	business_specialty	;		// Nature of the Company's Business	
		string1		sales_code	;						// Company's sales code associated with sales volume: A-J or blank
		string1		employee_code	;					// Company's employee code associated with number of employees: A-I or blank
		string1		location_type	;					// Type of Business Location:  S, H, B
		string75	parent_company	;				// Parent Company's Name
		string130	parent_address	;				// Parent Company's Address Street
		string50	parent_city	;						// Parent Company's Address City
		string3		parent_state	;					// Parent Company's Address State or Country if foreign
		string20	parent_zip	;						// Parent Company's Address Zip (9-digit if US address)
		string10	parent_phone	;					// Parent Company's Telephone Number
		string50	stock_symbol	;					// Company's stock symbol
		string50	stock_exchange	;				// Company's stock exchange
		string1		public	;								// If is a public company, then Y, otherwise blank
		string50	number_of_pcs	;					// Range for the number of PCs (computers) in the company
		string50	square_footage	;				// Range for the company's square footage
		string25	business_type	;					// Company's Business Type
		string2		incorporation_state	;		// State the company is incorporated in
		string1		minority	;							// If is a minority company, then Y, otherwise blank
		string1		woman	;									// If is a woman owned company, then Y, otherwise blank
		string1		government	;						// If is a government company, then Y, otherwise blank
		string1		small	;									// If is a small company, then Y, otherwise blank
		string1		home_office	;						// If is a home office, then Y, otherwise blank
		string1		soho	;									// If is a home office or small company, then Y, otherwise blank
		string1		franchise	;							// If is a franchise, then Y, otherwise blank
		string1		phoneable	;							// If a phone number is present in telephone field, then Y, otherwise blank
		string32	prefix	;								// Contact Prefix
		string32	first_name	;						// Contact First Name
		string32	middle_name	;						// Contact Middle Name
		string32	surname	;								// Contact Last Name
		string12	suffix	;								// Contact Name Suffix
		string4		birth_year	;						// Contact Birth Year
		string25	ethnicity	;							// Contact Ethnicity
		string1		gender	;								// Contact Gender:  M or F							
		string500	email	;									// Contact Emails separated by semicolons (;)
		string100	Contact_Title	;					// Contact Title
		string4		year_started	;					// Year the Company was started/established
		string6		date_added	;						// Date the record was added to the file
		string8		ValidationDate	;				// Date the records was last validated
		string1		Internal1	;							// Internal Use
		string1		Dacd	;									// If is present in Directory Assistance, then Y, otherwise blank
  END;   
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layout
	////////////////////////////////////////////////////////////////////////
	EXPORT Base := RECORD	
		STRING6    										source                            := '';
		UNSIGNED6   									rcid                              := 0;
	 	BIPV2.IDlayouts.l_xlink_ids;
		UNSIGNED6											did													      := 0;
	  UNSIGNED1											did_score										      := 0;
		UNSIGNED4 										dt_first_seen								      := 0;
	  UNSIGNED4 										dt_last_seen								      := 0;
	  UNSIGNED4 										dt_vendor_first_reported		      := 0;
	  UNSIGNED4 										dt_vendor_last_reported			      := 0;
		UNSIGNED4   									process_date                      := 0;
		STRING1												record_type									      := '';
    Sprayed_Input;
	  STRING1												normCompany_Type                  := ''; // B (Business), P (Parent Company), T (TradeName)
		STRING100											normCompany_Name                  := '';
		STRING150   									normCompany_Street 				        := '';
		STRING50    									normCompany_City                  := '';
		STRING3    										normCompany_State                 := '';
		STRING20    									normCompany_Zip                   := '';
		STRING10    									normCompany_Phone                 := '';
    STRING100   									clean_company_name                := '';
		STRING10    									clean_phone                       := '';
	  Address.Layout_Clean_Name; 
		Address.Layout_Clean182_fips; 
		UNSIGNED8											raw_aid														:= 0;
		UNSIGNED8											ace_aid														:= 0;
	  STRING100											prep_address_line1		    			 	:= '';
	  STRING50											prep_address_line_last		    		:= '';
  END; //End Base
	
  		
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	EXPORT Temp := MODULE
	
	  EXPORT DidSlim := RECORD
			UNSIGNED8		unique_id   := 0;
			STRING20 		fname;
			STRING20 		mname;
			STRING20 		lname;
			STRING5  		name_suffix;
			STRING10  	prim_range;
			STRING28		prim_name;
			STRING8			sec_range;
			STRING5			zip5;
			STRING2			state;
			STRING10		phone;
			UNSIGNED6		did         := 0;
			UNSIGNED1		did_score		:= 0;
	  END;

	  EXPORT BIPSlim := RECORD
			UNSIGNED8		unique_id;
			STRING80  	company;
			STRING10  	prim_range;
			STRING28		prim_name;
			STRING8			sec_range;
			STRING25 		city;   		      // p_city
			STRING2			state;
			STRING5			zip5;
			STRING20 		fname;
			STRING20 		mname;
			STRING20 		lname;
			STRING10		phone;
			STRING      url;
			STRING      email;
			BIPV2.IDlayouts.l_xlink_ids;
	  END;
		
	  EXPORT UniqueId := RECORD
 		  UNSIGNED8		unique_id;
		  Base;
		END;
    
	END;  //End Temporary
	
END;  //End Layouts