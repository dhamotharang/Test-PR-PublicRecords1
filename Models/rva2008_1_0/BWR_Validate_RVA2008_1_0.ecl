IMPORT UT,STD;
IMPORT rva2008_1_0;
IMPORT rva2008_1_0 AS LUCI_Model;
SHARED Constants := rva2008_1_0.Constants;
SHARED Layouts := rva2008_1_0.z_layouts;
SHARED FNValidation := rva2008_1_0.FNValidationWithRC;
// SHARED FNValidation := rva2008_1_0.FNValidationWORC;
SHARED SampleSize := 1000; // The number of mismatches provided for review
SHARED Threshold_ScoreComp := 0.0000009; // The threshold setup for tree model.
SHARED LandingZoneIP  := '10.173.10.159'; // Will set up by user.
/******************************************************************************\
|**************************Step 0 - Spray Input File***************************|
\******************************************************************************/
SHARED ModelName := 'RVA2008_1_0';
SHARED lzFilePathFolder  := '/var/lib/HPCCSystems/mydropzone/LUCI/';
SHARED CSVSprayFile := '~mmarshik::in::rva2008_1_0-validation-data.csv';
SHARED lzFilePath        := lzFilePathFolder + CSVSprayFile;
SHARED SprayCSVName      := '~mmarshik::in::rva2008_1_0-validation-data.csv'; // Will set up by user if test file is a logical file.
SHARED CSVSpraySeparator := ','; // Will set up by user.
SHARED CSVSprayQuote     := '\"'; // Will set up by user.
SHARED HeaderLine := TRUE; // Will set up by user.
SHARED isCSVFile := TRUE;
  //rva2008_1_0.FNSpray(LandingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
/******************************************************************************\
|**************************Step 1a - Load Input File***************************|
\******************************************************************************/
  FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, HeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote);
