//gong records with a valid did field  
//boolean var1 := true : stored('production');
import ut,data_services;
export File_Gong_Did := 
	dataset('~thor_data400::base::gong_did',Layout_Gong_DID, flat);