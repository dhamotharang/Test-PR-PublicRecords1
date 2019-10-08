//gong records with a valid did field  
boolean var1 := true : stored('production');
import ut,data_services,Watchdog;
layout_gong_did_ccpa := RECORD
	Watchdog.Layout_Gong_DID;
	UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
END;

export File_Gong_Did := 
dataset(data_services.Data_location.Prefix('Gong_did') +'thor_data400::base::Gong_did' + if(var1,'_Prod',''),layout_gong_did_ccpa, flat);