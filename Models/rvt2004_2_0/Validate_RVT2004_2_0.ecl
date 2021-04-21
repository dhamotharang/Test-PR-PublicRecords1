EXPORT Validate_RVT2004_2_0(reasonCodes=TRUE,landingZoneIP='Constants.LandingZoneIP',lzFilePathFolder='\'/data/LUCI/RVT2004_2_0/\'',
                    fileLayout='\'rvt2004_2_0.z_layouts\'',CSVSprayFile='\'RVT2004_2_0_luci_validationfile.csv\'',CSVSprayHeaderLine=1,CSVSpraySeparator='\'|\'',
                    CSVSprayQuote='\'"\'',isCSVFile=FALSE,preSprayed=FALSE,sprayedFile='\'\'',deSpray=TRUE,deSpraySuffix='\'\'') := FUNCTIONMACRO
 Validate_Model := MODULE
    IMPORT UT,STD;
    IMPORT rvt2004_2_0 AS LUCI_Model;
    SHARED Constants := rvt2004_2_0.Constants;
    SHARED Layouts := #EXPAND(fileLayout);
    #IF(reasonCodes)
        SHARED FNValidation := rvt2004_2_0.FNValidationWithRC;
    #ELSE
        SHARED FNValidation := rvt2004_2_0.FNValidationWORC;
    #END;
    SHARED SampleSize := 1000; // The number of mismatches provided for review
    SHARED Threshold_ScoreComp := 0.0000009; // The threshold setup for tree model.
    /******************************************************************************\
    |**************************Step 0 - Spray Input File***************************|
    \******************************************************************************/
    SHARED ModelName      := 'RVT2004_2_0';
    SHARED lzFilePath     := lzFilePathFolder + CSVSprayFile;
    #IF(sprayedFile)
    SHARED SprayCSVName 	:= sprayedFile; // Will set up by user if test file is a logical file.
    #ELSE
    SHARED SprayCSVName   := '~rvt2004_2_0::' + (STRING)STD.Date.Today() + '::' + ModelName +'_from_csv';
    #END
    #IF(~preSprayed)
    EXPORT inputFileSprayed := rvt2004_2_0.FNSpray(landingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
    #END
    /******************************************************************************\
    |**************************Step 1a - Load Input File***************************|
    \******************************************************************************/
    FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, CSVSprayHeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote, FALSE);
    EXPORT RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVT2004_2_0 := TRUE, SELF := LEFT));
    EXPORT OutInputSet := OUTPUT(RawInputSet,,NAMED('RawInput'));

    /******************************************************************************\
    |**********************Step 1b - Standardized Input File***********************|
    \******************************************************************************/
    #IF(reasonCodes)
    FNValidation.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile, FALSE, FALSE, 5);
    #ELSE
    FNValidation.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile, FALSE);
    #END
    EXPORT OutStdInputSet := OUTPUT(StdFile, NAMED('ModelerSTDFile'));
    SHARED pLUCIresults := LUCI_Model.AsResults(RawInputSet);
    EXPORT LUCIresults  := DISTRIBUTE(pLUCIresults.Validation(), hash32(TransactionID));
    EXPORT OutLUCIResults := OUTPUT(LUCIresults, NAMED('LUCIresults'));

    //Adding ADR Result  => ADR report for by Audit team
    EXPORT LUCIresultsADR := pLUCIresults.Stats();
    EXPORT OutLUCIResultsADR := OUTPUT(CHOOSEN(LUCIresultsADR, ALL), NAMED('LUCIresultsADR'));

    /******************************************************************************\
    |****************Step 2 - Get Statistics of Final Scores, RC   ****************|
    \******************************************************************************/
     #IF(reasonCodes)
     	FNValidation.MAC_CompareScore(LUCIresults, StdFile, Check_Result, pOutputSet, scoreDiffAsPercSet, FALSE, FALSE);
     	EXPORT rc_mismatches := Check_Result(score_match,~rc_match);
     	EXPORT OutRCMismatches := OUTPUT(rc_mismatches,,NAMED('rc_mismatches'));
     	SHARED Check_Result_rc_mismatch := CHOOSEN(rc_mismatches, SampleSize);
     	SHARED mismatch_list_rc := SET(Check_Result_rc_mismatch, TransactionId);
     #ELSE
        FNValidation.MAC_CompareScore(LUCIresults, StdFile, Check_Result, pOutputSet, scoreDiffAsPercSet, FALSE);
     #END
     EXPORT OutCheckResult := OUTPUT(CHOOSEN(Check_Result, 500), NAMED('CheckResult'));
     EXPORT OutCheckResultStats := OUTPUT(pOutputSet,, NAMED('CheckResultStats'));
     EXPORT OutScoreDiffPercStats := OUTPUT(scoreDiffAsPercSet,, NAMED('ScoreDiffPercStats'));
     EXPORT sc_mismatches := Check_Result(~score_match);
     EXPORT OutSCMismatches := OUTPUT(sc_mismatches,,NAMED('sc_mismatches'));
     SHARED Check_Result_sc_mismatch := CHOOSEN(sc_mismatches, SampleSize);
     SHARED mismatch_list_sc := SET(Check_Result_sc_mismatch, TransactionId);

    /******************************************************************************\
    |***Step3 - Check Points Assignments and Reason Code of Mismatches(Optional)***|
    \******************************************************************************/
    SHARED LUCI_Points_Assignments_Pre := LUCI_Model.AsResults(RawInputSet).ValidationF;

    Layouts.StandLayouts xGetLUCIPointsAssignments(LUCI_Points_Assignments_Pre L) := TRANSFORM
    	SELF.TransactionID := L.TransactionID;
        //Points Assignments
        SELF.L_ca_addrchangeindex_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_score;
        SELF.L_ca_creditseeking_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_score;
        SELF.L_ca_derogseverityindex_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_score;
        SELF.L_ca_nonderogindex_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_score;
        SELF.addrcurrentownershipindex_pts := L.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_score;
        SELF.addrprevioustimeoldest_pts := L.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_score;
        SELF.assetpropcurrentcount_pts := L.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_score;
        SELF.assetpropeversoldcount_pts := L.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_score;

        //Contribution Value
        SELF.L_ca_addrchangeindex_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_contribution_best;
        SELF.L_ca_creditseeking_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_contribution_best;
        SELF.L_ca_derogseverityindex_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_contribution_best;
        SELF.L_ca_nonderogindex_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_contribution_best;
        SELF.addrcurrentownershipindex_cont:= L.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_contribution_best;
        SELF.addrprevioustimeoldest_cont:= L.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_contribution_best;
        SELF.assetpropcurrentcount_cont:= L.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_contribution_best;
        SELF.assetpropeversoldcount_cont:= L.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_contribution_best;

        //Scores
        SELF.rawscore:= L.RVT2004_2_0_SCORECARD_model47_Score0;
        SELF.predscr:= (700 + -40 * ((SELF.rawscore - 0 - LN(0.35685210312076)) / LN(2)));
        SELF.finalscore := L.RVT2004_2_0_Score;
        SELF.SOURCE := 'HPCC';
        SELF.stdrawscore  := (string)L.RVT2004_2_0_SCORECARD_model47_Score0;
        SELF.std_scr := (string)L.RVT2004_2_0_Score;
        #IF(reasonCodes)
            //Reason Codes
            SELF.STD_RC := L.RVT2004_2_0_Reasons;
            SELF.ReasonCode1 := L.RVT2004_2_0_Reasons[1];
            SELF.ReasonCode2 := L.RVT2004_2_0_Reasons[2];
            SELF.ReasonCode3 := L.RVT2004_2_0_Reasons[3];
            SELF.ReasonCode4 := L.RVT2004_2_0_Reasons[4];
            SELF.ReasonCode5 := L.RVT2004_2_0_Reasons[5];

        #END
        SELF := L;
        SELF := [];
    END;
    SHARED LUCI_Points_Assignments := PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIPointsAssignments(LEFT));
    SHARED DS_Comp_pre := SORT(LUCI_Points_Assignments + StdFile, TransactionID, -SOURCE);
    EXPORT DS_Comp := PROJECT(DS_Comp_pre, Layouts.StandLayouts);
    #IF(reasonCodes)
        EXPORT OutRCMismatchesDetails := OUTPUT(DS_Comp(TransactionID in mismatch_list_rc),,NAMED('rc_mismatches_details'));
    #END
    EXPORT OutSCMismatchesDetails := OUTPUT(DS_Comp(TransactionID in mismatch_list_sc),,NAMED('sc_mismatches_details'));
    EXPORT OutAuditComparison := OUTPUT(DS_Comp,,NAMED('AuditComparison'));


    /******************************************************************************\
    |*******************Step4 - Get Validation File for Auditing*******************|
    \******************************************************************************/
    Layouts.AuditLayouts xGetLUCIAuditFile(LUCI_Points_Assignments_Pre L) := TRANSFORM
        #IF(reasonCodes)
            SELF.GROUPTYPE  := rvt2004_2_0.RCCodes(L.RVT2004_2_0_Reasons[1]).GroupType;
            SELF.RCMessage1 := rvt2004_2_0.RCCodes(L.RVT2004_2_0_Reasons[1]).Description;
            SELF.RCMessage2 := rvt2004_2_0.RCCodes(L.RVT2004_2_0_Reasons[2]).Description;
            SELF.RCMessage3 := rvt2004_2_0.RCCodes(L.RVT2004_2_0_Reasons[3]).Description;
            SELF.RCMessage4 := rvt2004_2_0.RCCodes(L.RVT2004_2_0_Reasons[4]).Description;
            SELF.RCMessage5 := rvt2004_2_0.RCCodes(L.RVT2004_2_0_Reasons[5]).Description;

        #END
        //Points Assignments
        SELF.L_ca_addrchangeindex_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_score;
        SELF.L_ca_creditseeking_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_score;
        SELF.L_ca_derogseverityindex_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_score;
        SELF.L_ca_nonderogindex_pts := L.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_score;
        SELF.addrcurrentownershipindex_pts := L.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_score;
        SELF.addrprevioustimeoldest_pts := L.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_score;
        SELF.assetpropcurrentcount_pts := L.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_score;
        SELF.assetpropeversoldcount_pts := L.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_score;

        //Contribution Value
        SELF.L_ca_addrchangeindex_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_contribution_best;
        SELF.L_ca_creditseeking_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_contribution_best;
        SELF.L_ca_derogseverityindex_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_contribution_best;
        SELF.L_ca_nonderogindex_cont:= L.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_contribution_best;
        SELF.addrcurrentownershipindex_cont:= L.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_contribution_best;
        SELF.addrprevioustimeoldest_cont:= L.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_contribution_best;
        SELF.assetpropcurrentcount_cont:= L.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_contribution_best;
        SELF.assetpropeversoldcount_cont:= L.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_contribution_best;

        //Scores
        SELF.rawscore:= L.RVT2004_2_0_SCORECARD_model47_Score0;
        SELF.predscr:= (700 + -40 * ((SELF.rawscore - 0 - LN(0.35685210312076)) / LN(2)));
        SELF.finalscore := L.RVT2004_2_0_Score;
        #IF(reasonCodes)
    	    //Reason Codes
            //SELF.ReasonCode  := L.RVT2004_2_0_Reasons;
            SELF.ReasonCode1 := L.RVT2004_2_0_Reasons[1];
            SELF.ReasonCode2 := L.RVT2004_2_0_Reasons[2];
            SELF.ReasonCode3 := L.RVT2004_2_0_Reasons[3];
            SELF.ReasonCode4 := L.RVT2004_2_0_Reasons[4];
            SELF.ReasonCode5 := L.RVT2004_2_0_Reasons[5];

        #END
        SELF := L;
        SELF := [];
    END;

    EXPORT LUCI_AuditResult := PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIAuditFile(LEFT));
    EXPORT OutLUCIResultsAudit := OUTPUT(LUCI_AuditResult,,NAMED('LUCIResults_Audit'));

    #IF(deSpray)
    /******************************************************************************\
    |*************************Step5 - Despray the Results**************************|
    \******************************************************************************/
    dateString := (STRING)STD.Date.Today() + ''; //CYNDY: Using " + '' " to control version
    TempLogical(String LogicalName) := LogicalName + WORKUNIT;
    desprayName(STRING desprayNamePre) := desprayNamePre + dateString + deSpraySuffix + '.csv';
    lzDesprayFilePath(STRING desprayNamePre) := lzFilePathFolder + desprayName(desprayNamePre);
    DesprayAuditResult := rvt2004_2_0.FNDesprayCSV(LUCI_AuditResult, TempLogical('~LUCI::AuditFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_AuditFile'));
    DesprayComparision := rvt2004_2_0.FNDesprayCSV(DS_Comp, TempLogical('~LUCI::ComparisonFile:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ComparisonFile'));
    DesprayADR := rvt2004_2_0.FNDesprayCSV(LUCIresultsADR, TempLogical('~LUCI::ADR:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ADR'));
    DesprayMismatches_SC := rvt2004_2_0.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_sc), TempLogical('~LUCI::Mismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_SC'));
    #IF(reasonCodes)
    DesprayMismatches_RC := rvt2004_2_0.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_rc), TempLogical('~LUCI::Mismatches_RC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_RC'));
    #END

    EXPORT desprayOutputs := SEQUENTIAL(DesprayAuditResult
                                     ,DesprayComparision
                                     ,DesprayMismatches_SC
                                     #IF(reasonCodes)
                                     ,DesprayMismatches_RC
                                     #END
                                     ,DesprayADR);
    #END

    EXPORT runValidation := SEQUENTIAL(
                                    #IF(~preSprayed) inputFileSprayed, #END
                                    OutInputSet
                                    ,OutStdInputSet
                                    ,OutLUCIResults
                                    ,OutLUCIResultsADR
                                    ,OutCheckResult
                                    ,OutCheckResultStats
                                    ,OutScoreDiffPercStats
                                    #IF(reasonCodes)
                                    ,OutRCMismatches
                                    ,OutRCMismatchesDetails
                                    #END
                                    ,OutSCMismatches
                                    ,OutSCMismatchesDetails
                                    ,OutAuditComparison
                                    ,OutLUCIResultsAudit
                                    #IF(deSpray) ,desprayOutputs #END);
 END;
 RETURN Validate_Model;
ENDMACRO;
