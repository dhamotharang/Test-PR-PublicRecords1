//######################################################
//## This Key is no longer in GongKeys 2/26/2020      ##
//######################################################
import Data_Services, doxie; 

export key_bdid := index(File_BDID_Gong(bdid<>0),
                             {unsigned6 l_bdid := bdid},{File_BDID_Gong},
                             Data_Services.Data_location.Prefix('Gong')+'thor_data400::key::gong_bdid_'+doxie.Version_SuperKey);
