import address;
export Layouts :=
module

	// Jira# CCPA-102, The below layout with 2 new fields are added for CCPA (California Consumer Protection Act) project.
	// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
	export CCPA_fields := 
	record
		unsigned4 													global_sid 		:= 0;
		unsigned8 													record_sid 		:= 0;
	end;

	export Base :=
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
		CCPA_fields																						; // Added new CCPA fields as per Jira# CCPA-102

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
		CCPA_fields																						; // Added new CCPA fields as per Jira# CCPA-102

	end;                                                		

	export source_hierarchy := record
		string2   source;
		unsigned1 source_order;
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
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
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