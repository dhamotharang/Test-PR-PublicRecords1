import address,standard,dnb;
export Layouts :=
module
	
	export Input := 
	module
		
		export Sprayed :=
		record
			string14	jobid							;
			string3		acctno            ;
			string9		tin_number        ;
			string24	tin_name					;
			string1		tin_type          ;
			string1		tin_match_code    ;
			string23	date_created			;
			string23	last_updated      ;
			string31	address           ;
			string17	city							;
			string2		state             ;
			string9		zip               ;
			string10	account_number		;
			string10	phone             ;
			string10	gcid              ;
		end;
		
	end;
	
	export Base :=
	record
			unsigned8														rid													;
			unsigned6														bdid												;
			unsigned1														bdid_score									;
			unsigned4														date_first_seen							;
			unsigned4														date_last_seen							;
			unsigned4														date_vendor_first_reported	;
			unsigned4														date_vendor_last_reported		;
			unsigned1  													record_type									; //CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
			input.sprayed												rawfields										;
			Address.Layout_Clean182_fips				clean_address								;
			unsigned8 													rawaid 									:= 0;
			unsigned8 													aceaid 									:= 0;
	end;   
	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

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
