IMPORT address, AID,Orbit3SOA;

EXPORT layouts := MODULE
		
	EXPORT MasterList	:= RECORD
		STRING LNfileCategory;
		STRING LNsourcetCode;
		STRING vendorName;
		STRING Address1;
		STRING Address2;
		STRING City;
		STRING State;
		STRING ZipCode;
		STRING Phone;
	END;
	
	
	EXPORT Bank_Court	:= RECORD
	  STRING    LNCourtCode;
		STRING		RMScourt_code;
		STRING		court_name;
		STRING		address1;
		STRING		address2;
		STRING		city;
		STRING		state;
		STRING		zip;
		STRING		phone;
	END;
	
	EXPORT Lien_Court	:= RECORD
	  STRING    LNCourtCode;
		STRING 		RMScourt_code;
		STRING		court_name;
		STRING		address1;
		STRING		address2;
		STRING		city;
		STRING		state;
		STRING		zip;
		STRING		phone;
	END;
	
	EXPORT Court_Locations	:= RECORD
		string5		FipsCode;
		string2		StateFIPS;
		string3		CountyFips;
		STRING 		CourtID;
		STRING		ConsolidatedCourtID;
		string		MasterID;
		string		StateOfService;
		string		CountyOfService;
		STRING		CourtName;
		string		Phone;
		STRING		Address1;
		STRING		Address2;
		STRING		city;
		STRING		state;
		STRING5		ZipCode;
		string4		Zip4;
		STRING		MailAddress1;
		STRING		MailAddress2;
		STRING		MailCity;
		STRING		MailCtate;
		STRING5		MailZipCode;
		string4		MailZip4;
	END;	
	
	EXPORT Riskview_FFD	:= RECORD
		STRING		item_id;												// column A
		STRING		item_name;											// column B
		STRING		item_description;								// column C
		STRING		status_name;										// column D
		STRING		item_source_code;								// column E
		STRING		source_id;											// column F
		STRING		source_name;										// column G
		STRING		source_address1;								// column H
		STRING		source_address2;								// column I 
		STRING		source_city;										// column J
		STRING		source_state;										// column K
		STRING		source_zip;											// column L
		STRING		source_phone;										// column M
		STRING		source_website;									// column N
		STRING		unused_source_sourceCodes;			// column O
		STRING		unused_fcra;										// column P
		STRING		unused_fcra_comments;						// column Q
		STRING		market_restrict_flag;						// column R
		STRING		unused_market_comments;					// column S
		STRING		unused_contact_category_name;		// column T
		STRING		unused_contact_name;						// column U
		STRING		unused_contact_phone;						// column V
		STRING		unused_contact_email;						// column W
	END;
	
		// EXPORT Orbit	:= RECORD
// Riskview_FFD ;
// end;
   

	EXPORT MergedSrc_Base	:= RECORD
																				// Bank/Lien Court Match				// Riskview/FFD
		STRING		item_source;							//  court_code 		(col A)				//	item_source_code			
		STRING75	source_code;							//	court_code 		(col A)				//	item_source_code			
		STRING		display_name;							//	court_name 		(col B)				//	source_name							
		STRING		description;							//	court_name 		(col B)				//	item_description			
		STRING		status;										//	court_name 		(col B)				//	status_name						
		STRING		data_notes;								//		<no match>								//		<no match>
		STRING		coverage_1;								//		<no match>								//		<no match>
		STRING		coverage_2;								//		<no match>								//		<no match>
		STRING		orbit_item_name;					//		<no match>								//	item_name							
		STRING		orbit_source;							//		<no match>								//	item_source_id				
		STRING		orbit_number;							//		<no match>								//	item_id								
		STRING		website;									//		<no match>								//	source_website				
		STRING		notes;										//		<no match>								//		<no match>
		STRING		date_added;								//	<from build_all date>				//	<from build_all date>
		STRING		input_file_id;						//	BANKRUPTCY - or- LIEN 			//	(left blank for now)
		STRING		market_restrict_flag;			//		<no match>								//	market_restrict_flag	
		STRING10  clean_phone;							//	phone				(col H)					//	source_phone					
		STRING10	clean_fax;								//		<no match>								//
		STRING65  Prepped_addr1;						//	address cleaner fields 			//	(based on source address fields)
		STRING35  Prepped_addr2;
		STRING28  v_prim_name;
		STRING5   v_zip;
		STRING4   v_zip4;
		STRING		prim_range;
		STRING		predir;
		STRING		prim_name;
		STRING		addr_suffix;
		STRING		postdir;
		STRING		unit_desig;
		STRING		sec_range;
		STRING		p_city_name;
		STRING		v_city_name;
		STRING		st;
		STRING		zip;
		STRING		zip4;
		STRING		cart;
		STRING		cr_sort_sz;
		STRING		lot;
		STRING		lot_order;
		STRING		dbpc;
		STRING		chk_digit;
		STRING		rec_type;
		STRING		county;
		STRING		geo_lat;
		STRING		geo_long;
		STRING		msa;
		STRING		geo_blk;
		STRING		geo_match;
		STRING		err_stat;

	END;
	
	EXPORT Base	:= RECORD
