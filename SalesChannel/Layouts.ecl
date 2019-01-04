IMPORT AID,address,BIPV2;

EXPORT Layouts :=
MODULE

	EXPORT input :=
	RECORD
		string10 	Row_ID				;
		string50	Company_Name	;
		string80	Web_Address		;
		string8		Prefix				;
		string60	Contact_Name	;
		string30	First_Name		;
		string20	Middle_Name		;
		string30	Last_Name			;
		string170	Title					;
		string40	Address				;
		string20	Address1			;
		string20	City					;
		string2		State					;
		string10	Zip_Code			;
		string20	Country				;
		string15	Phone_Number	;
		string50	Email					;
	END;

	EXPORT base :=
	RECORD
		unsigned6														rid													;
		unsigned6														bdid												;
		unsigned1														bdid_score									;
		BIPV2.IDlayouts.l_xlink_ids																			;
		unsigned6														did													;
		unsigned1														did_score										;
		unsigned4   												date_first_seen							;
		unsigned4   												date_last_seen							;
		unsigned4   												date_vendor_first_reported	;
		unsigned4   												date_vendor_last_reported		;
		AID.Common.xAID											RawAID											;
		AID.Common.xAID											AceAID											;
		unsigned1  													record_type									; //CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
		input																rawfields										;
		Address.Layout_Clean_Name						clean_name									;
		Address.Layout_Clean182_fips				clean_address								;
	END;
	
	EXPORT base_new := RECORD
		base;
		boolean															current_rec									;
	END;

	EXPORT keybuild := base - BIPV2.IDlayouts.l_xlink_ids;

	EXPORT strata_base :=
	RECORD
		unsigned6														rid													;
		unsigned6														bdid												;
		unsigned1														bdid_score									;
		BIPV2.IDlayouts.l_xlink_ids																			;
		unsigned6														did													;
		unsigned1														did_score										;
		unsigned4   												date_first_seen							;
		unsigned4   												date_last_seen							;
		unsigned4   												date_vendor_first_reported	;
		unsigned4   												date_vendor_last_reported		;
		AID.Common.xAID											RawAID											;
		AID.Common.xAID											AceAID											;
		string15  													record_type									; //CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
		input																rawfields										;
		Address.Layout_Clean_Name						clean_name									;
		Address.Layout_Clean182_fips				clean_address								;
	END;
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
			string25    p_city_name				;
			string10		phone		  		    ;
			string9			fein		  		    ;
			string34		source_group	    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			BIPV2.IDlayouts.l_xlink_ids 	;	
			string80		Web_Address				;
			string50		Email							;
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;			
	  end;
			
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;

		export aid_prep :=
		record
		
			string			address1				;
			string			address2				;
			Base												;
		
		end;
		
	end;
		
END;