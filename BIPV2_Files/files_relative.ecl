IMPORT BIPV2_Relative, BIPV2;

EXPORT files_relative := MODULE


	shared filePrefix := '~thor_data400::key::proxid::bipv2_relative::';
	SHARED fileSuffix := '::assoc';
	EXPORT logicalFile := filePrefix + BIPV2.KeySuffix + fileSuffix;

	EXPORT FILE_KEY_RELATIVE_QA 					:= filePrefix + 'qa' + fileSuffix;
	EXPORT FILE_KEY_RELATIVE_FATHER 			:= filePrefix + 'father' + fileSuffix; 
	EXPORT FILE_KEY_RELATIVE_GRANDFATHER	:= filePrefix + 'grandfather' + fileSuffix;
																									 
	EXPORT updateKeySuperFile(STRING inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_KEY_RELATIVE_QA, 
																									 FILE_KEY_RELATIVE_FATHER, 
																									 FILE_KEY_RELATIVE_GRANDFATHER], inFile, true)
							);
		RETURN action;
	END;
	
	inFile := BIPV2_Relative.In_DOT_Base;
	shared relatives := BIPV2_Relative.keys(inFile).ASSOC; 
			
	export key_proxid  := INDEX(relatives, {Proxid1,Proxid2}, {relatives},	FILE_KEY_RELATIVE_QA);
	
END;