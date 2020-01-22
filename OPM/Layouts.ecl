import BIPV2, Address;

export Layouts := module

 	export Sprayed_Input := record //Raw Vendor Layout 
	
		string	Employee_Name ;
		string	Duty_Station	;
		string	Country				;
		string	State					;
		string	City					;
		string	County				;
		string	Agency				;
		string	Agency_Sub_Element  ;
		string	Computation_Date	  ;
		string	Occupational_Series ;
		string  File_Date ;

	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
 	export Base :=	record
   	  string6    							   			source                      := '';
   		unsigned4                       global_sid                       ; //this is a unique source ID that will be coming from Orbit.
   		unsigned8                       record_sid                       ; //this is a source specific unique and persistent record id (from SALT).  
   		BIPV2.IDlayouts.l_xlink_ids;
   		unsigned6												did													:= 0;
   	  unsigned1											  did_score							      := 0;
			string9	                        ssn                         := ''; //derivied ssn macro (MAC_Add_SSN_By_DID)
     	unsigned4 											dt_first_seen								     ;
   		unsigned4 											dt_last_seen								     ;
   		unsigned4 											dt_vendor_first_reported		     ;
   		unsigned4 											dt_vendor_last_reported			     ;
      unsigned4 											process_date          			     ;																											
    	string1												  record_type								  := '';   
      Sprayed_Input;
			string2	                        State_Code	;			
			string5   										  zip5                        := ''; //derivied from (city,st)
			string	Occu_Series_Desc;
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
   	  Base ;
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
   			unsigned6		did         := 0;
   			unsigned1		did_score		:= 0;
				string9	    ssn         := '';
   			string20 		fname;
   			string20 		mname;
   			string20 		lname;
   			string5  		name_suffix;
				string10  	prim_range;
			  string28		prim_name;
				string8			sec_range;
				string5			zip5;
				string2		  State_Code	;
   	  end;
    		
   	 export BIPSlim := record
			unsigned8		unique_id;	
			string120   business_name; 
			string10  	prim_range;
			string28		prim_name;
			string8			sec_range;
			string25 		city;   		      
			string2			state_Code;
			string5			zip5;
			string20 		fname;
			string20 		mname;
			string20 		lname;			
			BIPV2.IDlayouts.l_xlink_ids;
	  end;
		
	  export UniqueId := record
 		  unsigned8		unique_id;
		  Base;
		end;
   		
  end;  

end;