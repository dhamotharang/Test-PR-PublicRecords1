//--------------------------------------------------------------------
// PRTE2_Bankruptcy.BWR_Despray_Base
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

// --------------------------------------------------------------------------------
//  This is for despraying base data to csv file
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Bankruptcy, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Bankruptcy Despray');

Constants := PRTE2_Bankruptcy.Constants;
Files     := PRTE2_Bankruptcy.Files;
Layouts		:= PRTE2_Bankruptcy.Layouts;
//u_Files   := PRTE2_Bankruptcy.u_Files;
LandingZoneIP 			:= Constants.LandingZoneIP;


STRING fileVersion 	:= ut.GetDate+'';
//------------- despray names --------------------------------
despray_status 			:= 'Bankruptcy_status_DEV_'+fileVersion+'.csv';
despray_comments 		:= 'Bankruptcy_comments_DEV_'+fileVersion+'.csv';
despray_main 				:= 'Bankruptcy_main_DEV_'+fileVersion+'.csv';
despray_search 			:= 'Bankruptcy_search_DEV_'+fileVersion+'.csv';
//------------------------------------------------------------

//------------- despray Alpharetta DEV data ------------------
EXPORT_DS_status		:=	Files.status_SF_DS;
EXPORT_DS_comments	:=	Files.comments_SF_DS;
EXPORT_DS_main			:=	Files.main_SF_DS;
EXPORT_DS_search		:=	Files.search_SF_DS;
//------------------------------------------------------------
/*
//------------- despray initial Alpharetta DEV data ----------
EXPORT_DS_status		:=	u_Files.status_SF_DS;
EXPORT_DS_comments	:=	u_Files.comments_SF_DS;
EXPORT_DS_main			:=	u_Files.main_SF_DS;
EXPORT_DS_search		:=	u_Files.search_SF_DS;
//------------------------------------------------------------
*/


//------------------------------------------------------------
Temp_status_CSV			:= Files.FILE_DESPRAY_status + '::' +  WORKUNIT;
Temp_comments_CSV		:= Files.FILE_DESPRAY_comments + '::' +  WORKUNIT;
Temp_main_CSV				:= Files.FILE_DESPRAY_main + '::' +  WORKUNIT;
Temp_search_CSV			:= Files.FILE_DESPRAY_search + '::' +  WORKUNIT;

lzFilePathGatewayFile_status		:= Constants.SourcePathForCSV + despray_status;
lzFilePathGatewayFile_comments	:= Constants.SourcePathForCSV + despray_comments;
lzFilePathGatewayFile_main			:= Constants.SourcePathForCSV + despray_main;
lzFilePathGatewayFile_search		:= Constants.SourcePathForCSV + despray_search;

PRTE2_Common.DesprayCSV(EXPORT_DS_status, 	Temp_status_CSV, 		LandingZoneIP, lzFilePathGatewayFile_status);
PRTE2_Common.DesprayCSV(EXPORT_DS_comments, Temp_comments_CSV,	LandingZoneIP, lzFilePathGatewayFile_comments);
PRTE2_Common.DesprayCSV(EXPORT_DS_main, 		Temp_main_CSV, 			LandingZoneIP, lzFilePathGatewayFile_main);
PRTE2_Common.DesprayCSV(EXPORT_DS_search, 	Temp_search_CSV, 		LandingZoneIP, lzFilePathGatewayFile_search);
