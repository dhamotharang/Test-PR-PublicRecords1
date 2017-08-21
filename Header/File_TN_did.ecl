boolean var1 := true : stored('production');
import ut,data_services;
export File_TN_did := 
dataset(data_services.Data_location.tucs_did +'thor_data400::base::TransunionCred_did' + if(var1,'_Prod',''),header.Layout_Header, flat);