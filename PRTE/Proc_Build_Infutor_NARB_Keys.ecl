import	_control;

export Proc_Build_Infutor_NARB_Keys(STRING pIndexVersion) := function

	rKeyInfutor_NARB__linkid	:= RECORD
		STRING6   source;
		UNSIGNED6 rcid;
	 	UNSIGNED6 ultid;
		UNSIGNED6 orgid;
		UNSIGNED6 seleid;
		UNSIGNED6 proxid;
		UNSIGNED6 powid;
		UNSIGNED6 empid;
		UNSIGNED6 dotid;
		UNSIGNED2 ultscore;
		UNSIGNED2 orgscore;
		UNSIGNED2 selescore;
		UNSIGNED2 proxscore;
		UNSIGNED2 powscore;
		UNSIGNED2 empscore;
		UNSIGNED2 dotscore;
		UNSIGNED2 ultweight;
		UNSIGNED2 orgweight;
		UNSIGNED2 seleweight;
		UNSIGNED2 proxweight;
		UNSIGNED2 powweight;
		UNSIGNED2 empweight;
		UNSIGNED2 dotweight;
		UNSIGNED6 did;
	  UNSIGNED1 did_score;
		UNSIGNED4 dt_first_seen;
	  UNSIGNED4 dt_last_seen;
	  UNSIGNED4 dt_vendor_first_reported;
	  UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED4 process_date;
		STRING1   record_type;
	  STRING10	PID;										 
		STRING20	record_id;							 
		STRING9		ein;										 
		STRING100	Busname;								 
		STRING75	TradeName;							 
		STRING20	House;									 
		STRING12	PreDirection;					 
		STRING80	Street;								 
		STRING14	StrType;								 
		STRING12	PostDirection;				   
		STRING14	AptType;								 
		STRING12	AptNbr;								 
		STRING50	city;									 
		STRING2		state;									 
		STRING5		zip5;									 
		STRING4		zipLast4;							 
		STRING3		Dpc;										 
		STRING4		carrier_route;					 
		STRING1		address_type_code;			 
		STRING1		DPV_Code;							 
		STRING1		Mailable;							 
		STRING3		county_code;						 
		STRING6		CensusTract;						 
		STRING1		CensusBlockGroup;			 
		STRING4		CensusBlock;						 
		STRING2		congress_code;					 
		STRING4		msacode;								 
		STRING2		timezonecode;					  
		STRING20	latitude;							 
		STRING20	longitude;							  
		STRING500	url;										 
		STRING10	telephone;							 
		STRING10	toll_free_number;			 
		STRING10	fax;										 
		STRING8		SIC1;									 
		STRING8		SIC2;									 
		STRING8		SIC3;									 
		STRING8		SIC4;									 
		STRING8		SIC5;									 
		STRING1		STDClass;							 
		STRING100	Heading1;							 
		STRING100	Heading2;							 
		STRING100	Heading3;							 
		STRING100	Heading4;							 
		STRING100	Heading5;							 
		STRING50	business_specialty;		 
		STRING1		sales_code;						 
		STRING1		employee_code;					 
		STRING1		location_type;					 
		STRING75	parent_company;				 
		STRING130	parent_address;				 
		STRING50	parent_city;						 
		STRING3		parent_state;					 
		STRING20	parent_zip;						 
		STRING10	parent_phone;					 
		STRING50	stock_symbol;					 
		STRING50	stock_exchange;				 
		STRING1		public;							 
		STRING50	number_of_pcs;					 
		STRING50	square_footage;				 
		STRING25	business_type;					
		STRING2		incorporation_state;		
		STRING1		minority;							
		STRING1		woman;									
		STRING1		government;						
		STRING1		small;								
		STRING1		home_office;						
		STRING1		soho;									
		STRING1		franchise;							
		STRING1		phoneable;							
		STRING32	prefix;								
		STRING32	first_name;						
		STRING32	middle_name;						
		STRING32	surname;								
		STRING12	suffix;								
		STRING4		birth_year;						
		STRING25	ethnicity;							
		STRING1		gender;														
		STRING500	email;									
		STRING100	Contact_Title;					
		STRING4		year_started;					
		STRING6		date_added;						
		STRING8		ValidationDate;				
		STRING1		Internal1;							
		STRING1		Dacd;						
	  STRING1		normCompany_Type; 
		STRING100	normCompany_Name;
		STRING150 normCompany_Street;
		STRING50  normCompany_City;
		STRING3   normCompany_State;
		STRING20  normCompany_Zip;
		STRING10  normCompany_Phone;
    STRING100 clean_company_name;
		STRING10  clean_phone;
	  STRING5   title;
		STRING20  fname;
		STRING20  mname;
		STRING20  lname;
		STRING5   name_suffix;
		STRING3   name_score;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  p_city_name;
		STRING25  v_city_name;
		STRING2   st;
		STRING5   zip;
		STRING4   zip4;
		STRING4   cart;
		STRING1   cr_sort_sz;
		STRING4   lot;
		STRING1   lot_order;
		STRING2   dbpc;
		STRING1   chk_digit;
		STRING2   rec_type;
		STRING2   fips_state;
		STRING3   fips_county;
		STRING10  geo_lat;
		STRING11  geo_long;
		STRING4   msa;
		STRING7   geo_blk;
		STRING1   geo_match;
		STRING4   err_stat;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
	  STRING100 prep_address_line1;
	  STRING50  prep_address_line_last;
		INTEGER1  fp;
	end;

	ds_linkid						:= dataset([],rKeyInfutor_NARB__linkid);
		
	linkid_IN			  		:= index(ds_linkid, 			 {ultid,orgid,seleid,proxid,powid,empid,dotid},
													 {ds_linkid}, 		 '~prte::key::Infutor_NARB::'+pIndexVersion+'::linkids');
	
	return	sequential(	
								build(linkid_IN, update),
								
								PRTE.UpdateVersion('InfutorNARBKeys',				   			//	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );

end;