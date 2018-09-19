import address, LiensV2, bipv2;
export Layouts :=
module

  shared max_size := _Constants().max_record_size;

	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	//////////////////////////////////////////////////////////////////////// 
	export Input :=
	module
		
	export Sprayed := 
		record
		  STRING CU_Number;
			STRING cycle_date;
			STRING join_number;
			STRING SiteId;
			STRING CU_Name;
			STRING SiteName;
			STRING SiteTypeName;
			STRING MainOffice;
			STRING PhysicalAddressLine1;
			STRING PhysicalAddressLine2;
			STRING PhysicalAddressCity;
			STRING PhysicalAddressStateCode;
			STRING PhysicalAddressPostalCode;
			STRING PhysicalAddressCountyName;
			STRING PhysicalAddressCountry;
			STRING MailingAddressLine1;
			STRING MailingAddressLine2;
			STRING MailingAddressCity;
			STRING MailingAddressStateCode;
			STRING MailingAddressStateName;
			STRING MailingAddressPostalCode;
			STRING PhoneNumber;
	end;

  
  //Fixed layout is based on the old base layout.  This layout is used for the keybuild.
	export Fixed := 
		record
			string7		Charter;     //CU_Number
			string35	CU_NAME;
			string35	Address1;
			string15	City;
			string5 	State;
			string10	Zip_Code;
			string35	Contact_Name;
			string10	Phone;
			string14	Assets;
			string14	Loans;
			string20	NetWorthRatio;
			string21	Perc_ShareGrowth;
			string21	Perc_LoanGrowth;
			string20	LoantoAssetsRatio;
			string17	InvestAssetsRatio;
			string10	NumMem;
			string8 	NumFull;
	 end;                        
	end;

    export NormRec	:=	record 
			/* Normalize the records to split the physical and mailing addresses */
			unsigned8	unique_id;
			string Charter;                    //CU_Number
			string cycle_date;                 //New Field
			string join_number;                //New Field
			string SiteId;                     //New Field
			string CU_Name;
			string SiteName;                   //New Field
			string SiteTypeName;               //New Field
			string MainOffice;                 //New Field
			string addrtype;                   
			string Address1;
			string Address2;                   //New Field
			string City;
			string State;
			string StateName;                  //New Field
			string Zip_Code;
			string CountyName;                 //New Field
			string Country;                    //New Field
			string Phone;
			string Contact_Name;               
			string Assets;
			string Loans;
			string NetWorthRatio;
			string Perc_ShareGrowth;
			string Perc_LoanGrowth;
			string LoantoAssetsRatio;
			string InvestAssetsRatio;
			string NumMem;
			string NumFull;
		end;
		
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	
  export Base :=
	record
	  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
		unsigned8 source_rec_id := 0; //Added for BIP project	
		unsigned6														did											:= 0;
		unsigned1														did_score										;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					raw_aid									:= 0;
		unsigned8							    					ace_aid									:= 0;
		unsigned8							    					mail_raw_aid						:= 0;
    unsigned8							    					mail_ace_aid						:= 0;		
		string1															record_type									;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		NormRec - unique_id;
		Address.Layout_Clean_Name						                    				;
		Address.Layout_Clean182_fips		                                ;
		string100														Prep_Addr_Line1					:='';
		string50														Prep_Addr_Line_Last			:='';
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layouts
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=
	record
		unsigned6														did											:= 0;
		unsigned1														did_score										;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					raw_aid									:= 0;
		unsigned8							    					ace_aid									:= 0;
		string1															record_type									;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		input.Fixed													rawfields										;
		Address.Layout_Clean_Name						clean_contact_name					;
		Address.Layout_Clean182_fips		    Clean_address								;
	end;
	
	export Keybuild_LinkIds :=
	record
    bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
		unsigned8 source_rec_id := 0; //Added for BIP project	
		keybuild;
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

    export TempRec := record
			unsigned8	unique_id;
			Input.Sprayed;
		end;
		
	  export StandardizeInput :=
	  record
			unsigned8		unique_id		 				;
			base 					 					 				;
	  end;
		
 	  export DidSlim := 
	  record
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix		  ;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range			 	;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned8		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state		 					;
			string10		phone		  		    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string25    city              ;
			string20    fname 				:='';
			string20    mname  				:='';
			string20    lname  				:='';
			bipv2.IDlayouts.l_xlink_ids   ;
			unsigned8 	source_rec_id := 0;
			string2     source            ;
	  end;
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;
		
	End;
	
end;