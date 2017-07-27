import Address, AID, BIPV2;
export Layouts := module

	export Input := 
	module
		
		export Sprayed := record
			string carrier_id;						
			string crash_id;					
			string carrier_source_code;				
			string carrier_name;						
			string carrier_street;							
			string carrier_city;						
			string carrier_city_code;						
			string carrier_state;						
			string carrier_zip_code;					
			string crash_colonia;					
			string prefix;	
			string docket_number;
			string interstate;
			string no_id_flag;
			string state_number;			
			string state_issuing_number;
		end;
			
		export Sprayed_Fixed := record			
			string8													carrier_id;
			string8													crash_id;
			string1   											carrier_source_code;
			string120					 							carrier_name;
			string50 												carrier_street;
			string25				 								carrier_city;
			string5 												carrier_city_code;
			string2 												carrier_state;
			string10												carrier_zip_code;
			string25 												crash_colonia;
			string2 												prefix;
			string8 												docket_number;
			string1 												interstate;
			string1					 								no_id_flag;
			string12 												state_number;
			string2 												state_issuing_number;			
		end;			
			
	end;

	export Base := record
			BIPV2.IDlayouts.l_xlink_ids;			
			unsigned6												bdid;
			unsigned1												bdid_score							:= 0;
			unsigned6												did;
			unsigned1												did_score								:= 0;				
			unsigned8												source_rec_id;
			unsigned4 											dt_first_seen;
			unsigned4 											dt_last_seen;			
			unsigned4					 							dt_vendor_first_reported;
			unsigned4 											dt_vendor_last_reported;
			Input.Sprayed										raw;			
			string2													source;
			string120												cleaned_carrier_name;		
			string50												cleaned_carrier_street;	
			string25												cleaned_carrier_city; 			
			string2													cleaned_carrier_state; 
			string10 												cleaned_carrier_zip_code;			
			string2													cleaned_prefix;
			string60												carrier_name_source_desc;
			string20												interstate_desc;
			string20												no_census_number_desc;
			Address.Layout_Clean_Name;
			Address.Layout_Clean182_fips;
			AID.Common.xAID									ace_aid;
			AID.Common.xAID									raw_aid;
			string100												prep_addr_line1					:='';
			string50												prep_addr_line_last			:='';			
	end;

	export Keybuild := record
			BIPV2.IDlayouts.l_xlink_ids;		
			unsigned6												bdid;
			unsigned1												bdid_score;
			unsigned6												did;
			unsigned1												did_score								:= 0;				
			unsigned8												source_rec_id;
			unsigned4 											dt_first_seen;
			unsigned4 											dt_last_seen;			
			unsigned4					 							dt_vendor_first_reported;
			unsigned4 											dt_vendor_last_reported;
			Input.Sprayed_Fixed							raw;
			string2													source;
			string120												cleaned_carrier_name;		
			string50												cleaned_carrier_street;	
			string25												cleaned_carrier_city; 			
			string2													cleaned_carrier_state; 
			string10 												cleaned_carrier_zip_code;			
			string2													cleaned_prefix;
			string60												carrier_name_source_desc;
			string20												interstate_desc;
			string20												no_census_number_desc;
			Address.Layout_Clean_Name;
			Address.Layout_Clean182_fips;
			AID.Common.xAID									ace_aid;
			AID.Common.xAID									raw_aid;
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary := module
		
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
			string5			zip							;
			string2			st							;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned8		unique_id					;
			string120 	cleaned_carrier_name;
			string10  	prim_range				;
			string28		prim_name					;
			string8			sec_range					;
			string25 		p_city_name				; 
			string5			zip			 					;
			string2			st			 					;			
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			BIPV2.IDlayouts.l_xlink_ids		;
			string2			source						;			
			unsigned8		source_rec_id			;
	  end;

	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base						  		;
		end;
	end;

end;