import address, BIPV2;
export Layouts :=
module

	shared max_size := _Dataset().max_record_size;

	export Miscellaneous :=
	module
	
		export Cleaned_Dates :=
		record

			unsigned4		Validation_Date			;

		end;
		
		export Cleaned_Phones :=
		record

			string10 Company_Phone_Number		;

		end;
		
	end;

	export Input :=
	module
	
		export Sprayed :=
		record, maxlength(max_size)
		
			string First_Name										;
			string Last_Name										;
			string Job_Title										;
			string Company_Name									;
			string Validation_Date							;
			string Company_Street_Address				;
			string Company_City									;
			string Company_State								;
			string Company_Postal_Code					;
			string Company_Phone_Number					;
			string Company_Annual_Revenue				;
			string Company_Business_Description	;
			string lf   												;
		
		end;

		export keybuild :=
		record
		
			string50 	First_Name										;
			string50 	Last_Name											;
			string125 Job_Title											;
			string255 Company_Name									;
			string30 	Validation_Date								;
			string100 Company_Street_Address				;
			string40 	Company_City									;
			string5		Company_State									;
			string16	Company_Postal_Code						;
			string20	Company_Phone_Number					;
			string30	Company_Annual_Revenue				;
			string255	Company_Business_Description	;
		
		end;

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record, maxlength(max_size)
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6												Did													:= 0;
		unsigned1												did_score										:= 0;
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;
		unsigned8							    			raw_aid											:= 0;
		unsigned8							    			ace_aid											:= 0;
		unsigned4 											dt_first_seen										;
		unsigned4 											dt_last_seen										;
		unsigned4 											dt_vendor_first_reported				;
		unsigned4 											dt_vendor_last_reported					;
		string1													record_type											;

		input.Sprayed										rawfields												;
		Address.Layout_Clean_Name				clean_contact_name							;
		Address.Layout_Clean182_fips		Clean_Company_address						;

		Miscellaneous.Cleaned_Dates			clean_dates											;
		Miscellaneous.Cleaned_Phones		clean_phones										;
		// The below 2 fields are added for CCPA (California Consumer Protection Act) - JIRA# CCPA-13
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		unsigned4 											global_sid 									:= 0;
		unsigned8 											record_sid 									:= 0;
	end;
	
	export Keybuild :=
	record
		unsigned6												Did													:= 0;
		unsigned1												did_score										:= 0;
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;
		unsigned8							    			raw_aid											:= 0;
		unsigned8							    			ace_aid											:= 0;
		unsigned4 											dt_first_seen										;
		unsigned4 											dt_last_seen										;
		unsigned4 											dt_vendor_first_reported				;
		unsigned4 											dt_vendor_last_reported					;
		string1													record_type											;

		input.Keybuild									rawfields												;
		Address.Layout_Clean_Name				clean_contact_name							;
		Address.Layout_Clean182_fips		Clean_Company_address						;

		Miscellaneous.Cleaned_Dates			clean_dates											;
		Miscellaneous.Cleaned_Phones		clean_phones										;
		// The below 2 fields are added for CCPA (California Consumer Protection Act) - JIRA# CCPA-13
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		unsigned4 											global_sid 									:= 0;
		unsigned8 											record_sid 									:= 0;
		
	end;

	export Keybuild_BIP :=
	record
		BIPV2.IDlayouts.l_xlink_ids;
		Keybuild;
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

		export StandardizeInput := 
		record, maxlength(max_size)

			unsigned8										unique_id	;

			string100 									address1	;
			string50										address2	;

			Base																	;

		end;

		export UniqueId := 
		record, maxlength(max_size)

			unsigned8										unique_id	;

			Base																	;

		end;

		export DidSlim := 
		record
		
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix			;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range				;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	
		end;

		export BdidSlim := 
		record

			unsigned8		unique_id					;
			BIPV2.IDlayouts.l_xlink_ids;			
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state							;
			string10		phone							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			Base.clean_contact_name.fname;
			Base.clean_contact_name.mname;
			Base.clean_contact_name.lname;
			Base.clean_company_address.p_city_name;

		end;

	end;


end;