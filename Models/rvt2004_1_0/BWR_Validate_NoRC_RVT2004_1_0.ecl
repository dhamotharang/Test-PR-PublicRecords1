IMPORT UT,STD;
IMPORT rvt2004_1_0;
IMPORT rvt2004_1_0 AS LUCI_Model;
SHARED Constants := rvt2004_1_0.Constants;
SHARED Layouts := rvt2004_1_0.z_layouts;
SHARED FNValidation := rvt2004_1_0.FNValidationWORC;
SHARED SampleSize := 1000; // The number of mismatches provided for review
SHARED Threshold_ScoreComp := 0.0000009; // The threshold setup for tree model.
SHARED LandingZoneIP  := '10.173.10.159'; // Will set up by user.
/******************************************************************************\
|**************************Step 0 - Spray Input File***************************|
\******************************************************************************/
SHARED ModelName := 'RVT2004_1_0';
SHARED lzFilePathFolder  := '/var/lib/HPCCSystems/mydropzone/LUCI/';
SHARED CSVSprayFile := 'RVT2004_1_0_luci_validationfile.csv';
SHARED lzFilePath        := lzFilePathFolder + CSVSprayFile;
SHARED SprayCSVName      := '~fazetu01::rvt2004_1_0-validation-data.csv_thor'; // Will set up by user if test file is a logical file.
SHARED CSVSpraySeparator := '|'; // Will set up by user.
SHARED CSVSprayQuote     := '\"'; // Will set up by user.
SHARED HeaderLine := 1; // Will set up by user.
SHARED isCSVFile := FALSE;
  //rvt2004_1_0.FNSpray(LandingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
/******************************************************************************\
|**************************Step 1a - Load Input File***************************|
\******************************************************************************/
  FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, HeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote);
SHARED RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVT2004_1_0 := TRUE, SELF := LEFT));

/******************************************************************************\
|**********************Step 1b - Standardized Input File***********************|
\******************************************************************************/
  FNValidation.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile);
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
    SELF.L_addrprevioustimeoldest_alt_pts := L.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_score;
    SELF.L_ca_addrchangeindex_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_score;
    SELF.L_ca_creditseeking_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_score;
    SELF.L_ca_derogseverityindex_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_score;
    SELF.L_ca_nonderogindex_alt_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_score;
    SELF.addrcurrentownershipindex_pts := L.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_score;
    SELF.assetpropevercount_pts := L.RVT2004_1_0_SCORECARD_model110_assetpropevercount_score;

    //Contribution Value
    SELF.L_addrprevioustimeoldest_alt_cont:= L.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_contribution_best;
    SELF.L_ca_addrchangeindex_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_contribution_best;
    SELF.L_ca_creditseeking_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_contribution_best;
    SELF.L_ca_derogseverityindex_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_contribution_best;
    SELF.L_ca_nonderogindex_alt_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_contribution_best;
    SELF.addrcurrentownershipindex_cont:= L.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_contribution_best;
    SELF.assetpropevercount_cont:= L.RVT2004_1_0_SCORECARD_model110_assetpropevercount_contribution_best;

    //Scores
    SELF.rawscore:= L.RVT2004_1_0_SCORECARD_model110_Score0;
    SELF.predscr:= (700 + -40 * ((SELF.rawscore - 0 - LN(0.35685210312076)) / LN(2)));
    SELF.finalscore := L.RVT2004_1_0_Score;
    SELF.SOURCE := 'HPCC';
    SELF.stdrawscore  := (string)L.RVT2004_1_0_SCORECARD_model110_Score0;
    SELF.std_scr := (string)L.RVT2004_1_0_Score;
    SELF := L;
    SELF := [];
  END;
  SHARED LUCI_Points_Assignments :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIPointsAssignments(LEFT));
  SHARED DS_Comp_pre := SORT(LUCI_Points_Assignments + StdFile, TransactionID, -SOURCE);
  SHARED DS_Comp := PROJECT(DS_Comp_pre, Layouts.StandLayouts);
  OUTPUT(DS_Comp(TransactionID in mismatch_list_sc),,NAMED('sc_mismatches_details'));
  OUTPUT(DS_Comp,,NAMED('AuditComparison'));

/******************************************************************************\
|*******************Step4 - Get Validation File for Auditing*******************|
\******************************************************************************/
  Layouts.AuditLayouts xGetLUCIAuditFile(LUCI_Points_Assignments_Pre L) := TRANSFORM
    //Points Assignments
    SELF.L_addrprevioustimeoldest_alt_pts := L.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_score;
    SELF.L_ca_addrchangeindex_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_score;
    SELF.L_ca_creditseeking_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_score;
    SELF.L_ca_derogseverityindex_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_score;
    SELF.L_ca_nonderogindex_alt_pts := L.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_score;
    SELF.addrcurrentownershipindex_pts := L.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_score;
    SELF.assetpropevercount_pts := L.RVT2004_1_0_SCORECARD_model110_assetpropevercount_score;

    //Contribution Value
    SELF.L_addrprevioustimeoldest_alt_cont:= L.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_contribution_best;
    SELF.L_ca_addrchangeindex_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_contribution_best;
    SELF.L_ca_creditseeking_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_contribution_best;
    SELF.L_ca_derogseverityindex_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_contribution_best;
    SELF.L_ca_nonderogindex_alt_cont:= L.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_contribution_best;
    SELF.addrcurrentownershipindex_cont:= L.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_contribution_best;
    SELF.assetpropevercount_cont:= L.RVT2004_1_0_SCORECARD_model110_assetpropevercount_contribution_best;

    //Scores
    SELF.rawscore:= L.RVT2004_1_0_SCORECARD_model110_Score0;
    SELF.predscr:= (700 + -40 * ((SELF.rawscore - 0 - LN(0.35685210312076)) / LN(2)));
    SELF.finalscore := L.RVT2004_1_0_Score;
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
  DesprayAuditResult   := rvt2004_1_0.FNDesprayCSV(LUCI_AuditResult, TempLogical('~LUCI::AuditFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_AuditFile'));
  DesprayComparision   := rvt2004_1_0.FNDesprayCSV(DS_Comp, TempLogical('~LUCI::ComparisonFile:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ComparisonFile'));
  DesprayADR           := rvt2004_1_0.FNDesprayCSV(LUCIresultsADR, TempLogical('~LUCI::ADR:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ADR'));
  DesprayMismatches_SC := rvt2004_1_0.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_sc), TempLogical('~LUCI::Mismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_SC'));
SEQUENTIAL( DesprayAuditResult
            ,DesprayComparision
            ,DesprayMismatches_SC
            ,DesprayADR
            );

