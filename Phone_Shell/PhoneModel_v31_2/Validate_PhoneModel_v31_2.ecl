EXPORT Validate_PhoneModel_v31_2(landingZoneIP='Constants.LandingZoneIP',lzFilePathFolder='\'/data/LUCI/PhoneModel_v31_2/\'',
                    fileLayout='\'PhoneModel_v31_2.z_layouts\'',CSVSprayFile='\'PhoneModel_v31_2_luci_validationfile.csv\'',CSVSprayHeaderLine=1,CSVSpraySeparator='\'|\'',
                    CSVSprayQuote='\'"\'',isCSVFile=FALSE,preSprayed=FALSE,sprayedFile='\'\'',deSpray=TRUE,deSpraySuffix='\'\'') := FUNCTIONMACRO
 Validate_Model := MODULE
    IMPORT UT,STD;
    IMPORT PhoneModel_v31_2 AS LUCI_Model;
    SHARED Constants := PhoneModel_v31_2.Constants;
    SHARED Layouts := #EXPAND(fileLayout);
    SHARED FNValidation := PhoneModel_v31_2.FNValidationWORC;
    SHARED SampleSize := 1000; // The number of mismatches provided for review
    /******************************************************************************\
    |**************************Step 0 - Spray Input File***************************|
    \******************************************************************************/
    SHARED ModelName      := 'PhoneModel_v31_2';
    SHARED lzFilePath     := lzFilePathFolder + CSVSprayFile;
    #IF(sprayedFile)
    SHARED SprayCSVName 	:= sprayedFile; // Will set up by user if test file is a logical file.
    #ELSE
    SHARED SprayCSVName   := '~PhoneModel_v31_2::' + (STRING)STD.Date.Today() + '::' + ModelName +'_from_csv';
    #END
    #IF(~preSprayed)
    EXPORT inputFileSprayed := PhoneModel_v31_2.FNSpray(landingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
    #END
    /******************************************************************************\
    |**************************Step 1a - Load Input File***************************|
    \******************************************************************************/
    FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, CSVSprayHeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote, FALSE);
    EXPORT RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_PhoneModel_v31_2 := TRUE, SELF := LEFT));
    EXPORT OutInputSet := OUTPUT(RawInputSet,,NAMED('RawInput'));

    /******************************************************************************\
    |**********************Step 1b - Standardized Input File***********************|
    \******************************************************************************/
    FNValidation.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile, FALSE);
    EXPORT OutStdInputSet := OUTPUT(StdFile, NAMED('ModelerSTDFile'));
    SHARED pLUCIresults := LUCI_Model.AsResults(RawInputSet);
    EXPORT LUCIresults  := DISTRIBUTE(pLUCIresults.Validation(), hash32(TransactionID));
    EXPORT OutLUCIResults := OUTPUT(LUCIresults, NAMED('LUCIresults'));

    /******************************************************************************\
    |****************Step 2 - Get Statistics of Final Scores, RC   ****************|
    \******************************************************************************/
     FNValidation.MAC_CompareScore(LUCIresults, StdFile, Check_Result, pOutputSet, scoreDiffAsPercSet, FALSE);
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
        //Scores
        SELF.rawscore:= L.PhoneModel_v31_2_OVERALL_Score0;
        SELF.predscr:= (700 + 50 * ((SELF.rawscore - 0.0 - -1.074512) / LN(2)));
        SELF.finalscore := L.PhoneModel_v31_2_Score;
        SELF.SOURCE := 'HPCC';
        SELF.stdrawscore  := (string)L.PhoneModel_v31_2_OVERALL_Score0;
        SELF.std_scr := (string)L.PhoneModel_v31_2_Score;
        SELF := L;
        SELF := [];
    END;
    SHARED LUCI_Points_Assignments := PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIPointsAssignments(LEFT));
    SHARED DS_Comp_pre := SORT(LUCI_Points_Assignments + StdFile, TransactionID, -SOURCE);
    EXPORT DS_Comp := PROJECT(DS_Comp_pre, Layouts.StandLayouts);
    TerminalNodesLayout := RECORD
      UNSIGNED OVERALL_tree1_node;
      UNSIGNED OVERALL_tree2_node;
      UNSIGNED OVERALL_tree3_node;
      UNSIGNED OVERALL_tree4_node;
      UNSIGNED OVERALL_tree5_node;
      UNSIGNED OVERALL_tree6_node;
      UNSIGNED OVERALL_tree7_node;
      UNSIGNED OVERALL_tree8_node;
      UNSIGNED OVERALL_tree9_node;
      UNSIGNED OVERALL_tree10_node;
      UNSIGNED OVERALL_tree11_node;
      UNSIGNED OVERALL_tree12_node;
      UNSIGNED OVERALL_tree13_node;
      UNSIGNED OVERALL_tree14_node;
      UNSIGNED OVERALL_tree15_node;
      UNSIGNED OVERALL_tree16_node;
      UNSIGNED OVERALL_tree17_node;
      UNSIGNED OVERALL_tree18_node;
      UNSIGNED OVERALL_tree19_node;
      UNSIGNED OVERALL_tree20_node;
      UNSIGNED OVERALL_tree21_node;
      UNSIGNED OVERALL_tree22_node;
      UNSIGNED OVERALL_tree23_node;
      UNSIGNED OVERALL_tree24_node;
      UNSIGNED OVERALL_tree25_node;
      UNSIGNED OVERALL_tree26_node;
      UNSIGNED OVERALL_tree27_node;
      UNSIGNED OVERALL_tree28_node;
      UNSIGNED OVERALL_tree29_node;
      UNSIGNED OVERALL_tree30_node;
      UNSIGNED OVERALL_tree31_node;
      UNSIGNED OVERALL_tree32_node;
      UNSIGNED OVERALL_tree33_node;
      UNSIGNED OVERALL_tree34_node;
      UNSIGNED OVERALL_tree35_node;
      UNSIGNED OVERALL_tree36_node;
      UNSIGNED OVERALL_tree37_node;
      UNSIGNED OVERALL_tree38_node;
      UNSIGNED OVERALL_tree39_node;
      UNSIGNED OVERALL_tree40_node;
      UNSIGNED OVERALL_tree41_node;
      UNSIGNED OVERALL_tree42_node;
      UNSIGNED OVERALL_tree43_node;
      UNSIGNED OVERALL_tree44_node;
      UNSIGNED OVERALL_tree45_node;
      UNSIGNED OVERALL_tree46_node;
      UNSIGNED OVERALL_tree47_node;
      UNSIGNED OVERALL_tree48_node;
      UNSIGNED OVERALL_tree49_node;
      UNSIGNED OVERALL_tree50_node;
      UNSIGNED OVERALL_tree51_node;
      UNSIGNED OVERALL_tree52_node;
      UNSIGNED OVERALL_tree53_node;
      UNSIGNED OVERALL_tree54_node;
      UNSIGNED OVERALL_tree55_node;
      UNSIGNED OVERALL_tree56_node;
      UNSIGNED OVERALL_tree57_node;
      UNSIGNED OVERALL_tree58_node;
      UNSIGNED OVERALL_tree59_node;
      UNSIGNED OVERALL_tree60_node;
      UNSIGNED OVERALL_tree61_node;
      UNSIGNED OVERALL_tree62_node;
      UNSIGNED OVERALL_tree63_node;
      UNSIGNED OVERALL_tree64_node;
      UNSIGNED OVERALL_tree65_node;
      UNSIGNED OVERALL_tree66_node;
      UNSIGNED OVERALL_tree67_node;
      UNSIGNED OVERALL_tree68_node;
      UNSIGNED OVERALL_tree69_node;
      UNSIGNED OVERALL_tree70_node;
      UNSIGNED OVERALL_tree71_node;
      UNSIGNED OVERALL_tree72_node;
      UNSIGNED OVERALL_tree73_node;
      UNSIGNED OVERALL_tree74_node;
      UNSIGNED OVERALL_tree75_node;
      UNSIGNED OVERALL_tree76_node;
      UNSIGNED OVERALL_tree77_node;
      UNSIGNED OVERALL_tree78_node;
      UNSIGNED OVERALL_tree79_node;
      UNSIGNED OVERALL_tree80_node;
      UNSIGNED OVERALL_tree81_node;
      UNSIGNED OVERALL_tree82_node;
      UNSIGNED OVERALL_tree83_node;
      UNSIGNED OVERALL_tree84_node;
      UNSIGNED OVERALL_tree85_node;
      UNSIGNED OVERALL_tree86_node;
      UNSIGNED OVERALL_tree87_node;
      UNSIGNED OVERALL_tree88_node;
      UNSIGNED OVERALL_tree89_node;
      UNSIGNED OVERALL_tree90_node;
      UNSIGNED OVERALL_tree91_node;
      UNSIGNED OVERALL_tree92_node;
      UNSIGNED OVERALL_tree93_node;
      UNSIGNED OVERALL_tree94_node;
      UNSIGNED OVERALL_tree95_node;
      UNSIGNED OVERALL_tree96_node;
      UNSIGNED OVERALL_tree97_node;
      UNSIGNED OVERALL_tree98_node;
      UNSIGNED OVERALL_tree99_node;
      UNSIGNED OVERALL_tree100_node;
      UNSIGNED OVERALL_tree101_node;
      UNSIGNED OVERALL_tree102_node;
      UNSIGNED OVERALL_tree103_node;
      UNSIGNED OVERALL_tree104_node;
      UNSIGNED OVERALL_tree105_node;
      UNSIGNED OVERALL_tree106_node;
      UNSIGNED OVERALL_tree107_node;
      UNSIGNED OVERALL_tree108_node;
      UNSIGNED OVERALL_tree109_node;
      UNSIGNED OVERALL_tree110_node;
      UNSIGNED OVERALL_tree111_node;
      UNSIGNED OVERALL_tree112_node;
      UNSIGNED OVERALL_tree113_node;
      UNSIGNED OVERALL_tree114_node;
      UNSIGNED OVERALL_tree115_node;
      UNSIGNED OVERALL_tree116_node;
      UNSIGNED OVERALL_tree117_node;
      UNSIGNED OVERALL_tree118_node;
      UNSIGNED OVERALL_tree119_node;
      UNSIGNED OVERALL_tree120_node;
      UNSIGNED OVERALL_tree121_node;
      UNSIGNED OVERALL_tree122_node;
      UNSIGNED OVERALL_tree123_node;
      UNSIGNED OVERALL_tree124_node;
      UNSIGNED OVERALL_tree125_node;
      UNSIGNED OVERALL_tree126_node;
      UNSIGNED OVERALL_tree127_node;
      UNSIGNED OVERALL_tree128_node;
      UNSIGNED OVERALL_tree129_node;
      UNSIGNED OVERALL_tree130_node;
      UNSIGNED OVERALL_tree131_node;
      UNSIGNED OVERALL_tree132_node;
      UNSIGNED OVERALL_tree133_node;
      UNSIGNED OVERALL_tree134_node;
      UNSIGNED OVERALL_tree135_node;
      UNSIGNED OVERALL_tree136_node;
      UNSIGNED OVERALL_tree137_node;
      UNSIGNED OVERALL_tree138_node;
      UNSIGNED OVERALL_tree139_node;
      UNSIGNED OVERALL_tree140_node;
      UNSIGNED OVERALL_tree141_node;
      UNSIGNED OVERALL_tree142_node;
      UNSIGNED OVERALL_tree143_node;
      UNSIGNED OVERALL_tree144_node;
      UNSIGNED OVERALL_tree145_node;
      UNSIGNED OVERALL_tree146_node;
      UNSIGNED OVERALL_tree147_node;
      UNSIGNED OVERALL_tree148_node;
      UNSIGNED OVERALL_tree149_node;
      UNSIGNED OVERALL_tree150_node;
      UNSIGNED OVERALL_tree151_node;
      UNSIGNED OVERALL_tree152_node;
      UNSIGNED OVERALL_tree153_node;
      UNSIGNED OVERALL_tree154_node;
      UNSIGNED OVERALL_tree155_node;
      UNSIGNED OVERALL_tree156_node;
      UNSIGNED OVERALL_tree157_node;
      UNSIGNED OVERALL_tree158_node;
      UNSIGNED OVERALL_tree159_node;
      UNSIGNED OVERALL_tree160_node;
      UNSIGNED OVERALL_tree161_node;
      UNSIGNED OVERALL_tree162_node;
      UNSIGNED OVERALL_tree163_node;
      UNSIGNED OVERALL_tree164_node;
      UNSIGNED OVERALL_tree165_node;
      UNSIGNED OVERALL_tree166_node;
      UNSIGNED OVERALL_tree167_node;
      UNSIGNED OVERALL_tree168_node;
      UNSIGNED OVERALL_tree169_node;
      UNSIGNED OVERALL_tree170_node;
      UNSIGNED OVERALL_tree171_node;
      UNSIGNED OVERALL_tree172_node;
      UNSIGNED OVERALL_tree173_node;
      UNSIGNED OVERALL_tree174_node;
      UNSIGNED OVERALL_tree175_node;
      UNSIGNED OVERALL_tree176_node;
      UNSIGNED OVERALL_tree177_node;
      UNSIGNED OVERALL_tree178_node;
      UNSIGNED OVERALL_tree179_node;
      UNSIGNED OVERALL_tree180_node;
      UNSIGNED OVERALL_tree181_node;
      UNSIGNED OVERALL_tree182_node;
      UNSIGNED OVERALL_tree183_node;
      UNSIGNED OVERALL_tree184_node;
      UNSIGNED OVERALL_tree185_node;
      UNSIGNED OVERALL_tree186_node;
      UNSIGNED OVERALL_tree187_node;
      UNSIGNED OVERALL_tree188_node;
      UNSIGNED OVERALL_tree189_node;
      UNSIGNED OVERALL_tree190_node;
      UNSIGNED OVERALL_tree191_node;
      UNSIGNED OVERALL_tree192_node;
      UNSIGNED OVERALL_tree193_node;
      UNSIGNED OVERALL_tree194_node;
      UNSIGNED OVERALL_tree195_node;
      UNSIGNED OVERALL_tree196_node;
      UNSIGNED OVERALL_tree197_node;
      UNSIGNED OVERALL_tree198_node;
      UNSIGNED OVERALL_tree199_node;
      UNSIGNED OVERALL_tree200_node;
      UNSIGNED OVERALL_tree201_node;
      UNSIGNED OVERALL_tree202_node;
      UNSIGNED OVERALL_tree203_node;
      UNSIGNED OVERALL_tree204_node;
      UNSIGNED OVERALL_tree205_node;
      UNSIGNED OVERALL_tree206_node;
      UNSIGNED OVERALL_tree207_node;
      UNSIGNED OVERALL_tree208_node;
      UNSIGNED OVERALL_tree209_node;
      UNSIGNED OVERALL_tree210_node;
      UNSIGNED OVERALL_tree211_node;
      UNSIGNED OVERALL_tree212_node;
      UNSIGNED OVERALL_tree213_node;
      UNSIGNED OVERALL_tree214_node;
      UNSIGNED OVERALL_tree215_node;
      UNSIGNED OVERALL_tree216_node;
      UNSIGNED OVERALL_tree217_node;
      UNSIGNED OVERALL_tree218_node;
      UNSIGNED OVERALL_tree219_node;
      UNSIGNED OVERALL_tree220_node;
      UNSIGNED OVERALL_tree221_node;
      UNSIGNED OVERALL_tree222_node;
      UNSIGNED OVERALL_tree223_node;
      UNSIGNED OVERALL_tree224_node;
      UNSIGNED OVERALL_tree225_node;
      UNSIGNED OVERALL_tree226_node;
      UNSIGNED OVERALL_tree227_node;
      UNSIGNED OVERALL_tree228_node;
      UNSIGNED OVERALL_tree229_node;
      UNSIGNED OVERALL_tree230_node;
      UNSIGNED OVERALL_tree231_node;
      UNSIGNED OVERALL_tree232_node;
      UNSIGNED OVERALL_tree233_node;
      UNSIGNED OVERALL_tree234_node;
      UNSIGNED OVERALL_tree235_node;
      UNSIGNED OVERALL_tree236_node;
      UNSIGNED OVERALL_tree237_node;
      UNSIGNED OVERALL_tree238_node;
      UNSIGNED OVERALL_tree239_node;
      UNSIGNED OVERALL_tree240_node;
      UNSIGNED OVERALL_tree241_node;
      UNSIGNED OVERALL_tree242_node;
      UNSIGNED OVERALL_tree243_node;
      UNSIGNED OVERALL_tree244_node;
      UNSIGNED OVERALL_tree245_node;
      UNSIGNED OVERALL_tree246_node;
      UNSIGNED OVERALL_tree247_node;
      UNSIGNED OVERALL_tree248_node;
      UNSIGNED OVERALL_tree249_node;
      UNSIGNED OVERALL_tree250_node;
      UNSIGNED OVERALL_tree251_node;
      UNSIGNED OVERALL_tree252_node;
      UNSIGNED OVERALL_tree253_node;
      UNSIGNED OVERALL_tree254_node;
      UNSIGNED OVERALL_tree255_node;
      UNSIGNED OVERALL_tree256_node;
      UNSIGNED OVERALL_tree257_node;
      UNSIGNED OVERALL_tree258_node;
      UNSIGNED OVERALL_tree259_node;
      UNSIGNED OVERALL_tree260_node;
      UNSIGNED OVERALL_tree261_node;
      UNSIGNED OVERALL_tree262_node;
      UNSIGNED OVERALL_tree263_node;
      UNSIGNED OVERALL_tree264_node;
      UNSIGNED OVERALL_tree265_node;
      UNSIGNED OVERALL_tree266_node;
      UNSIGNED OVERALL_tree267_node;
      UNSIGNED OVERALL_tree268_node;
      UNSIGNED OVERALL_tree269_node;
      UNSIGNED OVERALL_tree270_node;
      UNSIGNED OVERALL_tree271_node;
      UNSIGNED OVERALL_tree272_node;
      UNSIGNED OVERALL_tree273_node;
      UNSIGNED OVERALL_tree274_node;
      UNSIGNED OVERALL_tree275_node;
      UNSIGNED OVERALL_tree276_node;
      UNSIGNED OVERALL_tree277_node;
      UNSIGNED OVERALL_tree278_node;
      UNSIGNED OVERALL_tree279_node;
      UNSIGNED OVERALL_tree280_node;
      UNSIGNED OVERALL_tree281_node;
      UNSIGNED OVERALL_tree282_node;
      UNSIGNED OVERALL_tree283_node;
      UNSIGNED OVERALL_tree284_node;
      UNSIGNED OVERALL_tree285_node;
      UNSIGNED OVERALL_tree286_node;
      UNSIGNED OVERALL_tree287_node;
      UNSIGNED OVERALL_tree288_node;
      UNSIGNED OVERALL_tree289_node;
      UNSIGNED OVERALL_tree290_node;
      UNSIGNED OVERALL_tree291_node;

    END;
    StandLayoutsLimited := Layouts.StandLayouts - TerminalNodesLayout;
    SHARED DS_Comp_out := PROJECT(DS_Comp, StandLayoutsLimited);
    EXPORT OutSCMismatchesDetails := OUTPUT(DS_Comp_out(TransactionID in mismatch_list_sc),,NAMED('sc_mismatches_details'));
    EXPORT OutAuditComparison := OUTPUT(DS_Comp_out,,NAMED('AuditComparison'));

    /******************************************************************************\
    |***Step3a - Compute Terminal Node mismatches per Tree (for Forest only)*******|
    \******************************************************************************/
    SHARED TerminalNodeCompPerTreeLayout := RECORD
    	UNSIGNED treeNo;
    	UNSIGNED expectedNode;
    	UNSIGNED actualNode;
    END;

    SHARED TerminalNodeMismatchesLayout := RECORD
    	STRING TransactionID;
    	DATASET(TerminalNodeCompPerTreeLayout) TerminalNodeMismatches := DATASET([], TerminalNodeCompPerTreeLayout);
    END;

    SHARED DS_Comp_sc_grp := GROUP(DS_Comp(TransactionID in mismatch_list_sc),TransactionID);

    SHARED TerminalNodeMismatchesLayout doRollUp(Layouts.StandLayouts L, DATASET(Layouts.StandLayouts) R) := TRANSFORM
    	SELF.TransactionID := L.TransactionID;
    	SELF.TerminalNodeMismatches := IF(L.OVERALL_tree1_node != R[2].OVERALL_tree1_node, DATASET([{1, L.OVERALL_tree1_node, R[2].OVERALL_tree1_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree2_node != R[2].OVERALL_tree2_node, DATASET([{2, L.OVERALL_tree2_node, R[2].OVERALL_tree2_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree3_node != R[2].OVERALL_tree3_node, DATASET([{3, L.OVERALL_tree3_node, R[2].OVERALL_tree3_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree4_node != R[2].OVERALL_tree4_node, DATASET([{4, L.OVERALL_tree4_node, R[2].OVERALL_tree4_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree5_node != R[2].OVERALL_tree5_node, DATASET([{5, L.OVERALL_tree5_node, R[2].OVERALL_tree5_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree6_node != R[2].OVERALL_tree6_node, DATASET([{6, L.OVERALL_tree6_node, R[2].OVERALL_tree6_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree7_node != R[2].OVERALL_tree7_node, DATASET([{7, L.OVERALL_tree7_node, R[2].OVERALL_tree7_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree8_node != R[2].OVERALL_tree8_node, DATASET([{8, L.OVERALL_tree8_node, R[2].OVERALL_tree8_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree9_node != R[2].OVERALL_tree9_node, DATASET([{9, L.OVERALL_tree9_node, R[2].OVERALL_tree9_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree10_node != R[2].OVERALL_tree10_node, DATASET([{10, L.OVERALL_tree10_node, R[2].OVERALL_tree10_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree11_node != R[2].OVERALL_tree11_node, DATASET([{11, L.OVERALL_tree11_node, R[2].OVERALL_tree11_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree12_node != R[2].OVERALL_tree12_node, DATASET([{12, L.OVERALL_tree12_node, R[2].OVERALL_tree12_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree13_node != R[2].OVERALL_tree13_node, DATASET([{13, L.OVERALL_tree13_node, R[2].OVERALL_tree13_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree14_node != R[2].OVERALL_tree14_node, DATASET([{14, L.OVERALL_tree14_node, R[2].OVERALL_tree14_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree15_node != R[2].OVERALL_tree15_node, DATASET([{15, L.OVERALL_tree15_node, R[2].OVERALL_tree15_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree16_node != R[2].OVERALL_tree16_node, DATASET([{16, L.OVERALL_tree16_node, R[2].OVERALL_tree16_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree17_node != R[2].OVERALL_tree17_node, DATASET([{17, L.OVERALL_tree17_node, R[2].OVERALL_tree17_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree18_node != R[2].OVERALL_tree18_node, DATASET([{18, L.OVERALL_tree18_node, R[2].OVERALL_tree18_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree19_node != R[2].OVERALL_tree19_node, DATASET([{19, L.OVERALL_tree19_node, R[2].OVERALL_tree19_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree20_node != R[2].OVERALL_tree20_node, DATASET([{20, L.OVERALL_tree20_node, R[2].OVERALL_tree20_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree21_node != R[2].OVERALL_tree21_node, DATASET([{21, L.OVERALL_tree21_node, R[2].OVERALL_tree21_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree22_node != R[2].OVERALL_tree22_node, DATASET([{22, L.OVERALL_tree22_node, R[2].OVERALL_tree22_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree23_node != R[2].OVERALL_tree23_node, DATASET([{23, L.OVERALL_tree23_node, R[2].OVERALL_tree23_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree24_node != R[2].OVERALL_tree24_node, DATASET([{24, L.OVERALL_tree24_node, R[2].OVERALL_tree24_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree25_node != R[2].OVERALL_tree25_node, DATASET([{25, L.OVERALL_tree25_node, R[2].OVERALL_tree25_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree26_node != R[2].OVERALL_tree26_node, DATASET([{26, L.OVERALL_tree26_node, R[2].OVERALL_tree26_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree27_node != R[2].OVERALL_tree27_node, DATASET([{27, L.OVERALL_tree27_node, R[2].OVERALL_tree27_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree28_node != R[2].OVERALL_tree28_node, DATASET([{28, L.OVERALL_tree28_node, R[2].OVERALL_tree28_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree29_node != R[2].OVERALL_tree29_node, DATASET([{29, L.OVERALL_tree29_node, R[2].OVERALL_tree29_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree30_node != R[2].OVERALL_tree30_node, DATASET([{30, L.OVERALL_tree30_node, R[2].OVERALL_tree30_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree31_node != R[2].OVERALL_tree31_node, DATASET([{31, L.OVERALL_tree31_node, R[2].OVERALL_tree31_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree32_node != R[2].OVERALL_tree32_node, DATASET([{32, L.OVERALL_tree32_node, R[2].OVERALL_tree32_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree33_node != R[2].OVERALL_tree33_node, DATASET([{33, L.OVERALL_tree33_node, R[2].OVERALL_tree33_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree34_node != R[2].OVERALL_tree34_node, DATASET([{34, L.OVERALL_tree34_node, R[2].OVERALL_tree34_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree35_node != R[2].OVERALL_tree35_node, DATASET([{35, L.OVERALL_tree35_node, R[2].OVERALL_tree35_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree36_node != R[2].OVERALL_tree36_node, DATASET([{36, L.OVERALL_tree36_node, R[2].OVERALL_tree36_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree37_node != R[2].OVERALL_tree37_node, DATASET([{37, L.OVERALL_tree37_node, R[2].OVERALL_tree37_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree38_node != R[2].OVERALL_tree38_node, DATASET([{38, L.OVERALL_tree38_node, R[2].OVERALL_tree38_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree39_node != R[2].OVERALL_tree39_node, DATASET([{39, L.OVERALL_tree39_node, R[2].OVERALL_tree39_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree40_node != R[2].OVERALL_tree40_node, DATASET([{40, L.OVERALL_tree40_node, R[2].OVERALL_tree40_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree41_node != R[2].OVERALL_tree41_node, DATASET([{41, L.OVERALL_tree41_node, R[2].OVERALL_tree41_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree42_node != R[2].OVERALL_tree42_node, DATASET([{42, L.OVERALL_tree42_node, R[2].OVERALL_tree42_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree43_node != R[2].OVERALL_tree43_node, DATASET([{43, L.OVERALL_tree43_node, R[2].OVERALL_tree43_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree44_node != R[2].OVERALL_tree44_node, DATASET([{44, L.OVERALL_tree44_node, R[2].OVERALL_tree44_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree45_node != R[2].OVERALL_tree45_node, DATASET([{45, L.OVERALL_tree45_node, R[2].OVERALL_tree45_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree46_node != R[2].OVERALL_tree46_node, DATASET([{46, L.OVERALL_tree46_node, R[2].OVERALL_tree46_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree47_node != R[2].OVERALL_tree47_node, DATASET([{47, L.OVERALL_tree47_node, R[2].OVERALL_tree47_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree48_node != R[2].OVERALL_tree48_node, DATASET([{48, L.OVERALL_tree48_node, R[2].OVERALL_tree48_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree49_node != R[2].OVERALL_tree49_node, DATASET([{49, L.OVERALL_tree49_node, R[2].OVERALL_tree49_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree50_node != R[2].OVERALL_tree50_node, DATASET([{50, L.OVERALL_tree50_node, R[2].OVERALL_tree50_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree51_node != R[2].OVERALL_tree51_node, DATASET([{51, L.OVERALL_tree51_node, R[2].OVERALL_tree51_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree52_node != R[2].OVERALL_tree52_node, DATASET([{52, L.OVERALL_tree52_node, R[2].OVERALL_tree52_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree53_node != R[2].OVERALL_tree53_node, DATASET([{53, L.OVERALL_tree53_node, R[2].OVERALL_tree53_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree54_node != R[2].OVERALL_tree54_node, DATASET([{54, L.OVERALL_tree54_node, R[2].OVERALL_tree54_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree55_node != R[2].OVERALL_tree55_node, DATASET([{55, L.OVERALL_tree55_node, R[2].OVERALL_tree55_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree56_node != R[2].OVERALL_tree56_node, DATASET([{56, L.OVERALL_tree56_node, R[2].OVERALL_tree56_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree57_node != R[2].OVERALL_tree57_node, DATASET([{57, L.OVERALL_tree57_node, R[2].OVERALL_tree57_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree58_node != R[2].OVERALL_tree58_node, DATASET([{58, L.OVERALL_tree58_node, R[2].OVERALL_tree58_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree59_node != R[2].OVERALL_tree59_node, DATASET([{59, L.OVERALL_tree59_node, R[2].OVERALL_tree59_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree60_node != R[2].OVERALL_tree60_node, DATASET([{60, L.OVERALL_tree60_node, R[2].OVERALL_tree60_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree61_node != R[2].OVERALL_tree61_node, DATASET([{61, L.OVERALL_tree61_node, R[2].OVERALL_tree61_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree62_node != R[2].OVERALL_tree62_node, DATASET([{62, L.OVERALL_tree62_node, R[2].OVERALL_tree62_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree63_node != R[2].OVERALL_tree63_node, DATASET([{63, L.OVERALL_tree63_node, R[2].OVERALL_tree63_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree64_node != R[2].OVERALL_tree64_node, DATASET([{64, L.OVERALL_tree64_node, R[2].OVERALL_tree64_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree65_node != R[2].OVERALL_tree65_node, DATASET([{65, L.OVERALL_tree65_node, R[2].OVERALL_tree65_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree66_node != R[2].OVERALL_tree66_node, DATASET([{66, L.OVERALL_tree66_node, R[2].OVERALL_tree66_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree67_node != R[2].OVERALL_tree67_node, DATASET([{67, L.OVERALL_tree67_node, R[2].OVERALL_tree67_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree68_node != R[2].OVERALL_tree68_node, DATASET([{68, L.OVERALL_tree68_node, R[2].OVERALL_tree68_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree69_node != R[2].OVERALL_tree69_node, DATASET([{69, L.OVERALL_tree69_node, R[2].OVERALL_tree69_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree70_node != R[2].OVERALL_tree70_node, DATASET([{70, L.OVERALL_tree70_node, R[2].OVERALL_tree70_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree71_node != R[2].OVERALL_tree71_node, DATASET([{71, L.OVERALL_tree71_node, R[2].OVERALL_tree71_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree72_node != R[2].OVERALL_tree72_node, DATASET([{72, L.OVERALL_tree72_node, R[2].OVERALL_tree72_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree73_node != R[2].OVERALL_tree73_node, DATASET([{73, L.OVERALL_tree73_node, R[2].OVERALL_tree73_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree74_node != R[2].OVERALL_tree74_node, DATASET([{74, L.OVERALL_tree74_node, R[2].OVERALL_tree74_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree75_node != R[2].OVERALL_tree75_node, DATASET([{75, L.OVERALL_tree75_node, R[2].OVERALL_tree75_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree76_node != R[2].OVERALL_tree76_node, DATASET([{76, L.OVERALL_tree76_node, R[2].OVERALL_tree76_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree77_node != R[2].OVERALL_tree77_node, DATASET([{77, L.OVERALL_tree77_node, R[2].OVERALL_tree77_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree78_node != R[2].OVERALL_tree78_node, DATASET([{78, L.OVERALL_tree78_node, R[2].OVERALL_tree78_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree79_node != R[2].OVERALL_tree79_node, DATASET([{79, L.OVERALL_tree79_node, R[2].OVERALL_tree79_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree80_node != R[2].OVERALL_tree80_node, DATASET([{80, L.OVERALL_tree80_node, R[2].OVERALL_tree80_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree81_node != R[2].OVERALL_tree81_node, DATASET([{81, L.OVERALL_tree81_node, R[2].OVERALL_tree81_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree82_node != R[2].OVERALL_tree82_node, DATASET([{82, L.OVERALL_tree82_node, R[2].OVERALL_tree82_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree83_node != R[2].OVERALL_tree83_node, DATASET([{83, L.OVERALL_tree83_node, R[2].OVERALL_tree83_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree84_node != R[2].OVERALL_tree84_node, DATASET([{84, L.OVERALL_tree84_node, R[2].OVERALL_tree84_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree85_node != R[2].OVERALL_tree85_node, DATASET([{85, L.OVERALL_tree85_node, R[2].OVERALL_tree85_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree86_node != R[2].OVERALL_tree86_node, DATASET([{86, L.OVERALL_tree86_node, R[2].OVERALL_tree86_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree87_node != R[2].OVERALL_tree87_node, DATASET([{87, L.OVERALL_tree87_node, R[2].OVERALL_tree87_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree88_node != R[2].OVERALL_tree88_node, DATASET([{88, L.OVERALL_tree88_node, R[2].OVERALL_tree88_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree89_node != R[2].OVERALL_tree89_node, DATASET([{89, L.OVERALL_tree89_node, R[2].OVERALL_tree89_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree90_node != R[2].OVERALL_tree90_node, DATASET([{90, L.OVERALL_tree90_node, R[2].OVERALL_tree90_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree91_node != R[2].OVERALL_tree91_node, DATASET([{91, L.OVERALL_tree91_node, R[2].OVERALL_tree91_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree92_node != R[2].OVERALL_tree92_node, DATASET([{92, L.OVERALL_tree92_node, R[2].OVERALL_tree92_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree93_node != R[2].OVERALL_tree93_node, DATASET([{93, L.OVERALL_tree93_node, R[2].OVERALL_tree93_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree94_node != R[2].OVERALL_tree94_node, DATASET([{94, L.OVERALL_tree94_node, R[2].OVERALL_tree94_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree95_node != R[2].OVERALL_tree95_node, DATASET([{95, L.OVERALL_tree95_node, R[2].OVERALL_tree95_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree96_node != R[2].OVERALL_tree96_node, DATASET([{96, L.OVERALL_tree96_node, R[2].OVERALL_tree96_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree97_node != R[2].OVERALL_tree97_node, DATASET([{97, L.OVERALL_tree97_node, R[2].OVERALL_tree97_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree98_node != R[2].OVERALL_tree98_node, DATASET([{98, L.OVERALL_tree98_node, R[2].OVERALL_tree98_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree99_node != R[2].OVERALL_tree99_node, DATASET([{99, L.OVERALL_tree99_node, R[2].OVERALL_tree99_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree100_node != R[2].OVERALL_tree100_node, DATASET([{100, L.OVERALL_tree100_node, R[2].OVERALL_tree100_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree101_node != R[2].OVERALL_tree101_node, DATASET([{101, L.OVERALL_tree101_node, R[2].OVERALL_tree101_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree102_node != R[2].OVERALL_tree102_node, DATASET([{102, L.OVERALL_tree102_node, R[2].OVERALL_tree102_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree103_node != R[2].OVERALL_tree103_node, DATASET([{103, L.OVERALL_tree103_node, R[2].OVERALL_tree103_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree104_node != R[2].OVERALL_tree104_node, DATASET([{104, L.OVERALL_tree104_node, R[2].OVERALL_tree104_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree105_node != R[2].OVERALL_tree105_node, DATASET([{105, L.OVERALL_tree105_node, R[2].OVERALL_tree105_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree106_node != R[2].OVERALL_tree106_node, DATASET([{106, L.OVERALL_tree106_node, R[2].OVERALL_tree106_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree107_node != R[2].OVERALL_tree107_node, DATASET([{107, L.OVERALL_tree107_node, R[2].OVERALL_tree107_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree108_node != R[2].OVERALL_tree108_node, DATASET([{108, L.OVERALL_tree108_node, R[2].OVERALL_tree108_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree109_node != R[2].OVERALL_tree109_node, DATASET([{109, L.OVERALL_tree109_node, R[2].OVERALL_tree109_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree110_node != R[2].OVERALL_tree110_node, DATASET([{110, L.OVERALL_tree110_node, R[2].OVERALL_tree110_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree111_node != R[2].OVERALL_tree111_node, DATASET([{111, L.OVERALL_tree111_node, R[2].OVERALL_tree111_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree112_node != R[2].OVERALL_tree112_node, DATASET([{112, L.OVERALL_tree112_node, R[2].OVERALL_tree112_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree113_node != R[2].OVERALL_tree113_node, DATASET([{113, L.OVERALL_tree113_node, R[2].OVERALL_tree113_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree114_node != R[2].OVERALL_tree114_node, DATASET([{114, L.OVERALL_tree114_node, R[2].OVERALL_tree114_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree115_node != R[2].OVERALL_tree115_node, DATASET([{115, L.OVERALL_tree115_node, R[2].OVERALL_tree115_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree116_node != R[2].OVERALL_tree116_node, DATASET([{116, L.OVERALL_tree116_node, R[2].OVERALL_tree116_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree117_node != R[2].OVERALL_tree117_node, DATASET([{117, L.OVERALL_tree117_node, R[2].OVERALL_tree117_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree118_node != R[2].OVERALL_tree118_node, DATASET([{118, L.OVERALL_tree118_node, R[2].OVERALL_tree118_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree119_node != R[2].OVERALL_tree119_node, DATASET([{119, L.OVERALL_tree119_node, R[2].OVERALL_tree119_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree120_node != R[2].OVERALL_tree120_node, DATASET([{120, L.OVERALL_tree120_node, R[2].OVERALL_tree120_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree121_node != R[2].OVERALL_tree121_node, DATASET([{121, L.OVERALL_tree121_node, R[2].OVERALL_tree121_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree122_node != R[2].OVERALL_tree122_node, DATASET([{122, L.OVERALL_tree122_node, R[2].OVERALL_tree122_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree123_node != R[2].OVERALL_tree123_node, DATASET([{123, L.OVERALL_tree123_node, R[2].OVERALL_tree123_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree124_node != R[2].OVERALL_tree124_node, DATASET([{124, L.OVERALL_tree124_node, R[2].OVERALL_tree124_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree125_node != R[2].OVERALL_tree125_node, DATASET([{125, L.OVERALL_tree125_node, R[2].OVERALL_tree125_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree126_node != R[2].OVERALL_tree126_node, DATASET([{126, L.OVERALL_tree126_node, R[2].OVERALL_tree126_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree127_node != R[2].OVERALL_tree127_node, DATASET([{127, L.OVERALL_tree127_node, R[2].OVERALL_tree127_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree128_node != R[2].OVERALL_tree128_node, DATASET([{128, L.OVERALL_tree128_node, R[2].OVERALL_tree128_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree129_node != R[2].OVERALL_tree129_node, DATASET([{129, L.OVERALL_tree129_node, R[2].OVERALL_tree129_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree130_node != R[2].OVERALL_tree130_node, DATASET([{130, L.OVERALL_tree130_node, R[2].OVERALL_tree130_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree131_node != R[2].OVERALL_tree131_node, DATASET([{131, L.OVERALL_tree131_node, R[2].OVERALL_tree131_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree132_node != R[2].OVERALL_tree132_node, DATASET([{132, L.OVERALL_tree132_node, R[2].OVERALL_tree132_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree133_node != R[2].OVERALL_tree133_node, DATASET([{133, L.OVERALL_tree133_node, R[2].OVERALL_tree133_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree134_node != R[2].OVERALL_tree134_node, DATASET([{134, L.OVERALL_tree134_node, R[2].OVERALL_tree134_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree135_node != R[2].OVERALL_tree135_node, DATASET([{135, L.OVERALL_tree135_node, R[2].OVERALL_tree135_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree136_node != R[2].OVERALL_tree136_node, DATASET([{136, L.OVERALL_tree136_node, R[2].OVERALL_tree136_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree137_node != R[2].OVERALL_tree137_node, DATASET([{137, L.OVERALL_tree137_node, R[2].OVERALL_tree137_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree138_node != R[2].OVERALL_tree138_node, DATASET([{138, L.OVERALL_tree138_node, R[2].OVERALL_tree138_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree139_node != R[2].OVERALL_tree139_node, DATASET([{139, L.OVERALL_tree139_node, R[2].OVERALL_tree139_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree140_node != R[2].OVERALL_tree140_node, DATASET([{140, L.OVERALL_tree140_node, R[2].OVERALL_tree140_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree141_node != R[2].OVERALL_tree141_node, DATASET([{141, L.OVERALL_tree141_node, R[2].OVERALL_tree141_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree142_node != R[2].OVERALL_tree142_node, DATASET([{142, L.OVERALL_tree142_node, R[2].OVERALL_tree142_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree143_node != R[2].OVERALL_tree143_node, DATASET([{143, L.OVERALL_tree143_node, R[2].OVERALL_tree143_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree144_node != R[2].OVERALL_tree144_node, DATASET([{144, L.OVERALL_tree144_node, R[2].OVERALL_tree144_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree145_node != R[2].OVERALL_tree145_node, DATASET([{145, L.OVERALL_tree145_node, R[2].OVERALL_tree145_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree146_node != R[2].OVERALL_tree146_node, DATASET([{146, L.OVERALL_tree146_node, R[2].OVERALL_tree146_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree147_node != R[2].OVERALL_tree147_node, DATASET([{147, L.OVERALL_tree147_node, R[2].OVERALL_tree147_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree148_node != R[2].OVERALL_tree148_node, DATASET([{148, L.OVERALL_tree148_node, R[2].OVERALL_tree148_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree149_node != R[2].OVERALL_tree149_node, DATASET([{149, L.OVERALL_tree149_node, R[2].OVERALL_tree149_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree150_node != R[2].OVERALL_tree150_node, DATASET([{150, L.OVERALL_tree150_node, R[2].OVERALL_tree150_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree151_node != R[2].OVERALL_tree151_node, DATASET([{151, L.OVERALL_tree151_node, R[2].OVERALL_tree151_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree152_node != R[2].OVERALL_tree152_node, DATASET([{152, L.OVERALL_tree152_node, R[2].OVERALL_tree152_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree153_node != R[2].OVERALL_tree153_node, DATASET([{153, L.OVERALL_tree153_node, R[2].OVERALL_tree153_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree154_node != R[2].OVERALL_tree154_node, DATASET([{154, L.OVERALL_tree154_node, R[2].OVERALL_tree154_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree155_node != R[2].OVERALL_tree155_node, DATASET([{155, L.OVERALL_tree155_node, R[2].OVERALL_tree155_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree156_node != R[2].OVERALL_tree156_node, DATASET([{156, L.OVERALL_tree156_node, R[2].OVERALL_tree156_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree157_node != R[2].OVERALL_tree157_node, DATASET([{157, L.OVERALL_tree157_node, R[2].OVERALL_tree157_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree158_node != R[2].OVERALL_tree158_node, DATASET([{158, L.OVERALL_tree158_node, R[2].OVERALL_tree158_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree159_node != R[2].OVERALL_tree159_node, DATASET([{159, L.OVERALL_tree159_node, R[2].OVERALL_tree159_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree160_node != R[2].OVERALL_tree160_node, DATASET([{160, L.OVERALL_tree160_node, R[2].OVERALL_tree160_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree161_node != R[2].OVERALL_tree161_node, DATASET([{161, L.OVERALL_tree161_node, R[2].OVERALL_tree161_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree162_node != R[2].OVERALL_tree162_node, DATASET([{162, L.OVERALL_tree162_node, R[2].OVERALL_tree162_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree163_node != R[2].OVERALL_tree163_node, DATASET([{163, L.OVERALL_tree163_node, R[2].OVERALL_tree163_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree164_node != R[2].OVERALL_tree164_node, DATASET([{164, L.OVERALL_tree164_node, R[2].OVERALL_tree164_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree165_node != R[2].OVERALL_tree165_node, DATASET([{165, L.OVERALL_tree165_node, R[2].OVERALL_tree165_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree166_node != R[2].OVERALL_tree166_node, DATASET([{166, L.OVERALL_tree166_node, R[2].OVERALL_tree166_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree167_node != R[2].OVERALL_tree167_node, DATASET([{167, L.OVERALL_tree167_node, R[2].OVERALL_tree167_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree168_node != R[2].OVERALL_tree168_node, DATASET([{168, L.OVERALL_tree168_node, R[2].OVERALL_tree168_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree169_node != R[2].OVERALL_tree169_node, DATASET([{169, L.OVERALL_tree169_node, R[2].OVERALL_tree169_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree170_node != R[2].OVERALL_tree170_node, DATASET([{170, L.OVERALL_tree170_node, R[2].OVERALL_tree170_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree171_node != R[2].OVERALL_tree171_node, DATASET([{171, L.OVERALL_tree171_node, R[2].OVERALL_tree171_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree172_node != R[2].OVERALL_tree172_node, DATASET([{172, L.OVERALL_tree172_node, R[2].OVERALL_tree172_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree173_node != R[2].OVERALL_tree173_node, DATASET([{173, L.OVERALL_tree173_node, R[2].OVERALL_tree173_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree174_node != R[2].OVERALL_tree174_node, DATASET([{174, L.OVERALL_tree174_node, R[2].OVERALL_tree174_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree175_node != R[2].OVERALL_tree175_node, DATASET([{175, L.OVERALL_tree175_node, R[2].OVERALL_tree175_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree176_node != R[2].OVERALL_tree176_node, DATASET([{176, L.OVERALL_tree176_node, R[2].OVERALL_tree176_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree177_node != R[2].OVERALL_tree177_node, DATASET([{177, L.OVERALL_tree177_node, R[2].OVERALL_tree177_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree178_node != R[2].OVERALL_tree178_node, DATASET([{178, L.OVERALL_tree178_node, R[2].OVERALL_tree178_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree179_node != R[2].OVERALL_tree179_node, DATASET([{179, L.OVERALL_tree179_node, R[2].OVERALL_tree179_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree180_node != R[2].OVERALL_tree180_node, DATASET([{180, L.OVERALL_tree180_node, R[2].OVERALL_tree180_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree181_node != R[2].OVERALL_tree181_node, DATASET([{181, L.OVERALL_tree181_node, R[2].OVERALL_tree181_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree182_node != R[2].OVERALL_tree182_node, DATASET([{182, L.OVERALL_tree182_node, R[2].OVERALL_tree182_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree183_node != R[2].OVERALL_tree183_node, DATASET([{183, L.OVERALL_tree183_node, R[2].OVERALL_tree183_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree184_node != R[2].OVERALL_tree184_node, DATASET([{184, L.OVERALL_tree184_node, R[2].OVERALL_tree184_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree185_node != R[2].OVERALL_tree185_node, DATASET([{185, L.OVERALL_tree185_node, R[2].OVERALL_tree185_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree186_node != R[2].OVERALL_tree186_node, DATASET([{186, L.OVERALL_tree186_node, R[2].OVERALL_tree186_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree187_node != R[2].OVERALL_tree187_node, DATASET([{187, L.OVERALL_tree187_node, R[2].OVERALL_tree187_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree188_node != R[2].OVERALL_tree188_node, DATASET([{188, L.OVERALL_tree188_node, R[2].OVERALL_tree188_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree189_node != R[2].OVERALL_tree189_node, DATASET([{189, L.OVERALL_tree189_node, R[2].OVERALL_tree189_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree190_node != R[2].OVERALL_tree190_node, DATASET([{190, L.OVERALL_tree190_node, R[2].OVERALL_tree190_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree191_node != R[2].OVERALL_tree191_node, DATASET([{191, L.OVERALL_tree191_node, R[2].OVERALL_tree191_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree192_node != R[2].OVERALL_tree192_node, DATASET([{192, L.OVERALL_tree192_node, R[2].OVERALL_tree192_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree193_node != R[2].OVERALL_tree193_node, DATASET([{193, L.OVERALL_tree193_node, R[2].OVERALL_tree193_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree194_node != R[2].OVERALL_tree194_node, DATASET([{194, L.OVERALL_tree194_node, R[2].OVERALL_tree194_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree195_node != R[2].OVERALL_tree195_node, DATASET([{195, L.OVERALL_tree195_node, R[2].OVERALL_tree195_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree196_node != R[2].OVERALL_tree196_node, DATASET([{196, L.OVERALL_tree196_node, R[2].OVERALL_tree196_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree197_node != R[2].OVERALL_tree197_node, DATASET([{197, L.OVERALL_tree197_node, R[2].OVERALL_tree197_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree198_node != R[2].OVERALL_tree198_node, DATASET([{198, L.OVERALL_tree198_node, R[2].OVERALL_tree198_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree199_node != R[2].OVERALL_tree199_node, DATASET([{199, L.OVERALL_tree199_node, R[2].OVERALL_tree199_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree200_node != R[2].OVERALL_tree200_node, DATASET([{200, L.OVERALL_tree200_node, R[2].OVERALL_tree200_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree201_node != R[2].OVERALL_tree201_node, DATASET([{201, L.OVERALL_tree201_node, R[2].OVERALL_tree201_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree202_node != R[2].OVERALL_tree202_node, DATASET([{202, L.OVERALL_tree202_node, R[2].OVERALL_tree202_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree203_node != R[2].OVERALL_tree203_node, DATASET([{203, L.OVERALL_tree203_node, R[2].OVERALL_tree203_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree204_node != R[2].OVERALL_tree204_node, DATASET([{204, L.OVERALL_tree204_node, R[2].OVERALL_tree204_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree205_node != R[2].OVERALL_tree205_node, DATASET([{205, L.OVERALL_tree205_node, R[2].OVERALL_tree205_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree206_node != R[2].OVERALL_tree206_node, DATASET([{206, L.OVERALL_tree206_node, R[2].OVERALL_tree206_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree207_node != R[2].OVERALL_tree207_node, DATASET([{207, L.OVERALL_tree207_node, R[2].OVERALL_tree207_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree208_node != R[2].OVERALL_tree208_node, DATASET([{208, L.OVERALL_tree208_node, R[2].OVERALL_tree208_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree209_node != R[2].OVERALL_tree209_node, DATASET([{209, L.OVERALL_tree209_node, R[2].OVERALL_tree209_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree210_node != R[2].OVERALL_tree210_node, DATASET([{210, L.OVERALL_tree210_node, R[2].OVERALL_tree210_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree211_node != R[2].OVERALL_tree211_node, DATASET([{211, L.OVERALL_tree211_node, R[2].OVERALL_tree211_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree212_node != R[2].OVERALL_tree212_node, DATASET([{212, L.OVERALL_tree212_node, R[2].OVERALL_tree212_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree213_node != R[2].OVERALL_tree213_node, DATASET([{213, L.OVERALL_tree213_node, R[2].OVERALL_tree213_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree214_node != R[2].OVERALL_tree214_node, DATASET([{214, L.OVERALL_tree214_node, R[2].OVERALL_tree214_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree215_node != R[2].OVERALL_tree215_node, DATASET([{215, L.OVERALL_tree215_node, R[2].OVERALL_tree215_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree216_node != R[2].OVERALL_tree216_node, DATASET([{216, L.OVERALL_tree216_node, R[2].OVERALL_tree216_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree217_node != R[2].OVERALL_tree217_node, DATASET([{217, L.OVERALL_tree217_node, R[2].OVERALL_tree217_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree218_node != R[2].OVERALL_tree218_node, DATASET([{218, L.OVERALL_tree218_node, R[2].OVERALL_tree218_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree219_node != R[2].OVERALL_tree219_node, DATASET([{219, L.OVERALL_tree219_node, R[2].OVERALL_tree219_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree220_node != R[2].OVERALL_tree220_node, DATASET([{220, L.OVERALL_tree220_node, R[2].OVERALL_tree220_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree221_node != R[2].OVERALL_tree221_node, DATASET([{221, L.OVERALL_tree221_node, R[2].OVERALL_tree221_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree222_node != R[2].OVERALL_tree222_node, DATASET([{222, L.OVERALL_tree222_node, R[2].OVERALL_tree222_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree223_node != R[2].OVERALL_tree223_node, DATASET([{223, L.OVERALL_tree223_node, R[2].OVERALL_tree223_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree224_node != R[2].OVERALL_tree224_node, DATASET([{224, L.OVERALL_tree224_node, R[2].OVERALL_tree224_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree225_node != R[2].OVERALL_tree225_node, DATASET([{225, L.OVERALL_tree225_node, R[2].OVERALL_tree225_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree226_node != R[2].OVERALL_tree226_node, DATASET([{226, L.OVERALL_tree226_node, R[2].OVERALL_tree226_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree227_node != R[2].OVERALL_tree227_node, DATASET([{227, L.OVERALL_tree227_node, R[2].OVERALL_tree227_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree228_node != R[2].OVERALL_tree228_node, DATASET([{228, L.OVERALL_tree228_node, R[2].OVERALL_tree228_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree229_node != R[2].OVERALL_tree229_node, DATASET([{229, L.OVERALL_tree229_node, R[2].OVERALL_tree229_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree230_node != R[2].OVERALL_tree230_node, DATASET([{230, L.OVERALL_tree230_node, R[2].OVERALL_tree230_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree231_node != R[2].OVERALL_tree231_node, DATASET([{231, L.OVERALL_tree231_node, R[2].OVERALL_tree231_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree232_node != R[2].OVERALL_tree232_node, DATASET([{232, L.OVERALL_tree232_node, R[2].OVERALL_tree232_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree233_node != R[2].OVERALL_tree233_node, DATASET([{233, L.OVERALL_tree233_node, R[2].OVERALL_tree233_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree234_node != R[2].OVERALL_tree234_node, DATASET([{234, L.OVERALL_tree234_node, R[2].OVERALL_tree234_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree235_node != R[2].OVERALL_tree235_node, DATASET([{235, L.OVERALL_tree235_node, R[2].OVERALL_tree235_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree236_node != R[2].OVERALL_tree236_node, DATASET([{236, L.OVERALL_tree236_node, R[2].OVERALL_tree236_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree237_node != R[2].OVERALL_tree237_node, DATASET([{237, L.OVERALL_tree237_node, R[2].OVERALL_tree237_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree238_node != R[2].OVERALL_tree238_node, DATASET([{238, L.OVERALL_tree238_node, R[2].OVERALL_tree238_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree239_node != R[2].OVERALL_tree239_node, DATASET([{239, L.OVERALL_tree239_node, R[2].OVERALL_tree239_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree240_node != R[2].OVERALL_tree240_node, DATASET([{240, L.OVERALL_tree240_node, R[2].OVERALL_tree240_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree241_node != R[2].OVERALL_tree241_node, DATASET([{241, L.OVERALL_tree241_node, R[2].OVERALL_tree241_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree242_node != R[2].OVERALL_tree242_node, DATASET([{242, L.OVERALL_tree242_node, R[2].OVERALL_tree242_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree243_node != R[2].OVERALL_tree243_node, DATASET([{243, L.OVERALL_tree243_node, R[2].OVERALL_tree243_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree244_node != R[2].OVERALL_tree244_node, DATASET([{244, L.OVERALL_tree244_node, R[2].OVERALL_tree244_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree245_node != R[2].OVERALL_tree245_node, DATASET([{245, L.OVERALL_tree245_node, R[2].OVERALL_tree245_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree246_node != R[2].OVERALL_tree246_node, DATASET([{246, L.OVERALL_tree246_node, R[2].OVERALL_tree246_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree247_node != R[2].OVERALL_tree247_node, DATASET([{247, L.OVERALL_tree247_node, R[2].OVERALL_tree247_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree248_node != R[2].OVERALL_tree248_node, DATASET([{248, L.OVERALL_tree248_node, R[2].OVERALL_tree248_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree249_node != R[2].OVERALL_tree249_node, DATASET([{249, L.OVERALL_tree249_node, R[2].OVERALL_tree249_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree250_node != R[2].OVERALL_tree250_node, DATASET([{250, L.OVERALL_tree250_node, R[2].OVERALL_tree250_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree251_node != R[2].OVERALL_tree251_node, DATASET([{251, L.OVERALL_tree251_node, R[2].OVERALL_tree251_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree252_node != R[2].OVERALL_tree252_node, DATASET([{252, L.OVERALL_tree252_node, R[2].OVERALL_tree252_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree253_node != R[2].OVERALL_tree253_node, DATASET([{253, L.OVERALL_tree253_node, R[2].OVERALL_tree253_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree254_node != R[2].OVERALL_tree254_node, DATASET([{254, L.OVERALL_tree254_node, R[2].OVERALL_tree254_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree255_node != R[2].OVERALL_tree255_node, DATASET([{255, L.OVERALL_tree255_node, R[2].OVERALL_tree255_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree256_node != R[2].OVERALL_tree256_node, DATASET([{256, L.OVERALL_tree256_node, R[2].OVERALL_tree256_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree257_node != R[2].OVERALL_tree257_node, DATASET([{257, L.OVERALL_tree257_node, R[2].OVERALL_tree257_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree258_node != R[2].OVERALL_tree258_node, DATASET([{258, L.OVERALL_tree258_node, R[2].OVERALL_tree258_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree259_node != R[2].OVERALL_tree259_node, DATASET([{259, L.OVERALL_tree259_node, R[2].OVERALL_tree259_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree260_node != R[2].OVERALL_tree260_node, DATASET([{260, L.OVERALL_tree260_node, R[2].OVERALL_tree260_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree261_node != R[2].OVERALL_tree261_node, DATASET([{261, L.OVERALL_tree261_node, R[2].OVERALL_tree261_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree262_node != R[2].OVERALL_tree262_node, DATASET([{262, L.OVERALL_tree262_node, R[2].OVERALL_tree262_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree263_node != R[2].OVERALL_tree263_node, DATASET([{263, L.OVERALL_tree263_node, R[2].OVERALL_tree263_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree264_node != R[2].OVERALL_tree264_node, DATASET([{264, L.OVERALL_tree264_node, R[2].OVERALL_tree264_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree265_node != R[2].OVERALL_tree265_node, DATASET([{265, L.OVERALL_tree265_node, R[2].OVERALL_tree265_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree266_node != R[2].OVERALL_tree266_node, DATASET([{266, L.OVERALL_tree266_node, R[2].OVERALL_tree266_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree267_node != R[2].OVERALL_tree267_node, DATASET([{267, L.OVERALL_tree267_node, R[2].OVERALL_tree267_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree268_node != R[2].OVERALL_tree268_node, DATASET([{268, L.OVERALL_tree268_node, R[2].OVERALL_tree268_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree269_node != R[2].OVERALL_tree269_node, DATASET([{269, L.OVERALL_tree269_node, R[2].OVERALL_tree269_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree270_node != R[2].OVERALL_tree270_node, DATASET([{270, L.OVERALL_tree270_node, R[2].OVERALL_tree270_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree271_node != R[2].OVERALL_tree271_node, DATASET([{271, L.OVERALL_tree271_node, R[2].OVERALL_tree271_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree272_node != R[2].OVERALL_tree272_node, DATASET([{272, L.OVERALL_tree272_node, R[2].OVERALL_tree272_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree273_node != R[2].OVERALL_tree273_node, DATASET([{273, L.OVERALL_tree273_node, R[2].OVERALL_tree273_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree274_node != R[2].OVERALL_tree274_node, DATASET([{274, L.OVERALL_tree274_node, R[2].OVERALL_tree274_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree275_node != R[2].OVERALL_tree275_node, DATASET([{275, L.OVERALL_tree275_node, R[2].OVERALL_tree275_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree276_node != R[2].OVERALL_tree276_node, DATASET([{276, L.OVERALL_tree276_node, R[2].OVERALL_tree276_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree277_node != R[2].OVERALL_tree277_node, DATASET([{277, L.OVERALL_tree277_node, R[2].OVERALL_tree277_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree278_node != R[2].OVERALL_tree278_node, DATASET([{278, L.OVERALL_tree278_node, R[2].OVERALL_tree278_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree279_node != R[2].OVERALL_tree279_node, DATASET([{279, L.OVERALL_tree279_node, R[2].OVERALL_tree279_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree280_node != R[2].OVERALL_tree280_node, DATASET([{280, L.OVERALL_tree280_node, R[2].OVERALL_tree280_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree281_node != R[2].OVERALL_tree281_node, DATASET([{281, L.OVERALL_tree281_node, R[2].OVERALL_tree281_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree282_node != R[2].OVERALL_tree282_node, DATASET([{282, L.OVERALL_tree282_node, R[2].OVERALL_tree282_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree283_node != R[2].OVERALL_tree283_node, DATASET([{283, L.OVERALL_tree283_node, R[2].OVERALL_tree283_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree284_node != R[2].OVERALL_tree284_node, DATASET([{284, L.OVERALL_tree284_node, R[2].OVERALL_tree284_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree285_node != R[2].OVERALL_tree285_node, DATASET([{285, L.OVERALL_tree285_node, R[2].OVERALL_tree285_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree286_node != R[2].OVERALL_tree286_node, DATASET([{286, L.OVERALL_tree286_node, R[2].OVERALL_tree286_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree287_node != R[2].OVERALL_tree287_node, DATASET([{287, L.OVERALL_tree287_node, R[2].OVERALL_tree287_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree288_node != R[2].OVERALL_tree288_node, DATASET([{288, L.OVERALL_tree288_node, R[2].OVERALL_tree288_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree289_node != R[2].OVERALL_tree289_node, DATASET([{289, L.OVERALL_tree289_node, R[2].OVERALL_tree289_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree290_node != R[2].OVERALL_tree290_node, DATASET([{290, L.OVERALL_tree290_node, R[2].OVERALL_tree290_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree291_node != R[2].OVERALL_tree291_node, DATASET([{291, L.OVERALL_tree291_node, R[2].OVERALL_tree291_node}], TerminalNodeCompPerTreeLayout));
    END;

    EXPORT tnMismatches_sc := ROLLUP(DS_Comp_sc_grp, GROUP, doRollUp(LEFT,ROWS(LEFT)));
    EXPORT OutTNMismatchesSC := OUTPUT(CHOOSEN(tnMismatches_sc,100),,NAMED('terminal_node_mismatches_sc'));

    SHARED TerminalNodeMismatchesLayoutFlat := RECORD
    	STRING TransactionID;
    	TerminalNodeCompPerTreeLayout;
    END;

    SHARED TerminalNodeMismatchesLayoutFlat flattenTNMismatch(TerminalNodeMismatchesLayout L, INTEGER C) := TRANSFORM
    	SELF.TransactionID := L.TransactionID;
    	SELF.treeNo := L.TerminalNodeMismatches[C].treeNo;
    	SELF.expectedNode := L.TerminalNodeMismatches[C].expectedNode;
    	SELF.actualNode := L.TerminalNodeMismatches[C].actualNode;
    END;

    EXPORT tnMismatches_sc_full := NORMALIZE(tnMismatches_sc,COUNT(LEFT.TerminalNodeMismatches),flattenTNMismatch(LEFT,COUNTER));


    /******************************************************************************\
    |*******************Step4 - Get Validation File for Auditing*******************|
    \******************************************************************************/
    Layouts.AuditLayouts xGetLUCIAuditFile(LUCI_Points_Assignments_Pre L) := TRANSFORM
        //Scores
        SELF.rawscore:= L.PhoneModel_v31_2_OVERALL_Score0;
        SELF.predscr:= (700 + 50 * ((SELF.rawscore - 0.0 - -1.074512) / LN(2)));
        SELF.finalscore := L.PhoneModel_v31_2_Score;
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
    DesprayAuditResult := PhoneModel_v31_2.FNDesprayCSV(LUCI_AuditResult, TempLogical('~LUCI::AuditFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_AuditFile'));
    DesprayComparision := PhoneModel_v31_2.FNDesprayCSV(DS_Comp, TempLogical('~LUCI::ComparisonFile:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ComparisonFile'));
    DesprayMismatches_SC := PhoneModel_v31_2.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_sc), TempLogical('~LUCI::Mismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_SC'));
    DesprayTNMismatches_SC := PhoneModel_v31_2.FNDesprayCSV(tnMismatches_sc_full, TempLogical('~LUCI::TerminalNodeMismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_TNMismatches_SC'));
    EXPORT desprayOutputs := SEQUENTIAL(DesprayAuditResult
                                     ,DesprayComparision
                                     ,DesprayMismatches_SC
                                     ,DesprayTNMismatches_SC
);
    #END

    EXPORT runValidation := SEQUENTIAL(
                                    #IF(~preSprayed) inputFileSprayed, #END
                                    OutInputSet
                                    ,OutStdInputSet
                                    ,OutLUCIResults
                                    ,OutCheckResult
                                    ,OutCheckResultStats
                                    ,OutScoreDiffPercStats
                                    ,OutSCMismatches
                                    ,OutSCMismatchesDetails
                                    ,OutAuditComparison
                                    ,OutTNMismatchesSC
                                    ,OutLUCIResultsAudit
                                    #IF(deSpray) ,desprayOutputs #END);
 END;
 RETURN Validate_Model;
ENDMACRO;
