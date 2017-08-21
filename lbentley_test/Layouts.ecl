import address;
export Layouts :=
module

  shared max_size := _Dataset().max_record_size;

	export Miscellaneous :=
	module
	
		export Cleaned_Dates :=
		record

			unsigned4		DOB							;
			unsigned4		LastInquiryDate	;

		end;
		
		export Cleaned_Phones :=
		record

			unsigned5 HomePhone		;
			unsigned5 MobilePhone	;
			unsigned5 WorkPhone		;
			unsigned5 Ref1Phone		;

		end;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export Sprayed := 
		record
			string7        Company_ID								;
			string88       Company_Name             ;
			string50       Address_Line_1           ;
			string49       Address_Line_2           ;
			string37       City                     ;
			string5        State                    ;
			string10       Zip_Code                 ;
			string14       Phone_Number             ;
			string10       Phone_Number_Ext         ;
			string13       Company_Status           ;
			string19       Date_Added               ;
			string21       Sales_Rep                ;
			string24       Vertical                 ;
			string54       Main_Contact_Name        ;
			string50       Main_Address_Line_1      ;
			string46       Main_Address_Line_2      ;
			string37       Main_City                ;
			string5        Main_State               ;
			string10       Main_Zip_Code            ;
			string14       Main_Phone_Number        ;
			string10       Main_Phone_Number_Ext    ;
			string60       Main_Email_Address       ;
			string1        lf												;
		end;                            	
	
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record
		unsigned6							    					Did												:= 0;
		unsigned1														did_score									:= 0;
		unsigned6														Bdid											:= 0;
		unsigned1														bdid_score										;
		unsigned8							    					raw_company_aid							:= 0;
		unsigned8							    					ace_company_aid							:= 0;
		unsigned8							    					raw_contact_aid							:= 0;
		unsigned8							    					ace_contact_aid							:= 0;
		input.sprayed 		    							rawfields											;
		Address.Layout_Clean_Name						clean_name										;
		Address.Layout_Clean182_fips		    Clean_company_address    				;
		Address.Layout_Clean182_fips		    Clean_contact_address    				;
		Miscellaneous.Cleaned_Dates		    	Clean_dates    								;
		Miscellaneous.Cleaned_Phones		    Clean_phones    							;
		
	end;


	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	  export AddrCleanPrep :=
	  record
			unsigned8		unique_id				 ;
			string100 	company_address1		 ;
			string50		company_address2		 ;
			string100 	contact_address1		 ;
			string50		contact_address2		 ;
			base 					 							 ;
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
			string8			dob							;
			string9			ssn							;
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
	  end;
		
	  export UniqueId := 
		record, maxlength(max_size)
 		  unsigned8		unique_id	;
		  Base									;
		end;
		
	End;
	
end;