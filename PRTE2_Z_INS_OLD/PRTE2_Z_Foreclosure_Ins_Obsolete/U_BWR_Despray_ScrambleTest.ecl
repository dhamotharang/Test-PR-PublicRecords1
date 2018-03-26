// PRTE2_Foreclosure.BWR_Despray_ScrambleTest -
//  - despray scrambling test phases

IMPORT PRTE2_Foreclosure as FRCL;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT Foreclosure Scramble Despray');

dateString	:= ut.GetDate;
LandingZoneIP 				:= FRCL.Constants.LandingZoneIP;
TempCSV								:= FRCL.Files.FRCL_CSV_FILE + '::' +  WORKUNIT;

EXPORT_DS := SCR.Scramble_PChar.DoubleCheckRecords;
lzFilePathGatewayFile	:= FRCL.Constants.SourcePathForFRCLCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);