MergedSrc_Base ;
end;
   
	 
EXPORT Orbit := RECORD
	 
		string    item_id                       {xpath('d[k="819"]/v')};       // Legacy Id 
		string    item_name                     {xpath('d[k="21"]/v')};        // Dataset Name                   
		string    item_description              {xpath('d[k="15"]/v')};        // Dataset Description                              
		string    status_name                   {xpath('d[k="24"]/v')};        // Dataset Status                
		string    item_source_code              {xpath('d[k="721"]/v')};       // Dataset Source Codes         
		string    source_id                     {xpath('d[k="821"]/v')};       // Company Id - from Dataset Id - 18                  
		string    source_name                   {xpath('d[k="709"]/v')};       // Company Name                    
		string    source_address1               {xpath('d[k="701"]/v')};       // Company Address                  
		string    source_address2               {xpath('d[k="703"]/v')};       // Company Address 2            
		string    source_city                   {xpath('d[k="705"]/v')};       // Company City                  
		string    source_state                  {xpath('d[k="715"]/v')};       // Company State            
		string    source_zip                    {xpath('d[k="719"]/v')};       // Company Zip                     
		string    source_phone                  {xpath('d[k="711"]/v')};       // Company Phone 
		string    source_website                {xpath('d[k="717"]/v')};       // Company Website   
		string    unused_source_sourceCodes     := ''; //{xpath('d[k="713"]/v')};       // Company Source Codes - 607?
		// The following are blank fields but are necessary for the recordset 
		string    unused_fcra                   := ''; // xpath('d[k="619"]/v')};       // Restriction FCRA Use Permitted  
		string    unused_fcra_comments          := ''; // xpath('d[k="651"]/v')};       // Restriction Comment FCRA Use Permitted        
		string    market_restrict_flag          {xpath('d[k="607"]/v')};                // Restriction Marketing Restrictions - 599     
		string    unused_market_comments        := ''; // xpath('d[k="631"]/v')};       // Restriction Comment Marketing Restrictions    
		string    unused_contact_category_name  := ''; // xpath('d[k="723"]/v')};       // Contact Info
		string    unused_contact_name           := ''; // xpath('d[k="723"]/v')};       // Contact Info          
		string    unused_contact_phone          := ''; // xpath('d[k="723"]/v')};       // Contact Info       
		string    unused_contact_email          := ''; // xpath('d[k="723"]/v')};       // Contact Info 
end;

EXPORT InputRecord := record
		string   token {xpath('token')}           := Orbit3SOA.GetToken('Prod');
		integer  offset {xpath('offset')}         := 0;
		integer  count {xpath('count')}           := 1000000; 
		string   reportName {xpath('reportName')} := 'Dataset';
		string   viewType {xpath('viewName')}     := 'FFD No Filters';
		
END;
   			 
END;