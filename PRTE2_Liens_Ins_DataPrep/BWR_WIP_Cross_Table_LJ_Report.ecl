/* *****************************************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_WIP_Cross_Table_LJ_Report
Take the records in WIPMain and WIPParty and create a person L and/or J report along with the states

I should rename this BWR_WIP_Cross_Table_LJ_Report_TU_EQ_RC
This one happens to be broken into EQ, TU, RC - but it'll be a lot more simple if only 1 report is needed.
***************************************************************************************************************** */
IMPORT PRTE2_Liens_Ins_DataPrep,STD,PRTE2_Liens_Ins,PRTE2_Common;


STRING dateString := PRTE2_Common.Constants.TodayString+'';
desprayNameEQ	:= 'Liens_People_EQ_'+dateString+'.csv';
desprayNameTU	:= 'Liens_People_TU_'+dateString+'.csv';
desprayNameRC	:= 'Liens_People_RC_'+dateString+'.csv';

Party := PRTE2_Liens_Ins_DataPrep.Files.Save_PartyWIP_DS;
// Any main records without a filingTypeDesc are neither L or J but (I guess) just history records?
Main 	:= PRTE2_Liens_Ins_DataPrep.Files.Save_MainWIP_DS(TRIM(filing_type_desc)<>'');
CrossJoinLayout := PRTE2_Liens_Ins_DataPrep.Layouts.BaseMainCrossReportJoin;
LienJudgeLookup := PRTE2_Liens_Ins_DataPrep.Set_Lien_Judgement_Descriptions.LJDictionary;
// Desired reports - for each person, how many L and or J - and then report this by state.
// First we have to join the Party and Main to get all records that apply
LnJ_Records0 := JOIN(Party,Main,
								LEFT.tmsid = RIGHT.tmsid AND left.rmsid=RIGHT.rmsid,
										TRANSFORM({CrossJoinLayout},
												SELF.PJoinInt := LEFT.joinint,
												SELF.PDID := LEFT.did,
												SELF.PSSN		:= LEFT.SSN,
												SELF.POState := LEFT.orig_state,
												SELF.PSt		 := LEFT.st,
												SELF.PName := LEFT.orig_name,
												SELF.RecType_LJ := LienJudgeLookup[RIGHT.filing_type_desc].recType,
												SELF := LEFT,
												SELF := RIGHT
												),
								LEFT OUTER);
LnJ_Records := LnJ_Records0(tmsid<>'');

OUTPUT(LnJ_Records);
OUTPUT(COUNT(LnJ_Records));

//--------------------------------------------------------------
eqData := LnJ_Records(ln_product_tie='Eqfx_data');
tuData := LnJ_Records(ln_product_tie='TU_Data');
rcData := LnJ_Records(ln_product_tie='Risk_Classifier');
//--------------------------------------------------------------

report0 := RECORD
	recTypeSrc	:= eqData.POState+':'+eqData.PDID;
	Judgmts   	:= COUNT(GROUP,eqData.RecType_LJ='J');
	Liens   		:= COUNT(GROUP,eqData.RecType_LJ='L');
	GroupCount 	:= COUNT(GROUP);
END;

RepTable0 := TABLE(eqData,report0,eqData.POState+':'+eqData.PDID);

report1 := RECORD
	recTypeSrc	:= tuData.POState+':'+tuData.PDID;
	Judgmts   	:= COUNT(GROUP,tuData.RecType_LJ='J');
	Liens   		:= COUNT(GROUP,tuData.RecType_LJ='L');
	GroupCount 	:= COUNT(GROUP);
END;

RepTable1 := TABLE(tuData,report1,tuData.POState+':'+tuData.PDID);

report2 := RECORD
	recTypeSrc	:= rcData.POState+':'+rcData.PDID;
	Judgmts   	:= COUNT(GROUP,rcData.RecType_LJ='J');
	Liens   		:= COUNT(GROUP,rcData.RecType_LJ='L');
	GroupCount 	:= COUNT(GROUP);
END;

RepTable2 := TABLE(rcData,report2,rcData.POState+':'+rcData.PDID);


OUTPUT(SORT(RepTable0,recTypeSrc),ALL);
OUTPUT(SORT(RepTable1,recTypeSrc),ALL);
OUTPUT(SORT(RepTable2,recTypeSrc),ALL);
BasePartyReportLayout := PRTE2_Liens_Ins_DataPrep.Layouts.BasePartyReportLayout;
BasePartyWIPLayout := PRTE2_Liens_Ins_DataPrep.Layouts.BasePartyWIPLayout;
ReportSumEQ := PROJECT(RepTable0,
									TRANSFORM({BasePartyWIPLayout},
										SELF.DID :=STD.STR.SplitWords(LEFT.recTypeSrc,':')[2],
										SELF.STATE :=STD.STR.SplitWords(LEFT.recTypeSrc,':')[1],
										SELF := LEFT));
ReportSumTU := PROJECT(RepTable1,
									TRANSFORM({BasePartyWIPLayout},
										SELF.DID :=STD.STR.SplitWords(LEFT.recTypeSrc,':')[2],
										SELF.STATE :=STD.STR.SplitWords(LEFT.recTypeSrc,':')[1],
										SELF := LEFT));
ReportSumRC := PROJECT(RepTable2,
									TRANSFORM({BasePartyWIPLayout},
										SELF.DID :=STD.STR.SplitWords(LEFT.recTypeSrc,':')[2],
										SELF.STATE :=STD.STR.SplitWords(LEFT.recTypeSrc,':')[1],
										SELF := LEFT));

eqPeople := PROJECT(DEDUP(SORT(eqData,did),did),BasePartyReportLayout);
tuPeople := PROJECT(DEDUP(SORT(tuData,did),did),BasePartyReportLayout);
rcPeople := PROJECT(DEDUP(SORT(rcData,did),did),BasePartyReportLayout);
ReportEQ := JOIN(eqPeople,ReportSumEQ,
									LEFT.did = RIGHT.did,
										TRANSFORM({BasePartyReportLayout},
											SELF := RIGHT;
											SELF := LEFT));
ReportTU := JOIN(TUPeople,ReportSumTU,
									LEFT.did = RIGHT.did,
										TRANSFORM({BasePartyReportLayout},
											SELF := RIGHT;
											SELF := LEFT));
ReportRC := JOIN(RCPeople,ReportSumRC,
									LEFT.did = RIGHT.did,
										TRANSFORM({BasePartyReportLayout},
											SELF := RIGHT;
											SELF := LEFT));
											
OUTPUT(ReportEQ);
OUTPUT(ReportTU);
OUTPUT(ReportRC);
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
TempCSV3				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_3';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

PRTE2_Common.DesprayCSV(ReportEQ, TempCSV1, LandingZoneIP, pathFile+desprayNameEQ);
PRTE2_Common.DesprayCSV(ReportTU, TempCSV2, LandingZoneIP, pathFile+desprayNameTU);
PRTE2_Common.DesprayCSV(ReportRC, TempCSV2, LandingZoneIP, pathFile+desprayNameRC);
