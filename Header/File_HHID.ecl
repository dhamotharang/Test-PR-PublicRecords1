boolean var1 := true : stored('production');
import ut,data_services,header,PRTE2_Header;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_HHID := 
dataset('~PRTE::base::HHID' ,header.layout_hhid, flat);
#ELSE
export File_HHID := 
dataset(data_services.Data_location.prefix('') +'thor_data400::base::HHID' + if(var1,'_Prod',''),header.layout_hhid, flat);
#END