boolean var1 := true : stored('production');
import ut,header,Data_Services,PRTE2_Header;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_header_raw_syncd := prte2_header.file_header_base;
#ELSE
export File_header_raw_syncd := dataset(  Data_Services.Data_location.Prefix('Header')
																					+'thor_data400::base::header_raw_syncd' + if(var1,'_Prod',''),header.Layout_Header, flat);
#END