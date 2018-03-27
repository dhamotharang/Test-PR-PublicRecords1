/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_1

 Gather and ALL Boca data, fix dates and then despray results...
 Alter here to save these to TEMP THOR files for further processing.

 These are Phase 1 test cases - still need PII replaced
  -- there is possibility that we will receive other data instead of Boca PRTE cases so either of these can become phase1 data.
  -- preparation of that data if we get it will be a U_GatherFix_Boca_PRCT_Liens_1b which would create similar phase 1 data.

 THEN - add logic to replace all PII data with PrimDriver PII

1. we will test it in DEV, then migrate new code to spray our data to the prod thor.
2. once migrated we spray our new data into the prod thor.
3. Then we wait till Boca PRCT is ready to do a build and it adds the append of our data.
    (not sure if they will want to do initial testing without our data or not)

********************************************************************************************* */


IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins_DataPrep, PRTE2_Liens_Ins, PRTE2_Liens, PRTE2_Common, ut;

// **********************************************************************************************

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// **********************************************************************************************
PrimDrivers := PRTE2_X_Ins_DataCleanse.Files_Alpha.primDriverCleanDS(BocaDID <> 0);
MainNew0 := PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_Functions.gatherFixBocaMain;
PartyNew0 := PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_Functions.gatherFixBocaParty(0);
// **********************************************************************************************

MainWorkLay := PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseMain_in_joinable;
PartyWorkLay := PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseParty_in_joinable;
//--------------------------------------
PartyWorkLay workTrx(PartyNew0 L, integer cntr) := TRANSFORM
		SELF.JoinInt := cntr;
		SELF.tmsid_New := ''; 
		SELF := L;
END;
PartySort := SORT(PartyNew0,tmsid,persistent_record_id);
PartyNew := PROJECT(PartySort,workTrx(LEFT,COUNTER));
// **********************************************************************************************
partySet := SET(PartyNew,tmsid);
MainFilterd  := MainNew0(tmsid IN partySet);
MainWorkLay workTrxMain(MainFilterd L, integer cntr) := TRANSFORM
		SELF.JoinInt := cntr;
		SELF.tmsid_New := ''; 
		SELF.filing_status := L.filing_status[1].filing_status;
		SELF.filing_status_desc := L.filing_status[1].filing_status_desc;
		SELF := L;
END;
MainFilterd1 := SORT(MainFilterd,tmsid,persistent_record_id);
MainNew := PROJECT(MainFilterd1,workTrxMain(LEFT,COUNTER));
OUTPUT(MAX(MainNew,JoinInt),NAMED('MainNew_Max'));
// **********************************************************************************************
MainWorkLay joinEm(PartyNew L, MainNew R) := TRANSFORM
		SELF.JoinIntParty := L.JoinInt;
		SELF.tmsid_New := ''; 
		SELF.DID := L.DID;
		SELF := R;
END;
//--------------------------------------
Main2	:= JOIN(PartyNew,MainNew,
							left.tmsid = right.tmsid,
							joinEm(left,right),
							INNER
							);
//--------------------------------------
OUTPUT(COUNT(Main2),NAMED('main2_Cnt'));
Main3 := DEDUP(SORT(Main2,JoinInt),JoinInt);				// this s/b final dedup if we don't lose anything above in main2							
OUTPUT(MAX(Main3,JoinInt),NAMED('Main3_Max'));
OUTPUT(COUNT(Main3),NAMED('main3_Cnt'));
Export_Main			:=	SORT(Main3,JoinInt);
Export_Party		:=	SORT(PartyNew,JoinInt);
OUTPUT(Export_Main,NAMED('Export_Main_sample'));
OUTPUT(COUNT(Export_Main),NAMED('Export_Main_Cnt'));
// **********************************************************************************************
PrimDriversPerState := PrimDrivers;
//---------------------------------------------------------------------------------
JoinPrimLay := PRTE2_X_Ins_DataCleanse.Layouts_Alpha.primary_Driver_Clean_Join_Rec;
PrimGroup := GROUP(SORT(PrimDriversPerState,state),state);
PartyGroup := GROUP(SORT(Export_Party,st),st);
JoinPrimLay TrxPrim(PrimGroup L, INTEGER Cntr) := TRANSFORM
		SELF.joinInt := Cntr;
		SELF := L;
END;
PartyGroup trxBase(PartyGroup L,INTEGER CNT) := TRANSFORM
		SELF.joinInt := CNT;
		SELF := L;
