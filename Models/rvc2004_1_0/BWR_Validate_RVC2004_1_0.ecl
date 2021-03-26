IMPORT UT,STD;
IMPORT rvc2004_1_0;
IMPORT rvc2004_1_0 AS LUCI_Model;
SHARED Constants := rvc2004_1_0.Constants;
SHARED Layouts := rvc2004_1_0.z_layouts;
SHARED FNValidation := rvc2004_1_0.FNValidationWithRC;
// SHARED FNValidation := rvc2004_1_0.FNValidationWORC;
SHARED SampleSize := 1000; // The number of mismatches provided for review
SHARED Threshold_ScoreComp := 0.0000009; // The threshold setup for tree model.
SHARED LandingZoneIP  := '10.173.10.159'; // Will set up by user.
/******************************************************************************\
|**************************Step 0 - Spray Input File***************************|
\******************************************************************************/
SHARED ModelName := 'RVC2004_1_0';
SHARED lzFilePathFolder  := '/var/lib/HPCCSystems/mydropzone/LUCI/';
SHARED CSVSprayFile := 'RVC2004_1_0_luci_validationfile.csv';
SHARED lzFilePath        := lzFilePathFolder + CSVSprayFile;
SHARED SprayCSVName      := '~fazetu01::rvc2004_1_0-validation-data.csv_thor'; // Will set up by user if test file is a logical file.
SHARED CSVSpraySeparator := '|'; // Will set up by user.
SHARED CSVSprayQuote     := '\"'; // Will set up by user.
SHARED HeaderLine := 1; // Will set up by user.
SHARED isCSVFile := FALSE;
  //rvc2004_1_0.FNSpray(LandingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
/******************************************************************************\
|**************************Step 1a - Load Input File***************************|
\******************************************************************************/
  FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, HeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote);
SHARED RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVC2004_1_0 := TRUE, SELF := LEFT));

/******************************************************************************\
|**********************Step 1b - Standardized Input File***********************|
\******************************************************************************/
  FNValidation.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile,,, 5);
SHARED pLUCIresults := LUCI_Model.AsResults(RawInputSet);
SHARED LUCIresults  := DISTRIBUTE(pLUCIresults.Validation(), hash32(TransactionID));
OUTPUT(LUCIresults, NAMED('LUCIresults'));

//Adding ADR Result  => ADR report for by Audit team
SHARED LUCIresultsADR  := pLUCIresults.Stats();
OUTPUT(CHOOSEN(LUCIresultsADR, ALL), NAMED('LUCIresultsADR'));
/******************************************************************************\
|****************Step 2 - Get Statistics of Final Scores, RC   ****************|
\******************************************************************************/
  FNValidation.MAC_CompareScore(LUCIresults, StdFile, Check_Result, pOutputSet, scoreDiffAsPercSet);
  OUTPUT(scoreDiffAsPercSet,,NAMED('ScoreDiffPercStats'));
  SHARED rc_mismatches := Check_Result(score_match,~rc_match);
  OUTPUT(rc_mismatches,,NAMED('rc_mismatches'));
  SHARED Check_Result_rc_mismatch := CHOOSEN(rc_mismatches, SampleSize);
  SHARED mismatch_list_rc := SET(Check_Result_rc_mismatch, TransactionId);
  SHARED sc_mismatches := Check_Result(~score_match);
  OUTPUT(sc_mismatches,,NAMED('sc_mismatches'));
  SHARED Check_Result_sc_mismatch := CHOOSEN(sc_mismatches, SampleSize);
  SHARED mismatch_list_sc := SET(Check_Result_sc_mismatch, TransactionId);
