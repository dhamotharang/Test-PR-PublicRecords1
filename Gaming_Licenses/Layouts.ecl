
import address;
export Layouts :=
module
    shared max_size := _Dataset.max_record_size;
	export Miscellaneous :=
	module

		export NJ_Cleaned_Dates :=
		record
			unsigned4		IssueDate					;
			unsigned4		ExpiredDate				;
			unsigned4		DateLastRenewal		;
		end;

	end;
	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export NJ :=
		record
			string	ProfessionID				;
			string	Name								;
			string	Prefix							;
			string	FirstName						;
			string	MiddleName					;
			string	LastName						;
			string	Suffix							;
			string	Address							;
			string	City								;
			string	State								;
			string	Zip									;
			string	County							;
			string	RegistrationType		;
			string	RegistrationID			;
			string	RegistrationNumber	;
			string	Status							;
			string	IssueDate						;
			string	ExpiredDate					;
			string	DateLastRenewal			;
		end;
		

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		export NJ :=
		record
		    unsigned6							    Did			:= 0;
		    unsigned1								did_score	:= 0;
		    unsigned6								Bdid		:= 0;
		    unsigned1								bdid_score	;
			unsigned4 								dt_first_seen	;
			unsigned4 								dt_last_seen	;
			unsigned4 								dt_vendor_first_reported	;
			unsigned4 								dt_vendor_last_reported		;
			string1											record_type;
			input.NJ 								rawfields					;
			Address.Layout_Clean_Name				clean_name					;
			Address.Layout_Clean182_fips		    Clean_address			    ;
			Miscellaneous.NJ_Cleaned_Dates	clean_dates						    ;
		end;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	
		export NJ :=
		record
			unsigned8										unique_id					;

			string100 									address1					;
			string50										address2					;

			base.NJ																				;

		end;
		
		export DidSlim := 
		record
		
			unsigned8		unique_id				    ;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix		   	        ;
			string10  	    prim_range			        ;
			string28		prim_name				    ;
			string8			sec_range			 	    ;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			unsigned6		did				:= 0;
			unsigned1		did_score		:= 0;
	
		end;

		export BdidSlim := 
		record
			unsigned8		unique_id					;
			string100 	    company_name			    ;
			string10  	    prim_range				    ;
			string28		prim_name					;
			string5			zip5						;
			string8			sec_range					;
			string2			state		 				;
			string10		phone		  			    ;
			unsigned6		bdid			:= 0;
			unsigned1		bdid_score		:= 0;
		end;
		
		export NJ_UniqueId := 
		record, maxlength(max_size)
 		  unsigned8		unique_id	;
		  Base.NJ					;
		end;
		
	End;
	
end;