END;
PrimStates0 := UNGROUP(PROJECT(PrimGroup,TrxPrim(LEFT,COUNTER)));
PartyStates0 := UNGROUP(PROJECT(PartyGroup,trxBase(LEFT,COUNTER)));
PartyStates := SORT(PartyStates0,st,joinint);
PrimStates := SORT(PrimStates0,state,joinint);
PartyStates trxNewDIDs(PartyStates L, PrimStates R) := TRANSFORM
		SELF.DIDNew := (STRING) R.uniqueID;
		SELF.DIDBoca := (STRING) R.bocadid;
		SELF.JoinIntPrim := R.joinInt;
		SELF := L;
END;
Export_Main trxMainFinal(Export_Main L, PartyStates R) := TRANSFORM
		SELF.DIDNew 	:= R.DIDNew;
		SELF.DIDBoca 	:= R.DIDBoca;
		SELF := L;
END;
PartyFinal := JOIN(PartyStates, PrimStates,
			left.joinInt = right.joinInt AND left.st = right.state,
			trxNewDIDs(LEFT,RIGHT),
			left outer
			);
MainFinal0 := JOIN(Export_Main,PartyFinal,
								left.tmsid = right.tmsid,
								trxMainFinal(LEFT,RIGHT),
								LEFT OUTER);
MainFinal := DEDUP(SORT(MainFinal0,JoinInt),JoinInt);				// this s/b final dedup if we don't lose anything above in main2							
OUTPUT(COUNT(MainFinal),NAMED('MainFinal_Cnt'));
OUTPUT(MAX(MainFinal,JoinInt),NAMED('MainFinal_Max'));
OUTPUT(MainFinal,NAMED('MainFinal_sample'));

// **********************************************************************************************
MainName 	:= PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_File_1;
PartyName := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_File_1;
primStatesName := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.primStates_File;
OUTPUT(MainFinal,,MainName,overwrite);
OUTPUT(PartyFinal,,PartyName,overwrite);
OUTPUT(PrimStates,,primStatesName,overwrite);
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV	:= PRTE2_Liens_Ins.Files.FILE_SPRAY;
pathFileParty	:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;
PRTE2_Common.DesprayCSV(MainFinal, TempCSV+'_1', LandingZoneIP, pathFileParty+'Main_BocaP_Prepared_All.csv');
PRTE2_Common.DesprayCSV(PartyFinal, TempCSV+'_2', LandingZoneIP, pathFileParty+'Party_BocaP_Prepared_All.csv');
PRTE2_Common.DesprayCSV(PrimStates, TempCSV+'_3', LandingZoneIP, pathFileParty+'PrimDrivers_Prepared_All.csv');
// PRTE2_Common.DesprayCSV(MainFilterd, TempCSV+'_4', LandingZoneIP, pathFileParty+'Main_BocaP_Filtered.csv');

//---------------------------------------------------------------------------------
Reviewthis := PartyFinal(DIDnew <> '0');		// st is messed up on a few party records
report0 := RECORD
	recTypeSrc	 := Reviewthis.st;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(Reviewthis,report0,st);
OUTPUT(SORT(RepTable0,recTypeSrc),ALL);
//---------------------------------------------------------------------------------


/* Party2 := DEDUP(SORT(Export_Party,did),did);
   OUTPUT(COUNT(Party2),NAMED('Party2'));							// 2,308 individual DIDs  
*/

/* PrimDriversPerState := CHOOSESETS(PrimDrivers,
                  state='AK'=>100,state='AL'=>100,state='AR'=>100,state='AZ'=>100,state='CA'=>100,state='CO'=>100,
   							 state='CT'=>100,state='DC'=>100,state='DE'=>100,state='FL'=>100,state='GA'=>100,state='HI'=>100,
   							 state='IA'=>100,state='ID'=>100,state='IL'=>100,state='IN'=>100,state='KS'=>100,state='KY'=>100,
   							 state='LA'=>100,state='MA'=>100,state='MD'=>100,state='ME'=>100,state='MI'=>100,state='MN'=>100,
   							 state='MO'=>100,state='MS'=>100,state='MT'=>100,state='NC'=>100,state='ND'=>100,state='NE'=>100,
   							 state='NH'=>100,state='NJ'=>100,state='NM'=>100,state='NV'=>100,state='NY'=>100,state='OH'=>100,
   							 state='OK'=>100,state='OR'=>100,state='PA'=>100,state='RI'=>100,state='SC'=>100,state='SD'=>100,
   							 state='TN'=>100,state='TX'=>100,state='UT'=>100,state='VA'=>100,state='VT'=>100,state='WA'=>100,
   							 state='WI'=>100,state='WV'=>100,state='WY'=>100, 0);
*/
