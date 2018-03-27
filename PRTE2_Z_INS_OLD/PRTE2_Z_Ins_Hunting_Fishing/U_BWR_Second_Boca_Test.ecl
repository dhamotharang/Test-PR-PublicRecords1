import	ut, RoxieKeyBuild, PRTE_CSV, PRTE2_Hunting_Fishing, PRTE2_Common;

	STRING fileVersion := ut.GetDate+'d';
	dateString			:= ut.GetDate;
	LandingZoneIP 	:= PRTE2_Hunting_Fishing.Constants.LandingZoneIP;
	TempCSV					:= PRTE2_Hunting_Fishing.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
	desprayName 		:= 'HuntFish_Boca_Payload_'+dateString+'.csv';
	lzFilePathGatewayFile	:= PRTE2_Hunting_Fishing.Constants.SourcePathForCSV + desprayName;
	
	finalMasterLayout := PRTE2_Hunting_Fishing.Layouts.AlphaBaseOUT;
	
	DS1	:= 	PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__rid;

	DSFinal := PROJECT( DS1, finalMasterLayout);
	BocaINFileName := PRTE2_Hunting_Fishing.Files.HuntFish_Boca_IN(fileVersion);
	OUTPUT(DS1,, BocaINFileName, OVERWRITE);
	PRTE2_Common.DesprayCSV(DSFinal, TempCSV, LandingZoneIP, lzFilePathGatewayFile);


	// This macro is what builds the super files with generations: QA, Father, Grandfater
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(DSFinal,
																			 PRTE2_Hunting_Fishing.Files.BASE_PREFIX_NAME, 
																			 PRTE2_Hunting_Fishing.Files.BOCA_BASE_NAME,
																			 fileVersion, buildBase, 3,
																			 false,true);

	SEQUENTIAL(buildBase);
