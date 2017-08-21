import address;
export Layouts :=
module

  shared max_size := _Dataset().max_record_size;

	export Miscellaneous :=
	module
	
		export Cleaned_Dates :=
		record

			unsigned4		dob			;

		end;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export Sprayed := 
		record
			string isln												;
			string ilid												;
			string lastname										;
			string firstname									;
			string suf												;
			string govttitle									;
			string employedby									;
			string year_born									;
			string year_of_first_admission    ;
			string org_id                     ;
			string olid                       ;
			string orgname										;
			string city                       ;
			string state                      ;
			string borntext                   ;
			string admttext										;
			string eductext                   ;
			string description                ;
			string listing_restriction			  ;
		end;                            	
	
		export Fixed := 
		record
			string9 	isln											;
			string8	 	ilid											;
			string20	lastname									;
			string26	firstname									;
			string20	suf												;
			string60	govttitle									;
			string77	employedby								;
			string4	 	year_born									;
			string4	 	year_of_first_admission   ;
			string8	 	org_id                    ;
			string8	 	olid                      ;
			string50	orgname										;
			string28	city                      ;
			string2	 	state                     ;
			string90	borntext                  ;
			string500 admttext									;
			string292 eductext                  ;
			string35	description               ;
			string36  listing_restriction			  ;
		end;                            	

	end;
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record
		unsigned6														Bid											:= 0;
		unsigned1														Bid_score								:= 0;
		unsigned6														did											:= 0;
		unsigned1														did_score										;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					raw_aid									:= 0;
		unsigned8							    					ace_aid									:= 0;
		string1															record_type									;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		input.sprayed 											rawfields										;
		Address.Layout_Clean_Name						clean_contact_name					;
		Address.Layout_Clean182_fips		    Clean_address								;
		Miscellaneous.Cleaned_Dates					clean_dates									;
		
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
		input.Fixed		 											rawfields										;
		Address.Layout_Clean_Name						clean_contact_name					;
		Address.Layout_Clean182_fips		    Clean_address								;
		Miscellaneous.Cleaned_Dates					clean_dates									;
		
	end;
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	  export StandardizeInput :=
	  record
			unsigned8		unique_id		;
			string100 	address1		;
			string50		address2		;
			base 					 					;
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
			string8			dob						 	;
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
		
	  export BidSlim := 
	  record
			unsigned8		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state		 					;
			string10		phone		  		    ;
			unsigned6		bid						:= 0;
			unsigned1		bid_score			:= 0;
	  end;
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;

		export layslimjudge := 
		record

			string20	lname					;
			string20 	fname 				;
			string20	mname					;
			string2		st						;
			string4		year_born			;
			string8		dob						;
			string25	city					;
			string4		err_stat			;
			string		ISLN					;

		end;

		export layhdrextra := 
		record
			string20  fname;
			string20  mname;
			string20  lname;
			integer4  dob;
			string25  city_name;
			string10  phone;
			string2   st;
		end;
		
		export redid := 
		record
			Base												;
			unsigned8				cnt					;
			integer1				score				;
			integer1				mname_score	;
			integer1				dob_score		;
			integer1				city_score	;
			integer1				phone_score	;
			integer1				state_score	;
			layslimjudge 		judge_fields;
			layhdrextra			hdr_fields	;
		end;

		
	End;
	
end;
