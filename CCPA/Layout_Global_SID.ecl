EXPORT Layout_Global_SID := MODULE

	///////////////////////////////////////////////
	//Orbit Generated Lookup Table w/ Global_SIDs//
	///////////////////////////////////////////////
	
	EXPORT orbitTableLayout 	:= RECORD
		STRING dataset_id;
		STRING dataset_name;
		STRING source_codes;
		STRING company_name;
		STRING glb_srcid;
		STRING build_template_name;
		STRING maxlevel;
		STRING roxie_packages;
	END;	
	
	///////////////////////////////////////////////
	//Consolidated Lookup Table////////////////////
	///////////////////////////////////////////////
	
	EXPORT lookupTableLayout := RECORD
		STRING roxie_packages;
		STRING field_name;
		STRING source_codes;
		STRING dataset_id;
		STRING dataset_name;
		STRING global_sid; 	//ID pulled from the Orbit Generated Lookup Table
	END;

END;