IMPORT $;
IMPORT data_services, doxie;

STRING template := data_services.Data_location.Prefix ('InquiryHistory') + 
                   'thor_data::key::' + $.Constants.dataset_name;

STRING Get_prefix (UNSIGNED1 data_env, STRING pversion) := template + '::' + Data_Services.data_env.GetString(data_env) + '::' +  pversion + '::';
                                                 
EXPORT Names(UNSIGNED1 data_env = Data_Services.data_env.iFCRA, STRING pversion = doxie.Version_SuperKey) := MODULE  

  EXPORT STRING i_lexid          := Get_prefix(data_env, pversion) + 'lexid';
  EXPORT STRING i_grouprid       := Get_prefix(data_env, pversion) + 'group_rid';
	
END;