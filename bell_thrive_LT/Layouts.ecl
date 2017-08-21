import address,standard,dnb;
export Layouts :=
module
	
	export phones := 
	record
			 string10		Phone_Home   ;
			 string10		Phone_Work   ;
	end;
	export Input := 
	module
		
		export Sprayed :=
		record
			 string16		Fname					;
			 string173		Lname  				;
			 string60		Addr 					;
			 string27		City					; 
			 string2 		State  				;
			 string5 		Zip  					;
//			 string4 		Zip4  				; 
			 string47		Email  				;
			 string10		Phone  				;
			 string18		LoanType  		; 
			 string9 		BestTime  		;
			 string4 		MortRate  		;
			 string13		PropertyType  ; 
			 string10		RateType  		;
			 string3 		LTV  					;
			 string16		YrsThere  		; 
			 string207		Employer  		;
			 string9 		Credit  			;
			 string6 		Income  			; 
			 string6 		LoanAmt  			;
			 string16		DT  					;
			 string15		IP						; 
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
