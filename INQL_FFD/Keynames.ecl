import tools,dx_InquiryHistory, Data_Services;

export Keynames(

	          boolean isFCRA = true, 
						string pVersion = ''

) :=
module

  data_env := if(isFCRA,1,0);
	
	shared lPrefix   							:= '~thor_data::key::' + dx_InquiryHistory.Constants.dataset_name + '::' + Data_Services.data_env.GetString(data_env);

	export lLexidTemplate					:= lPrefix + '::@version@::lexid';
	export Lexid									:= tools.mod_FilenamesBuild(lLexidTemplate ,pVersion);

	export lGroupRIDTemplate			:= lPrefix + '::@version@::grouprid';
	export GroupRID								:= tools.mod_FilenamesBuild(lGroupRIDTemplate ,pVersion);



	export dAll_filenames := 

		Lexid.dAll_filenames +
		GroupRID.dAll_filenames		
		
		;

end;