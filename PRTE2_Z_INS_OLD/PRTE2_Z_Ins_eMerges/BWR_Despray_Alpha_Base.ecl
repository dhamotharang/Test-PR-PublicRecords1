﻿// --------------------------------------------------------------------------------
//  PRTE2_eMerges.BWR_Despray_Alpha_Base 
//  This is for despraying base data to csv file
// --------------------------------------------------------------------------------


IMPORT ut, PRTE2_eMerges, PRTE2_Common;
#workunit('name', 'Alpha PRTE2 eMerges Despray');

dateString			:= ut.GetDate;
LandingZoneIP 	:= PRTE2_eMerges.Constants.LandingZoneIP;
TempCSV					:= PRTE2_eMerges.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 				:= 'eMerges_Export_DEV_'+dateString+'.csv';
EXPORT_DS	:=	PRTE2_eMerges.Files.eMerges_Alpha_SF_DS;
// desprayName 				:= 'HuntFish_Export_PROD_'+dateString+'.csv';
// EXPORT_DS	:=	PRTE2_eMerges.Files.HuntFish_Alpha_SF_DS_Prod;
lzFilePathGatewayFile	:= PRTE2_eMerges.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

