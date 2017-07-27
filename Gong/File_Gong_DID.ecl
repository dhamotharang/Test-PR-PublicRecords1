//gong records with a valid did field  
boolean var1 := true : stored('production');
import ut,data_services,Watchdog;
export File_Gong_Did := 
dataset(data_services.Data_location.Prefix('Gong_did') +'thor_data400::base::Gong_did' + if(var1,'_Prod',''),Watchdog.Layout_Gong_DID, flat);