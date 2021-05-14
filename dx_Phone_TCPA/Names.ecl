IMPORT $, Data_Services, Doxie;
                                                 
EXPORT Names(UNSIGNED1 Data_Env = Data_Services.Data_Env.iNonFCRA, STRING pVersion = Doxie.Version_SuperKey) := MODULE  

	SHARED Template 										:= Data_Services.Data_location.Prefix ($.Constants.Dataset_Name) + 'thor_data400::key::' + $.Constants.Dataset_Name;											
	SHARED Data_Env_Name 								:= Data_Services.Data_Env.GetString(Data_Env);							
										
	SHARED Prefix												:= Template + if(trim(Data_Env_Name)<>'', '::' + Data_Env_Name, '') + '::' +  pVersion + '::';
		
	EXPORT STRING i_tcpa_phone_history	:= Prefix + 'phone_history';	
	
END;