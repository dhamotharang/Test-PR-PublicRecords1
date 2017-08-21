import Data_Services, doxie, ut; 

export key_did := index(File_Gong_Did(did<>0),
                             {unsigned6 l_did := did},{File_Gong_Did},
                             Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_did_'+doxie.Version_SuperKey);
