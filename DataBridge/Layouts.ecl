import BIPV2, Address;

export Layouts := module

 	export Sprayed_Input := record
		string30	Name;                    //Contact Full Name     
		string50	Company;                 //Business Name
		string30	Address;                 //Primary Address
		string30	Address2;                //Additional Primary Address Info
		string20	City;
		string2	  State;
		string3	  SCF;
		string5	  Zip_Code5;
		string4	  Zip_Code4;
		string1	  Mail_Score;
		string3	  Area_Code;
		string10	Telephone_Number;
		string1	  Name_Gender;
		string10	Name_Prefix;
		string20	Name_First;
		string1	  Name_Middle_Initial;
		string20	Name_Last;
		string10	Suffix;
		string4	  Title_Code_1;
		string4	  Title_Code_2;
		string4	  Title_Code_3;
		string4	  Title_Code_4;
		string50	Web_Address;
		string8	  SIC8_1;
		string8	  SIC8_2;
		string8	  SIC8_3;
		string8	  SIC8_4;
		string6	  SIC6_1;
		string6	  SIC6_2;
		string6	  SIC6_3;
		string6	  SIC6_4;
		string6	  SIC6_5;
		string6   Transaction_date;
		string10	Database_Site_ID;
		string10	Database_Individual_ID;   
		string50	Email;
		string1	  Email_Present_Flag;
		string1	  Site_Source1;
		string1	  Site_Source2;
		string1	  Site_Source3;
		string1	  Site_Source4;
		string1	  Site_Source5;
		string1	  Site_Source6;
		string1	  Site_Source7;
		string1	  Site_Source8;
		string1	  Site_Source9;
		string1	  Site_Source10;
		string1	  Individual_Source1;
		string1	  Individual_Source2;
		string1	  Individual_Source3;
		string1	  Individual_Source4;
		string1	  Individual_Source5;
		string1	  Individual_Source6;
		string1	  Individual_Source7;
		string1	  Individual_Source8;
		string1	  Individual_Source9;
		string1	  Individual_Source10;
		string7	  Email_Status;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=	record
	  string6    							   			source                      := '';
		//unsigned6     									rcid                        :=  0;
		unsigned4                       global_sid                       ; //this is a unique source ID that will be coming from Orbit.
		unsigned8                       record_sid                       ; //this is a source specific unique and persistent record id (from SALT).  
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6												did													:=  0;
	  unsigned1											  did_score							      :=  0;
  	unsigned4 											dt_first_seen								     ;
		unsigned4 											dt_last_seen								     ;
		unsigned4 											dt_vendor_first_reported		     ;
		unsigned4 											dt_vendor_last_reported			     ;
    unsigned4 											process_date          			     ;																											
 		string1												  record_type								  := '';
		string100   									  clean_company_name          := '';
		string3                         clean_area_code             := '';
		string10    									  clean_telephone_num         := '';
		string13                        Mail_Score_Desc             := '';
		string9                         Name_Gender_Desc            := '';
		string40	                      Title_Desc_1                := '';
		string40	                      Title_Desc_2                := ''; 
		string40	                      Title_Desc_3                := '';               
		string40	                      Title_Desc_4                := '';
		string50                        Web_Address1                := '';
		string50                        Web_Address2                := '';
		string50                        Web_Address3                := '';
		string75                        SIC8_Desc_1                 := '';
		string75                        SIC8_Desc_2                 := '';
		string75                        SIC8_Desc_3                 := '';
		string75                        SIC8_Desc_4                 := '';
		string75                        SIC6_Desc_1                 := '';
		string75                        SIC6_Desc_2                 := '';
		string75                        SIC6_Desc_3                 := '';
		string75                        SIC6_Desc_4                 := '';
		string75                        SIC6_Desc_5                 := '';
		string50                        Email1                      := '';
		string50                        Email2                      := '';
		string50                        Email3                      := '';
		Sprayed_Input;
		Address.Layout_Clean_Name; 
		Address.Layout_Clean182_fips; 
		unsigned8												raw_aid											:=  0;
		unsigned8												ace_aid										 	:=  0;
		string100												prep_address_line1		  	 	:= '';
		string50												prep_address_line_last		 	:= '';
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layout
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=record	
	  Base -[Web_Address, Email];
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temp := module
	
		export StandardizeInput := record
			unsigned8		unique_id	;
			Base ;
		end;
		
		export DidSlim := record
			unsigned8		unique_id   := 0;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string5  		name_suffix;
			string10  	prim_range;
			string28		prim_name;
			string8			sec_range;
			string5			zip5;
			string2			state;
			string10		phone;
			unsigned6		did         := 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BIPSlim := record
			unsigned8		unique_id;
			string80  	company;
			string10  	prim_range;
			string28		prim_name;
			string8			sec_range;
			string25 		city;   		      // p_city
			string2			state;
			string5			zip5;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string10		phone;
			string      url;
			string      email;
			BIPV2.IDlayouts.l_xlink_ids;
	  end;
		
	  export UniqueId := record
 		  unsigned8		unique_id;
		  Base;
		end;
		
	end;  //Temporary
end;