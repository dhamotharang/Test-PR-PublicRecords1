import address,standard,dnb;
export Layouts :=
module
	
	export phones := 
	record
			 string10		Phone_Home        ;
			 string10		Phone_Cell        ; 
			 string10		Phone_Work        ;
	end;

	export Input := 
	module
		
		export Sprayed :=
		record
			 string15		ID								;
			 string15		Fname							;
			 string20		Lname             ;
			 string8		DOB               ; 
			 string2		Own_Home          ;
			 string20		DLNum		          ;
			 string6		State_Of_License  ;
			 string44		Addr							; 
			 string25		City              ;
			 string6		St                ;
			 string5		Zip               ; 
			 string10		Phone_Home        ;
			 string10		Phone_Cell        ; 
			 string10		Phone_Work        ;
			 string40		Email             ;
			 string15		IP                ; 
			 string15		DT                ;
			 string10		Income_Monthly    ; 
			 string10		Weekly_BiWeekly   ; 
			 string5		MonthsEmployed    ;
			 string14		MonthsAtBank      ;
			 string75		Employer          ;
			 string10		Bank					    ;
		end;

	end;
	
	export Base :=
	record
			unsigned8														rid								;
			unsigned6														bdid							;
			unsigned1														bdid_score				;
			unsigned6														did					:= 0	;
			unsigned1														did_score		:= 0	;
			input.sprayed												rawfields					;
			Address.Layout_Clean_Name						clean_name				;
			Address.Layout_Clean182_fips				clean_address			;
			phones															clean_phones			;
			unsigned8 													rawaid 				:= 0;
			unsigned8 													aceaid 				:= 0;
	end;   

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
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
			string9			fein		  		    ;
			string34		source_group	    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
	  end;
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base				;
		end;
		export aid_prep :=
		record
		
 		  unsigned8		unique_id	;
			string			address1				;
			string			address2				;
			Base							;
		
		end;
	end;
	
end;
