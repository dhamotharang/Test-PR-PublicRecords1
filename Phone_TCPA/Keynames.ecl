IMPORT Data_Services, dx_Phone_TCPA, Tools;

EXPORT Keynames(boolean isFCRA = false, string pVersion = ''):= MODULE

  SHARED Data_Env 											:= if(isFCRA, 1, 0);
	SHARED Data_Env_name 									:= Data_Services.Data_Env.GetString(Data_Env);
	
	SHARED Prefix  												:= Data_Services.Data_location.Prefix (dx_Phone_TCPA.Constants.dataset_name) 
																						+	'thor_data400::key::' + dx_Phone_TCPA.Constants.dataset_name 
																						+ if(trim(Data_Env_name)<>'', '::' + Data_Env_name, '');	

	EXPORT TCPA_Phone_Template 						:= Prefix + '::@version@::phone';
	EXPORT TCPA_Phone											:= Tools.mod_FilenamesBuild(TCPA_Phone_Template, pVersion);
	
	EXPORT TCPA_Phone_History_Template 		:= Prefix + '::@version@::phone_history';
	EXPORT TCPA_Phone_History							:= Tools.mod_FilenamesBuild(TCPA_Phone_History_Template, pVersion);

	EXPORT dAll_filenames 								:= TCPA_Phone.dAll_filenames +
																					 TCPA_Phone_History.dAll_filenames;
																					 
END;