/******************************************************************************\
|***Step3 - Check Points Assignments and Reason Code of Mismatches(Optional)***|
\******************************************************************************/
  SHARED LUCI_Points_Assignments_Pre := LUCI_Model.AsResults(RawInputSet).ValidationF;

  Layouts.StandLayouts xGetLUCIPointsAssignments(LUCI_Points_Assignments_Pre L) := TRANSFORM
	SELF.TransactionID := L.TransactionID;
    //Points Assignments
    SELF.ChargeOffAmount_pts := L.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_score;
    SELF.CollateralStatus_pts := L.RVC2004_1_0_SCORECARD_model6_CollateralStatus_score;
    SELF.LoanType_pts := L.RVC2004_1_0_SCORECARD_model6_LoanType_score;
    SELF.OutOfStatuteIndicator_pts := L.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_score;
    SELF.addrcurrentphoneservice_pts := L.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_score;
    SELF.addrinputmatchindex_pts := L.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_score;
    SELF.addrinputsubjectowned_pts := L.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_score;
    SELF.addrprevioussubjectowned_pts := L.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_score;
    SELF.addrprevioustimeoldest_pts := L.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_score;
    SELF.dayssince_OpenDate_pts := L.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_score;
    SELF.dayssince_ReceivedDate_pts := L.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_score;
    SELF.sourcecredheadertimeoldest_pts := L.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_score;

    //Contribution Value
    SELF.ChargeOffAmount_cont:= L.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_contribution_best;
    SELF.CollateralStatus_cont:= L.RVC2004_1_0_SCORECARD_model6_CollateralStatus_contribution_best;
    SELF.LoanType_cont:= L.RVC2004_1_0_SCORECARD_model6_LoanType_contribution_best;
    SELF.OutOfStatuteIndicator_cont:= L.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_contribution_best;
    SELF.addrcurrentphoneservice_cont:= L.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_contribution_best;
    SELF.addrinputmatchindex_cont:= L.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_contribution_best;
    SELF.addrinputsubjectowned_cont:= L.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_contribution_best;
    SELF.addrprevioussubjectowned_cont:= L.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_contribution_best;
    SELF.addrprevioustimeoldest_cont:= L.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_contribution_best;
    SELF.dayssince_OpenDate_cont:= L.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_contribution_best;
    SELF.dayssince_ReceivedDate_cont:= L.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_contribution_best;
    SELF.sourcecredheadertimeoldest_cont:= L.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_contribution_best;

    //Scores
    SELF.rawscore:= L.RVC2004_1_0_SCORECARD_model6_Score0;
    SELF.predscr:= (700 + 20 * ((SELF.rawscore - 0 - LN(0.049227)) / LN(2)));
    SELF.finalscore := L.RVC2004_1_0_Score;
    SELF.SOURCE := 'HPCC';
    SELF.stdrawscore  := (string)L.RVC2004_1_0_SCORECARD_model6_Score0;
    SELF.std_scr := (string)L.RVC2004_1_0_Score;
	//Reason Codes
    SELF.STD_RC := L.RVC2004_1_0_Reasons;
    SELF.ReasonCode1 := L.RVC2004_1_0_Reasons[1];
    SELF.ReasonCode2 := L.RVC2004_1_0_Reasons[2];
    SELF.ReasonCode3 := L.RVC2004_1_0_Reasons[3];
    SELF.ReasonCode4 := L.RVC2004_1_0_Reasons[4];
    SELF.ReasonCode5 := L.RVC2004_1_0_Reasons[5];

    SELF := L;
    SELF := [];
  END;
  SHARED LUCI_Points_Assignments :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIPointsAssignments(LEFT));
  SHARED DS_Comp_pre := SORT(LUCI_Points_Assignments + StdFile, TransactionID, -SOURCE);
  SHARED DS_Comp := PROJECT(DS_Comp_pre, Layouts.StandLayouts);
  OUTPUT(DS_Comp(TransactionID in mismatch_list_rc),,NAMED('rc_mismatches_details'));
  OUTPUT(DS_Comp(TransactionID in mismatch_list_sc),,NAMED('sc_mismatches_details'));
  OUTPUT(DS_Comp,,NAMED('AuditComparison'));

