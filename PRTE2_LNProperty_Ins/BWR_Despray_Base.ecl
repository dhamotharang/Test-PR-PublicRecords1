/* *********************************************************************************************************************
PRTE2_LNProperty_Ins.BWR_Despray_Base

There is confusing stuff in various code attributes here until we can re-write some of this.
Originally we were told we had to take our base file and split it into 3 base files - then Terri saw that and said no -
We just had to convert our layout to the new layout and save one base file - then the Boca code would do the splitting.

NOTE: We don't yet have a true despray and spray so for now to put our base data into the new boca build we just did
PRTE2_LNProperty_Ins.BWR_Spray_Not_Yet_Ready

********************************************************************************************************************* */

IMPORT PRTE2_LNProperty_Ins as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString					:= ut.GetDate;
TempCSV							:= LNP.Files.FILE_SPRAY_NAME;

// Various files we might want to despray (Dev, Prod) [Dev and Prod need to be reduced]
// desprayName 				:= 'LN_PropertyV2_Base_DEV_'+dateString+'.csv';
// LNP_Base_Expanded	:= LNP.Files.ALP_LNP_SF_DS;
desprayName 				:= 'LN_PropertyV2_Base_PROD_'+dateString+'.csv';
LNP_Base_Expanded		:= LNP.Files.ALP_LNP_SF_DS_Prod;
EXPORT_DS						:= SORT(LNP_Base_Expanded, did,fid_type,ln_fares_id,lname,fname,zip);

LandingZoneIP 			:= LNP.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForCSV + desprayName;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

