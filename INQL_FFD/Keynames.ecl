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
	
	export lLexidTemplateFull			:= lPrefix + '::@version@::lexid_full';
	export Lexid_full							:= tools.mod_FilenamesBuild(lLexidTemplateFull ,pVersion);
	
	export lLexidTemplateDelta		:= lPrefix + '::@version@::lexid_delta';
	export Lexid_delta						:= tools.mod_FilenamesBuild(lLexidTemplateDelta ,pVersion);

	export lGroupRIDTemplate			:= lPrefix + '::@version@::group_rid';
	export GroupRID								:= tools.mod_FilenamesBuild(lGroupRIDTemplate ,pVersion);
	
	export lGroupRIDTemplateFull	:= lPrefix + '::@version@::group_rid_full';
	export GroupRID_full					:= tools.mod_FilenamesBuild(lGroupRIDTemplateFull ,pVersion);
	
	export lGroupRIDTemplateDelta	:= lPrefix + '::@version@::group_rid_delta';
	export GroupRID_delta					:= tools.mod_FilenamesBuild(lGroupRIDTemplateDelta ,pVersion);
	
	export lGroupRIDEncryptedTemplate			:= lPrefix + '::@version@::group_rid::encrypted';
	export GroupRID_Encrypted							:= tools.mod_FilenamesBuild(lGroupRIDEncryptedTemplate ,pVersion);
	
	export lGroupRIDEncryptedTemplateFull	:= lPrefix + '::@version@::group_rid_encrypted_full';
	export GroupRID_Encrypted_full				:= tools.mod_FilenamesBuild(lGroupRIDEncryptedTemplateFull ,pVersion);
	
	export lGroupRIDEncryptedTemplateDelta	:= lPrefix + '::@version@::group_rid_encrypted_delta';
	export GroupRID_Encrypted_delta					:= tools.mod_FilenamesBuild(lGroupRIDEncryptedTemplateDelta ,pVersion);

	export dAll_filenames := 

		Lexid.dAll_filenames +
		GroupRID.dAll_filenames	+
		GroupRID_Encrypted.dAll_filenames	+

		Lexid_full.dAll_filenames +
		GroupRID_full.dAll_filenames +
		GroupRID_Encrypted_full.dAll_filenames +
		
		Lexid_delta.dAll_filenames +
		GroupRID_delta.dAll_filenames	+
		GroupRID_Encrypted_delta.dAll_filenames		


		
		;

end;