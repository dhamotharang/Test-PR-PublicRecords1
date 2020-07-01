IMPORT $,data_services, doxie;
//DF-27472 Initial Roxie Release
                                                 
EXPORT Names(UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA, STRING pversion = doxie.Version_SuperKey) := MODULE  

	SHARED template := data_services.Data_location.Prefix ($.Constants.dataset_name) + 
										'thor_data400::key::' + $.Constants.dataset_name;

	SHARED data_env_name := Data_Services.data_env.GetString(data_env);
										
	SHARED Prefix  := template +  if(trim(data_env_name)<>'', '::' + data_env_name, '') + '::' +  pversion + '::';


  EXPORT STRING i_source_level_payload  			:= Prefix + 'source_level_payload';
	EXPORT STRING i_source_level_did      			:= Prefix + 'source_level_did';
  EXPORT STRING i_source_level_phone    			:= Prefix + 'source_level_phone';
	EXPORT STRING i_source_level_cellphoneidkey := Prefix + 'source_level_cellphoneidkey';	
	
END;