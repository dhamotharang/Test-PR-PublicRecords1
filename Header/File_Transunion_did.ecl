boolean var1 := true : stored('production');
import ut,data_services;
export File_Transunion_did := 
dataset(data_services.Data_location.transunion_did +'thor_data400::base::transunion_did' + if(var1,'_Prod',''),header.Layout_Header, flat);