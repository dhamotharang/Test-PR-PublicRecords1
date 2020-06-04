EXPORT Layout_Global_SID := MODULE

	//////////////////////////////////////////////////
	//In-Scope Table w/ Roxie Packages & Dataset_IDs//
	//////////////////////////////////////////////////
	
	EXPORT inScopeLayout 	:= RECORD
		string global_sid;
		string packages;
		string dataset_id;
		string legally_regulated_by_ddpa;
		string legally_regulated_by_glba;
		string public_records_as_defined_by_ccpa;
		string in_scope_for_ccpa;
		string notes;
		string rg_notes;
		string dataset_name;
		string dataset_company;
		string dataset_type;
		string dataset_description;
		string dataset_status;
		string dataset_data_type_1;
		string dataset_data_type_2;
		string dataset_date_type_3;
		string company_address;
		string company_address_2;
		string company_city;
		string company_name;
		string company_phone;
		string company_state;
		string company_zip;
	END;

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