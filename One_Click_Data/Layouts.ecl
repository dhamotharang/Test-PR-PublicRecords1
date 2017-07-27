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
			string	SSN							;
			string	FirstName				;
			string	LastName				;	
			string	DOB    					;
			string	HomeAddress    	;	
			string	HomeCity    		;
			string	HomeState    		;	
			string	HomeZip    			;
			string	HomePhone    		;	
			string	MobilePhone    	;
			string	EmailAddress    ;	
			string	WorkName    		;
			string	WorkAddress    	;	
			string	WorkCity    		;
			string	WorkState    		;	
			string	WorkZip    			;
			string	WorkPhone    		;	
			string	Ref1FirstName   ;
			string	Ref1LastName    ;	
			string	Ref1Phone    		;
			string	LastInquiryDate ;
			string	IP							;
		end;                            	
	
		export keybuild := 
		record
			string9		SSN							;
			string40	FirstName				;
			string40	LastName				;	
			string39	DOB    					;
			string64	HomeAddress    	;	
			string40	HomeCity    		;
			string13	HomeState    		;	
			string12	HomeZip    			;
			string10	HomePhone    		;	
			string10	MobilePhone    	;
			string100	EmailAddress    ;	
			string92	WorkName    		;
			string62	WorkAddress    	;	
			string28	WorkCity    		;
			string2		WorkState    		;	
			string5		WorkZip    			;
			string35	WorkPhone    		;	
			string50	Ref1FirstName   ;
			string50	Ref1LastName    ;	
			string10	Ref1Phone    		;
			string8		LastInquiryDate ;
			string16	IP							;
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
		unsigned8							    					raw_home_aid							:= 0;
		unsigned8							    					ace_home_aid							:= 0;
		unsigned8							    					raw_work_aid							:= 0;
		unsigned8							    					ace_work_aid							:= 0;
		unsigned4 													dt_first_seen									;	
		unsigned4 													dt_last_seen									;
		unsigned4 													dt_vendor_first_reported			;
		unsigned4 													dt_vendor_last_reported				;
		string1															record_type										;
		input.sprayed 		    							rawfields											;
		Address.Layout_Clean_Name						clean_name										;
		Address.Layout_Clean182_fips		    Clean_home_address    				;
		Address.Layout_Clean182_fips		    Clean_work_address    				;
		Miscellaneous.Cleaned_Dates		    	Clean_dates    								;
		Miscellaneous.Cleaned_Phones		    Clean_phones    							;
		
	end;

	export Keybuild :=
	record
		unsigned6							    					Did												:= 0;
		unsigned1														did_score									:= 0;
		unsigned6														Bdid											:= 0;
		unsigned1														bdid_score										;
		unsigned8							    					raw_home_aid							:= 0;
		unsigned8							    					ace_home_aid							:= 0;
		unsigned8							    					raw_work_aid							:= 0;
		unsigned8							    					ace_work_aid							:= 0;
		unsigned4 													dt_first_seen									;	
		unsigned4 													dt_last_seen									;
		unsigned4 													dt_vendor_first_reported			;
		unsigned4 													dt_vendor_last_reported				;
		string1															record_type										;
		input.keybuild 		    							rawfields											;
		Address.Layout_Clean_Name						clean_name										;
		Address.Layout_Clean182_fips		    Clean_home_address    				;
		Address.Layout_Clean182_fips		    Clean_work_address    				;
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
			string100 	home_address1		 ;
			string50		home_address2		 ;
			string100 	work_address1		 ;
			string50		work_address2		 ;
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