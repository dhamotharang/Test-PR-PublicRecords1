boolean var1 := true : stored('production');
import ut,data_services;
export File_TN_did := 
dataset('~thor_data400::base::TransunionCred_did' + if(var1,'_Prod',''),header.Layout_Header, flat);