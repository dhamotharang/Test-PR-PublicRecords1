IMPORT UT,STD,Models;
IMPORT Models.RVG2005_0_1;
IMPORT Models.RVG2005_0_1 AS LUCI_Model;
SHARED Constants := Models.RVG2005_0_1.Constants;
SHARED Layouts := Models.RVG2005_0_1.z_layouts;
SHARED FNValidation := Models.RVG2005_0_1.FNValidationWithRC;
// SHARED FNValidation := RVG2005_0_1.FNValidationWORC;
SHARED SampleSize := 1000; // The number of mismatches provided for review
SHARED LandingZoneIP  := Constants.LandingZoneIP; // Will set up by user.
/******************************************************************************\
|**************************Step 0 - Spray Input File***************************|
\******************************************************************************/
SHARED ModelName := 'RVG2005_0_1';
SHARED lzFilePathFolder  := '/data/LUCI/RVG2005_0_1/';
SHARED CSVSprayFile := '~fallen::in::stl-model-validation-vfinal.csv';
SHARED lzFilePath        := lzFilePathFolder + CSVSprayFile;
SHARED SprayCSVName      := '~fallen::in::stl-model-validation-vfinal.csv'; // Will set up by user if test file is a logical file.
SHARED CSVSpraySeparator := ','; // Will set up by user.
SHARED CSVSprayQuote     := '\"'; // Will set up by user.
SHARED HeaderLine := 1; // Will set up by user.
SHARED isCSVFile := TRUE;
  //RVG2005_0_1.FNSpray(LandingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
/******************************************************************************\
|**************************Step 1a - Load Input File***************************|
\******************************************************************************/
  FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, HeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote);
SHARED RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVG2005_0_1 := TRUE, SELF := LEFT));

/******************************************************************************\
|**********************Step 1b - Standardized Input File***********************|
\******************************************************************************/
  FNValidation.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile,,, 5);
SHARED pLUCIresults := LUCI_Model.AsResults(RawInputSet);
SHARED LUCIresults  := DISTRIBUTE(pLUCIresults.Validation(), hash32(TransactionID));
OUTPUT(LUCIresults, NAMED('LUCIresults'));

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
    //Scores
    SELF.rawscore:= L.RVG2005_0_1_OVERALL_Score0;
    SELF.predscr:= (600 + -50 * ((SELF.rawscore - LN(((1 - 0.2794912) * 0.2794912) / (0.2794912 * (1 - 0.2794912))) - -0.9469868) / LN(2)));
    SELF.finalscore := L.RVG2005_0_1_Score;
    SELF.SOURCE := 'HPCC';
    SELF.stdrawscore  := (string)L.RVG2005_0_1_OVERALL_Score0;
    SELF.std_scr := (string)L.RVG2005_0_1_Score;
	//Reason Codes
    SELF.STD_RC := L.RVG2005_0_1_Reasons;
    SELF.ReasonCode1 := L.RVG2005_0_1_Reasons[1];
    SELF.ReasonCode2 := L.RVG2005_0_1_Reasons[2];
    SELF.ReasonCode3 := L.RVG2005_0_1_Reasons[3];
    SELF.ReasonCode4 := L.RVG2005_0_1_Reasons[4];
    SELF.ReasonCode5 := L.RVG2005_0_1_Reasons[5];

    SELF := L;
    SELF := [];
  END;
  SHARED LUCI_Points_Assignments :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIPointsAssignments(LEFT));
  SHARED DS_Comp_pre := SORT(LUCI_Points_Assignments + StdFile, TransactionID, -SOURCE);
  SHARED DS_Comp := PROJECT(DS_Comp_pre, Layouts.StandLayouts);
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
    UNSIGNED OVERALL_tree292_node;
    UNSIGNED OVERALL_tree293_node;
    UNSIGNED OVERALL_tree294_node;
    UNSIGNED OVERALL_tree295_node;
    UNSIGNED OVERALL_tree296_node;
    UNSIGNED OVERALL_tree297_node;
    UNSIGNED OVERALL_tree298_node;
    UNSIGNED OVERALL_tree299_node;
    UNSIGNED OVERALL_tree300_node;
    UNSIGNED OVERALL_tree301_node;
    UNSIGNED OVERALL_tree302_node;
    UNSIGNED OVERALL_tree303_node;
    UNSIGNED OVERALL_tree304_node;
    UNSIGNED OVERALL_tree305_node;
    UNSIGNED OVERALL_tree306_node;
    UNSIGNED OVERALL_tree307_node;
    UNSIGNED OVERALL_tree308_node;
    UNSIGNED OVERALL_tree309_node;
    UNSIGNED OVERALL_tree310_node;
    UNSIGNED OVERALL_tree311_node;
    UNSIGNED OVERALL_tree312_node;
    UNSIGNED OVERALL_tree313_node;
    UNSIGNED OVERALL_tree314_node;
    UNSIGNED OVERALL_tree315_node;
    UNSIGNED OVERALL_tree316_node;
    UNSIGNED OVERALL_tree317_node;
    UNSIGNED OVERALL_tree318_node;
    UNSIGNED OVERALL_tree319_node;
    UNSIGNED OVERALL_tree320_node;
    UNSIGNED OVERALL_tree321_node;
    UNSIGNED OVERALL_tree322_node;
    UNSIGNED OVERALL_tree323_node;
    UNSIGNED OVERALL_tree324_node;
    UNSIGNED OVERALL_tree325_node;
    UNSIGNED OVERALL_tree326_node;
    UNSIGNED OVERALL_tree327_node;
    UNSIGNED OVERALL_tree328_node;
    UNSIGNED OVERALL_tree329_node;
    UNSIGNED OVERALL_tree330_node;
    UNSIGNED OVERALL_tree331_node;
    UNSIGNED OVERALL_tree332_node;
    UNSIGNED OVERALL_tree333_node;
    UNSIGNED OVERALL_tree334_node;
    UNSIGNED OVERALL_tree335_node;
    UNSIGNED OVERALL_tree336_node;
    UNSIGNED OVERALL_tree337_node;
    UNSIGNED OVERALL_tree338_node;
    UNSIGNED OVERALL_tree339_node;
    UNSIGNED OVERALL_tree340_node;
    UNSIGNED OVERALL_tree341_node;
    UNSIGNED OVERALL_tree342_node;
    UNSIGNED OVERALL_tree343_node;
    UNSIGNED OVERALL_tree344_node;
    UNSIGNED OVERALL_tree345_node;
    UNSIGNED OVERALL_tree346_node;
    UNSIGNED OVERALL_tree347_node;
    UNSIGNED OVERALL_tree348_node;
    UNSIGNED OVERALL_tree349_node;
    UNSIGNED OVERALL_tree350_node;
    UNSIGNED OVERALL_tree351_node;
    UNSIGNED OVERALL_tree352_node;
    UNSIGNED OVERALL_tree353_node;
    UNSIGNED OVERALL_tree354_node;
    UNSIGNED OVERALL_tree355_node;
    UNSIGNED OVERALL_tree356_node;
    UNSIGNED OVERALL_tree357_node;
    UNSIGNED OVERALL_tree358_node;
    UNSIGNED OVERALL_tree359_node;
    UNSIGNED OVERALL_tree360_node;
    UNSIGNED OVERALL_tree361_node;
    UNSIGNED OVERALL_tree362_node;
    UNSIGNED OVERALL_tree363_node;
    UNSIGNED OVERALL_tree364_node;
    UNSIGNED OVERALL_tree365_node;
    UNSIGNED OVERALL_tree366_node;
    UNSIGNED OVERALL_tree367_node;
    UNSIGNED OVERALL_tree368_node;
    UNSIGNED OVERALL_tree369_node;
    UNSIGNED OVERALL_tree370_node;
    UNSIGNED OVERALL_tree371_node;
    UNSIGNED OVERALL_tree372_node;
    UNSIGNED OVERALL_tree373_node;
    UNSIGNED OVERALL_tree374_node;
    UNSIGNED OVERALL_tree375_node;
    UNSIGNED OVERALL_tree376_node;
    UNSIGNED OVERALL_tree377_node;
    UNSIGNED OVERALL_tree378_node;
    UNSIGNED OVERALL_tree379_node;
    UNSIGNED OVERALL_tree380_node;
    UNSIGNED OVERALL_tree381_node;
    UNSIGNED OVERALL_tree382_node;
    UNSIGNED OVERALL_tree383_node;
    UNSIGNED OVERALL_tree384_node;
    UNSIGNED OVERALL_tree385_node;
    UNSIGNED OVERALL_tree386_node;
    UNSIGNED OVERALL_tree387_node;
    UNSIGNED OVERALL_tree388_node;
    UNSIGNED OVERALL_tree389_node;
    UNSIGNED OVERALL_tree390_node;
    UNSIGNED OVERALL_tree391_node;
    UNSIGNED OVERALL_tree392_node;
    UNSIGNED OVERALL_tree393_node;
    UNSIGNED OVERALL_tree394_node;
    UNSIGNED OVERALL_tree395_node;

  END;
  StandLayoutsLimited := Layouts.StandLayouts - TerminalNodesLayout;
  SHARED DS_Comp_out := PROJECT(DS_Comp, StandLayoutsLimited);
  OUTPUT(DS_Comp_out(TransactionID in mismatch_list_rc),,NAMED('rc_mismatches_details'));
  OUTPUT(DS_Comp_out(TransactionID in mismatch_list_sc),,NAMED('sc_mismatches_details'));
  OUTPUT(DS_Comp_out,,NAMED('AuditComparison'));

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

