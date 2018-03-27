// Despray the LNProperty file for Alpharetta but during the despray, revise the LN_fares_ID
// also adding the logic to convert to new V2 layout that will hold xyz_code values.

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;

TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;
LandingZoneIP 			:= LNP.Constants.LandingZoneIP;
Layouts.editable_spreadsheet_V2 Gateway_Reduce_V2(Layouts.batch_in L) := TRANSFORM
		SELF  := L;
		SELF  := [];
END;
desprayName 				:= 'LN_Property_FixFares_DEV_V2_'+dateString+'.csv';
LNP_Base_SF_DS			:= LNP.Files.LNP_Scramble_SF_DS;
lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;
// OAALP0100001
LNP_Base_SF_DS fixit(LNP_Base_SF_DS L, INTEGER CNTR) := TRANSFORM
		NumInt := 100000 + CNTR;
		StrInt := INTFORMAT(NumInt,7,1);
		SELF.LN_Fares_ID := L.LN_Fares_ID[1..2] + 'ALP' + StrInt;
		SELF := L;
END;
EXPORT_DS1 					:= PROJECT(LNP_Base_SF_DS, fixit(LEFT,COUNTER));
EXPORT_DS 					:= PROJECT(EXPORT_DS1, Gateway_Reduce_V2(LEFT));

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);