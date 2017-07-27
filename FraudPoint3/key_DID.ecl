import Fraudpoint3,Data_Services,doxie;

file_base_has_DID := fraudpoint3.file_base(appended_LexID > 0);

export Key_DID := 
       index(file_base_has_DID,
             {unsigned6 s_did := appended_LexID},
						 {file_base_has_DID},
						 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fraudpoint3::' + doxie.Version_SuperKey + '::did');