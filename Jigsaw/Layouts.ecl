/*2011-02-01T19:35:41Z (Giri Rajulapalli)
Modified for AID.
*/
import address, BIPV2;
export Layouts :=
module

  shared max_size := _Dataset().max_record_size;

	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export Sprayed := 
		record
			string CompanyID							;
			string ContactID 							;
			string FirstName 							;
			string LastName 							;
			string Title 									;	
			string Email 									;	
			string Phone 									;	
			string Rank 									;	
			string CompanyName 						;
			string CompanyStreetAddress 	;
			string CompanyCity 						;
			string CompanyState 					;		
			string CompanyZip 						;		
			string CompanyCountry 				;	
			string CompanyURL 						;		
			string GraveyardStatus 				;	
			string UpdateTimestamp 				;
			string Status                 ;
		end;
	
		export Keybuild := 
		record
			string7		CompanyID							;
			string8		ContactID 						;
			string128	FirstName 						;
			string128	LastName 							;
			string128	Title 								;	
			string70	Email 								;	
			string10	Phone 								;	
			string2		Rank 									;	
			string128	CompanyName 					;
			string128	CompanyStreetAddress 	;
			string60	CompanyCity 					;
			string30	CompanyState 					;		
			string15	CompanyZip 						;		
			string15	CompanyCountry 				;	
			string70	CompanyURL 						;		
			string1		GraveyardStatus 			;	
			string20	UpdateTimestamp 			;
			string9		Status                ;
		end;
	
	
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record
    unsigned8	                          source_rec_id           := 0; //Added for BIPV2 project     
    BIPV2.IDlayouts.l_xlink_ids                                     ;	//Added for BIPV2 project	
		unsigned6							    					Did											:= 0;
		unsigned1														did_score								:= 0;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					raw_aid									:= 0;
		unsigned8							    					ace_aid									:= 0;
		unsigned4 													dt_first_seen								;	
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		string1															record_type									;
		input.sprayed 		    							rawfields										;
		Address.Layout_Clean_Name						clean_name									;
		Address.Layout_Clean182_fips		    Clean_address			    			;
		
	end;
	
	export Keybuild :=
	record
		unsigned6							    					Did											:= 0;
		unsigned1														did_score								:= 0;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					raw_aid									:= 0;
		unsigned8							    					ace_aid									:= 0;
		unsigned4 													dt_first_seen								;	
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		string1															record_type									;
		input.keybuild 		    							rawfields										;
		Address.Layout_Clean_Name						clean_name									;
		Address.Layout_Clean182_fips		    Clean_address			    			;
		
	end;

  export Keybuild_Linkids :=
	record
	  base.source_rec_id                                              ;
		BIPV2.IDlayouts.l_xlink_ids                                     ;	//Added for BIPV2 project
		Keybuild                                                        ;
  end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	  export Jigsaw :=
	  record
			string100 	address1		      ;
			string50		address2		      ;
			base 					 					      ;
	  end;
		
	  export DidSlim := 
	  record
			unsigned8		unique_id			  	;
			string20 		fname					  	;
			string20 		mname					  	;
			string20 		lname					  	;
			string5  		name_suffix		    ;
			string10  	prim_range		    ;
			string28		prim_name			  	;
			string8			sec_range			   	;
			string5			zip5				  		;
			string2			state					  	;
			string10		phone					  	;
			unsigned6		did				   	:= 0;
			unsigned1		did_score		  := 0;
	  end;

	  export BdidSlim := 
	  record
      unsigned8	  source_rec_id := 0;    //Added for BIP2 project    
      BIPV2.IDlayouts.l_xlink_ids   ;    //Added for BIP2 project
			string2			source						;		 //Added for BIP2 project
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
      string25    p_city_name       ;
	    string20    fname					    ;
	    string20    mname					    ;
	    string20    lname					    ;
			string70	  CompanyURL        ;
			string70	  Email 						;
	  end;
		
	export Jigsaw_UniqueId := 
		record, maxlength(max_size)
 		  unsigned8		unique_id	;
		  Base							;
		end;
		
	  export Jigsaw_twophone := 
		record, maxlength(max_size)
 		  unsigned8		unique_id	;
		  Base									;
			unsigned6		business_phone;
			unsigned6		person_phone	;
		end;

    EXPORT Jigsaw_AddTwoPhones := RECORD,
	  	                      MAXLENGTH(max_size)
 		 Base;
		 UNSIGNED6		business_phone;
		 UNSIGNED6		person_phone	;
	  END;
		
	End;
	
	
end;