/******************************************************************************\
|*******************Step4 - Get Validation File for Auditing*******************|
\******************************************************************************/
  Layouts.AuditLayouts xGetLUCIAuditFile(LUCI_Points_Assignments_Pre L) := TRANSFORM
    SELF.GROUPTYPE  := rvc2004_1_0.RCCodes(L.RVC2004_1_0_Reasons[1]).GroupType;
    SELF.RCMessage1 := rvc2004_1_0.RCCodes(L.RVC2004_1_0_Reasons[1]).Description;
    SELF.RCMessage2 := rvc2004_1_0.RCCodes(L.RVC2004_1_0_Reasons[2]).Description;
    SELF.RCMessage3 := rvc2004_1_0.RCCodes(L.RVC2004_1_0_Reasons[3]).Description;
    SELF.RCMessage4 := rvc2004_1_0.RCCodes(L.RVC2004_1_0_Reasons[4]).Description;
    SELF.RCMessage5 := rvc2004_1_0.RCCodes(L.RVC2004_1_0_Reasons[5]).Description;

    //Points Assignments
    SELF.ChargeOffAmount_pts := L.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_score;
    SELF.CollateralStatus_pts := L.RVC2004_1_0_SCORECARD_model6_CollateralStatus_score;
    SELF.LoanType_pts := L.RVC2004_1_0_SCORECARD_model6_LoanType_score;
    SELF.OutOfStatuteIndicator_pts := L.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_score;
    SELF.addrcurrentphoneservice_pts := L.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_score;
    SELF.addrinputmatchindex_pts := L.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_score;
    SELF.addrinputsubjectowned_pts := L.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_score;
    SELF.addrprevioussubjectowned_pts := L.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_score;
    SELF.addrprevioustimeoldest_pts := L.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_score;
    SELF.dayssince_OpenDate_pts := L.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_score;
    SELF.dayssince_ReceivedDate_pts := L.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_score;
    SELF.sourcecredheadertimeoldest_pts := L.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_score;

    //Contribution Value
    SELF.ChargeOffAmount_cont:= L.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_contribution_best;
    SELF.CollateralStatus_cont:= L.RVC2004_1_0_SCORECARD_model6_CollateralStatus_contribution_best;
    SELF.LoanType_cont:= L.RVC2004_1_0_SCORECARD_model6_LoanType_contribution_best;
    SELF.OutOfStatuteIndicator_cont:= L.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_contribution_best;
    SELF.addrcurrentphoneservice_cont:= L.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_contribution_best;
    SELF.addrinputmatchindex_cont:= L.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_contribution_best;
    SELF.addrinputsubjectowned_cont:= L.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_contribution_best;
    SELF.addrprevioussubjectowned_cont:= L.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_contribution_best;
    SELF.addrprevioustimeoldest_cont:= L.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_contribution_best;
    SELF.dayssince_OpenDate_cont:= L.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_contribution_best;
    SELF.dayssince_ReceivedDate_cont:= L.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_contribution_best;
    SELF.sourcecredheadertimeoldest_cont:= L.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_contribution_best;

    //Scores
    SELF.rawscore:= L.RVC2004_1_0_SCORECARD_model6_Score0;
    SELF.predscr:= (700 + 20 * ((SELF.rawscore - 0 - LN(0.049227)) / LN(2)));
    SELF.finalscore := L.RVC2004_1_0_Score;
		//Reason Codes
    //SELF.ReasonCode  := L.RVC2004_1_0_Reasons;
    SELF.ReasonCode1 := L.RVC2004_1_0_Reasons[1];
    SELF.ReasonCode2 := L.RVC2004_1_0_Reasons[2];
    SELF.ReasonCode3 := L.RVC2004_1_0_Reasons[3];
    SELF.ReasonCode4 := L.RVC2004_1_0_Reasons[4];
    SELF.ReasonCode5 := L.RVC2004_1_0_Reasons[5];

    SELF := L;
    SELF := [];
  END;

  SHARED LUCI_AuditResult :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIAuditFile(LEFT));
OUTPUT(LUCI_AuditResult,,NAMED('LUCIResults_Audit'));

/******************************************************************************\
|*************************Step5 - Despray the Results**************************|
\******************************************************************************/
  dateString	    := (STRING)STD.Date.Today() + ''; //CYNDY: Using " + '' " to control version
  TempLogical(String LogicalName) := LogicalName +  WORKUNIT;
  desprayName(STRING desprayNamePre)     := desprayNamePre + dateString + WORKUNIT +'.csv';
  lzDesprayFilePath(STRING desprayNamePre)     := lzFilePathFolder + desprayName(desprayNamePre);
  DesprayAuditResult   := rvc2004_1_0.FNDesprayCSV(LUCI_AuditResult, TempLogical('~LUCI::AuditFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_AuditFile'));
  DesprayComparision   := rvc2004_1_0.FNDesprayCSV(DS_Comp, TempLogical('~LUCI::ComparisonFile:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ComparisonFile'));
  DesprayADR           := rvc2004_1_0.FNDesprayCSV(LUCIresultsADR, TempLogical('~LUCI::ADR:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ADR'));
  DesprayMismatches_SC := rvc2004_1_0.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_sc), TempLogical('~LUCI::Mismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_SC'));
  DesprayMismatches_RC := rvc2004_1_0.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_rc), TempLogical('~LUCI::Mismatches_RC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_RC'));
SEQUENTIAL( DesprayAuditResult
            ,DesprayComparision
            ,DesprayMismatches_SC
            ,DesprayMismatches_RC
            ,DesprayADR
            );

