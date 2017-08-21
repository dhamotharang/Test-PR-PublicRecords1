import address;
export Layouts :=
module

	export Input :=
	module
		
		export ADDRESS :=
		record
			string Street_Number		;
			string Street_Name			;
			string APT_Unit_Number	;
			string City							;
			string State 						;
			string Zip_Code					;
		end;

		export Groups :=
		record
			string Sequence				;
			string Quoteback			;
			string Group_Policy		;
			ADDRESS								;
		end;

		export Subject :=
		record
			string	First_Name				;
			string	Middle_Name       ;
			string	Last_Name         ;
			string	Suffix            ;
			string	DOB_MMDDYYYY      ;
			string	DL                ;
			string	DL_State          ;
			string	Gender            ;
			string	SSN               ;
			string	Policy_No         ;
			ADDRESS CURRENT_ADDRESS   ;
			ADDRESS FORMER_ADDRESS    ;
		end;

		export Vehicles :=
		record
			string VIN_Num	;
			string VIN_Yr		;
			string VIN_Make	;
		end;
		
		export Sprayed :=
		record
		
			Groups		Group_Current	;
			ADDRESS		Group_Prior		;
			Subject		Subject1			;
			Subject		Subject2			;
			Subject		Subject3			;
			Subject		Subject4			;
			Subject		Subject5			;
			Vehicles	Vehicle1			;
			Vehicles	Vehicle2			;
			Vehicles	Vehicle3			;
			Vehicles	Vehicle4			;
			
		end;
		
	end;
	
	export Cleaned_Dates :=
	record

		unsigned4		DOB			;

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Standardized Layouts
	////////////////////////////////////////////////////////////////////////
	export NormNames :=
	record
		
		unsigned6												Did													:= 0;
		unsigned1												did_score										:= 0;
		
		string													Quoteback											;	// unique id to join back to input file
		unsigned												subject_num										;
		input.Subject										Subject												;
		Address.Layout_Clean_Name				clean_subject_name						;
		Address.Layout_Clean182_fips		Clean_Subject_address					;

		Cleaned_Dates										clean_dates										;
		
	end;

	export NormVehicles :=
	record
		
		string													Quoteback											;	// unique id to join back to input file
		unsigned												vehicle_num										;
		input.Vehicles									Vehicle;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

		export DeNormNames :=
		record
			
			string													Quoteback												;	// unique id to join back to input file
			input.Subject										Subject1												;
			input.Subject										Subject2												;
			input.Subject										Subject3												;
			input.Subject										Subject4												;
			input.Subject										Subject5												;
			
		end;

		export DeNormVehicles :=
		record
			
			string													Quoteback	;	// unique id to join back to input file
			input.Vehicles									Vehicle1	;
			input.Vehicles									Vehicle2	;
			input.Vehicles									Vehicle3	;
			input.Vehicles									Vehicle4	;
			
		end;
		
		export DeNormAll :=
		record
			
			string													Quoteback												;	// unique id to join back to input file
			input.Subject										Subject1												;
			input.Subject										Subject2												;
			input.Subject										Subject3												;
			input.Subject										Subject4												;
			input.Subject										Subject5												;
			input.Vehicles									Vehicle1	;
			input.Vehicles									Vehicle2	;
			input.Vehicles									Vehicle3	;
			input.Vehicles									Vehicle4	;
			
		end;

		export StandardizeInput := 
		record

			unsigned8										unique_id	;

			string100 									address1	;
			string50										address2	;

			NormNames																	;
		end;
		
		export UniqueId := 
		record

			unsigned8										unique_id	;

			NormNames																	;
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
			string8			dob							;
			string9			ssn							;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	
		end;

	end;

end;
