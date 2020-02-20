import address, LiensV2, bipv2;
export Layouts :=
module

  shared max_size := _Constants().max_record_size;
	
	////////////////////////////////////////////////////////////////////////
	// -- Miscellanous working Layouts
	////////////////////////////////////////////////////////////////////////
	export Miscellaneous :=
	module
	
		export Cleaned_Phones :=
		record

			string10 Phone					;
			string10 Fax						;

		end;
		
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export RSIH := 
		record
			string AvdaNumber;
			string AttorneyName;
			string BusinessName;
			string Address1;
			string Address2;
			string Phone;
			string Email;
			string Primary_Range_Cln;
			string Primary_Name_Cln;
			string Sec_Range_Cln;
			string Zip_Cln;
			string Did_Header_Addr_Count;
			string Did_Header_Phone_Count;
			string Did_PhonePlus_GongPhone_Count;
		end;                            	
				
		export CC := 
		record
      string ID             ;
      string BusinessName   ;
			string DBA            ;              
      string OrgID          ;
      string Address1       ;
      string Address2       ;
      string City           ;
      string State          ;
      string Zip            ;
      string Zip4           ;
      string Phone          ;
      string Fax            ;
      string Email          ;
      string URL            ;
      string Status         ;
      string LicenseDateFrom;
      string LicenseDateTo  ;
      string OrgType        ;
			string Source         ;              
		end;
		
		export Common := 
		record
			string5		 AvdaNumber;
			string35	 AttorneyName;
			string80	 BusinessName;
			string70	 DBA;
			string15	 OrgID;
			string70	 Address1;
			string70	 Address2;
			string30	 City;
			string2	   State;
			string5		 Zip;
			string4		 Zip4;
			string16	 Phone;
			string16	 Fax;
			string50	 Email;
			string50	 Url;
			string75	 Status;
			string8	 	 LicenseDateFrom;
			string8	 	 LicenseDateTo;
			string70	 Source;
			string50   Miscellaneous;
		end;                            	
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Prep Layouts
	////////////////////////////////////////////////////////////////////////
	export Prep := module
		export RSIH := record
			Input.RSIH;
			string Miscellaneous;
			string Source;
		end;
	end;
	
	// Jira# CCPA-358, The below layout with 2 new fields are added for CCPA (California Consumer Protection Act) project.
	// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
	export CCPA_fields := 
		record
			unsigned4 													global_sid 		:= 0;
			unsigned8 													record_sid 		:= 0;
		end;
		
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record
	  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
		unsigned6														did											:= 0;
		unsigned1														did_score										;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					raw_aid									:= 0;
		unsigned8							    					ace_aid									:= 0;
		string1															record_type									;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		input.Common	 											rawfields										;
		Address.Layout_Clean_Name						clean_attorney_name					;
		Address.Layout_Clean182_fips		    clean_address								;
		Miscellaneous.Cleaned_Phones				clean_phones								;
		CCPA_fields;  // Jira# CCPA-358, Added for CCPA project
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
		input.Common												rawfields										;
		Address.Layout_Clean_Name						clean_attorney_name					;
		Address.Layout_Clean182_fips		    Clean_address								;
		Miscellaneous.Cleaned_Phones				clean_phones								;
		CCPA_fields;  // Jira# CCPA-358, Added for CCPA project
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

	  export StandardizeInput :=
	  record
			unsigned8		unique_id		 				;
			string150 	address1		;
			string50		address2		;
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
			string25    city               ;
			string50    email         := '';
			string50		URL						:= '';
			string20		fname 				:= '';
			string20    mname 				:= '';
			string20  	lname					:= '';
			 bipv2.IDlayouts.l_xlink_ids    ;
	  end;
			  
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;
		
	End;
	
end;