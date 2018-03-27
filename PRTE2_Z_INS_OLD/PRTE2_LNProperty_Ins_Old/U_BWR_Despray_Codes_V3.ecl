IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');
dateString	:= ut.GetDate;

desprayName 				:= 'LN_Property_Codes_V3_'+dateString+'.csv';

Files := LNP.Files;
TempCSV							:= Files.LNP_CSV_FILE + '::' +  WORKUNIT;
LandingZoneIP 			:= LNP.Constants.LandingZoneIP;

EXPORT_DS			:= SORT(Files.CODES_V3_SF_DS,file_name,field_name,long_desc);
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);