EXPORT Layout_Global_SID := MODULE

	//////////////////////////////////////////////////
	//In-Scope Table w/ Roxie Packages & Dataset_IDs//
	//////////////////////////////////////////////////
	
	EXPORT inScopeLayout 	:= RECORD
		STRING global_sid;
		STRING packages;
		STRING dataset_id;
		STRING legally_regulated_by_ddpa;
		STRING legally_regulated_by_glba;
		STRING public_records_as_defined_by_ccpa;
		STRING in_scope_for_ccpa;
		STRING notes;
		STRING rg_notes;
		STRING dataset_name;
		STRING dataset_company;
		STRING dataset_type;
		STRING dataset_description;
		STRING dataset_status;
		STRING dataset_data_type_1;
		STRING dataset_data_type_2;
		STRING dataset_date_type_3;
		STRING company_address;
		STRING company_address_2;
		STRING company_city;
		STRING company_name;
		STRING company_phone;
		STRING company_state;
		STRING company_zip;
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
		STRING 		data_set;
		STRING 		field_name;
		STRING 		source_codes;
		UNSIGNED4 dataset_id;
		STRING 		dataset_name;
		UNSIGNED4 global_sid;	//ID pulled from the Orbit Generated Lookup Table
	END;

END;