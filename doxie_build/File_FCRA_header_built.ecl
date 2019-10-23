import header,data_services,PRTE2_Header;
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_FCRA_header_built := PRTE2_Header.files.File_FCRA_header_building;
#ELSE
export File_FCRA_header_built := dataset(data_services.Data_location.prefix('person_header')
																		+'thor_data400::base::file_fcra_header_building_built',header.Layout_Header, flat);
#END