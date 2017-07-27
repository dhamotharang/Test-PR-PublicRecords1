import address;

export Layouts := module

	shared max_size := _Dataset().max_record_size;
	
	export Input :=	module

		//*** Teletrack Input tab delimated varying lenght layout	
		export Sprayed := record, maxlength(max_size)
				string	ssn;
				string	last_name;
				string	first_name;
				string	middle_name;
				string	generation;
				string	street_num;
				string	street_name;
				string	street_type;
				string	street_direction;
				string	apartment;
				string	city;
				string	state;
				string	zip_code;
				string	home_phone;
				string	work_place;
				string	work_city;
				string	work_state;
				string	work_phone;
				string	time_stamp;
				string	lf;
		end;
		
		export keybuild := 
		record
				string9		ssn;
				string40	last_name;
				string40	first_name;
				string40	middle_name;
				string5		generation;
				string10	street_num;
				string30	street_name;
				string10	street_type;
				string10	street_direction;
				string10	apartment;
				string28	city;
				string2		state;
				string9		zip_code;
				string10	home_phone;
				string100	work_place;
				string28	work_city;
				string2		work_state;
				string10	work_phone;
				string19	time_stamp;
		end;
	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Common Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export CleanedFields := record, maxlength(max_size)
			unsigned8											raw_aid							:= 0;
			unsigned8											ace_aid							:= 0;
			unsigned4 										dt_first_seen						;	
			unsigned4 										dt_last_seen						;
			unsigned4 										dt_vendor_first_reported;
			unsigned4 										dt_vendor_last_reported	;
			string1												record_type				 := '';
			Input.Sprayed									rawfields								;
			Address.Layout_Clean_Name 	 	Clean_name							;
			Address.Layout_Clean182_fips 	Clean_address			    	;
			string10											Clean_hphone						;
			string10											Clean_wphone						;
	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layout
	////////////////////////////////////////////////////////////////////////
	export Base := record 
		unsigned6						Did							:= 0;
		unsigned1						did_score				:= 0;
		unsigned6						Bdid						:= 0;
		unsigned1						bdid_score					;
		CleanedFields;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layout
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=
	record
		unsigned6							    			Did									:= 0;
		unsigned1												did_score						:= 0;
		unsigned6												Bdid								:= 0;
		unsigned1												bdid_score					:= 0;
		unsigned8							    			raw_aid							:= 0;
		unsigned8							    			ace_aid							:= 0;
		unsigned4 											dt_first_seen						;	
		unsigned4 											dt_last_seen						;
		unsigned4 											dt_vendor_first_reported;
		unsigned4 											dt_vendor_last_reported	;
		string1													record_type							;
		input.keybuild 		    					rawfields								;
		Address.Layout_Clean_Name 	 		Clean_name							;
		Address.Layout_Clean182_fips 		Clean_address		    		;
		string10												Clean_hphone						;
		string10												Clean_wphone						;		
	end;
	
		////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	  export Teletrack :=
	  record, maxlength(max_size)
			string100 	address1		 ;
			string50		address2		 ;
			CleanedFields	 					 ;
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
			string8			sec_range			 		;
			string5			zip5							;
			//string25    city							;
			string2			state		 					;
			string10		phone		  		    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
	  end;
		
	  export Teletrack_UniqueId := 
		record, maxlength(max_size)
 		  unsigned8		unique_id	;
		  Base									;
		end;		
	end;
end;