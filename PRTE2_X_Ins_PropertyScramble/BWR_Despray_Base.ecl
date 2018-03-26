// PRTE2_X_Ins_PropertyScramble.BWR_Despray_Base
//  - despray the Property Info base file for editing.
// Feb 2015 - going forward always despray the enhanced layout for editing and spray only enhanced so we retain the new fields

IMPORT ut, PRTE2_Common;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
#workunit('name', 'Boca CT Scramble Despray');

dateString := ut.GetDate;
LandingZoneIP 				:= SCR.Constants.LandingZoneIP;
TempCSV								:= SCR.Files.XRef_CSV_FILE + '::' +  WORKUNIT;
//--------------------------------------------------------------------
// desprayName 					:= 'Property_Scramble_Gateway_'+dateString+'.csv';
// EXPORT_DS							:= SCR.Files.XRef_NameAddrXRef_SF_DS; 		// This is the Full Name-Addr Format with a RECNUM
// EXPORT_DS := PROJECT(SCR.Files.XRef_NameAddrXRef_SF_DS ,SCR.layouts.Layout_XRef_Left);
// EXPORT_DS := PROJECT(SCR.Files.XRef_NameAddrXRef_SF_DS ,SCR.layouts.Layout_BatchGateway);
// desprayName 					:= 'Property_Scramble_AddrAddr_'+dateString+'.csv';
// EXPORT_DS							:= SCR.Files.XRef_AddrAddrXRef_SF_DS;				 // This is the thin Addr-Addr Format with a RECNUM (left the name off)
// EXPORT_DS							:= SCR.Files.XRef_AddrAddrXRef_SF_DS(state='FL'); 
// desprayName 					:= 'Property_XRef_Enhanced_Cntrs_'+dateString+'.csv';
// EXPORT_DS							:= SCR.Files.XRef_Enhanced_CNT_SF_DS;
//--- THIS IS THE ONLY LAYOUT TO RELOAD FROM -------------------------
desprayName 					:= 'Property_XRef_Enhanced_'+dateString+'.csv';
EXPORT_DS							:= SCR.Files.XRef_Enhanced_SF_DS;
//--------------------------------------------------------------------
lzFilePathGatewayFile	:= SCR.Constants.SourcePathForXRefCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

