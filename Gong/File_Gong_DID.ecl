//gong records with a valid did field  
boolean var1 := true : stored('production');
import ut,data_services,Watchdog,PRTE2_Header;
layout_gong_did_ccpa := RECORD
	Watchdog.Layout_Gong_DID;
	UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
END;
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_Gong_Did := dataset([],layout_gong_did_ccpa);
#ELSE
export File_Gong_Did := 
dataset(data_services.Data_location.Prefix('Gong_did') +'thor_data400::base::Gong_did' + if(var1,'_Prod',''),layout_gong_did_ccpa, flat);
#END