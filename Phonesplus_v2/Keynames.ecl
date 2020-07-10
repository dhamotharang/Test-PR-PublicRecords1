import tools,Data_Services,dx_PhonesPlus;

export Keynames(

	          boolean isFCRA = false, 
						string pVersion = ''

) :=
module

  data_env := if(isFCRA,1,0);
	data_env_name := Data_Services.data_env.GetString(data_env);
	
	shared Prefix  := data_services.Data_location.Prefix (dx_PhonesPlus.Constants.dataset_name) 
										+	'thor_data400::key::' + dx_PhonesPlus.Constants.dataset_name 
										+ if(trim(data_env_name)<>'', '::' + data_env_name, '');

	export Source_Level_Payload_Template	:= Prefix + '::@version@::source_level_payload';
	export Source_Level_Payload						:= tools.mod_FilenamesBuild(Source_Level_Payload_Template ,pVersion);

	export Source_Level_Did_Template 			:= Prefix + '::@version@::source_level_did';
	export Source_Level_Did								:= tools.mod_FilenamesBuild(Source_Level_Did_Template ,pVersion);

	export Source_Level_Phone_Template 		:= Prefix + '::@version@::source_level_phone';
	export Source_Level_Phone							:= tools.mod_FilenamesBuild(Source_Level_Phone_Template ,pVersion);
	
	export Source_Level_CellPhoneIDKey_Template 	:= Prefix + '::@version@::source_level_cellphoneidkey';
	export Source_Level_CellPhoneIDKey						:= tools.mod_FilenamesBuild(Source_Level_CellPhoneIDKey_Template ,pVersion);

	export dAll_filenames := 
		Source_Level_Payload.dAll_filenames +
		Source_Level_Did.dAll_filenames		+
		Source_Level_Phone.dAll_filenames +
		Source_Level_CellPhoneIDKey.dAll_filenames
	;

end;