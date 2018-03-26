/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_PRCT_Liens_2

********************************************************************************************* */
IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Common, LiensV2_preprocess, PRTE2_Liens_Ins, PRTE2_X_Ins_DataCleanse;

//---------------------------------------------------
STRING dateString := PRTE2_Common.Constants.TodayString;
desprayNameMain	:= 'Liens_Main_Test_'+dateString+'.csv';
desprayNameParty	:= 'Liens_Party_Test_'+dateString+'.csv';

//---- mini Prod files -----------------------------------------------
// Main_Prod_Mini		:=	SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Main_DS,tmsid,rmsid,process_date);
// Party_Prod_Mini	:=	SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Party_DS,tmsid,rmsid,date_first_seen);
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
Analy_DS := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.AnalyMain1_DS;
Main_Prod_Mini	:=	DEDUP(SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Main_DS_Raw,filing_number),filing_number);
transformMain := PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_Functions.transformMain;
TestMain := JOIN(Analy_DS,Main_Prod_Mini,
									LEFT.filing_number = RIGHT.filing_number,
									transformMain(LEFT,RIGHT),
									inner);
//-----------------------------------------------------------------------------------------
//---------------------------------------------------
PrimPartyLayout := PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseParty_in_joinable;
// PrimDrivers := PRTE2_X_Ins_DataCleanse.Files_Alpha.primDriverCleanDS;
PrimDrivers := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Prim_Party_DS;
//---------------------------------------------------
/* NEXT:
Create a Main numbered by state too.
JOIN those where joinint= and state=
	where those joins match will become our new party records.
ALSO - check all LexIDs against the Boca PRCT Person Header key to confirm no matches.
	OUTPUT a count of that to know if we hit any.
*/
//-----------------------------------------------------------------------------------------
G_Main := GROUP(SORT(PrimDrivers,agency_state),agency_state);
PrimPartyLayout trxParty(G_Main L, INTEGER CNT) := TRANSFORM
		SELF := L;
END;
PartyFinal := UNGROUP(PROJECT(G_Main,trxParty(LEFT,COUNTER)));
//-----------------------------------------------------------------------------------------

OUTPUT(TestMain,NAMED('TestMain'));
// OUTPUT(Party_Prod_Mini);

// ---------------------------------------------------------------------------

LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

PRTE2_Common.DesprayCSV(TestMain, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
// PRTE2_Common.DesprayCSV(Export_Party, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
// ---------------------------------------------------------------------------