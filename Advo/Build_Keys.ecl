  import  VersionControl,Risk_Indicators;

export Build_Keys(string pversion) := 
function

	key_geolink := Risk_Indicators.Key_Neighborhood_Stats_geolink;

	VersionControl.macBuildNewLogicalKeywithName(key_addr1			,Keynames(pversion).addr_search1.Logical			,Build_addr_search1_key			,pShouldExport := false);
	VersionControl.macBuildNewLogicalKeywithName(key_addr2			,Keynames(pversion).addr_search2.Logical			,Build_addr_search2_key			,pShouldExport := false);
	VersionControl.macBuildNewLogicalKeywithName(key_geolink		,Keynames(pversion).geolink.Logical						,Build_geolink_key					,pShouldExport := false);
	VersionControl.macBuildNewLogicalKeywithName(Key_Addr1_FCRA	,Keynames(pversion).addr_fcra_search1.Logical	,Build_FCRA_addr_search1_key,pShouldExport := false);
    VersionControl.macBuildNewLogicalKeywithName(advo.Key_Addr_City	,Keynames(pversion).city_search.Logical	,Build_city_key,pShouldExport := false);
	VersionControl.macBuildNewLogicalKeywithName(advo.Key_Addr_zip	,Keynames(pversion).zip_search.Logical	,Build_zip_key,pShouldExport := false);
	VersionControl.macBuildNewLogicalKeywithName(key_addr1_history			,Keynames(pversion).addr_search1_history.Logical			,Build_addr_search1_history_key			,pShouldExport := false);
	VersionControl.macBuildNewLogicalKeywithName(Key_Addr1_FCRA_history	,Keynames(pversion).addr_fcra_search1_history.Logical	,Build_FCRA_addr_search1_history_key, pShouldExport := false);
  	
		
	writekeys :=
			sequential(
			parallel(
				 Build_addr_search1_key
				,Build_addr_search2_key
				,Build_geolink_key
				,Build_FCRA_addr_search1_key
				,Build_addr_search1_history_key
				,Build_FCRA_addr_search1_history_key
				
					),
			 parallel(
				Build_city_key
				,Build_zip_key)
				);

	return
		if(VersionControl.IsValidVersion(pversion)
			,sequential(
				writekeys	
				,Promote(pversion, 'key').New2Built
			)
			,output('No Valid version parameter passed, skipping Advo.Build_Keys atribute')
		);

end;
