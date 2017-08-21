import bipv2,utilfile,address,poe;
export Layouts :=
module

	shared poelay := poe.Layouts.base;
	
	export utilraw := 
	record
		string15        id														;
		string10        exchange_serial_number        ;
		string8         date_added_to_exchange        ;
		string8         connect_date                  ;
		string8         record_date                   ;
		string10        util_type                     ;
		string25        orig_lname                    ;
		string20        orig_fname                    ;
		string20        orig_mname										;
		string5         orig_name_suffix              ;
		string1         addr_type                     ;
		string1         addr_dual                     ;
		string10        address_street                ;
		string100       address_street_Name           ;
		string5         address_street_Type           ;
		string2         address_street_direction      ;
		string10        address_apartment							;
		string20        address_city                  ;
		string2         address_state                 ;
		string10        address_zip                   ;
		string2         drivers_license_state_code    ;
		string22        drivers_license               ;
		string1					csa_indicator                 ;
		string1 				name_flag                     ;
	end;

	export Base :=
	record
		BIPV2.IDlayouts.l_xlink_ids;
		string2   									source										;
		unsigned6 									did												;
		unsigned1 									did_score									;
		unsigned6 									bdid											;
		unsigned1 									bdid_score								;
		unsigned4  									dt_first_seen							;
		unsigned4  									dt_last_seen							;
		string40  									vendor_id									;

		Address.Layout_Clean_Name		subject_name							;
		Address.Layout_Clean_Slim		subject_address						;
		unsigned5  									subject_phone							;
		unsigned4  									subject_ssn								;
		unsigned4  									subject_dob								;
		string35  									subject_job_title					;
		unsigned8 									subject_rawaid 				:= 0;
		unsigned8 									subject_aceaid 				:= 0;

		string120  									company_name							;
		Address.Layout_Clean_Slim		company_address						;
		unsigned5  									company_phone							;
		unsigned4  									company_fein							;
		unsigned8										company_rawaid				:= 0;
		unsigned8										company_aceaid				:= 0;

		utilraw											rawfields									;

	end;                                                		
	
	export Keybuild :=
	record

		string2   									source										;
		unsigned6 									did												;
		unsigned1 									did_score									;
		unsigned6 									bdid											;
		unsigned1 									bdid_score								;
		unsigned4  									dt_first_seen							;
		unsigned4  									dt_last_seen							;
		string40  									vendor_id									;

		Address.Layout_Clean_Name		subject_name							;
		Address.Layout_Clean_Slim		subject_address						;
		unsigned5  									subject_phone							;
		unsigned4  									subject_ssn								;
		unsigned4  									subject_dob								;
		string35  									subject_job_title					;
		unsigned8 									subject_rawaid 				:= 0;
		unsigned8 									subject_aceaid 				:= 0;

		string120  									company_name							;
		Address.Layout_Clean_Slim		company_address						;
		unsigned5  									company_phone							;
		unsigned4  									company_fein							;
		unsigned8										company_rawaid				:= 0;
		unsigned8										company_aceaid				:= 0;

		utilraw											rawfields									;

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
			BIPV2.IDlayouts.l_xlink_ids;			
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			string9	  	ssn								;				
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state		 					;
			string25    city_name					;			
			string10		phone		  		    ;
			string9			fein		  		    ;
	  end;
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;

		export aid_prep :=
		record
		
 		  unsigned8		unique_id				;
			string			subject_address1;
			string			subject_address2;
			string			company_address1;
			string			company_address2;
			Base												;
		
		end;
		
	End;

end;