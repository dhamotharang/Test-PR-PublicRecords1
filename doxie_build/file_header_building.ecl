boolean var1 := true : stored('production');
import ut,data_services,header,PRTE2_Header;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export file_header_building := 
PRTE2_Header.files.file_header_building;
#ELSE
export file_header_building := 
dataset(data_services.Data_location.file_header_building +'thor_data400::base::file_header_building' + if(var1,'_Prod',''),header.Layout_Header, flat);
#END