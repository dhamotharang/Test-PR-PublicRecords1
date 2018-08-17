IMPORT PRTE2_Email_Data_Ins, PRTE2_BIPV2_BusHeader, PRTE2_Common;

fileVersion := PRTE2_Common.Constants.TodayString+'';

desprayName := 'PRCT_BIPHeaderCommonBase_'+fileVersion+'.csv';
EXPORT_DS	  := SORT(PRTE2_BIPV2_BusHeader.CommonBase.DS_BUILT,orgid,seleid,proxid);

// Change these once we have a code module ***************************************
TempCSV			:= PRTE2_Email_Data_Ins.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
LandingZoneIP 	:= PRTE2_Common.Constants.InsLandingZone;
lzFilePathGatewayFile	:= PRTE2_Email_Data_Ins.Constants.SourcePathForCSV + desprayName;
// END: Change these once we have a code module **********************************


InsLandingPathPrefix 	:= PRTE2_Common.Constants.InsLandingPathPrefix;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
