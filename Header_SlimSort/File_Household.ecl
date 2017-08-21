import ut,data_services,PRTE2_Header;
boolean var1 := true : stored('production');
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
EXPORT File_Household := header_slimsort.hss_household;
#ELSE
EXPORT File_Household := DATASET(
	data_services.data_location.prefix('Person_header') + 'thor400_44::base::HSS_Household' + if(var1,'_Prod',''),
	header_slimsort.layout_household,
	flat);
#END