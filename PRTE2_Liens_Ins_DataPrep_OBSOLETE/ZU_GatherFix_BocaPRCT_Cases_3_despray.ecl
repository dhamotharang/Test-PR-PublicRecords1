/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_3_despray

 Gather and ALL Boca data, fix dates and then despray results...
 Alter here to save these to TEMP THOR files for further processing.

 These are Phase 1 test cases - still need PII replaced
  -- there is possibility that we will receive other data instead of Boca PRTE cases so either of these can become phase1 data.
 THEN - add logic to replace all PII data with PrimDriver PII

1. we will test it in DEV, then migrate new code to spray our data to the prod thor.
2. once migrated we spray our new data into the prod thor.
3. Then we wait till Boca PRCT is ready to do a build and it adds the append of our data.
    (not sure if they will want to do initial testing without our data or not)

********************************************************************************************* */


IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins_DataPrep, PRTE2_Liens, PRTE2_Common, ut;

// **********************************************************************************************

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// **********************************************************************************************
Main1DS := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_2_DS;
Party1DS := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_2_DS;
// **********************************************************************************************
MainLay := PRTE2_Liens_Ins.Layouts.BaseMain_in_raw;
PartyLay := PRTE2_Liens_Ins.Layouts.Baseparty_in;
// **********************************************************************************************
PartyLay trxParty(Party1DS L) := TRANSFORM
		SELF.tmsid := L.tmsid_New;
		SELF.rmsid := L.tmsid_New[1..2]+'R'+L.tmsid_New[3..];
		SELF.DID := L.DIDNew;
		SELF := L;
END;
PartyOut := PROJECT(Party1DS,trxParty(LEFT));

MainLay trxMain(Main1DS L) := TRANSFORM
		SELF.tmsid := L.tmsid_New;
		SELF.rmsid := L.tmsid_New[1..2]+'R'+L.tmsid_New[3..];
		SELF := L;
END;
MainOut := PROJECT(Main1DS,trxMain(LEFT));

// **********************************************************************************************
// **********************************************************************************************
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV	:= PRTE2_Liens_Ins.Files.FILE_SPRAY;
pathFileParty	:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;
PRTE2_Common.DesprayCSV(MainOut, TempCSV+'_1', LandingZoneIP, pathFileParty+'Main_Alpha_All.csv');
PRTE2_Common.DesprayCSV(PartyOut, TempCSV+'_2', LandingZoneIP, pathFileParty+'Party_Alpha_All.csv');
// **********************************************************************************************