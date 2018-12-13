/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_2

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
PrimDrivers := PRTE2_X_Ins_DataCleanse.Files_Alpha.primDriverCleanDS(BocaDID <> 0);
Main1DS := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_1_DS(DIDNew<>'0');
Party0DS := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_1_DS(DIDNew<>'0');
// **********************************************************************************************
Party0DS fillTmsNew(Main1DS L, Party0DS R) := TRANSFORM
	SELF.tmsid_New := L.tmsid_New;
	SELF.rmsid := L.tmsid_New[1..2]+'R'+L.tmsid_New[3..];
	SELF := R;
END;
// **************** renumber the joinint values (they were per state) ***************************
Party0DS workTrx(Party0DS L, integer cntr) := TRANSFORM
		SELF.JoinInt := cntr;
		SELF := L;
END;
Party1DS := PROJECT(Party0DS,workTrx(LEFT,COUNTER));
// **********************************************************************************************

MainWorkLay := PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseMain_in_joinable;
PartyWorkLay := PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseParty_in_joinable;

OUTPUT(Main1DS);
OUTPUT(Party1DS);
OUTPUT(PrimDrivers);
// ** reviewing fields in 

MainFilled := JOIN(Main1DS, PrimDrivers,
											left.didnew = (STRING)right.uniqueid,
											PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_TransformMain(LEFT,RIGHT),
											left outer
									);
Party1aDS := JOIN(MainFilled,Party1DS,
											left.tmsid = right.tmsid,
											fillTmsNew(LEFT,RIGHT),
											inner
									);
Party1bDS := DEDUP(SORT(Party1aDS,joinint),joinint);
OUTPUT(COUNT(Party1DS));
OUTPUT(COUNT(Party1aDS));
OUTPUT(COUNT(Party1bDS));
PartyFilled := JOIN(Party1bDS, PrimDrivers,
											left.didnew = (STRING)right.uniqueid,
											PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_TransformParty(LEFT,RIGHT),
											left outer
									);

OUTPUT(MainFilled);
OUTPUT(PartyFilled);

// **********************************************************************************************
MainName 	:= PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_File_2;
PartyName := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_File_2;
OUTPUT(MainFilled,,MainName,overwrite);
OUTPUT(PartyFilled,,PartyName,overwrite);
// **********************************************************************************************

