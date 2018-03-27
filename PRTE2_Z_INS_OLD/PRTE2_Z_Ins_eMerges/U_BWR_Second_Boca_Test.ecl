import	ut, RoxieKeyBuild, PRTE_CSV, PRTE2_eMerges, PRTE2_Common;

	STRING fileVersion := ut.GetDate+'d';
	dateString			:= ut.GetDate;
	LandingZoneIP 	:= PRTE2_eMerges.Constants.LandingZoneIP;
	TempCSV					:= PRTE2_eMerges.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
	desprayName 		:= 'CCW_Boca_Payload_'+dateString+'.csv';
	lzFilePathGatewayFile	:= PRTE2_eMerges.Constants.SourcePathForCSV + desprayName;
	
	finalMasterLayout := PRTE2_eMerges.Layouts.AlphaBaseOUT;
	
	DS1	:= 	PRTE_CSV.CCW.dthor_data400__key__ccw__rid;

	DSFinal := PROJECT( DS1, finalMasterLayout);
	// BocaINFileName := PRTE2_eMerges.Files.eMerges_Boca_IN(fileVersion);
	// OUTPUT(DS1,, BocaINFileName, OVERWRITE);
	// PRTE2_Common.DesprayCSV(DSFinal, TempCSV, LandingZoneIP, lzFilePathGatewayFile);


	// This macro is what builds the super files with generations: QA, Father, Grandfater
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(DSFinal,
																			 PRTE2_eMerges.Files.BASE_PREFIX_NAME, 
																			 PRTE2_eMerges.Files.Boca_BASE_NAME, 
																			 fileVersion, buildBase, 3,
																			 false,true);

	SEQUENTIAL(buildBase);
