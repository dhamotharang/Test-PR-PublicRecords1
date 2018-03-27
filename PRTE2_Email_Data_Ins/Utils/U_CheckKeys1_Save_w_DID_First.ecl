/* --------------------------------------------------------------------------------
 Despray the data but put DID as a first column so I can easily copy/paste from the CSV
 Need to do that copy paste of some sample DIDs into the second script U_CheckKeys2_Paste_in_DIDs
 -------------------------------------------------------------------------------- */

IMPORT ut, PRTE2_Email_Data_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Emails Despray');

dateString			:= ut.GetDate;
TempCSV					:= PRTE2_Email_Data_Ins.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

DIDFirstLayout := RECORD
			unsigned6 bapdid := 0;
			PRTE2_Email_Data_Ins.Layouts.base;
END;

desprayName 		:= 'Email_Base_DidFirst_'+dateString+'.csv';
EXPORT_DS1	    := PRTE2_Email_Data_Ins.Files.Email_Base_DS;

DIDFirstLayout transx(EXPORT_DS1 L) := TRANSFORM
		SELF.bapdid := L.did;
		SELF := L;
END;
EXPORT_DS	      := PROJECT(EXPORT_DS1,transx(LEFT));
// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_Common.Constants.EDATA11;
lzFilePathGatewayFile	:= PRTE2_Email_Data_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

