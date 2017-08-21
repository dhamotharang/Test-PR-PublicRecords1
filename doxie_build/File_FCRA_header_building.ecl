boolean var1 := true : stored('production');
import header,data_services,PRTE2_Header;
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_FCRA_header_building := PRTE2_Header.files.File_FCRA_header_building;
#ELSE
export File_FCRA_header_building := dataset(data_services.Data_location.prefix('person_header')
																		+'thor_data400::base::file_fcra_header_building' + if(var1,'_Prod',''),header.Layout_Header, flat);
#END