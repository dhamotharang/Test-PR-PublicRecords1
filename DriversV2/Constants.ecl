import Data_Services;

export Constants := module
	// export cluster            := '~thor_data400::';
	export cluster						:= '~thor_200::';
	export autokey_keyname	  := Data_Services.Data_location.Prefix('DLS')
	                             +'thor_data400::key::dl2::autokey::@version@::';
	export autokey_qa_Keyname := Data_Services.Data_location.Prefix('DLS')
	                             +'thor_data400::key::dl2::autokey::qa::';
	
	export autokey_logical(string filedate) := Data_Services.Data_location.Prefix('DLS')
	                                           +'thor_data400::key::dl2::' + filedate + '::autokey::';
	export autokey_typeStr  := 'DL';
	export autokey_skipSet  := ['B','P','Q','F'];
	export IncludeHistory := module
			export history := 'H';
			export current := 'C';
			export allRows := 'A';
	end;
	
	// This set specifies the sources that require opt-in at runtime via "IncludeNonDMV"
	export nonDMVSources := [ 'CY' ];
	
	export history_flag 	:= ['H','E'];
	
	// Location of lock files used while spraying
	export drvlicbin := '/data/dl_data/drvlic/logs';
	
	export DL_PER_DID := 1000;
end;