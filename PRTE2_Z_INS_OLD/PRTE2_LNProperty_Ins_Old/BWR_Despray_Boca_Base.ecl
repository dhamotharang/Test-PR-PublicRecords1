// PRTE2_LNProperty.BWR_Despray_Boca_Base 

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;

TempCSV							:= LNP.Files.LNP_CSV_FILE;
desprayNameA 				:= 'LN_Property_Boca_Base_A_'+dateString+'.csv';
desprayNameDM				:= 'LN_Property_Boca_Base_DM_'+dateString+'.csv';

LNP_Base_SF_DS			:= LNP.Files.BOCA_BASE_SF_DS_PROD;		// Boca base only on PROD THOR
BaseSort						:= SORT(LNP_Base_SF_DS,RECORD);
BaseDedup						:= DEDUP(BaseSort,RECORD);
// Boca can decide if they want to use the smaller CSV layout or not. Here's a first guess.

// The following is more for study - probably not a good layout to spray back in yet
EXPORT_DS 					:= PROJECT(BaseDedup, LNP.Transforms.Boca_Reduce(LEFT));
EXPORT_DS_A		:= EXPORT_DS(LN_Fares_ID[2]='A');
EXPORT_DS_DM	:= EXPORT_DS(LN_Fares_ID[2]<>'A');
LandingZoneIP 			:= LNP.Constants.LandingZoneIP;
lzFilePathGatewayFileA	:= LNP.Constants.SourcePathForLNPCSV + desprayNameA;
lzFilePathGatewayFileDM	:= LNP.Constants.SourcePathForLNPCSV + desprayNameDM;
PRTE2_Common.DesprayCSV(EXPORT_DS_A, TempCSV, LandingZoneIP, lzFilePathGatewayFileA);
PRTE2_Common.DesprayCSV(EXPORT_DS_DM, TempCSV, LandingZoneIP, lzFilePathGatewayFileDM);
