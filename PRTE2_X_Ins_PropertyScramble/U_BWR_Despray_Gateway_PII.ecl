﻿// PRTE2_PropertyInfo.U_BWR_Despray_Gateway 
//  - despray the Property Info gateway file (PRE-Scramble) for editing.

IMPORT PRTE2_PropertyInfo as PII;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT PropertyInfo Despray');

dateString := ut.GetDate;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.PII_CSV_FILE + '::' +  WORKUNIT;
//----------- Prepare the Export_DS desired --------------------------
desprayName 					:= 'PropertyInfo_Orig_GW_'+dateString+'.csv';
EXPORT_DS0				:= PII.Files.PII_Gateway_Base_SF_DS;
EXPORT_DS := SORT(EXPORT_DS0,lname,fname,i_datasource);
// desprayName 					:= 'PropertyInfo_Gateway_Recover2_'+dateString+'.csv';
// EXPORT_DS							:= Files.PII_Gateway_Scramble2_DS;
// PII_Base_SF_DS				:= PII.Files.PII_Gateway_Scramble2_DS;

//-----------------------------------------------------------------------
lzFilePathGatewayFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