SHARED RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVA2008_1_0 := TRUE, SELF := LEFT));

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
    SELF.addrchangecount03month_pts := L.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_score;
    SELF.addrinputmatchindex_pts := L.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_score;
    SELF.addrinputsubjectowned_pts := L.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_score;
    SELF.addrprevioustimeoldest_pts := L.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_score;
    SELF.assetpropevercount_pts := L.RVA2008_1_0_SCORECARD_model29_assetpropevercount_score;
    SELF.confirmationinputaddress_pts := L.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_score;
    SELF.criminalfelonycount_pts := L.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_score;
    SELF.derogtimenewest_pts := L.RVA2008_1_0_SCORECARD_model29_derogtimenewest_score;
    SELF.evictioncount_pts := L.RVA2008_1_0_SCORECARD_model29_evictioncount_score;
    SELF.inquiryauto12month_pts := L.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_score;
    SELF.inquirybanking12month_pts := L.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_score;
    SELF.inquiryshortterm12month_pts := L.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_score;
    SELF.lienjudgmenttaxcount_pts := L.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_score;
    SELF.sourcecredheadertimeoldest_pts := L.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_score;
    SELF.ssnsubjectcount_pts := L.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_score;

    //Contribution Value
    SELF.addrchangecount03month_cont:= L.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_contribution_best;
    SELF.addrinputmatchindex_cont:= L.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_contribution_best;
    SELF.addrinputsubjectowned_cont:= L.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_contribution_best;
    SELF.addrprevioustimeoldest_cont:= L.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_contribution_best;
    SELF.assetpropevercount_cont:= L.RVA2008_1_0_SCORECARD_model29_assetpropevercount_contribution_best;
    SELF.confirmationinputaddress_cont:= L.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_contribution_best;
    SELF.criminalfelonycount_cont:= L.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_contribution_best;
    SELF.derogtimenewest_cont:= L.RVA2008_1_0_SCORECARD_model29_derogtimenewest_contribution_best;
    SELF.evictioncount_cont:= L.RVA2008_1_0_SCORECARD_model29_evictioncount_contribution_best;
    SELF.inquiryauto12month_cont:= L.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_contribution_best;
    SELF.inquirybanking12month_cont:= L.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_contribution_best;
    SELF.inquiryshortterm12month_cont:= L.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_contribution_best;
    SELF.lienjudgmenttaxcount_cont:= L.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_contribution_best;
    SELF.sourcecredheadertimeoldest_cont:= L.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_contribution_best;
    SELF.ssnsubjectcount_cont:= L.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_contribution_best;

    //Scores
    SELF.rawscore:= L.RVA2008_1_0_SCORECARD_model29_Score0;
    SELF.predscr:= (725 + -50 * ((SELF.rawscore - 0 - LN(0.157809362992116)) / LN(2)));
    SELF.finalscore := L.RVA2008_1_0_Score;
    SELF.SOURCE := 'HPCC';
    SELF.stdrawscore  := (string)L.RVA2008_1_0_SCORECARD_model29_Score0;
    SELF.std_scr := (string)L.RVA2008_1_0_Score;
	//Reason Codes
    SELF.STD_RC := L.RVA2008_1_0_Reasons;
    SELF.ReasonCode1 := L.RVA2008_1_0_Reasons[1];
    SELF.ReasonCode2 := L.RVA2008_1_0_Reasons[2];
    SELF.ReasonCode3 := L.RVA2008_1_0_Reasons[3];
    SELF.ReasonCode4 := L.RVA2008_1_0_Reasons[4];
    SELF.ReasonCode5 := L.RVA2008_1_0_Reasons[5];

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
    SELF.GROUPTYPE  := rva2008_1_0.RCCodes(L.RVA2008_1_0_Reasons[1]).GroupType;
    SELF.RCMessage1 := rva2008_1_0.RCCodes(L.RVA2008_1_0_Reasons[1]).Description;
    SELF.RCMessage2 := rva2008_1_0.RCCodes(L.RVA2008_1_0_Reasons[2]).Description;
    SELF.RCMessage3 := rva2008_1_0.RCCodes(L.RVA2008_1_0_Reasons[3]).Description;
    SELF.RCMessage4 := rva2008_1_0.RCCodes(L.RVA2008_1_0_Reasons[4]).Description;
    SELF.RCMessage5 := rva2008_1_0.RCCodes(L.RVA2008_1_0_Reasons[5]).Description;

    //Points Assignments
    SELF.addrchangecount03month_pts := L.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_score;
    SELF.addrinputmatchindex_pts := L.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_score;
    SELF.addrinputsubjectowned_pts := L.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_score;
    SELF.addrprevioustimeoldest_pts := L.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_score;
    SELF.assetpropevercount_pts := L.RVA2008_1_0_SCORECARD_model29_assetpropevercount_score;
    SELF.confirmationinputaddress_pts := L.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_score;
    SELF.criminalfelonycount_pts := L.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_score;
    SELF.derogtimenewest_pts := L.RVA2008_1_0_SCORECARD_model29_derogtimenewest_score;
    SELF.evictioncount_pts := L.RVA2008_1_0_SCORECARD_model29_evictioncount_score;
    SELF.inquiryauto12month_pts := L.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_score;
    SELF.inquirybanking12month_pts := L.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_score;
    SELF.inquiryshortterm12month_pts := L.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_score;
    SELF.lienjudgmenttaxcount_pts := L.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_score;
    SELF.sourcecredheadertimeoldest_pts := L.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_score;
    SELF.ssnsubjectcount_pts := L.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_score;

    //Contribution Value
    SELF.addrchangecount03month_cont:= L.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_contribution_best;
    SELF.addrinputmatchindex_cont:= L.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_contribution_best;
    SELF.addrinputsubjectowned_cont:= L.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_contribution_best;
    SELF.addrprevioustimeoldest_cont:= L.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_contribution_best;
    SELF.assetpropevercount_cont:= L.RVA2008_1_0_SCORECARD_model29_assetpropevercount_contribution_best;
    SELF.confirmationinputaddress_cont:= L.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_contribution_best;
    SELF.criminalfelonycount_cont:= L.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_contribution_best;
    SELF.derogtimenewest_cont:= L.RVA2008_1_0_SCORECARD_model29_derogtimenewest_contribution_best;
    SELF.evictioncount_cont:= L.RVA2008_1_0_SCORECARD_model29_evictioncount_contribution_best;
    SELF.inquiryauto12month_cont:= L.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_contribution_best;
    SELF.inquirybanking12month_cont:= L.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_contribution_best;
    SELF.inquiryshortterm12month_cont:= L.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_contribution_best;
    SELF.lienjudgmenttaxcount_cont:= L.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_contribution_best;
    SELF.sourcecredheadertimeoldest_cont:= L.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_contribution_best;
    SELF.ssnsubjectcount_cont:= L.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_contribution_best;

    //Scores
    SELF.rawscore:= L.RVA2008_1_0_SCORECARD_model29_Score0;
    SELF.predscr:= (725 + -50 * ((SELF.rawscore - 0 - LN(0.157809362992116)) / LN(2)));
    SELF.finalscore := L.RVA2008_1_0_Score;
		//Reason Codes
    //SELF.ReasonCode  := L.RVA2008_1_0_Reasons;
    SELF.ReasonCode1 := L.RVA2008_1_0_Reasons[1];
    SELF.ReasonCode2 := L.RVA2008_1_0_Reasons[2];
    SELF.ReasonCode3 := L.RVA2008_1_0_Reasons[3];
    SELF.ReasonCode4 := L.RVA2008_1_0_Reasons[4];
    SELF.ReasonCode5 := L.RVA2008_1_0_Reasons[5];

    SELF := L;
    SELF := [];
  END;

  SHARED LUCI_AuditResult :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIAuditFile(LEFT));
OUTPUT(LUCI_AuditResult,,NAMED('LUCIResults_Audit'));

/******************************************************************************\
|*************************Step5 - Despray the Results**************************|
\******************************************************************************/
  // dateString	    := (STRING)STD.Date.Today() + ''; //CYNDY: Using " + '' " to control version
  // TempLogical(String LogicalName) := LogicalName +  WORKUNIT;
  // desprayName(STRING desprayNamePre)     := desprayNamePre + dateString + WORKUNIT +'.csv';
  // lzDesprayFilePath(STRING desprayNamePre)     := lzFilePathFolder + desprayName(desprayNamePre);
  // DesprayAuditResult   := rva2008_1_0.FNDesprayCSV(LUCI_AuditResult, TempLogical('~LUCI::AuditFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_AuditFile'));
  // DesprayComparision   := rva2008_1_0.FNDesprayCSV(DS_Comp, TempLogical('~LUCI::ComparisonFile:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ComparisonFile'));
  // DesprayADR           := rva2008_1_0.FNDesprayCSV(LUCIresultsADR, TempLogical('~LUCI::ADR:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ADR'));
  // DesprayMismatches_SC := rva2008_1_0.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_sc), TempLogical('~LUCI::Mismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_SC'));
  // DesprayMismatches_RC := rva2008_1_0.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_rc), TempLogical('~LUCI::Mismatches_RC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_RC'));
// SEQUENTIAL( DesprayAuditResult
            // ,DesprayComparision
            // ,DesprayMismatches_SC
            // ,DesprayMismatches_RC
            // ,DesprayADR
            // );