SHARED DS_Comp_rc_grp := GROUP(DS_Comp(TransactionID in mismatch_list_rc),TransactionID);
SHARED DS_Comp_sc_grp := GROUP(DS_Comp(TransactionID in mismatch_list_sc),TransactionID);

SHARED TerminalNodeMismatchesLayout doRollUp(Layouts.StandLayouts L, DATASET(Layouts.StandLayouts) R) := TRANSFORM
	SELF.TransactionID := L.TransactionID;
	SELF.TerminalNodeMismatches := IF(L.OVERALL_tree1_node != R[2].OVERALL_tree1_node, DATASET([{1, L.OVERALL_tree1_node, R[2].OVERALL_tree1_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree2_node != R[2].OVERALL_tree2_node, DATASET([{2, L.OVERALL_tree2_node, R[2].OVERALL_tree2_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree3_node != R[2].OVERALL_tree3_node, DATASET([{3, L.OVERALL_tree3_node, R[2].OVERALL_tree3_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree4_node != R[2].OVERALL_tree4_node, DATASET([{4, L.OVERALL_tree4_node, R[2].OVERALL_tree4_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree5_node != R[2].OVERALL_tree5_node, DATASET([{5, L.OVERALL_tree5_node, R[2].OVERALL_tree5_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree6_node != R[2].OVERALL_tree6_node, DATASET([{6, L.OVERALL_tree6_node, R[2].OVERALL_tree6_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree7_node != R[2].OVERALL_tree7_node, DATASET([{7, L.OVERALL_tree7_node, R[2].OVERALL_tree7_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree8_node != R[2].OVERALL_tree8_node, DATASET([{8, L.OVERALL_tree8_node, R[2].OVERALL_tree8_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree9_node != R[2].OVERALL_tree9_node, DATASET([{9, L.OVERALL_tree9_node, R[2].OVERALL_tree9_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree10_node != R[2].OVERALL_tree10_node, DATASET([{10, L.OVERALL_tree10_node, R[2].OVERALL_tree10_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree11_node != R[2].OVERALL_tree11_node, DATASET([{11, L.OVERALL_tree11_node, R[2].OVERALL_tree11_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree12_node != R[2].OVERALL_tree12_node, DATASET([{12, L.OVERALL_tree12_node, R[2].OVERALL_tree12_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree13_node != R[2].OVERALL_tree13_node, DATASET([{13, L.OVERALL_tree13_node, R[2].OVERALL_tree13_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree14_node != R[2].OVERALL_tree14_node, DATASET([{14, L.OVERALL_tree14_node, R[2].OVERALL_tree14_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree15_node != R[2].OVERALL_tree15_node, DATASET([{15, L.OVERALL_tree15_node, R[2].OVERALL_tree15_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree16_node != R[2].OVERALL_tree16_node, DATASET([{16, L.OVERALL_tree16_node, R[2].OVERALL_tree16_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree17_node != R[2].OVERALL_tree17_node, DATASET([{17, L.OVERALL_tree17_node, R[2].OVERALL_tree17_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree18_node != R[2].OVERALL_tree18_node, DATASET([{18, L.OVERALL_tree18_node, R[2].OVERALL_tree18_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree19_node != R[2].OVERALL_tree19_node, DATASET([{19, L.OVERALL_tree19_node, R[2].OVERALL_tree19_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree20_node != R[2].OVERALL_tree20_node, DATASET([{20, L.OVERALL_tree20_node, R[2].OVERALL_tree20_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree21_node != R[2].OVERALL_tree21_node, DATASET([{21, L.OVERALL_tree21_node, R[2].OVERALL_tree21_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree22_node != R[2].OVERALL_tree22_node, DATASET([{22, L.OVERALL_tree22_node, R[2].OVERALL_tree22_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree23_node != R[2].OVERALL_tree23_node, DATASET([{23, L.OVERALL_tree23_node, R[2].OVERALL_tree23_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree24_node != R[2].OVERALL_tree24_node, DATASET([{24, L.OVERALL_tree24_node, R[2].OVERALL_tree24_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree25_node != R[2].OVERALL_tree25_node, DATASET([{25, L.OVERALL_tree25_node, R[2].OVERALL_tree25_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree26_node != R[2].OVERALL_tree26_node, DATASET([{26, L.OVERALL_tree26_node, R[2].OVERALL_tree26_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree27_node != R[2].OVERALL_tree27_node, DATASET([{27, L.OVERALL_tree27_node, R[2].OVERALL_tree27_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree28_node != R[2].OVERALL_tree28_node, DATASET([{28, L.OVERALL_tree28_node, R[2].OVERALL_tree28_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree29_node != R[2].OVERALL_tree29_node, DATASET([{29, L.OVERALL_tree29_node, R[2].OVERALL_tree29_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree30_node != R[2].OVERALL_tree30_node, DATASET([{30, L.OVERALL_tree30_node, R[2].OVERALL_tree30_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree31_node != R[2].OVERALL_tree31_node, DATASET([{31, L.OVERALL_tree31_node, R[2].OVERALL_tree31_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree32_node != R[2].OVERALL_tree32_node, DATASET([{32, L.OVERALL_tree32_node, R[2].OVERALL_tree32_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree33_node != R[2].OVERALL_tree33_node, DATASET([{33, L.OVERALL_tree33_node, R[2].OVERALL_tree33_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree34_node != R[2].OVERALL_tree34_node, DATASET([{34, L.OVERALL_tree34_node, R[2].OVERALL_tree34_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree35_node != R[2].OVERALL_tree35_node, DATASET([{35, L.OVERALL_tree35_node, R[2].OVERALL_tree35_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree36_node != R[2].OVERALL_tree36_node, DATASET([{36, L.OVERALL_tree36_node, R[2].OVERALL_tree36_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree37_node != R[2].OVERALL_tree37_node, DATASET([{37, L.OVERALL_tree37_node, R[2].OVERALL_tree37_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree38_node != R[2].OVERALL_tree38_node, DATASET([{38, L.OVERALL_tree38_node, R[2].OVERALL_tree38_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree39_node != R[2].OVERALL_tree39_node, DATASET([{39, L.OVERALL_tree39_node, R[2].OVERALL_tree39_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree40_node != R[2].OVERALL_tree40_node, DATASET([{40, L.OVERALL_tree40_node, R[2].OVERALL_tree40_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree41_node != R[2].OVERALL_tree41_node, DATASET([{41, L.OVERALL_tree41_node, R[2].OVERALL_tree41_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree42_node != R[2].OVERALL_tree42_node, DATASET([{42, L.OVERALL_tree42_node, R[2].OVERALL_tree42_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree43_node != R[2].OVERALL_tree43_node, DATASET([{43, L.OVERALL_tree43_node, R[2].OVERALL_tree43_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree44_node != R[2].OVERALL_tree44_node, DATASET([{44, L.OVERALL_tree44_node, R[2].OVERALL_tree44_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree45_node != R[2].OVERALL_tree45_node, DATASET([{45, L.OVERALL_tree45_node, R[2].OVERALL_tree45_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree46_node != R[2].OVERALL_tree46_node, DATASET([{46, L.OVERALL_tree46_node, R[2].OVERALL_tree46_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree47_node != R[2].OVERALL_tree47_node, DATASET([{47, L.OVERALL_tree47_node, R[2].OVERALL_tree47_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree48_node != R[2].OVERALL_tree48_node, DATASET([{48, L.OVERALL_tree48_node, R[2].OVERALL_tree48_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree49_node != R[2].OVERALL_tree49_node, DATASET([{49, L.OVERALL_tree49_node, R[2].OVERALL_tree49_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree50_node != R[2].OVERALL_tree50_node, DATASET([{50, L.OVERALL_tree50_node, R[2].OVERALL_tree50_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree51_node != R[2].OVERALL_tree51_node, DATASET([{51, L.OVERALL_tree51_node, R[2].OVERALL_tree51_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree52_node != R[2].OVERALL_tree52_node, DATASET([{52, L.OVERALL_tree52_node, R[2].OVERALL_tree52_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree53_node != R[2].OVERALL_tree53_node, DATASET([{53, L.OVERALL_tree53_node, R[2].OVERALL_tree53_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree54_node != R[2].OVERALL_tree54_node, DATASET([{54, L.OVERALL_tree54_node, R[2].OVERALL_tree54_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree55_node != R[2].OVERALL_tree55_node, DATASET([{55, L.OVERALL_tree55_node, R[2].OVERALL_tree55_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree56_node != R[2].OVERALL_tree56_node, DATASET([{56, L.OVERALL_tree56_node, R[2].OVERALL_tree56_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree57_node != R[2].OVERALL_tree57_node, DATASET([{57, L.OVERALL_tree57_node, R[2].OVERALL_tree57_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree58_node != R[2].OVERALL_tree58_node, DATASET([{58, L.OVERALL_tree58_node, R[2].OVERALL_tree58_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree59_node != R[2].OVERALL_tree59_node, DATASET([{59, L.OVERALL_tree59_node, R[2].OVERALL_tree59_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree60_node != R[2].OVERALL_tree60_node, DATASET([{60, L.OVERALL_tree60_node, R[2].OVERALL_tree60_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree61_node != R[2].OVERALL_tree61_node, DATASET([{61, L.OVERALL_tree61_node, R[2].OVERALL_tree61_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree62_node != R[2].OVERALL_tree62_node, DATASET([{62, L.OVERALL_tree62_node, R[2].OVERALL_tree62_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree63_node != R[2].OVERALL_tree63_node, DATASET([{63, L.OVERALL_tree63_node, R[2].OVERALL_tree63_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree64_node != R[2].OVERALL_tree64_node, DATASET([{64, L.OVERALL_tree64_node, R[2].OVERALL_tree64_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree65_node != R[2].OVERALL_tree65_node, DATASET([{65, L.OVERALL_tree65_node, R[2].OVERALL_tree65_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree66_node != R[2].OVERALL_tree66_node, DATASET([{66, L.OVERALL_tree66_node, R[2].OVERALL_tree66_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree67_node != R[2].OVERALL_tree67_node, DATASET([{67, L.OVERALL_tree67_node, R[2].OVERALL_tree67_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree68_node != R[2].OVERALL_tree68_node, DATASET([{68, L.OVERALL_tree68_node, R[2].OVERALL_tree68_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree69_node != R[2].OVERALL_tree69_node, DATASET([{69, L.OVERALL_tree69_node, R[2].OVERALL_tree69_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree70_node != R[2].OVERALL_tree70_node, DATASET([{70, L.OVERALL_tree70_node, R[2].OVERALL_tree70_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree71_node != R[2].OVERALL_tree71_node, DATASET([{71, L.OVERALL_tree71_node, R[2].OVERALL_tree71_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree72_node != R[2].OVERALL_tree72_node, DATASET([{72, L.OVERALL_tree72_node, R[2].OVERALL_tree72_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree73_node != R[2].OVERALL_tree73_node, DATASET([{73, L.OVERALL_tree73_node, R[2].OVERALL_tree73_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree74_node != R[2].OVERALL_tree74_node, DATASET([{74, L.OVERALL_tree74_node, R[2].OVERALL_tree74_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree75_node != R[2].OVERALL_tree75_node, DATASET([{75, L.OVERALL_tree75_node, R[2].OVERALL_tree75_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree76_node != R[2].OVERALL_tree76_node, DATASET([{76, L.OVERALL_tree76_node, R[2].OVERALL_tree76_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree77_node != R[2].OVERALL_tree77_node, DATASET([{77, L.OVERALL_tree77_node, R[2].OVERALL_tree77_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree78_node != R[2].OVERALL_tree78_node, DATASET([{78, L.OVERALL_tree78_node, R[2].OVERALL_tree78_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree79_node != R[2].OVERALL_tree79_node, DATASET([{79, L.OVERALL_tree79_node, R[2].OVERALL_tree79_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree80_node != R[2].OVERALL_tree80_node, DATASET([{80, L.OVERALL_tree80_node, R[2].OVERALL_tree80_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree81_node != R[2].OVERALL_tree81_node, DATASET([{81, L.OVERALL_tree81_node, R[2].OVERALL_tree81_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree82_node != R[2].OVERALL_tree82_node, DATASET([{82, L.OVERALL_tree82_node, R[2].OVERALL_tree82_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree83_node != R[2].OVERALL_tree83_node, DATASET([{83, L.OVERALL_tree83_node, R[2].OVERALL_tree83_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree84_node != R[2].OVERALL_tree84_node, DATASET([{84, L.OVERALL_tree84_node, R[2].OVERALL_tree84_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree85_node != R[2].OVERALL_tree85_node, DATASET([{85, L.OVERALL_tree85_node, R[2].OVERALL_tree85_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree86_node != R[2].OVERALL_tree86_node, DATASET([{86, L.OVERALL_tree86_node, R[2].OVERALL_tree86_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree87_node != R[2].OVERALL_tree87_node, DATASET([{87, L.OVERALL_tree87_node, R[2].OVERALL_tree87_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree88_node != R[2].OVERALL_tree88_node, DATASET([{88, L.OVERALL_tree88_node, R[2].OVERALL_tree88_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree89_node != R[2].OVERALL_tree89_node, DATASET([{89, L.OVERALL_tree89_node, R[2].OVERALL_tree89_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree90_node != R[2].OVERALL_tree90_node, DATASET([{90, L.OVERALL_tree90_node, R[2].OVERALL_tree90_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree91_node != R[2].OVERALL_tree91_node, DATASET([{91, L.OVERALL_tree91_node, R[2].OVERALL_tree91_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree92_node != R[2].OVERALL_tree92_node, DATASET([{92, L.OVERALL_tree92_node, R[2].OVERALL_tree92_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree93_node != R[2].OVERALL_tree93_node, DATASET([{93, L.OVERALL_tree93_node, R[2].OVERALL_tree93_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree94_node != R[2].OVERALL_tree94_node, DATASET([{94, L.OVERALL_tree94_node, R[2].OVERALL_tree94_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree95_node != R[2].OVERALL_tree95_node, DATASET([{95, L.OVERALL_tree95_node, R[2].OVERALL_tree95_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree96_node != R[2].OVERALL_tree96_node, DATASET([{96, L.OVERALL_tree96_node, R[2].OVERALL_tree96_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree97_node != R[2].OVERALL_tree97_node, DATASET([{97, L.OVERALL_tree97_node, R[2].OVERALL_tree97_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree98_node != R[2].OVERALL_tree98_node, DATASET([{98, L.OVERALL_tree98_node, R[2].OVERALL_tree98_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree99_node != R[2].OVERALL_tree99_node, DATASET([{99, L.OVERALL_tree99_node, R[2].OVERALL_tree99_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree100_node != R[2].OVERALL_tree100_node, DATASET([{100, L.OVERALL_tree100_node, R[2].OVERALL_tree100_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree101_node != R[2].OVERALL_tree101_node, DATASET([{101, L.OVERALL_tree101_node, R[2].OVERALL_tree101_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree102_node != R[2].OVERALL_tree102_node, DATASET([{102, L.OVERALL_tree102_node, R[2].OVERALL_tree102_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree103_node != R[2].OVERALL_tree103_node, DATASET([{103, L.OVERALL_tree103_node, R[2].OVERALL_tree103_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree104_node != R[2].OVERALL_tree104_node, DATASET([{104, L.OVERALL_tree104_node, R[2].OVERALL_tree104_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree105_node != R[2].OVERALL_tree105_node, DATASET([{105, L.OVERALL_tree105_node, R[2].OVERALL_tree105_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree106_node != R[2].OVERALL_tree106_node, DATASET([{106, L.OVERALL_tree106_node, R[2].OVERALL_tree106_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree107_node != R[2].OVERALL_tree107_node, DATASET([{107, L.OVERALL_tree107_node, R[2].OVERALL_tree107_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree108_node != R[2].OVERALL_tree108_node, DATASET([{108, L.OVERALL_tree108_node, R[2].OVERALL_tree108_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree109_node != R[2].OVERALL_tree109_node, DATASET([{109, L.OVERALL_tree109_node, R[2].OVERALL_tree109_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree110_node != R[2].OVERALL_tree110_node, DATASET([{110, L.OVERALL_tree110_node, R[2].OVERALL_tree110_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree111_node != R[2].OVERALL_tree111_node, DATASET([{111, L.OVERALL_tree111_node, R[2].OVERALL_tree111_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree112_node != R[2].OVERALL_tree112_node, DATASET([{112, L.OVERALL_tree112_node, R[2].OVERALL_tree112_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree113_node != R[2].OVERALL_tree113_node, DATASET([{113, L.OVERALL_tree113_node, R[2].OVERALL_tree113_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree114_node != R[2].OVERALL_tree114_node, DATASET([{114, L.OVERALL_tree114_node, R[2].OVERALL_tree114_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree115_node != R[2].OVERALL_tree115_node, DATASET([{115, L.OVERALL_tree115_node, R[2].OVERALL_tree115_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree116_node != R[2].OVERALL_tree116_node, DATASET([{116, L.OVERALL_tree116_node, R[2].OVERALL_tree116_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree117_node != R[2].OVERALL_tree117_node, DATASET([{117, L.OVERALL_tree117_node, R[2].OVERALL_tree117_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree118_node != R[2].OVERALL_tree118_node, DATASET([{118, L.OVERALL_tree118_node, R[2].OVERALL_tree118_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree119_node != R[2].OVERALL_tree119_node, DATASET([{119, L.OVERALL_tree119_node, R[2].OVERALL_tree119_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree120_node != R[2].OVERALL_tree120_node, DATASET([{120, L.OVERALL_tree120_node, R[2].OVERALL_tree120_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree121_node != R[2].OVERALL_tree121_node, DATASET([{121, L.OVERALL_tree121_node, R[2].OVERALL_tree121_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree122_node != R[2].OVERALL_tree122_node, DATASET([{122, L.OVERALL_tree122_node, R[2].OVERALL_tree122_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree123_node != R[2].OVERALL_tree123_node, DATASET([{123, L.OVERALL_tree123_node, R[2].OVERALL_tree123_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree124_node != R[2].OVERALL_tree124_node, DATASET([{124, L.OVERALL_tree124_node, R[2].OVERALL_tree124_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree125_node != R[2].OVERALL_tree125_node, DATASET([{125, L.OVERALL_tree125_node, R[2].OVERALL_tree125_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree126_node != R[2].OVERALL_tree126_node, DATASET([{126, L.OVERALL_tree126_node, R[2].OVERALL_tree126_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree127_node != R[2].OVERALL_tree127_node, DATASET([{127, L.OVERALL_tree127_node, R[2].OVERALL_tree127_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree128_node != R[2].OVERALL_tree128_node, DATASET([{128, L.OVERALL_tree128_node, R[2].OVERALL_tree128_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree129_node != R[2].OVERALL_tree129_node, DATASET([{129, L.OVERALL_tree129_node, R[2].OVERALL_tree129_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree130_node != R[2].OVERALL_tree130_node, DATASET([{130, L.OVERALL_tree130_node, R[2].OVERALL_tree130_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree131_node != R[2].OVERALL_tree131_node, DATASET([{131, L.OVERALL_tree131_node, R[2].OVERALL_tree131_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree132_node != R[2].OVERALL_tree132_node, DATASET([{132, L.OVERALL_tree132_node, R[2].OVERALL_tree132_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree133_node != R[2].OVERALL_tree133_node, DATASET([{133, L.OVERALL_tree133_node, R[2].OVERALL_tree133_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree134_node != R[2].OVERALL_tree134_node, DATASET([{134, L.OVERALL_tree134_node, R[2].OVERALL_tree134_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree135_node != R[2].OVERALL_tree135_node, DATASET([{135, L.OVERALL_tree135_node, R[2].OVERALL_tree135_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree136_node != R[2].OVERALL_tree136_node, DATASET([{136, L.OVERALL_tree136_node, R[2].OVERALL_tree136_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree137_node != R[2].OVERALL_tree137_node, DATASET([{137, L.OVERALL_tree137_node, R[2].OVERALL_tree137_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree138_node != R[2].OVERALL_tree138_node, DATASET([{138, L.OVERALL_tree138_node, R[2].OVERALL_tree138_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree139_node != R[2].OVERALL_tree139_node, DATASET([{139, L.OVERALL_tree139_node, R[2].OVERALL_tree139_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree140_node != R[2].OVERALL_tree140_node, DATASET([{140, L.OVERALL_tree140_node, R[2].OVERALL_tree140_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree141_node != R[2].OVERALL_tree141_node, DATASET([{141, L.OVERALL_tree141_node, R[2].OVERALL_tree141_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree142_node != R[2].OVERALL_tree142_node, DATASET([{142, L.OVERALL_tree142_node, R[2].OVERALL_tree142_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree143_node != R[2].OVERALL_tree143_node, DATASET([{143, L.OVERALL_tree143_node, R[2].OVERALL_tree143_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree144_node != R[2].OVERALL_tree144_node, DATASET([{144, L.OVERALL_tree144_node, R[2].OVERALL_tree144_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree145_node != R[2].OVERALL_tree145_node, DATASET([{145, L.OVERALL_tree145_node, R[2].OVERALL_tree145_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree146_node != R[2].OVERALL_tree146_node, DATASET([{146, L.OVERALL_tree146_node, R[2].OVERALL_tree146_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree147_node != R[2].OVERALL_tree147_node, DATASET([{147, L.OVERALL_tree147_node, R[2].OVERALL_tree147_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree148_node != R[2].OVERALL_tree148_node, DATASET([{148, L.OVERALL_tree148_node, R[2].OVERALL_tree148_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree149_node != R[2].OVERALL_tree149_node, DATASET([{149, L.OVERALL_tree149_node, R[2].OVERALL_tree149_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree150_node != R[2].OVERALL_tree150_node, DATASET([{150, L.OVERALL_tree150_node, R[2].OVERALL_tree150_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree151_node != R[2].OVERALL_tree151_node, DATASET([{151, L.OVERALL_tree151_node, R[2].OVERALL_tree151_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree152_node != R[2].OVERALL_tree152_node, DATASET([{152, L.OVERALL_tree152_node, R[2].OVERALL_tree152_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree153_node != R[2].OVERALL_tree153_node, DATASET([{153, L.OVERALL_tree153_node, R[2].OVERALL_tree153_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree154_node != R[2].OVERALL_tree154_node, DATASET([{154, L.OVERALL_tree154_node, R[2].OVERALL_tree154_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree155_node != R[2].OVERALL_tree155_node, DATASET([{155, L.OVERALL_tree155_node, R[2].OVERALL_tree155_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree156_node != R[2].OVERALL_tree156_node, DATASET([{156, L.OVERALL_tree156_node, R[2].OVERALL_tree156_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree157_node != R[2].OVERALL_tree157_node, DATASET([{157, L.OVERALL_tree157_node, R[2].OVERALL_tree157_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree158_node != R[2].OVERALL_tree158_node, DATASET([{158, L.OVERALL_tree158_node, R[2].OVERALL_tree158_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree159_node != R[2].OVERALL_tree159_node, DATASET([{159, L.OVERALL_tree159_node, R[2].OVERALL_tree159_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree160_node != R[2].OVERALL_tree160_node, DATASET([{160, L.OVERALL_tree160_node, R[2].OVERALL_tree160_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree161_node != R[2].OVERALL_tree161_node, DATASET([{161, L.OVERALL_tree161_node, R[2].OVERALL_tree161_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree162_node != R[2].OVERALL_tree162_node, DATASET([{162, L.OVERALL_tree162_node, R[2].OVERALL_tree162_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree163_node != R[2].OVERALL_tree163_node, DATASET([{163, L.OVERALL_tree163_node, R[2].OVERALL_tree163_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree164_node != R[2].OVERALL_tree164_node, DATASET([{164, L.OVERALL_tree164_node, R[2].OVERALL_tree164_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree165_node != R[2].OVERALL_tree165_node, DATASET([{165, L.OVERALL_tree165_node, R[2].OVERALL_tree165_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree166_node != R[2].OVERALL_tree166_node, DATASET([{166, L.OVERALL_tree166_node, R[2].OVERALL_tree166_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree167_node != R[2].OVERALL_tree167_node, DATASET([{167, L.OVERALL_tree167_node, R[2].OVERALL_tree167_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree168_node != R[2].OVERALL_tree168_node, DATASET([{168, L.OVERALL_tree168_node, R[2].OVERALL_tree168_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree169_node != R[2].OVERALL_tree169_node, DATASET([{169, L.OVERALL_tree169_node, R[2].OVERALL_tree169_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree170_node != R[2].OVERALL_tree170_node, DATASET([{170, L.OVERALL_tree170_node, R[2].OVERALL_tree170_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree171_node != R[2].OVERALL_tree171_node, DATASET([{171, L.OVERALL_tree171_node, R[2].OVERALL_tree171_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree172_node != R[2].OVERALL_tree172_node, DATASET([{172, L.OVERALL_tree172_node, R[2].OVERALL_tree172_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree173_node != R[2].OVERALL_tree173_node, DATASET([{173, L.OVERALL_tree173_node, R[2].OVERALL_tree173_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree174_node != R[2].OVERALL_tree174_node, DATASET([{174, L.OVERALL_tree174_node, R[2].OVERALL_tree174_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree175_node != R[2].OVERALL_tree175_node, DATASET([{175, L.OVERALL_tree175_node, R[2].OVERALL_tree175_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree176_node != R[2].OVERALL_tree176_node, DATASET([{176, L.OVERALL_tree176_node, R[2].OVERALL_tree176_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree177_node != R[2].OVERALL_tree177_node, DATASET([{177, L.OVERALL_tree177_node, R[2].OVERALL_tree177_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree178_node != R[2].OVERALL_tree178_node, DATASET([{178, L.OVERALL_tree178_node, R[2].OVERALL_tree178_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree179_node != R[2].OVERALL_tree179_node, DATASET([{179, L.OVERALL_tree179_node, R[2].OVERALL_tree179_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree180_node != R[2].OVERALL_tree180_node, DATASET([{180, L.OVERALL_tree180_node, R[2].OVERALL_tree180_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree181_node != R[2].OVERALL_tree181_node, DATASET([{181, L.OVERALL_tree181_node, R[2].OVERALL_tree181_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree182_node != R[2].OVERALL_tree182_node, DATASET([{182, L.OVERALL_tree182_node, R[2].OVERALL_tree182_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree183_node != R[2].OVERALL_tree183_node, DATASET([{183, L.OVERALL_tree183_node, R[2].OVERALL_tree183_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree184_node != R[2].OVERALL_tree184_node, DATASET([{184, L.OVERALL_tree184_node, R[2].OVERALL_tree184_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree185_node != R[2].OVERALL_tree185_node, DATASET([{185, L.OVERALL_tree185_node, R[2].OVERALL_tree185_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree186_node != R[2].OVERALL_tree186_node, DATASET([{186, L.OVERALL_tree186_node, R[2].OVERALL_tree186_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree187_node != R[2].OVERALL_tree187_node, DATASET([{187, L.OVERALL_tree187_node, R[2].OVERALL_tree187_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree188_node != R[2].OVERALL_tree188_node, DATASET([{188, L.OVERALL_tree188_node, R[2].OVERALL_tree188_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree189_node != R[2].OVERALL_tree189_node, DATASET([{189, L.OVERALL_tree189_node, R[2].OVERALL_tree189_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree190_node != R[2].OVERALL_tree190_node, DATASET([{190, L.OVERALL_tree190_node, R[2].OVERALL_tree190_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree191_node != R[2].OVERALL_tree191_node, DATASET([{191, L.OVERALL_tree191_node, R[2].OVERALL_tree191_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree192_node != R[2].OVERALL_tree192_node, DATASET([{192, L.OVERALL_tree192_node, R[2].OVERALL_tree192_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree193_node != R[2].OVERALL_tree193_node, DATASET([{193, L.OVERALL_tree193_node, R[2].OVERALL_tree193_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree194_node != R[2].OVERALL_tree194_node, DATASET([{194, L.OVERALL_tree194_node, R[2].OVERALL_tree194_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree195_node != R[2].OVERALL_tree195_node, DATASET([{195, L.OVERALL_tree195_node, R[2].OVERALL_tree195_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree196_node != R[2].OVERALL_tree196_node, DATASET([{196, L.OVERALL_tree196_node, R[2].OVERALL_tree196_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree197_node != R[2].OVERALL_tree197_node, DATASET([{197, L.OVERALL_tree197_node, R[2].OVERALL_tree197_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree198_node != R[2].OVERALL_tree198_node, DATASET([{198, L.OVERALL_tree198_node, R[2].OVERALL_tree198_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree199_node != R[2].OVERALL_tree199_node, DATASET([{199, L.OVERALL_tree199_node, R[2].OVERALL_tree199_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree200_node != R[2].OVERALL_tree200_node, DATASET([{200, L.OVERALL_tree200_node, R[2].OVERALL_tree200_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree201_node != R[2].OVERALL_tree201_node, DATASET([{201, L.OVERALL_tree201_node, R[2].OVERALL_tree201_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree202_node != R[2].OVERALL_tree202_node, DATASET([{202, L.OVERALL_tree202_node, R[2].OVERALL_tree202_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree203_node != R[2].OVERALL_tree203_node, DATASET([{203, L.OVERALL_tree203_node, R[2].OVERALL_tree203_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree204_node != R[2].OVERALL_tree204_node, DATASET([{204, L.OVERALL_tree204_node, R[2].OVERALL_tree204_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree205_node != R[2].OVERALL_tree205_node, DATASET([{205, L.OVERALL_tree205_node, R[2].OVERALL_tree205_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree206_node != R[2].OVERALL_tree206_node, DATASET([{206, L.OVERALL_tree206_node, R[2].OVERALL_tree206_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree207_node != R[2].OVERALL_tree207_node, DATASET([{207, L.OVERALL_tree207_node, R[2].OVERALL_tree207_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree208_node != R[2].OVERALL_tree208_node, DATASET([{208, L.OVERALL_tree208_node, R[2].OVERALL_tree208_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree209_node != R[2].OVERALL_tree209_node, DATASET([{209, L.OVERALL_tree209_node, R[2].OVERALL_tree209_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree210_node != R[2].OVERALL_tree210_node, DATASET([{210, L.OVERALL_tree210_node, R[2].OVERALL_tree210_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree211_node != R[2].OVERALL_tree211_node, DATASET([{211, L.OVERALL_tree211_node, R[2].OVERALL_tree211_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree212_node != R[2].OVERALL_tree212_node, DATASET([{212, L.OVERALL_tree212_node, R[2].OVERALL_tree212_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree213_node != R[2].OVERALL_tree213_node, DATASET([{213, L.OVERALL_tree213_node, R[2].OVERALL_tree213_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree214_node != R[2].OVERALL_tree214_node, DATASET([{214, L.OVERALL_tree214_node, R[2].OVERALL_tree214_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree215_node != R[2].OVERALL_tree215_node, DATASET([{215, L.OVERALL_tree215_node, R[2].OVERALL_tree215_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree216_node != R[2].OVERALL_tree216_node, DATASET([{216, L.OVERALL_tree216_node, R[2].OVERALL_tree216_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree217_node != R[2].OVERALL_tree217_node, DATASET([{217, L.OVERALL_tree217_node, R[2].OVERALL_tree217_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree218_node != R[2].OVERALL_tree218_node, DATASET([{218, L.OVERALL_tree218_node, R[2].OVERALL_tree218_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree219_node != R[2].OVERALL_tree219_node, DATASET([{219, L.OVERALL_tree219_node, R[2].OVERALL_tree219_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree220_node != R[2].OVERALL_tree220_node, DATASET([{220, L.OVERALL_tree220_node, R[2].OVERALL_tree220_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree221_node != R[2].OVERALL_tree221_node, DATASET([{221, L.OVERALL_tree221_node, R[2].OVERALL_tree221_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree222_node != R[2].OVERALL_tree222_node, DATASET([{222, L.OVERALL_tree222_node, R[2].OVERALL_tree222_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree223_node != R[2].OVERALL_tree223_node, DATASET([{223, L.OVERALL_tree223_node, R[2].OVERALL_tree223_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree224_node != R[2].OVERALL_tree224_node, DATASET([{224, L.OVERALL_tree224_node, R[2].OVERALL_tree224_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree225_node != R[2].OVERALL_tree225_node, DATASET([{225, L.OVERALL_tree225_node, R[2].OVERALL_tree225_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree226_node != R[2].OVERALL_tree226_node, DATASET([{226, L.OVERALL_tree226_node, R[2].OVERALL_tree226_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree227_node != R[2].OVERALL_tree227_node, DATASET([{227, L.OVERALL_tree227_node, R[2].OVERALL_tree227_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree228_node != R[2].OVERALL_tree228_node, DATASET([{228, L.OVERALL_tree228_node, R[2].OVERALL_tree228_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree229_node != R[2].OVERALL_tree229_node, DATASET([{229, L.OVERALL_tree229_node, R[2].OVERALL_tree229_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree230_node != R[2].OVERALL_tree230_node, DATASET([{230, L.OVERALL_tree230_node, R[2].OVERALL_tree230_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree231_node != R[2].OVERALL_tree231_node, DATASET([{231, L.OVERALL_tree231_node, R[2].OVERALL_tree231_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree232_node != R[2].OVERALL_tree232_node, DATASET([{232, L.OVERALL_tree232_node, R[2].OVERALL_tree232_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree233_node != R[2].OVERALL_tree233_node, DATASET([{233, L.OVERALL_tree233_node, R[2].OVERALL_tree233_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree234_node != R[2].OVERALL_tree234_node, DATASET([{234, L.OVERALL_tree234_node, R[2].OVERALL_tree234_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree235_node != R[2].OVERALL_tree235_node, DATASET([{235, L.OVERALL_tree235_node, R[2].OVERALL_tree235_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree236_node != R[2].OVERALL_tree236_node, DATASET([{236, L.OVERALL_tree236_node, R[2].OVERALL_tree236_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree237_node != R[2].OVERALL_tree237_node, DATASET([{237, L.OVERALL_tree237_node, R[2].OVERALL_tree237_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree238_node != R[2].OVERALL_tree238_node, DATASET([{238, L.OVERALL_tree238_node, R[2].OVERALL_tree238_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree239_node != R[2].OVERALL_tree239_node, DATASET([{239, L.OVERALL_tree239_node, R[2].OVERALL_tree239_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree240_node != R[2].OVERALL_tree240_node, DATASET([{240, L.OVERALL_tree240_node, R[2].OVERALL_tree240_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree241_node != R[2].OVERALL_tree241_node, DATASET([{241, L.OVERALL_tree241_node, R[2].OVERALL_tree241_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree242_node != R[2].OVERALL_tree242_node, DATASET([{242, L.OVERALL_tree242_node, R[2].OVERALL_tree242_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree243_node != R[2].OVERALL_tree243_node, DATASET([{243, L.OVERALL_tree243_node, R[2].OVERALL_tree243_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree244_node != R[2].OVERALL_tree244_node, DATASET([{244, L.OVERALL_tree244_node, R[2].OVERALL_tree244_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree245_node != R[2].OVERALL_tree245_node, DATASET([{245, L.OVERALL_tree245_node, R[2].OVERALL_tree245_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree246_node != R[2].OVERALL_tree246_node, DATASET([{246, L.OVERALL_tree246_node, R[2].OVERALL_tree246_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree247_node != R[2].OVERALL_tree247_node, DATASET([{247, L.OVERALL_tree247_node, R[2].OVERALL_tree247_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree248_node != R[2].OVERALL_tree248_node, DATASET([{248, L.OVERALL_tree248_node, R[2].OVERALL_tree248_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree249_node != R[2].OVERALL_tree249_node, DATASET([{249, L.OVERALL_tree249_node, R[2].OVERALL_tree249_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree250_node != R[2].OVERALL_tree250_node, DATASET([{250, L.OVERALL_tree250_node, R[2].OVERALL_tree250_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree251_node != R[2].OVERALL_tree251_node, DATASET([{251, L.OVERALL_tree251_node, R[2].OVERALL_tree251_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree252_node != R[2].OVERALL_tree252_node, DATASET([{252, L.OVERALL_tree252_node, R[2].OVERALL_tree252_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree253_node != R[2].OVERALL_tree253_node, DATASET([{253, L.OVERALL_tree253_node, R[2].OVERALL_tree253_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree254_node != R[2].OVERALL_tree254_node, DATASET([{254, L.OVERALL_tree254_node, R[2].OVERALL_tree254_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree255_node != R[2].OVERALL_tree255_node, DATASET([{255, L.OVERALL_tree255_node, R[2].OVERALL_tree255_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree256_node != R[2].OVERALL_tree256_node, DATASET([{256, L.OVERALL_tree256_node, R[2].OVERALL_tree256_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree257_node != R[2].OVERALL_tree257_node, DATASET([{257, L.OVERALL_tree257_node, R[2].OVERALL_tree257_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree258_node != R[2].OVERALL_tree258_node, DATASET([{258, L.OVERALL_tree258_node, R[2].OVERALL_tree258_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree259_node != R[2].OVERALL_tree259_node, DATASET([{259, L.OVERALL_tree259_node, R[2].OVERALL_tree259_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree260_node != R[2].OVERALL_tree260_node, DATASET([{260, L.OVERALL_tree260_node, R[2].OVERALL_tree260_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree261_node != R[2].OVERALL_tree261_node, DATASET([{261, L.OVERALL_tree261_node, R[2].OVERALL_tree261_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree262_node != R[2].OVERALL_tree262_node, DATASET([{262, L.OVERALL_tree262_node, R[2].OVERALL_tree262_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree263_node != R[2].OVERALL_tree263_node, DATASET([{263, L.OVERALL_tree263_node, R[2].OVERALL_tree263_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree264_node != R[2].OVERALL_tree264_node, DATASET([{264, L.OVERALL_tree264_node, R[2].OVERALL_tree264_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree265_node != R[2].OVERALL_tree265_node, DATASET([{265, L.OVERALL_tree265_node, R[2].OVERALL_tree265_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree266_node != R[2].OVERALL_tree266_node, DATASET([{266, L.OVERALL_tree266_node, R[2].OVERALL_tree266_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree267_node != R[2].OVERALL_tree267_node, DATASET([{267, L.OVERALL_tree267_node, R[2].OVERALL_tree267_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree268_node != R[2].OVERALL_tree268_node, DATASET([{268, L.OVERALL_tree268_node, R[2].OVERALL_tree268_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree269_node != R[2].OVERALL_tree269_node, DATASET([{269, L.OVERALL_tree269_node, R[2].OVERALL_tree269_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree270_node != R[2].OVERALL_tree270_node, DATASET([{270, L.OVERALL_tree270_node, R[2].OVERALL_tree270_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree271_node != R[2].OVERALL_tree271_node, DATASET([{271, L.OVERALL_tree271_node, R[2].OVERALL_tree271_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree272_node != R[2].OVERALL_tree272_node, DATASET([{272, L.OVERALL_tree272_node, R[2].OVERALL_tree272_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree273_node != R[2].OVERALL_tree273_node, DATASET([{273, L.OVERALL_tree273_node, R[2].OVERALL_tree273_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree274_node != R[2].OVERALL_tree274_node, DATASET([{274, L.OVERALL_tree274_node, R[2].OVERALL_tree274_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree275_node != R[2].OVERALL_tree275_node, DATASET([{275, L.OVERALL_tree275_node, R[2].OVERALL_tree275_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree276_node != R[2].OVERALL_tree276_node, DATASET([{276, L.OVERALL_tree276_node, R[2].OVERALL_tree276_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree277_node != R[2].OVERALL_tree277_node, DATASET([{277, L.OVERALL_tree277_node, R[2].OVERALL_tree277_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree278_node != R[2].OVERALL_tree278_node, DATASET([{278, L.OVERALL_tree278_node, R[2].OVERALL_tree278_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree279_node != R[2].OVERALL_tree279_node, DATASET([{279, L.OVERALL_tree279_node, R[2].OVERALL_tree279_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree280_node != R[2].OVERALL_tree280_node, DATASET([{280, L.OVERALL_tree280_node, R[2].OVERALL_tree280_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree281_node != R[2].OVERALL_tree281_node, DATASET([{281, L.OVERALL_tree281_node, R[2].OVERALL_tree281_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree282_node != R[2].OVERALL_tree282_node, DATASET([{282, L.OVERALL_tree282_node, R[2].OVERALL_tree282_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree283_node != R[2].OVERALL_tree283_node, DATASET([{283, L.OVERALL_tree283_node, R[2].OVERALL_tree283_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree284_node != R[2].OVERALL_tree284_node, DATASET([{284, L.OVERALL_tree284_node, R[2].OVERALL_tree284_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree285_node != R[2].OVERALL_tree285_node, DATASET([{285, L.OVERALL_tree285_node, R[2].OVERALL_tree285_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree286_node != R[2].OVERALL_tree286_node, DATASET([{286, L.OVERALL_tree286_node, R[2].OVERALL_tree286_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree287_node != R[2].OVERALL_tree287_node, DATASET([{287, L.OVERALL_tree287_node, R[2].OVERALL_tree287_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree288_node != R[2].OVERALL_tree288_node, DATASET([{288, L.OVERALL_tree288_node, R[2].OVERALL_tree288_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree289_node != R[2].OVERALL_tree289_node, DATASET([{289, L.OVERALL_tree289_node, R[2].OVERALL_tree289_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree290_node != R[2].OVERALL_tree290_node, DATASET([{290, L.OVERALL_tree290_node, R[2].OVERALL_tree290_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree291_node != R[2].OVERALL_tree291_node, DATASET([{291, L.OVERALL_tree291_node, R[2].OVERALL_tree291_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree292_node != R[2].OVERALL_tree292_node, DATASET([{292, L.OVERALL_tree292_node, R[2].OVERALL_tree292_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree293_node != R[2].OVERALL_tree293_node, DATASET([{293, L.OVERALL_tree293_node, R[2].OVERALL_tree293_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree294_node != R[2].OVERALL_tree294_node, DATASET([{294, L.OVERALL_tree294_node, R[2].OVERALL_tree294_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree295_node != R[2].OVERALL_tree295_node, DATASET([{295, L.OVERALL_tree295_node, R[2].OVERALL_tree295_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree296_node != R[2].OVERALL_tree296_node, DATASET([{296, L.OVERALL_tree296_node, R[2].OVERALL_tree296_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree297_node != R[2].OVERALL_tree297_node, DATASET([{297, L.OVERALL_tree297_node, R[2].OVERALL_tree297_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree298_node != R[2].OVERALL_tree298_node, DATASET([{298, L.OVERALL_tree298_node, R[2].OVERALL_tree298_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree299_node != R[2].OVERALL_tree299_node, DATASET([{299, L.OVERALL_tree299_node, R[2].OVERALL_tree299_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree300_node != R[2].OVERALL_tree300_node, DATASET([{300, L.OVERALL_tree300_node, R[2].OVERALL_tree300_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree301_node != R[2].OVERALL_tree301_node, DATASET([{301, L.OVERALL_tree301_node, R[2].OVERALL_tree301_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree302_node != R[2].OVERALL_tree302_node, DATASET([{302, L.OVERALL_tree302_node, R[2].OVERALL_tree302_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree303_node != R[2].OVERALL_tree303_node, DATASET([{303, L.OVERALL_tree303_node, R[2].OVERALL_tree303_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree304_node != R[2].OVERALL_tree304_node, DATASET([{304, L.OVERALL_tree304_node, R[2].OVERALL_tree304_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree305_node != R[2].OVERALL_tree305_node, DATASET([{305, L.OVERALL_tree305_node, R[2].OVERALL_tree305_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree306_node != R[2].OVERALL_tree306_node, DATASET([{306, L.OVERALL_tree306_node, R[2].OVERALL_tree306_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree307_node != R[2].OVERALL_tree307_node, DATASET([{307, L.OVERALL_tree307_node, R[2].OVERALL_tree307_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree308_node != R[2].OVERALL_tree308_node, DATASET([{308, L.OVERALL_tree308_node, R[2].OVERALL_tree308_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree309_node != R[2].OVERALL_tree309_node, DATASET([{309, L.OVERALL_tree309_node, R[2].OVERALL_tree309_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree310_node != R[2].OVERALL_tree310_node, DATASET([{310, L.OVERALL_tree310_node, R[2].OVERALL_tree310_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree311_node != R[2].OVERALL_tree311_node, DATASET([{311, L.OVERALL_tree311_node, R[2].OVERALL_tree311_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree312_node != R[2].OVERALL_tree312_node, DATASET([{312, L.OVERALL_tree312_node, R[2].OVERALL_tree312_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree313_node != R[2].OVERALL_tree313_node, DATASET([{313, L.OVERALL_tree313_node, R[2].OVERALL_tree313_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree314_node != R[2].OVERALL_tree314_node, DATASET([{314, L.OVERALL_tree314_node, R[2].OVERALL_tree314_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree315_node != R[2].OVERALL_tree315_node, DATASET([{315, L.OVERALL_tree315_node, R[2].OVERALL_tree315_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree316_node != R[2].OVERALL_tree316_node, DATASET([{316, L.OVERALL_tree316_node, R[2].OVERALL_tree316_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree317_node != R[2].OVERALL_tree317_node, DATASET([{317, L.OVERALL_tree317_node, R[2].OVERALL_tree317_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree318_node != R[2].OVERALL_tree318_node, DATASET([{318, L.OVERALL_tree318_node, R[2].OVERALL_tree318_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree319_node != R[2].OVERALL_tree319_node, DATASET([{319, L.OVERALL_tree319_node, R[2].OVERALL_tree319_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree320_node != R[2].OVERALL_tree320_node, DATASET([{320, L.OVERALL_tree320_node, R[2].OVERALL_tree320_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree321_node != R[2].OVERALL_tree321_node, DATASET([{321, L.OVERALL_tree321_node, R[2].OVERALL_tree321_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree322_node != R[2].OVERALL_tree322_node, DATASET([{322, L.OVERALL_tree322_node, R[2].OVERALL_tree322_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree323_node != R[2].OVERALL_tree323_node, DATASET([{323, L.OVERALL_tree323_node, R[2].OVERALL_tree323_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree324_node != R[2].OVERALL_tree324_node, DATASET([{324, L.OVERALL_tree324_node, R[2].OVERALL_tree324_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree325_node != R[2].OVERALL_tree325_node, DATASET([{325, L.OVERALL_tree325_node, R[2].OVERALL_tree325_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree326_node != R[2].OVERALL_tree326_node, DATASET([{326, L.OVERALL_tree326_node, R[2].OVERALL_tree326_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree327_node != R[2].OVERALL_tree327_node, DATASET([{327, L.OVERALL_tree327_node, R[2].OVERALL_tree327_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree328_node != R[2].OVERALL_tree328_node, DATASET([{328, L.OVERALL_tree328_node, R[2].OVERALL_tree328_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree329_node != R[2].OVERALL_tree329_node, DATASET([{329, L.OVERALL_tree329_node, R[2].OVERALL_tree329_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree330_node != R[2].OVERALL_tree330_node, DATASET([{330, L.OVERALL_tree330_node, R[2].OVERALL_tree330_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree331_node != R[2].OVERALL_tree331_node, DATASET([{331, L.OVERALL_tree331_node, R[2].OVERALL_tree331_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree332_node != R[2].OVERALL_tree332_node, DATASET([{332, L.OVERALL_tree332_node, R[2].OVERALL_tree332_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree333_node != R[2].OVERALL_tree333_node, DATASET([{333, L.OVERALL_tree333_node, R[2].OVERALL_tree333_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree334_node != R[2].OVERALL_tree334_node, DATASET([{334, L.OVERALL_tree334_node, R[2].OVERALL_tree334_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree335_node != R[2].OVERALL_tree335_node, DATASET([{335, L.OVERALL_tree335_node, R[2].OVERALL_tree335_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree336_node != R[2].OVERALL_tree336_node, DATASET([{336, L.OVERALL_tree336_node, R[2].OVERALL_tree336_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree337_node != R[2].OVERALL_tree337_node, DATASET([{337, L.OVERALL_tree337_node, R[2].OVERALL_tree337_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree338_node != R[2].OVERALL_tree338_node, DATASET([{338, L.OVERALL_tree338_node, R[2].OVERALL_tree338_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree339_node != R[2].OVERALL_tree339_node, DATASET([{339, L.OVERALL_tree339_node, R[2].OVERALL_tree339_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree340_node != R[2].OVERALL_tree340_node, DATASET([{340, L.OVERALL_tree340_node, R[2].OVERALL_tree340_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree341_node != R[2].OVERALL_tree341_node, DATASET([{341, L.OVERALL_tree341_node, R[2].OVERALL_tree341_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree342_node != R[2].OVERALL_tree342_node, DATASET([{342, L.OVERALL_tree342_node, R[2].OVERALL_tree342_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree343_node != R[2].OVERALL_tree343_node, DATASET([{343, L.OVERALL_tree343_node, R[2].OVERALL_tree343_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree344_node != R[2].OVERALL_tree344_node, DATASET([{344, L.OVERALL_tree344_node, R[2].OVERALL_tree344_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree345_node != R[2].OVERALL_tree345_node, DATASET([{345, L.OVERALL_tree345_node, R[2].OVERALL_tree345_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree346_node != R[2].OVERALL_tree346_node, DATASET([{346, L.OVERALL_tree346_node, R[2].OVERALL_tree346_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree347_node != R[2].OVERALL_tree347_node, DATASET([{347, L.OVERALL_tree347_node, R[2].OVERALL_tree347_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree348_node != R[2].OVERALL_tree348_node, DATASET([{348, L.OVERALL_tree348_node, R[2].OVERALL_tree348_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree349_node != R[2].OVERALL_tree349_node, DATASET([{349, L.OVERALL_tree349_node, R[2].OVERALL_tree349_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree350_node != R[2].OVERALL_tree350_node, DATASET([{350, L.OVERALL_tree350_node, R[2].OVERALL_tree350_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree351_node != R[2].OVERALL_tree351_node, DATASET([{351, L.OVERALL_tree351_node, R[2].OVERALL_tree351_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree352_node != R[2].OVERALL_tree352_node, DATASET([{352, L.OVERALL_tree352_node, R[2].OVERALL_tree352_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree353_node != R[2].OVERALL_tree353_node, DATASET([{353, L.OVERALL_tree353_node, R[2].OVERALL_tree353_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree354_node != R[2].OVERALL_tree354_node, DATASET([{354, L.OVERALL_tree354_node, R[2].OVERALL_tree354_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree355_node != R[2].OVERALL_tree355_node, DATASET([{355, L.OVERALL_tree355_node, R[2].OVERALL_tree355_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree356_node != R[2].OVERALL_tree356_node, DATASET([{356, L.OVERALL_tree356_node, R[2].OVERALL_tree356_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree357_node != R[2].OVERALL_tree357_node, DATASET([{357, L.OVERALL_tree357_node, R[2].OVERALL_tree357_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree358_node != R[2].OVERALL_tree358_node, DATASET([{358, L.OVERALL_tree358_node, R[2].OVERALL_tree358_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree359_node != R[2].OVERALL_tree359_node, DATASET([{359, L.OVERALL_tree359_node, R[2].OVERALL_tree359_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree360_node != R[2].OVERALL_tree360_node, DATASET([{360, L.OVERALL_tree360_node, R[2].OVERALL_tree360_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree361_node != R[2].OVERALL_tree361_node, DATASET([{361, L.OVERALL_tree361_node, R[2].OVERALL_tree361_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree362_node != R[2].OVERALL_tree362_node, DATASET([{362, L.OVERALL_tree362_node, R[2].OVERALL_tree362_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree363_node != R[2].OVERALL_tree363_node, DATASET([{363, L.OVERALL_tree363_node, R[2].OVERALL_tree363_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree364_node != R[2].OVERALL_tree364_node, DATASET([{364, L.OVERALL_tree364_node, R[2].OVERALL_tree364_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree365_node != R[2].OVERALL_tree365_node, DATASET([{365, L.OVERALL_tree365_node, R[2].OVERALL_tree365_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree366_node != R[2].OVERALL_tree366_node, DATASET([{366, L.OVERALL_tree366_node, R[2].OVERALL_tree366_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree367_node != R[2].OVERALL_tree367_node, DATASET([{367, L.OVERALL_tree367_node, R[2].OVERALL_tree367_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree368_node != R[2].OVERALL_tree368_node, DATASET([{368, L.OVERALL_tree368_node, R[2].OVERALL_tree368_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree369_node != R[2].OVERALL_tree369_node, DATASET([{369, L.OVERALL_tree369_node, R[2].OVERALL_tree369_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree370_node != R[2].OVERALL_tree370_node, DATASET([{370, L.OVERALL_tree370_node, R[2].OVERALL_tree370_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree371_node != R[2].OVERALL_tree371_node, DATASET([{371, L.OVERALL_tree371_node, R[2].OVERALL_tree371_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree372_node != R[2].OVERALL_tree372_node, DATASET([{372, L.OVERALL_tree372_node, R[2].OVERALL_tree372_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree373_node != R[2].OVERALL_tree373_node, DATASET([{373, L.OVERALL_tree373_node, R[2].OVERALL_tree373_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree374_node != R[2].OVERALL_tree374_node, DATASET([{374, L.OVERALL_tree374_node, R[2].OVERALL_tree374_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree375_node != R[2].OVERALL_tree375_node, DATASET([{375, L.OVERALL_tree375_node, R[2].OVERALL_tree375_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree376_node != R[2].OVERALL_tree376_node, DATASET([{376, L.OVERALL_tree376_node, R[2].OVERALL_tree376_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree377_node != R[2].OVERALL_tree377_node, DATASET([{377, L.OVERALL_tree377_node, R[2].OVERALL_tree377_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree378_node != R[2].OVERALL_tree378_node, DATASET([{378, L.OVERALL_tree378_node, R[2].OVERALL_tree378_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree379_node != R[2].OVERALL_tree379_node, DATASET([{379, L.OVERALL_tree379_node, R[2].OVERALL_tree379_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree380_node != R[2].OVERALL_tree380_node, DATASET([{380, L.OVERALL_tree380_node, R[2].OVERALL_tree380_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree381_node != R[2].OVERALL_tree381_node, DATASET([{381, L.OVERALL_tree381_node, R[2].OVERALL_tree381_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree382_node != R[2].OVERALL_tree382_node, DATASET([{382, L.OVERALL_tree382_node, R[2].OVERALL_tree382_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree383_node != R[2].OVERALL_tree383_node, DATASET([{383, L.OVERALL_tree383_node, R[2].OVERALL_tree383_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree384_node != R[2].OVERALL_tree384_node, DATASET([{384, L.OVERALL_tree384_node, R[2].OVERALL_tree384_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree385_node != R[2].OVERALL_tree385_node, DATASET([{385, L.OVERALL_tree385_node, R[2].OVERALL_tree385_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree386_node != R[2].OVERALL_tree386_node, DATASET([{386, L.OVERALL_tree386_node, R[2].OVERALL_tree386_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree387_node != R[2].OVERALL_tree387_node, DATASET([{387, L.OVERALL_tree387_node, R[2].OVERALL_tree387_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree388_node != R[2].OVERALL_tree388_node, DATASET([{388, L.OVERALL_tree388_node, R[2].OVERALL_tree388_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree389_node != R[2].OVERALL_tree389_node, DATASET([{389, L.OVERALL_tree389_node, R[2].OVERALL_tree389_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree390_node != R[2].OVERALL_tree390_node, DATASET([{390, L.OVERALL_tree390_node, R[2].OVERALL_tree390_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree391_node != R[2].OVERALL_tree391_node, DATASET([{391, L.OVERALL_tree391_node, R[2].OVERALL_tree391_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree392_node != R[2].OVERALL_tree392_node, DATASET([{392, L.OVERALL_tree392_node, R[2].OVERALL_tree392_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree393_node != R[2].OVERALL_tree393_node, DATASET([{393, L.OVERALL_tree393_node, R[2].OVERALL_tree393_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree394_node != R[2].OVERALL_tree394_node, DATASET([{394, L.OVERALL_tree394_node, R[2].OVERALL_tree394_node}], TerminalNodeCompPerTreeLayout)) + IF(L.OVERALL_tree395_node != R[2].OVERALL_tree395_node, DATASET([{395, L.OVERALL_tree395_node, R[2].OVERALL_tree395_node}], TerminalNodeCompPerTreeLayout));
END;

SHARED tnMismatches_rc := ROLLUP(DS_Comp_rc_grp, GROUP, doRollUp(LEFT,ROWS(LEFT)));
OUTPUT(CHOOSEN(tnMismatches_rc,100),,NAMED('terminal_node_mismatches_rc'));
SHARED tnMismatches_sc := ROLLUP(DS_Comp_sc_grp, GROUP, doRollUp(LEFT,ROWS(LEFT)));
OUTPUT(CHOOSEN(tnMismatches_sc,100),,NAMED('terminal_node_mismatches_sc'));

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

SHARED tnMismatches_rc_full := NORMALIZE(tnMismatches_rc,COUNT(LEFT.TerminalNodeMismatches),flattenTNMismatch(LEFT,COUNTER));
SHARED tnMismatches_sc_full := NORMALIZE(tnMismatches_sc,COUNT(LEFT.TerminalNodeMismatches),flattenTNMismatch(LEFT,COUNTER));

/******************************************************************************\
|*******************Step4 - Get Validation File for Auditing*******************|
\******************************************************************************/
  Layouts.AuditLayouts xGetLUCIAuditFile(LUCI_Points_Assignments_Pre L) := TRANSFORM
    SELF.GROUPTYPE  := RVG2005_0_1.RCCodes(L.RVG2005_0_1_Reasons[1]).GroupType;
    SELF.RCMessage1 := RVG2005_0_1.RCCodes(L.RVG2005_0_1_Reasons[1]).Description;
    SELF.RCMessage2 := RVG2005_0_1.RCCodes(L.RVG2005_0_1_Reasons[2]).Description;
    SELF.RCMessage3 := RVG2005_0_1.RCCodes(L.RVG2005_0_1_Reasons[3]).Description;
    SELF.RCMessage4 := RVG2005_0_1.RCCodes(L.RVG2005_0_1_Reasons[4]).Description;
    SELF.RCMessage5 := RVG2005_0_1.RCCodes(L.RVG2005_0_1_Reasons[5]).Description;

    //Scores
    SELF.rawscore:= L.RVG2005_0_1_OVERALL_Score0;
    SELF.predscr:= (600 + -50 * ((SELF.rawscore - LN(((1 - 0.2794912) * 0.2794912) / (0.2794912 * (1 - 0.2794912))) - -0.9469868) / LN(2)));
    SELF.finalscore := L.RVG2005_0_1_Score;
		//Reason Codes
    //SELF.ReasonCode  := L.RVG2005_0_1_Reasons;
    SELF.ReasonCode1 := L.RVG2005_0_1_Reasons[1];
    SELF.ReasonCode2 := L.RVG2005_0_1_Reasons[2];
    SELF.ReasonCode3 := L.RVG2005_0_1_Reasons[3];
    SELF.ReasonCode4 := L.RVG2005_0_1_Reasons[4];
    SELF.ReasonCode5 := L.RVG2005_0_1_Reasons[5];

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
  // DesprayAuditResult   := RVG2005_0_1.FNDesprayCSV(LUCI_AuditResult, TempLogical('~LUCI::AuditFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_AuditFile'));
  // DesprayComparision   := RVG2005_0_1.FNDesprayCSV(DS_Comp, TempLogical('~LUCI::ComparisonFile:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ComparisonFile'));
  // DesprayMismatches_SC := RVG2005_0_1.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_sc), TempLogical('~LUCI::Mismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_SC'));
  // DesprayTNMismatches_SC := RVG2005_0_1.FNDesprayCSV(tnMismatches_sc_full, TempLogical('~LUCI::TerminalNodeMismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_TNMismatches_SC'));
  // DesprayMismatches_RC := RVG2005_0_1.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_rc), TempLogical('~LUCI::Mismatches_RC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_RC'));
  // DesprayTNMismatches_RC := RVG2005_0_1.FNDesprayCSV(tnMismatches_rc_full, TempLogical('~LUCI::TerminalNodeMismatches_RC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_TNMismatches_RC'));
// SEQUENTIAL( DesprayAuditResult
            // ,DesprayComparision
            // ,DesprayMismatches_SC
            // ,DesprayTNMismatches_SC
            // ,DesprayMismatches_RC
            // ,DesprayTNMismatches_RC
            // );

