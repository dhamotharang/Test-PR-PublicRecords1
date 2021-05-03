IMPORT data_services, doxie;

EXPORT names (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA, string file_version = doxie.Version_SuperKey):= MODULE

  SHARED string prefix        :=  data_services.data_location.prefix('Banko') + 'thor_data400::KEY::Banko';
	SHARED string Env_name      :=  Data_Services.data_env.GetString(data_env);

  SHARED string Fullprefix    :=  prefix+ if(trim(Env_name)<>'', '::' + Env_name, '') + '::' +  file_version + '::';
  EXPORT i_caseNum            :=  Fullprefix + 'courtcode.casenumber.caseId.payload';
  EXPORT i_FullCaseNum        :=  Fullprefix + 'courtcode.fullcasenumber.caseId.payload'; 
	EXPORT i_DeltaRID           :=  Fullprefix + 'Delta_rid';
	                              
END;

