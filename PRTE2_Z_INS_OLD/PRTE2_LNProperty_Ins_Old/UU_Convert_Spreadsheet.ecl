/*---------------------------------------------------------------------
routine to move our spreadsheet to the Boca layout. Codes, not descriptions.
---------------------------------------------------------------------*/
IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;
TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;
Transformer 				:= LNP.UU_Transform_Data(dateString);

desprayName 				:= 'LN_Property_AV3_Base_DEV_'+dateString+'.csv';
testds1							:= LNP.Files.LNP_Scramble_SF_DS;
// testds 							:= DISTRIBUTE(testds1,(integer)zip);
Reformat_DS1 				:= PROJECT(testds1, Transformer.Reformat_PHASE1 (Left));
EXPORT_DS						:= SORT(Reformat_DS1, did,fid_type,ln_fares_id,lname,fname,zip);

tempDS1 := EXPORT_DS(did=0);
tempDS2 := EXPORT_DS(did>0);

minDID := MIN(tempDS2,did);
maxDID := MAX(EXPORT_DS,did);

OUTPUT(COUNT(tempDS1));
OUTPUT(minDID+' to '+maxDID);

LandingZoneIP 			:= LNP.Constants.LandingZoneIP;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);




