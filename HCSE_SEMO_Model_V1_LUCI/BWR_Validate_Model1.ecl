IMPORT UT,STD,LUCI;
IMPORT HCSE_SEMO_Model_V1_LUCI AS LUCI_Model;
SHARED Constants := LUCI.Constants;
SHARED Layouts := HCSE_SEMO_Model_V1_LUCI.z_layouts;
SHARED FNValidation := LUCI.FNValidationWithRC;
// SHARED FNValidation := LUCI.FNValidationWORC;
SHARED SampleSize := 1000; // The number of mismatches provided for review
SHARED Threshold_ScoreComp := 0.0000009; // The threshold setup for tree model.

/******************************************************************************\
|**************************Step 0 - Spray Input File***************************|
\******************************************************************************/
SHARED ModelName := 'Model1';
SHARED lzFilePathFolder  := '/data/LUCI/Model1/';
SHARED CSVSprayFile := 'Model1_luci_validationfile.csv';
SHARED lzFilePath        := lzFilePathFolder + CSVSprayFile;
SHARED SprayCSVName      := '~HCSE_SEMO_Model_V1_LUCI::' + (STRING)STD.Date.Today() + '::' + ModelName +'_from_csv'; // Will set up by user if test file is a logical file.
SHARED CSVSpraySeparator := '|'; // Will set up by user.
SHARED HeaderLine := 1; // Will set up by user.
SHARED isCSVFile := TRUE; // Will set up by user.
  LUCI.FNSpray(lzFilePath, SprayCSVName, CSVSpraySeparator);

/******************************************************************************\
|**************************Step 1a - Load Input File***************************|
\******************************************************************************/
  FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, HeaderLine, isCSVFile, CSVSpraySeparator);
SHARED RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_Model1 := TRUE, SELF := LEFT));

/******************************************************************************\
|**********************Step 1b - Standardized Input File***********************|
\******************************************************************************/
  FNValidation.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile);
SHARED pLUCIresults := LUCI_Model.AsResults(RawInputSet);
SHARED LUCIresults  := DISTRIBUTE(pLUCIresults.Validation(), hash32(TransactionID));
OUTPUT(LUCIresults, NAMED('LUCIresults'));

/******************************************************************************\
|****************Step 2 - Get Statistics of Final Scores, RC   ****************|
\******************************************************************************/
  FNValidation.MAC_CompareScore(LUCIresults, StdFile, Check_Result, pOutputSet);
  SHARED rc_mismatches := Check_Result(score_match,~rc_match);
  SHARED sc_mismatches := Check_Result(~score_match);
OUTPUT(rc_mismatches,,NAMED('rc_mismatches'));
OUTPUT(sc_mismatches,,NAMED('sc_mismatches'));
  SHARED Check_Result_rc_mismatch := CHOOSEN(rc_mismatches, SampleSize);
  SHARED Check_Result_sc_mismatch := CHOOSEN(sc_mismatches, SampleSize);
  SHARED mismatch_list_rc := SET(Check_Result_rc_mismatch, TransactionId);
  SHARED mismatch_list_sc := SET(Check_Result_sc_mismatch, TransactionId);

/******************************************************************************\
|***Step3 - Check Points Assignments and Reason Code of Mismatches(Optional)***|
\******************************************************************************/
  SHARED LUCI_Points_Assignments_Pre := LUCI_Model.AsResults(RawInputSet).ValidationF;

  Layouts.StandLayouts xGetLUCIPointsAssignments(LUCI_Points_Assignments_Pre L) := TRANSFORM
	  SELF.TransactionID := L.TransactionID;
    SELF.Score1 := L.Score1_Tree1_score;
    SELF.Score2 := L.Score1_Tree2_score;
    SELF.Score3 := L.Score1_Tree3_score;
    SELF.Score4 := L.Score1_Tree4_score;
    SELF.Score5 := L.Score1_Tree5_score;
    SELF.Score6 := L.Score1_Tree6_score;
    SELF.Score7 := L.Score1_Tree7_score;
    SELF.Score8 := L.Score1_Tree8_score;
    SELF.Score9 := L.Score1_Tree9_score;
    SELF.Score10 := L.Score1_Tree10_score;
    SELF.Score11 := L.Score1_Tree11_score;
    SELF.Score12 := L.Score1_Tree12_score;
    SELF.Score13 := L.Score1_Tree13_score;
    SELF.Score14 := L.Score1_Tree14_score;
    SELF.Score15 := L.Score1_Tree15_score;
    SELF.Score16 := L.Score1_Tree16_score;
    SELF.Score17 := L.Score1_Tree17_score;
    SELF.Score18 := L.Score1_Tree18_score;
    SELF.Score19 := L.Score1_Tree19_score;
    SELF.Score20 := L.Score1_Tree20_score;
    SELF.Score21 := L.Score1_Tree21_score;
    SELF.Score22 := L.Score1_Tree22_score;
    SELF.Score23 := L.Score1_Tree23_score;
    SELF.Score24 := L.Score1_Tree24_score;
    SELF.Score25 := L.Score1_Tree25_score;
    SELF.Score26 := L.Score1_Tree26_score;
    SELF.Score27 := L.Score1_Tree27_score;
    SELF.Score28 := L.Score1_Tree28_score;
    SELF.Score29 := L.Score1_Tree29_score;
    SELF.Score30 := L.Score1_Tree30_score;
    SELF.Score31 := L.Score1_Tree31_score;
    SELF.Score32 := L.Score1_Tree32_score;
    SELF.Score33 := L.Score1_Tree33_score;
    SELF.Score34 := L.Score1_Tree34_score;
    SELF.Score35 := L.Score1_Tree35_score;
    SELF.Score36 := L.Score1_Tree36_score;
    SELF.Score37 := L.Score1_Tree37_score;
    SELF.Score38 := L.Score1_Tree38_score;
    SELF.Score39 := L.Score1_Tree39_score;
    SELF.Score40 := L.Score1_Tree40_score;
    SELF.Score41 := L.Score1_Tree41_score;
    SELF.Score42 := L.Score1_Tree42_score;
    SELF.Score43 := L.Score1_Tree43_score;
    SELF.Score44 := L.Score1_Tree44_score;
    SELF.Score45 := L.Score1_Tree45_score;
    SELF.Score46 := L.Score1_Tree46_score;
    SELF.Score47 := L.Score1_Tree47_score;
    SELF.Score48 := L.Score1_Tree48_score;
    SELF.Score49 := L.Score1_Tree49_score;
    SELF.Score50 := L.Score1_Tree50_score;
    SELF.Score51 := L.Score1_Tree51_score;
    SELF.Score52 := L.Score1_Tree52_score;
    SELF.Score53 := L.Score1_Tree53_score;
    SELF.Score54 := L.Score1_Tree54_score;
    SELF.Score55 := L.Score1_Tree55_score;
    SELF.Score56 := L.Score1_Tree56_score;
    SELF.Score57 := L.Score1_Tree57_score;
    SELF.Score58 := L.Score1_Tree58_score;
    SELF.Score59 := L.Score1_Tree59_score;
    SELF.Score60 := L.Score1_Tree60_score;
    SELF.Score61 := L.Score1_Tree61_score;
    SELF.Score62 := L.Score1_Tree62_score;
    SELF.Score63 := L.Score1_Tree63_score;
    SELF.Score64 := L.Score1_Tree64_score;
    SELF.Score65 := L.Score1_Tree65_score;
    SELF.Score66 := L.Score1_Tree66_score;
    SELF.Score67 := L.Score1_Tree67_score;
    SELF.Score68 := L.Score1_Tree68_score;
    SELF.Score69 := L.Score1_Tree69_score;
    SELF.Score70 := L.Score1_Tree70_score;
    SELF.Score71 := L.Score1_Tree71_score;
    SELF.Score72 := L.Score1_Tree72_score;
    SELF.Score73 := L.Score1_Tree73_score;
    SELF.Score74 := L.Score1_Tree74_score;
    SELF.Score75 := L.Score1_Tree75_score;
    SELF.Score76 := L.Score1_Tree76_score;
    SELF.Score77 := L.Score1_Tree77_score;
    SELF.Score78 := L.Score1_Tree78_score;
    SELF.Score79 := L.Score1_Tree79_score;
    SELF.Score80 := L.Score1_Tree80_score;
    SELF.Score81 := L.Score1_Tree81_score;
    SELF.Score82 := L.Score1_Tree82_score;
    SELF.Score83 := L.Score1_Tree83_score;
    SELF.Score84 := L.Score1_Tree84_score;
    SELF.Score85 := L.Score1_Tree85_score;
    SELF.Score86 := L.Score1_Tree86_score;
    SELF.Score87 := L.Score1_Tree87_score;
    SELF.Score88 := L.Score1_Tree88_score;
    SELF.Score89 := L.Score1_Tree89_score;
    SELF.Score90 := L.Score1_Tree90_score;
    SELF.Score91 := L.Score1_Tree91_score;
    SELF.Score92 := L.Score1_Tree92_score;
    SELF.Score93 := L.Score1_Tree93_score;
    SELF.Score94 := L.Score1_Tree94_score;
    SELF.Score95 := L.Score1_Tree95_score;
    SELF.Score96 := L.Score1_Tree96_score;
    SELF.Score97 := L.Score1_Tree97_score;
    SELF.Score98 := L.Score1_Tree98_score;
    SELF.Score99 := L.Score1_Tree99_score;
    SELF.Score100 := L.Score1_Tree100_score;
    SELF.Score101 := L.Score1_Tree101_score;
    SELF.Score102 := L.Score1_Tree102_score;
    SELF.Score103 := L.Score1_Tree103_score;
    SELF.Score104 := L.Score1_Tree104_score;
    SELF.Score105 := L.Score1_Tree105_score;
    SELF.Score106 := L.Score1_Tree106_score;
    SELF.Score107 := L.Score1_Tree107_score;
    SELF.Score108 := L.Score1_Tree108_score;
    SELF.Score109 := L.Score1_Tree109_score;
    SELF.Score110 := L.Score1_Tree110_score;
    SELF.Score111 := L.Score1_Tree111_score;
    SELF.Score112 := L.Score1_Tree112_score;
    SELF.Score113 := L.Score1_Tree113_score;
    SELF.Score114 := L.Score1_Tree114_score;
    SELF.Score115 := L.Score1_Tree115_score;
    SELF.Score116 := L.Score1_Tree116_score;
    SELF.Score117 := L.Score1_Tree117_score;
    SELF.Score118 := L.Score1_Tree118_score;
    SELF.Score119 := L.Score1_Tree119_score;
    SELF.Score120 := L.Score1_Tree120_score;
    SELF.Score121 := L.Score1_Tree121_score;
    SELF.Score122 := L.Score1_Tree122_score;
    SELF.Score123 := L.Score1_Tree123_score;
    SELF.Score124 := L.Score1_Tree124_score;
    SELF.Score125 := L.Score1_Tree125_score;
    SELF.Score126 := L.Score1_Tree126_score;
    SELF.Score127 := L.Score1_Tree127_score;
    SELF.Score128 := L.Score1_Tree128_score;
    SELF.Score129 := L.Score1_Tree129_score;
    SELF.Score130 := L.Score1_Tree130_score;
    SELF.Score131 := L.Score1_Tree131_score;
    SELF.Score132 := L.Score1_Tree132_score;
    SELF.Score133 := L.Score1_Tree133_score;
    SELF.Score134 := L.Score1_Tree134_score;
    SELF.Score135 := L.Score1_Tree135_score;
    SELF.Score136 := L.Score1_Tree136_score;
    SELF.Score137 := L.Score1_Tree137_score;
    SELF.Score138 := L.Score1_Tree138_score;
    SELF.Score139 := L.Score1_Tree139_score;
    SELF.Score140 := L.Score1_Tree140_score;
    SELF.Score141 := L.Score1_Tree141_score;
    SELF.Score142 := L.Score1_Tree142_score;
    SELF.Score143 := L.Score1_Tree143_score;
    SELF.Score144 := L.Score1_Tree144_score;
    SELF.Score145 := L.Score1_Tree145_score;
    SELF.Score146 := L.Score1_Tree146_score;
    SELF.Score147 := L.Score1_Tree147_score;
    SELF.Score148 := L.Score1_Tree148_score;
    SELF.Score149 := L.Score1_Tree149_score;
    SELF.Score150 := L.Score1_Tree150_score;
    SELF.Score151 := L.Score1_Tree151_score;
    SELF.Score152 := L.Score1_Tree152_score;
    SELF.Score153 := L.Score1_Tree153_score;
    SELF.Score154 := L.Score1_Tree154_score;
    SELF.Score155 := L.Score1_Tree155_score;
    SELF.Score156 := L.Score1_Tree156_score;
    SELF.Score157 := L.Score1_Tree157_score;
    SELF.Score158 := L.Score1_Tree158_score;
    SELF.Score159 := L.Score1_Tree159_score;
    SELF.Score160 := L.Score1_Tree160_score;
    SELF.Score161 := L.Score1_Tree161_score;
    SELF.Score162 := L.Score1_Tree162_score;
    SELF.Score163 := L.Score1_Tree163_score;
    SELF.Score164 := L.Score1_Tree164_score;
    SELF.Score165 := L.Score1_Tree165_score;
    SELF.Score166 := L.Score1_Tree166_score;
    SELF.Score167 := L.Score1_Tree167_score;
    SELF.Score168 := L.Score1_Tree168_score;
    SELF.Score169 := L.Score1_Tree169_score;
    SELF.Score170 := L.Score1_Tree170_score;
    SELF.Score171 := L.Score1_Tree171_score;
    SELF.Score172 := L.Score1_Tree172_score;
    SELF.Score173 := L.Score1_Tree173_score;
    SELF.Score174 := L.Score1_Tree174_score;
    SELF.Score175 := L.Score1_Tree175_score;
    SELF.Score176 := L.Score1_Tree176_score;
    SELF.Score177 := L.Score1_Tree177_score;
    SELF.Score178 := L.Score1_Tree178_score;
    SELF.Score179 := L.Score1_Tree179_score;
    SELF.Score180 := L.Score1_Tree180_score;
    SELF.Score181 := L.Score1_Tree181_score;
    SELF.Score182 := L.Score1_Tree182_score;
    SELF.Score183 := L.Score1_Tree183_score;
    SELF.Score184 := L.Score1_Tree184_score;
    SELF.Score185 := L.Score1_Tree185_score;
    SELF.Score186 := L.Score1_Tree186_score;
    SELF.Score187 := L.Score1_Tree187_score;
    SELF.Score188 := L.Score1_Tree188_score;
    SELF.Score189 := L.Score1_Tree189_score;
    SELF.Score190 := L.Score1_Tree190_score;
    SELF.Score191 := L.Score1_Tree191_score;
    SELF.Score192 := L.Score1_Tree192_score;
    SELF.Score193 := L.Score1_Tree193_score;
    SELF.Score194 := L.Score1_Tree194_score;
    SELF.Score195 := L.Score1_Tree195_score;
    SELF.Score196 := L.Score1_Tree196_score;
    SELF.Score197 := L.Score1_Tree197_score;
    SELF.Score198 := L.Score1_Tree198_score;
    SELF.Score199 := L.Score1_Tree199_score;
    SELF.Score200 := L.Score1_Tree200_score;
    SELF.Score201 := L.Score1_Tree201_score;
    SELF.Score202 := L.Score1_Tree202_score;
    SELF.Score203 := L.Score1_Tree203_score;
    SELF.Score204 := L.Score1_Tree204_score;
    SELF.Score205 := L.Score1_Tree205_score;
    SELF.Score206 := L.Score1_Tree206_score;
    SELF.Score207 := L.Score1_Tree207_score;
    SELF.Score208 := L.Score1_Tree208_score;
    SELF.Score209 := L.Score1_Tree209_score;
    SELF.Score210 := L.Score1_Tree210_score;
    SELF.Score211 := L.Score1_Tree211_score;
    SELF.Score212 := L.Score1_Tree212_score;
    SELF.Score213 := L.Score1_Tree213_score;
    SELF.Score214 := L.Score1_Tree214_score;
    SELF.Score215 := L.Score1_Tree215_score;
    SELF.Score216 := L.Score1_Tree216_score;
    SELF.Score217 := L.Score1_Tree217_score;
    SELF.Score218 := L.Score1_Tree218_score;
    SELF.Score219 := L.Score1_Tree219_score;
    SELF.Score220 := L.Score1_Tree220_score;
    SELF.Score221 := L.Score1_Tree221_score;
    SELF.Score222 := L.Score1_Tree222_score;
    SELF.Score223 := L.Score1_Tree223_score;
    SELF.Score224 := L.Score1_Tree224_score;
    SELF.Score225 := L.Score1_Tree225_score;
    SELF.Score226 := L.Score1_Tree226_score;
    SELF.Score227 := L.Score1_Tree227_score;
    SELF.Score228 := L.Score1_Tree228_score;
    SELF.Score229 := L.Score1_Tree229_score;
    SELF.Score230 := L.Score1_Tree230_score;
    SELF.Score231 := L.Score1_Tree231_score;
    SELF.Score232 := L.Score1_Tree232_score;
    SELF.Score233 := L.Score1_Tree233_score;
    SELF.Score234 := L.Score1_Tree234_score;
    SELF.Score235 := L.Score1_Tree235_score;
    SELF.Score236 := L.Score1_Tree236_score;
    SELF.Score237 := L.Score1_Tree237_score;
    SELF.Score238 := L.Score1_Tree238_score;
    SELF.Score239 := L.Score1_Tree239_score;
    SELF.Score240 := L.Score1_Tree240_score;
    SELF.Score241 := L.Score1_Tree241_score;
    SELF.Score242 := L.Score1_Tree242_score;
    SELF.Score243 := L.Score1_Tree243_score;
    SELF.Score244 := L.Score1_Tree244_score;
    SELF.Score245 := L.Score1_Tree245_score;
    SELF.Score246 := L.Score1_Tree246_score;
    SELF.Score247 := L.Score1_Tree247_score;
    SELF.Score248 := L.Score1_Tree248_score;
    SELF.Score249 := L.Score1_Tree249_score;
    SELF.Score250 := L.Score1_Tree250_score;
    SELF.Score251 := L.Score1_Tree251_score;
    SELF.Score252 := L.Score1_Tree252_score;
    SELF.Score253 := L.Score1_Tree253_score;
    SELF.Score254 := L.Score1_Tree254_score;
    SELF.Score255 := L.Score1_Tree255_score;
    SELF.Score256 := L.Score1_Tree256_score;

    //Scores
    SELF.rawscore:= L.Model1_Score1_Score0;
    SELF.predscr:= SELF.rawscore;
    SELF.finalscore := L.Model1_Score;
    SELF.SOURCE := 'HPCC';
    SELF.stdrawscore  := (string)(unsigned)L.Model1_Score1_Score0;
    SELF.std_scr := (string)(unsigned)L.Model1_Score;
    SELF := L;
    SELF := [];
  END;
  SHARED LUCI_Points_Assignments :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIPointsAssignments(LEFT));
  SHARED DS_Comp_pre := SORT(LUCI_Points_Assignments + StdFile, TransactionID) ;
  SHARED DS_Comp := PROJECT(DS_Comp_pre, layouts.StandLayouts) ;
OUTPUT(DS_Comp( TransactionID in mismatch_list_rc),,NAMED('rc_mismatches_details'));
OUTPUT(DS_Comp( TransactionID in Mismatch_list_sc),,NAMED('sc_mismatches_details'));
OUTPUT(DS_Comp,,NAMED('AuditComparison'));

/*******************************************************************************************\
|***Step3b* - If any mismatches - output mismatches list of each individual tree for RICKY***|
\*******************************************************************************************/
IndividualTreeTest_Rec := RECORD
	STRING20 TransactionID;
	REAL Score1_comp;
	REAL Score2_comp;
	REAL Score3_comp;
	REAL Score4_comp;
	REAL Score5_comp;
	REAL Score6_comp;
	REAL Score7_comp;
	REAL Score8_comp;
	REAL Score9_comp;
	REAL Score10_comp;
	REAL Score11_comp;
	REAL Score12_comp;
	REAL Score13_comp;
	REAL Score14_comp;
	REAL Score15_comp;
	REAL Score16_comp;
	REAL Score17_comp;
	REAL Score18_comp;
	REAL Score19_comp;
	REAL Score20_comp;
	REAL Score21_comp;
	REAL Score22_comp;
	REAL Score23_comp;
	REAL Score24_comp;
	REAL Score25_comp;
	REAL Score26_comp;
	REAL Score27_comp;
	REAL Score28_comp;
	REAL Score29_comp;
	REAL Score30_comp;
	REAL Score31_comp;
	REAL Score32_comp;
	REAL Score33_comp;
	REAL Score34_comp;
	REAL Score35_comp;
	REAL Score36_comp;
	REAL Score37_comp;
	REAL Score38_comp;
	REAL Score39_comp;
	REAL Score40_comp;
	REAL Score41_comp;
	REAL Score42_comp;
	REAL Score43_comp;
	REAL Score44_comp;
	REAL Score45_comp;
	REAL Score46_comp;
	REAL Score47_comp;
	REAL Score48_comp;
	REAL Score49_comp;
	REAL Score50_comp;
	REAL Score51_comp;
	REAL Score52_comp;
	REAL Score53_comp;
	REAL Score54_comp;
	REAL Score55_comp;
	REAL Score56_comp;
	REAL Score57_comp;
	REAL Score58_comp;
	REAL Score59_comp;
	REAL Score60_comp;
	REAL Score61_comp;
	REAL Score62_comp;
	REAL Score63_comp;
	REAL Score64_comp;
	REAL Score65_comp;
	REAL Score66_comp;
	REAL Score67_comp;
	REAL Score68_comp;
	REAL Score69_comp;
	REAL Score70_comp;
	REAL Score71_comp;
	REAL Score72_comp;
	REAL Score73_comp;
	REAL Score74_comp;
	REAL Score75_comp;
	REAL Score76_comp;
	REAL Score77_comp;
	REAL Score78_comp;
	REAL Score79_comp;
	REAL Score80_comp;
	REAL Score81_comp;
	REAL Score82_comp;
	REAL Score83_comp;
	REAL Score84_comp;
	REAL Score85_comp;
	REAL Score86_comp;
	REAL Score87_comp;
	REAL Score88_comp;
	REAL Score89_comp;
	REAL Score90_comp;
	REAL Score91_comp;
	REAL Score92_comp;
	REAL Score93_comp;
	REAL Score94_comp;
	REAL Score95_comp;
	REAL Score96_comp;
	REAL Score97_comp;
	REAL Score98_comp;
	REAL Score99_comp;
	REAL Score100_comp;
	REAL Score101_comp;
	REAL Score102_comp;
	REAL Score103_comp;
	REAL Score104_comp;
	REAL Score105_comp;
	REAL Score106_comp;
	REAL Score107_comp;
	REAL Score108_comp;
	REAL Score109_comp;
	REAL Score110_comp;
	REAL Score111_comp;
	REAL Score112_comp;
	REAL Score113_comp;
	REAL Score114_comp;
	REAL Score115_comp;
	REAL Score116_comp;
	REAL Score117_comp;
	REAL Score118_comp;
	REAL Score119_comp;
	REAL Score120_comp;
	REAL Score121_comp;
	REAL Score122_comp;
	REAL Score123_comp;
	REAL Score124_comp;
	REAL Score125_comp;
	REAL Score126_comp;
	REAL Score127_comp;
	REAL Score128_comp;
	REAL Score129_comp;
	REAL Score130_comp;
	REAL Score131_comp;
	REAL Score132_comp;
	REAL Score133_comp;
	REAL Score134_comp;
	REAL Score135_comp;
	REAL Score136_comp;
	REAL Score137_comp;
	REAL Score138_comp;
	REAL Score139_comp;
	REAL Score140_comp;
	REAL Score141_comp;
	REAL Score142_comp;
	REAL Score143_comp;
	REAL Score144_comp;
	REAL Score145_comp;
	REAL Score146_comp;
	REAL Score147_comp;
	REAL Score148_comp;
	REAL Score149_comp;
	REAL Score150_comp;
	REAL Score151_comp;
	REAL Score152_comp;
	REAL Score153_comp;
	REAL Score154_comp;
	REAL Score155_comp;
	REAL Score156_comp;
	REAL Score157_comp;
	REAL Score158_comp;
	REAL Score159_comp;
	REAL Score160_comp;
	REAL Score161_comp;
	REAL Score162_comp;
	REAL Score163_comp;
	REAL Score164_comp;
	REAL Score165_comp;
	REAL Score166_comp;
	REAL Score167_comp;
	REAL Score168_comp;
	REAL Score169_comp;
	REAL Score170_comp;
	REAL Score171_comp;
	REAL Score172_comp;
	REAL Score173_comp;
	REAL Score174_comp;
	REAL Score175_comp;
	REAL Score176_comp;
	REAL Score177_comp;
	REAL Score178_comp;
	REAL Score179_comp;
	REAL Score180_comp;
	REAL Score181_comp;
	REAL Score182_comp;
	REAL Score183_comp;
	REAL Score184_comp;
	REAL Score185_comp;
	REAL Score186_comp;
	REAL Score187_comp;
	REAL Score188_comp;
	REAL Score189_comp;
	REAL Score190_comp;
	REAL Score191_comp;
	REAL Score192_comp;
	REAL Score193_comp;
	REAL Score194_comp;
	REAL Score195_comp;
	REAL Score196_comp;
	REAL Score197_comp;
	REAL Score198_comp;
	REAL Score199_comp;
	REAL Score200_comp;
	REAL Score201_comp;
	REAL Score202_comp;
	REAL Score203_comp;
	REAL Score204_comp;
	REAL Score205_comp;
	REAL Score206_comp;
	REAL Score207_comp;
	REAL Score208_comp;
	REAL Score209_comp;
	REAL Score210_comp;
	REAL Score211_comp;
	REAL Score212_comp;
	REAL Score213_comp;
	REAL Score214_comp;
	REAL Score215_comp;
	REAL Score216_comp;
	REAL Score217_comp;
	REAL Score218_comp;
	REAL Score219_comp;
	REAL Score220_comp;
	REAL Score221_comp;
	REAL Score222_comp;
	REAL Score223_comp;
	REAL Score224_comp;
	REAL Score225_comp;
	REAL Score226_comp;
	REAL Score227_comp;
	REAL Score228_comp;
	REAL Score229_comp;
	REAL Score230_comp;
	REAL Score231_comp;
	REAL Score232_comp;
	REAL Score233_comp;
	REAL Score234_comp;
	REAL Score235_comp;
	REAL Score236_comp;
	REAL Score237_comp;
	REAL Score238_comp;
	REAL Score239_comp;
	REAL Score240_comp;
	REAL Score241_comp;
	REAL Score242_comp;
	REAL Score243_comp;
	REAL Score244_comp;
	REAL Score245_comp;
	REAL Score246_comp;
	REAL Score247_comp;
	REAL Score248_comp;
	REAL Score249_comp;
	REAL Score250_comp;
	REAL Score251_comp;
	REAL Score252_comp;
	REAL Score253_comp;
	REAL Score254_comp;
	REAL Score255_comp;
	REAL Score256_comp;

END;
GetCompTable(real compValue):= FUNCTION
IndividualTreeTest_Rec xGetCompTable(StdFile L, LUCI_Points_Assignments R) := TRANSFORM
    SELF.Score1_comp    := IF(abs( ROUND( L.Score1 ,7) - ROUND(   R.Score1, 7 ))< CompValue, 0, 1);
    SELF.Score2_comp    := IF(abs( ROUND( L.Score2 ,7) - ROUND(   R.Score2, 7 ))< CompValue, 0, 1);
    SELF.Score3_comp    := IF(abs( ROUND( L.Score3 ,7) - ROUND(   R.Score3, 7 ))< CompValue, 0, 1);
    SELF.Score4_comp    := IF(abs( ROUND( L.Score4 ,7) - ROUND(   R.Score4, 7 ))< CompValue, 0, 1);
    SELF.Score5_comp    := IF(abs( ROUND( L.Score5 ,7) - ROUND(   R.Score5, 7 ))< CompValue, 0, 1);
    SELF.Score6_comp    := IF(abs( ROUND( L.Score6 ,7) - ROUND(   R.Score6, 7 ))< CompValue, 0, 1);
    SELF.Score7_comp    := IF(abs( ROUND( L.Score7 ,7) - ROUND(   R.Score7, 7 ))< CompValue, 0, 1);
    SELF.Score8_comp    := IF(abs( ROUND( L.Score8 ,7) - ROUND(   R.Score8, 7 ))< CompValue, 0, 1);
    SELF.Score9_comp    := IF(abs( ROUND( L.Score9 ,7) - ROUND(   R.Score9, 7 ))< CompValue, 0, 1);
    SELF.Score10_comp    := IF(abs( ROUND( L.Score10 ,7) - ROUND(   R.Score10, 7 ))< CompValue, 0, 1);
    SELF.Score11_comp    := IF(abs( ROUND( L.Score11 ,7) - ROUND(   R.Score11, 7 ))< CompValue, 0, 1);
    SELF.Score12_comp    := IF(abs( ROUND( L.Score12 ,7) - ROUND(   R.Score12, 7 ))< CompValue, 0, 1);
    SELF.Score13_comp    := IF(abs( ROUND( L.Score13 ,7) - ROUND(   R.Score13, 7 ))< CompValue, 0, 1);
    SELF.Score14_comp    := IF(abs( ROUND( L.Score14 ,7) - ROUND(   R.Score14, 7 ))< CompValue, 0, 1);
    SELF.Score15_comp    := IF(abs( ROUND( L.Score15 ,7) - ROUND(   R.Score15, 7 ))< CompValue, 0, 1);
    SELF.Score16_comp    := IF(abs( ROUND( L.Score16 ,7) - ROUND(   R.Score16, 7 ))< CompValue, 0, 1);
    SELF.Score17_comp    := IF(abs( ROUND( L.Score17 ,7) - ROUND(   R.Score17, 7 ))< CompValue, 0, 1);
    SELF.Score18_comp    := IF(abs( ROUND( L.Score18 ,7) - ROUND(   R.Score18, 7 ))< CompValue, 0, 1);
    SELF.Score19_comp    := IF(abs( ROUND( L.Score19 ,7) - ROUND(   R.Score19, 7 ))< CompValue, 0, 1);
    SELF.Score20_comp    := IF(abs( ROUND( L.Score20 ,7) - ROUND(   R.Score20, 7 ))< CompValue, 0, 1);
    SELF.Score21_comp    := IF(abs( ROUND( L.Score21 ,7) - ROUND(   R.Score21, 7 ))< CompValue, 0, 1);
    SELF.Score22_comp    := IF(abs( ROUND( L.Score22 ,7) - ROUND(   R.Score22, 7 ))< CompValue, 0, 1);
    SELF.Score23_comp    := IF(abs( ROUND( L.Score23 ,7) - ROUND(   R.Score23, 7 ))< CompValue, 0, 1);
    SELF.Score24_comp    := IF(abs( ROUND( L.Score24 ,7) - ROUND(   R.Score24, 7 ))< CompValue, 0, 1);
    SELF.Score25_comp    := IF(abs( ROUND( L.Score25 ,7) - ROUND(   R.Score25, 7 ))< CompValue, 0, 1);
    SELF.Score26_comp    := IF(abs( ROUND( L.Score26 ,7) - ROUND(   R.Score26, 7 ))< CompValue, 0, 1);
    SELF.Score27_comp    := IF(abs( ROUND( L.Score27 ,7) - ROUND(   R.Score27, 7 ))< CompValue, 0, 1);
    SELF.Score28_comp    := IF(abs( ROUND( L.Score28 ,7) - ROUND(   R.Score28, 7 ))< CompValue, 0, 1);
    SELF.Score29_comp    := IF(abs( ROUND( L.Score29 ,7) - ROUND(   R.Score29, 7 ))< CompValue, 0, 1);
    SELF.Score30_comp    := IF(abs( ROUND( L.Score30 ,7) - ROUND(   R.Score30, 7 ))< CompValue, 0, 1);
    SELF.Score31_comp    := IF(abs( ROUND( L.Score31 ,7) - ROUND(   R.Score31, 7 ))< CompValue, 0, 1);
    SELF.Score32_comp    := IF(abs( ROUND( L.Score32 ,7) - ROUND(   R.Score32, 7 ))< CompValue, 0, 1);
    SELF.Score33_comp    := IF(abs( ROUND( L.Score33 ,7) - ROUND(   R.Score33, 7 ))< CompValue, 0, 1);
    SELF.Score34_comp    := IF(abs( ROUND( L.Score34 ,7) - ROUND(   R.Score34, 7 ))< CompValue, 0, 1);
    SELF.Score35_comp    := IF(abs( ROUND( L.Score35 ,7) - ROUND(   R.Score35, 7 ))< CompValue, 0, 1);
    SELF.Score36_comp    := IF(abs( ROUND( L.Score36 ,7) - ROUND(   R.Score36, 7 ))< CompValue, 0, 1);
    SELF.Score37_comp    := IF(abs( ROUND( L.Score37 ,7) - ROUND(   R.Score37, 7 ))< CompValue, 0, 1);
    SELF.Score38_comp    := IF(abs( ROUND( L.Score38 ,7) - ROUND(   R.Score38, 7 ))< CompValue, 0, 1);
    SELF.Score39_comp    := IF(abs( ROUND( L.Score39 ,7) - ROUND(   R.Score39, 7 ))< CompValue, 0, 1);
    SELF.Score40_comp    := IF(abs( ROUND( L.Score40 ,7) - ROUND(   R.Score40, 7 ))< CompValue, 0, 1);
    SELF.Score41_comp    := IF(abs( ROUND( L.Score41 ,7) - ROUND(   R.Score41, 7 ))< CompValue, 0, 1);
    SELF.Score42_comp    := IF(abs( ROUND( L.Score42 ,7) - ROUND(   R.Score42, 7 ))< CompValue, 0, 1);
    SELF.Score43_comp    := IF(abs( ROUND( L.Score43 ,7) - ROUND(   R.Score43, 7 ))< CompValue, 0, 1);
    SELF.Score44_comp    := IF(abs( ROUND( L.Score44 ,7) - ROUND(   R.Score44, 7 ))< CompValue, 0, 1);
    SELF.Score45_comp    := IF(abs( ROUND( L.Score45 ,7) - ROUND(   R.Score45, 7 ))< CompValue, 0, 1);
    SELF.Score46_comp    := IF(abs( ROUND( L.Score46 ,7) - ROUND(   R.Score46, 7 ))< CompValue, 0, 1);
    SELF.Score47_comp    := IF(abs( ROUND( L.Score47 ,7) - ROUND(   R.Score47, 7 ))< CompValue, 0, 1);
    SELF.Score48_comp    := IF(abs( ROUND( L.Score48 ,7) - ROUND(   R.Score48, 7 ))< CompValue, 0, 1);
    SELF.Score49_comp    := IF(abs( ROUND( L.Score49 ,7) - ROUND(   R.Score49, 7 ))< CompValue, 0, 1);
    SELF.Score50_comp    := IF(abs( ROUND( L.Score50 ,7) - ROUND(   R.Score50, 7 ))< CompValue, 0, 1);
    SELF.Score51_comp    := IF(abs( ROUND( L.Score51 ,7) - ROUND(   R.Score51, 7 ))< CompValue, 0, 1);
    SELF.Score52_comp    := IF(abs( ROUND( L.Score52 ,7) - ROUND(   R.Score52, 7 ))< CompValue, 0, 1);
    SELF.Score53_comp    := IF(abs( ROUND( L.Score53 ,7) - ROUND(   R.Score53, 7 ))< CompValue, 0, 1);
    SELF.Score54_comp    := IF(abs( ROUND( L.Score54 ,7) - ROUND(   R.Score54, 7 ))< CompValue, 0, 1);
    SELF.Score55_comp    := IF(abs( ROUND( L.Score55 ,7) - ROUND(   R.Score55, 7 ))< CompValue, 0, 1);
    SELF.Score56_comp    := IF(abs( ROUND( L.Score56 ,7) - ROUND(   R.Score56, 7 ))< CompValue, 0, 1);
    SELF.Score57_comp    := IF(abs( ROUND( L.Score57 ,7) - ROUND(   R.Score57, 7 ))< CompValue, 0, 1);
    SELF.Score58_comp    := IF(abs( ROUND( L.Score58 ,7) - ROUND(   R.Score58, 7 ))< CompValue, 0, 1);
    SELF.Score59_comp    := IF(abs( ROUND( L.Score59 ,7) - ROUND(   R.Score59, 7 ))< CompValue, 0, 1);
    SELF.Score60_comp    := IF(abs( ROUND( L.Score60 ,7) - ROUND(   R.Score60, 7 ))< CompValue, 0, 1);
    SELF.Score61_comp    := IF(abs( ROUND( L.Score61 ,7) - ROUND(   R.Score61, 7 ))< CompValue, 0, 1);
    SELF.Score62_comp    := IF(abs( ROUND( L.Score62 ,7) - ROUND(   R.Score62, 7 ))< CompValue, 0, 1);
    SELF.Score63_comp    := IF(abs( ROUND( L.Score63 ,7) - ROUND(   R.Score63, 7 ))< CompValue, 0, 1);
    SELF.Score64_comp    := IF(abs( ROUND( L.Score64 ,7) - ROUND(   R.Score64, 7 ))< CompValue, 0, 1);
    SELF.Score65_comp    := IF(abs( ROUND( L.Score65 ,7) - ROUND(   R.Score65, 7 ))< CompValue, 0, 1);
    SELF.Score66_comp    := IF(abs( ROUND( L.Score66 ,7) - ROUND(   R.Score66, 7 ))< CompValue, 0, 1);
    SELF.Score67_comp    := IF(abs( ROUND( L.Score67 ,7) - ROUND(   R.Score67, 7 ))< CompValue, 0, 1);
    SELF.Score68_comp    := IF(abs( ROUND( L.Score68 ,7) - ROUND(   R.Score68, 7 ))< CompValue, 0, 1);
    SELF.Score69_comp    := IF(abs( ROUND( L.Score69 ,7) - ROUND(   R.Score69, 7 ))< CompValue, 0, 1);
    SELF.Score70_comp    := IF(abs( ROUND( L.Score70 ,7) - ROUND(   R.Score70, 7 ))< CompValue, 0, 1);
    SELF.Score71_comp    := IF(abs( ROUND( L.Score71 ,7) - ROUND(   R.Score71, 7 ))< CompValue, 0, 1);
    SELF.Score72_comp    := IF(abs( ROUND( L.Score72 ,7) - ROUND(   R.Score72, 7 ))< CompValue, 0, 1);
    SELF.Score73_comp    := IF(abs( ROUND( L.Score73 ,7) - ROUND(   R.Score73, 7 ))< CompValue, 0, 1);
    SELF.Score74_comp    := IF(abs( ROUND( L.Score74 ,7) - ROUND(   R.Score74, 7 ))< CompValue, 0, 1);
    SELF.Score75_comp    := IF(abs( ROUND( L.Score75 ,7) - ROUND(   R.Score75, 7 ))< CompValue, 0, 1);
    SELF.Score76_comp    := IF(abs( ROUND( L.Score76 ,7) - ROUND(   R.Score76, 7 ))< CompValue, 0, 1);
    SELF.Score77_comp    := IF(abs( ROUND( L.Score77 ,7) - ROUND(   R.Score77, 7 ))< CompValue, 0, 1);
    SELF.Score78_comp    := IF(abs( ROUND( L.Score78 ,7) - ROUND(   R.Score78, 7 ))< CompValue, 0, 1);
    SELF.Score79_comp    := IF(abs( ROUND( L.Score79 ,7) - ROUND(   R.Score79, 7 ))< CompValue, 0, 1);
    SELF.Score80_comp    := IF(abs( ROUND( L.Score80 ,7) - ROUND(   R.Score80, 7 ))< CompValue, 0, 1);
    SELF.Score81_comp    := IF(abs( ROUND( L.Score81 ,7) - ROUND(   R.Score81, 7 ))< CompValue, 0, 1);
    SELF.Score82_comp    := IF(abs( ROUND( L.Score82 ,7) - ROUND(   R.Score82, 7 ))< CompValue, 0, 1);
    SELF.Score83_comp    := IF(abs( ROUND( L.Score83 ,7) - ROUND(   R.Score83, 7 ))< CompValue, 0, 1);
    SELF.Score84_comp    := IF(abs( ROUND( L.Score84 ,7) - ROUND(   R.Score84, 7 ))< CompValue, 0, 1);
    SELF.Score85_comp    := IF(abs( ROUND( L.Score85 ,7) - ROUND(   R.Score85, 7 ))< CompValue, 0, 1);
    SELF.Score86_comp    := IF(abs( ROUND( L.Score86 ,7) - ROUND(   R.Score86, 7 ))< CompValue, 0, 1);
    SELF.Score87_comp    := IF(abs( ROUND( L.Score87 ,7) - ROUND(   R.Score87, 7 ))< CompValue, 0, 1);
    SELF.Score88_comp    := IF(abs( ROUND( L.Score88 ,7) - ROUND(   R.Score88, 7 ))< CompValue, 0, 1);
    SELF.Score89_comp    := IF(abs( ROUND( L.Score89 ,7) - ROUND(   R.Score89, 7 ))< CompValue, 0, 1);
    SELF.Score90_comp    := IF(abs( ROUND( L.Score90 ,7) - ROUND(   R.Score90, 7 ))< CompValue, 0, 1);
    SELF.Score91_comp    := IF(abs( ROUND( L.Score91 ,7) - ROUND(   R.Score91, 7 ))< CompValue, 0, 1);
    SELF.Score92_comp    := IF(abs( ROUND( L.Score92 ,7) - ROUND(   R.Score92, 7 ))< CompValue, 0, 1);
    SELF.Score93_comp    := IF(abs( ROUND( L.Score93 ,7) - ROUND(   R.Score93, 7 ))< CompValue, 0, 1);
    SELF.Score94_comp    := IF(abs( ROUND( L.Score94 ,7) - ROUND(   R.Score94, 7 ))< CompValue, 0, 1);
    SELF.Score95_comp    := IF(abs( ROUND( L.Score95 ,7) - ROUND(   R.Score95, 7 ))< CompValue, 0, 1);
    SELF.Score96_comp    := IF(abs( ROUND( L.Score96 ,7) - ROUND(   R.Score96, 7 ))< CompValue, 0, 1);
    SELF.Score97_comp    := IF(abs( ROUND( L.Score97 ,7) - ROUND(   R.Score97, 7 ))< CompValue, 0, 1);
    SELF.Score98_comp    := IF(abs( ROUND( L.Score98 ,7) - ROUND(   R.Score98, 7 ))< CompValue, 0, 1);
    SELF.Score99_comp    := IF(abs( ROUND( L.Score99 ,7) - ROUND(   R.Score99, 7 ))< CompValue, 0, 1);
    SELF.Score100_comp    := IF(abs( ROUND( L.Score100 ,7) - ROUND(   R.Score100, 7 ))< CompValue, 0, 1);
    SELF.Score101_comp    := IF(abs( ROUND( L.Score101 ,7) - ROUND(   R.Score101, 7 ))< CompValue, 0, 1);
    SELF.Score102_comp    := IF(abs( ROUND( L.Score102 ,7) - ROUND(   R.Score102, 7 ))< CompValue, 0, 1);
    SELF.Score103_comp    := IF(abs( ROUND( L.Score103 ,7) - ROUND(   R.Score103, 7 ))< CompValue, 0, 1);
    SELF.Score104_comp    := IF(abs( ROUND( L.Score104 ,7) - ROUND(   R.Score104, 7 ))< CompValue, 0, 1);
    SELF.Score105_comp    := IF(abs( ROUND( L.Score105 ,7) - ROUND(   R.Score105, 7 ))< CompValue, 0, 1);
    SELF.Score106_comp    := IF(abs( ROUND( L.Score106 ,7) - ROUND(   R.Score106, 7 ))< CompValue, 0, 1);
    SELF.Score107_comp    := IF(abs( ROUND( L.Score107 ,7) - ROUND(   R.Score107, 7 ))< CompValue, 0, 1);
    SELF.Score108_comp    := IF(abs( ROUND( L.Score108 ,7) - ROUND(   R.Score108, 7 ))< CompValue, 0, 1);
    SELF.Score109_comp    := IF(abs( ROUND( L.Score109 ,7) - ROUND(   R.Score109, 7 ))< CompValue, 0, 1);
    SELF.Score110_comp    := IF(abs( ROUND( L.Score110 ,7) - ROUND(   R.Score110, 7 ))< CompValue, 0, 1);
    SELF.Score111_comp    := IF(abs( ROUND( L.Score111 ,7) - ROUND(   R.Score111, 7 ))< CompValue, 0, 1);
    SELF.Score112_comp    := IF(abs( ROUND( L.Score112 ,7) - ROUND(   R.Score112, 7 ))< CompValue, 0, 1);
    SELF.Score113_comp    := IF(abs( ROUND( L.Score113 ,7) - ROUND(   R.Score113, 7 ))< CompValue, 0, 1);
    SELF.Score114_comp    := IF(abs( ROUND( L.Score114 ,7) - ROUND(   R.Score114, 7 ))< CompValue, 0, 1);
    SELF.Score115_comp    := IF(abs( ROUND( L.Score115 ,7) - ROUND(   R.Score115, 7 ))< CompValue, 0, 1);
    SELF.Score116_comp    := IF(abs( ROUND( L.Score116 ,7) - ROUND(   R.Score116, 7 ))< CompValue, 0, 1);
    SELF.Score117_comp    := IF(abs( ROUND( L.Score117 ,7) - ROUND(   R.Score117, 7 ))< CompValue, 0, 1);
    SELF.Score118_comp    := IF(abs( ROUND( L.Score118 ,7) - ROUND(   R.Score118, 7 ))< CompValue, 0, 1);
    SELF.Score119_comp    := IF(abs( ROUND( L.Score119 ,7) - ROUND(   R.Score119, 7 ))< CompValue, 0, 1);
    SELF.Score120_comp    := IF(abs( ROUND( L.Score120 ,7) - ROUND(   R.Score120, 7 ))< CompValue, 0, 1);
    SELF.Score121_comp    := IF(abs( ROUND( L.Score121 ,7) - ROUND(   R.Score121, 7 ))< CompValue, 0, 1);
    SELF.Score122_comp    := IF(abs( ROUND( L.Score122 ,7) - ROUND(   R.Score122, 7 ))< CompValue, 0, 1);
    SELF.Score123_comp    := IF(abs( ROUND( L.Score123 ,7) - ROUND(   R.Score123, 7 ))< CompValue, 0, 1);
    SELF.Score124_comp    := IF(abs( ROUND( L.Score124 ,7) - ROUND(   R.Score124, 7 ))< CompValue, 0, 1);
    SELF.Score125_comp    := IF(abs( ROUND( L.Score125 ,7) - ROUND(   R.Score125, 7 ))< CompValue, 0, 1);
    SELF.Score126_comp    := IF(abs( ROUND( L.Score126 ,7) - ROUND(   R.Score126, 7 ))< CompValue, 0, 1);
    SELF.Score127_comp    := IF(abs( ROUND( L.Score127 ,7) - ROUND(   R.Score127, 7 ))< CompValue, 0, 1);
    SELF.Score128_comp    := IF(abs( ROUND( L.Score128 ,7) - ROUND(   R.Score128, 7 ))< CompValue, 0, 1);
    SELF.Score129_comp    := IF(abs( ROUND( L.Score129 ,7) - ROUND(   R.Score129, 7 ))< CompValue, 0, 1);
    SELF.Score130_comp    := IF(abs( ROUND( L.Score130 ,7) - ROUND(   R.Score130, 7 ))< CompValue, 0, 1);
    SELF.Score131_comp    := IF(abs( ROUND( L.Score131 ,7) - ROUND(   R.Score131, 7 ))< CompValue, 0, 1);
    SELF.Score132_comp    := IF(abs( ROUND( L.Score132 ,7) - ROUND(   R.Score132, 7 ))< CompValue, 0, 1);
    SELF.Score133_comp    := IF(abs( ROUND( L.Score133 ,7) - ROUND(   R.Score133, 7 ))< CompValue, 0, 1);
    SELF.Score134_comp    := IF(abs( ROUND( L.Score134 ,7) - ROUND(   R.Score134, 7 ))< CompValue, 0, 1);
    SELF.Score135_comp    := IF(abs( ROUND( L.Score135 ,7) - ROUND(   R.Score135, 7 ))< CompValue, 0, 1);
    SELF.Score136_comp    := IF(abs( ROUND( L.Score136 ,7) - ROUND(   R.Score136, 7 ))< CompValue, 0, 1);
    SELF.Score137_comp    := IF(abs( ROUND( L.Score137 ,7) - ROUND(   R.Score137, 7 ))< CompValue, 0, 1);
    SELF.Score138_comp    := IF(abs( ROUND( L.Score138 ,7) - ROUND(   R.Score138, 7 ))< CompValue, 0, 1);
    SELF.Score139_comp    := IF(abs( ROUND( L.Score139 ,7) - ROUND(   R.Score139, 7 ))< CompValue, 0, 1);
    SELF.Score140_comp    := IF(abs( ROUND( L.Score140 ,7) - ROUND(   R.Score140, 7 ))< CompValue, 0, 1);
    SELF.Score141_comp    := IF(abs( ROUND( L.Score141 ,7) - ROUND(   R.Score141, 7 ))< CompValue, 0, 1);
    SELF.Score142_comp    := IF(abs( ROUND( L.Score142 ,7) - ROUND(   R.Score142, 7 ))< CompValue, 0, 1);
    SELF.Score143_comp    := IF(abs( ROUND( L.Score143 ,7) - ROUND(   R.Score143, 7 ))< CompValue, 0, 1);
    SELF.Score144_comp    := IF(abs( ROUND( L.Score144 ,7) - ROUND(   R.Score144, 7 ))< CompValue, 0, 1);
    SELF.Score145_comp    := IF(abs( ROUND( L.Score145 ,7) - ROUND(   R.Score145, 7 ))< CompValue, 0, 1);
    SELF.Score146_comp    := IF(abs( ROUND( L.Score146 ,7) - ROUND(   R.Score146, 7 ))< CompValue, 0, 1);
    SELF.Score147_comp    := IF(abs( ROUND( L.Score147 ,7) - ROUND(   R.Score147, 7 ))< CompValue, 0, 1);
    SELF.Score148_comp    := IF(abs( ROUND( L.Score148 ,7) - ROUND(   R.Score148, 7 ))< CompValue, 0, 1);
    SELF.Score149_comp    := IF(abs( ROUND( L.Score149 ,7) - ROUND(   R.Score149, 7 ))< CompValue, 0, 1);
    SELF.Score150_comp    := IF(abs( ROUND( L.Score150 ,7) - ROUND(   R.Score150, 7 ))< CompValue, 0, 1);
    SELF.Score151_comp    := IF(abs( ROUND( L.Score151 ,7) - ROUND(   R.Score151, 7 ))< CompValue, 0, 1);
    SELF.Score152_comp    := IF(abs( ROUND( L.Score152 ,7) - ROUND(   R.Score152, 7 ))< CompValue, 0, 1);
    SELF.Score153_comp    := IF(abs( ROUND( L.Score153 ,7) - ROUND(   R.Score153, 7 ))< CompValue, 0, 1);
    SELF.Score154_comp    := IF(abs( ROUND( L.Score154 ,7) - ROUND(   R.Score154, 7 ))< CompValue, 0, 1);
    SELF.Score155_comp    := IF(abs( ROUND( L.Score155 ,7) - ROUND(   R.Score155, 7 ))< CompValue, 0, 1);
    SELF.Score156_comp    := IF(abs( ROUND( L.Score156 ,7) - ROUND(   R.Score156, 7 ))< CompValue, 0, 1);
    SELF.Score157_comp    := IF(abs( ROUND( L.Score157 ,7) - ROUND(   R.Score157, 7 ))< CompValue, 0, 1);
    SELF.Score158_comp    := IF(abs( ROUND( L.Score158 ,7) - ROUND(   R.Score158, 7 ))< CompValue, 0, 1);
    SELF.Score159_comp    := IF(abs( ROUND( L.Score159 ,7) - ROUND(   R.Score159, 7 ))< CompValue, 0, 1);
    SELF.Score160_comp    := IF(abs( ROUND( L.Score160 ,7) - ROUND(   R.Score160, 7 ))< CompValue, 0, 1);
    SELF.Score161_comp    := IF(abs( ROUND( L.Score161 ,7) - ROUND(   R.Score161, 7 ))< CompValue, 0, 1);
    SELF.Score162_comp    := IF(abs( ROUND( L.Score162 ,7) - ROUND(   R.Score162, 7 ))< CompValue, 0, 1);
    SELF.Score163_comp    := IF(abs( ROUND( L.Score163 ,7) - ROUND(   R.Score163, 7 ))< CompValue, 0, 1);
    SELF.Score164_comp    := IF(abs( ROUND( L.Score164 ,7) - ROUND(   R.Score164, 7 ))< CompValue, 0, 1);
    SELF.Score165_comp    := IF(abs( ROUND( L.Score165 ,7) - ROUND(   R.Score165, 7 ))< CompValue, 0, 1);
    SELF.Score166_comp    := IF(abs( ROUND( L.Score166 ,7) - ROUND(   R.Score166, 7 ))< CompValue, 0, 1);
    SELF.Score167_comp    := IF(abs( ROUND( L.Score167 ,7) - ROUND(   R.Score167, 7 ))< CompValue, 0, 1);
    SELF.Score168_comp    := IF(abs( ROUND( L.Score168 ,7) - ROUND(   R.Score168, 7 ))< CompValue, 0, 1);
    SELF.Score169_comp    := IF(abs( ROUND( L.Score169 ,7) - ROUND(   R.Score169, 7 ))< CompValue, 0, 1);
    SELF.Score170_comp    := IF(abs( ROUND( L.Score170 ,7) - ROUND(   R.Score170, 7 ))< CompValue, 0, 1);
    SELF.Score171_comp    := IF(abs( ROUND( L.Score171 ,7) - ROUND(   R.Score171, 7 ))< CompValue, 0, 1);
    SELF.Score172_comp    := IF(abs( ROUND( L.Score172 ,7) - ROUND(   R.Score172, 7 ))< CompValue, 0, 1);
    SELF.Score173_comp    := IF(abs( ROUND( L.Score173 ,7) - ROUND(   R.Score173, 7 ))< CompValue, 0, 1);
    SELF.Score174_comp    := IF(abs( ROUND( L.Score174 ,7) - ROUND(   R.Score174, 7 ))< CompValue, 0, 1);
    SELF.Score175_comp    := IF(abs( ROUND( L.Score175 ,7) - ROUND(   R.Score175, 7 ))< CompValue, 0, 1);
    SELF.Score176_comp    := IF(abs( ROUND( L.Score176 ,7) - ROUND(   R.Score176, 7 ))< CompValue, 0, 1);
    SELF.Score177_comp    := IF(abs( ROUND( L.Score177 ,7) - ROUND(   R.Score177, 7 ))< CompValue, 0, 1);
    SELF.Score178_comp    := IF(abs( ROUND( L.Score178 ,7) - ROUND(   R.Score178, 7 ))< CompValue, 0, 1);
    SELF.Score179_comp    := IF(abs( ROUND( L.Score179 ,7) - ROUND(   R.Score179, 7 ))< CompValue, 0, 1);
    SELF.Score180_comp    := IF(abs( ROUND( L.Score180 ,7) - ROUND(   R.Score180, 7 ))< CompValue, 0, 1);
    SELF.Score181_comp    := IF(abs( ROUND( L.Score181 ,7) - ROUND(   R.Score181, 7 ))< CompValue, 0, 1);
    SELF.Score182_comp    := IF(abs( ROUND( L.Score182 ,7) - ROUND(   R.Score182, 7 ))< CompValue, 0, 1);
    SELF.Score183_comp    := IF(abs( ROUND( L.Score183 ,7) - ROUND(   R.Score183, 7 ))< CompValue, 0, 1);
    SELF.Score184_comp    := IF(abs( ROUND( L.Score184 ,7) - ROUND(   R.Score184, 7 ))< CompValue, 0, 1);
    SELF.Score185_comp    := IF(abs( ROUND( L.Score185 ,7) - ROUND(   R.Score185, 7 ))< CompValue, 0, 1);
    SELF.Score186_comp    := IF(abs( ROUND( L.Score186 ,7) - ROUND(   R.Score186, 7 ))< CompValue, 0, 1);
    SELF.Score187_comp    := IF(abs( ROUND( L.Score187 ,7) - ROUND(   R.Score187, 7 ))< CompValue, 0, 1);
    SELF.Score188_comp    := IF(abs( ROUND( L.Score188 ,7) - ROUND(   R.Score188, 7 ))< CompValue, 0, 1);
    SELF.Score189_comp    := IF(abs( ROUND( L.Score189 ,7) - ROUND(   R.Score189, 7 ))< CompValue, 0, 1);
    SELF.Score190_comp    := IF(abs( ROUND( L.Score190 ,7) - ROUND(   R.Score190, 7 ))< CompValue, 0, 1);
    SELF.Score191_comp    := IF(abs( ROUND( L.Score191 ,7) - ROUND(   R.Score191, 7 ))< CompValue, 0, 1);
    SELF.Score192_comp    := IF(abs( ROUND( L.Score192 ,7) - ROUND(   R.Score192, 7 ))< CompValue, 0, 1);
    SELF.Score193_comp    := IF(abs( ROUND( L.Score193 ,7) - ROUND(   R.Score193, 7 ))< CompValue, 0, 1);
    SELF.Score194_comp    := IF(abs( ROUND( L.Score194 ,7) - ROUND(   R.Score194, 7 ))< CompValue, 0, 1);
    SELF.Score195_comp    := IF(abs( ROUND( L.Score195 ,7) - ROUND(   R.Score195, 7 ))< CompValue, 0, 1);
    SELF.Score196_comp    := IF(abs( ROUND( L.Score196 ,7) - ROUND(   R.Score196, 7 ))< CompValue, 0, 1);
    SELF.Score197_comp    := IF(abs( ROUND( L.Score197 ,7) - ROUND(   R.Score197, 7 ))< CompValue, 0, 1);
    SELF.Score198_comp    := IF(abs( ROUND( L.Score198 ,7) - ROUND(   R.Score198, 7 ))< CompValue, 0, 1);
    SELF.Score199_comp    := IF(abs( ROUND( L.Score199 ,7) - ROUND(   R.Score199, 7 ))< CompValue, 0, 1);
    SELF.Score200_comp    := IF(abs( ROUND( L.Score200 ,7) - ROUND(   R.Score200, 7 ))< CompValue, 0, 1);
    SELF.Score201_comp    := IF(abs( ROUND( L.Score201 ,7) - ROUND(   R.Score201, 7 ))< CompValue, 0, 1);
    SELF.Score202_comp    := IF(abs( ROUND( L.Score202 ,7) - ROUND(   R.Score202, 7 ))< CompValue, 0, 1);
    SELF.Score203_comp    := IF(abs( ROUND( L.Score203 ,7) - ROUND(   R.Score203, 7 ))< CompValue, 0, 1);
    SELF.Score204_comp    := IF(abs( ROUND( L.Score204 ,7) - ROUND(   R.Score204, 7 ))< CompValue, 0, 1);
    SELF.Score205_comp    := IF(abs( ROUND( L.Score205 ,7) - ROUND(   R.Score205, 7 ))< CompValue, 0, 1);
    SELF.Score206_comp    := IF(abs( ROUND( L.Score206 ,7) - ROUND(   R.Score206, 7 ))< CompValue, 0, 1);
    SELF.Score207_comp    := IF(abs( ROUND( L.Score207 ,7) - ROUND(   R.Score207, 7 ))< CompValue, 0, 1);
    SELF.Score208_comp    := IF(abs( ROUND( L.Score208 ,7) - ROUND(   R.Score208, 7 ))< CompValue, 0, 1);
    SELF.Score209_comp    := IF(abs( ROUND( L.Score209 ,7) - ROUND(   R.Score209, 7 ))< CompValue, 0, 1);
    SELF.Score210_comp    := IF(abs( ROUND( L.Score210 ,7) - ROUND(   R.Score210, 7 ))< CompValue, 0, 1);
    SELF.Score211_comp    := IF(abs( ROUND( L.Score211 ,7) - ROUND(   R.Score211, 7 ))< CompValue, 0, 1);
    SELF.Score212_comp    := IF(abs( ROUND( L.Score212 ,7) - ROUND(   R.Score212, 7 ))< CompValue, 0, 1);
    SELF.Score213_comp    := IF(abs( ROUND( L.Score213 ,7) - ROUND(   R.Score213, 7 ))< CompValue, 0, 1);
    SELF.Score214_comp    := IF(abs( ROUND( L.Score214 ,7) - ROUND(   R.Score214, 7 ))< CompValue, 0, 1);
    SELF.Score215_comp    := IF(abs( ROUND( L.Score215 ,7) - ROUND(   R.Score215, 7 ))< CompValue, 0, 1);
    SELF.Score216_comp    := IF(abs( ROUND( L.Score216 ,7) - ROUND(   R.Score216, 7 ))< CompValue, 0, 1);
    SELF.Score217_comp    := IF(abs( ROUND( L.Score217 ,7) - ROUND(   R.Score217, 7 ))< CompValue, 0, 1);
    SELF.Score218_comp    := IF(abs( ROUND( L.Score218 ,7) - ROUND(   R.Score218, 7 ))< CompValue, 0, 1);
    SELF.Score219_comp    := IF(abs( ROUND( L.Score219 ,7) - ROUND(   R.Score219, 7 ))< CompValue, 0, 1);
    SELF.Score220_comp    := IF(abs( ROUND( L.Score220 ,7) - ROUND(   R.Score220, 7 ))< CompValue, 0, 1);
    SELF.Score221_comp    := IF(abs( ROUND( L.Score221 ,7) - ROUND(   R.Score221, 7 ))< CompValue, 0, 1);
    SELF.Score222_comp    := IF(abs( ROUND( L.Score222 ,7) - ROUND(   R.Score222, 7 ))< CompValue, 0, 1);
    SELF.Score223_comp    := IF(abs( ROUND( L.Score223 ,7) - ROUND(   R.Score223, 7 ))< CompValue, 0, 1);
    SELF.Score224_comp    := IF(abs( ROUND( L.Score224 ,7) - ROUND(   R.Score224, 7 ))< CompValue, 0, 1);
    SELF.Score225_comp    := IF(abs( ROUND( L.Score225 ,7) - ROUND(   R.Score225, 7 ))< CompValue, 0, 1);
    SELF.Score226_comp    := IF(abs( ROUND( L.Score226 ,7) - ROUND(   R.Score226, 7 ))< CompValue, 0, 1);
    SELF.Score227_comp    := IF(abs( ROUND( L.Score227 ,7) - ROUND(   R.Score227, 7 ))< CompValue, 0, 1);
    SELF.Score228_comp    := IF(abs( ROUND( L.Score228 ,7) - ROUND(   R.Score228, 7 ))< CompValue, 0, 1);
    SELF.Score229_comp    := IF(abs( ROUND( L.Score229 ,7) - ROUND(   R.Score229, 7 ))< CompValue, 0, 1);
    SELF.Score230_comp    := IF(abs( ROUND( L.Score230 ,7) - ROUND(   R.Score230, 7 ))< CompValue, 0, 1);
    SELF.Score231_comp    := IF(abs( ROUND( L.Score231 ,7) - ROUND(   R.Score231, 7 ))< CompValue, 0, 1);
    SELF.Score232_comp    := IF(abs( ROUND( L.Score232 ,7) - ROUND(   R.Score232, 7 ))< CompValue, 0, 1);
    SELF.Score233_comp    := IF(abs( ROUND( L.Score233 ,7) - ROUND(   R.Score233, 7 ))< CompValue, 0, 1);
    SELF.Score234_comp    := IF(abs( ROUND( L.Score234 ,7) - ROUND(   R.Score234, 7 ))< CompValue, 0, 1);
    SELF.Score235_comp    := IF(abs( ROUND( L.Score235 ,7) - ROUND(   R.Score235, 7 ))< CompValue, 0, 1);
    SELF.Score236_comp    := IF(abs( ROUND( L.Score236 ,7) - ROUND(   R.Score236, 7 ))< CompValue, 0, 1);
    SELF.Score237_comp    := IF(abs( ROUND( L.Score237 ,7) - ROUND(   R.Score237, 7 ))< CompValue, 0, 1);
    SELF.Score238_comp    := IF(abs( ROUND( L.Score238 ,7) - ROUND(   R.Score238, 7 ))< CompValue, 0, 1);
    SELF.Score239_comp    := IF(abs( ROUND( L.Score239 ,7) - ROUND(   R.Score239, 7 ))< CompValue, 0, 1);
    SELF.Score240_comp    := IF(abs( ROUND( L.Score240 ,7) - ROUND(   R.Score240, 7 ))< CompValue, 0, 1);
    SELF.Score241_comp    := IF(abs( ROUND( L.Score241 ,7) - ROUND(   R.Score241, 7 ))< CompValue, 0, 1);
    SELF.Score242_comp    := IF(abs( ROUND( L.Score242 ,7) - ROUND(   R.Score242, 7 ))< CompValue, 0, 1);
    SELF.Score243_comp    := IF(abs( ROUND( L.Score243 ,7) - ROUND(   R.Score243, 7 ))< CompValue, 0, 1);
    SELF.Score244_comp    := IF(abs( ROUND( L.Score244 ,7) - ROUND(   R.Score244, 7 ))< CompValue, 0, 1);
    SELF.Score245_comp    := IF(abs( ROUND( L.Score245 ,7) - ROUND(   R.Score245, 7 ))< CompValue, 0, 1);
    SELF.Score246_comp    := IF(abs( ROUND( L.Score246 ,7) - ROUND(   R.Score246, 7 ))< CompValue, 0, 1);
    SELF.Score247_comp    := IF(abs( ROUND( L.Score247 ,7) - ROUND(   R.Score247, 7 ))< CompValue, 0, 1);
    SELF.Score248_comp    := IF(abs( ROUND( L.Score248 ,7) - ROUND(   R.Score248, 7 ))< CompValue, 0, 1);
    SELF.Score249_comp    := IF(abs( ROUND( L.Score249 ,7) - ROUND(   R.Score249, 7 ))< CompValue, 0, 1);
    SELF.Score250_comp    := IF(abs( ROUND( L.Score250 ,7) - ROUND(   R.Score250, 7 ))< CompValue, 0, 1);
    SELF.Score251_comp    := IF(abs( ROUND( L.Score251 ,7) - ROUND(   R.Score251, 7 ))< CompValue, 0, 1);
    SELF.Score252_comp    := IF(abs( ROUND( L.Score252 ,7) - ROUND(   R.Score252, 7 ))< CompValue, 0, 1);
    SELF.Score253_comp    := IF(abs( ROUND( L.Score253 ,7) - ROUND(   R.Score253, 7 ))< CompValue, 0, 1);
    SELF.Score254_comp    := IF(abs( ROUND( L.Score254 ,7) - ROUND(   R.Score254, 7 ))< CompValue, 0, 1);
    SELF.Score255_comp    := IF(abs( ROUND( L.Score255 ,7) - ROUND(   R.Score255, 7 ))< CompValue, 0, 1);
    SELF.Score256_comp    := IF(abs( ROUND( L.Score256 ,7) - ROUND(   R.Score256, 7 ))< CompValue, 0, 1);

		SELF := L;
END;

IndividualTreeTest := JOIN(StdFile, LUCI_Points_Assignments,
                           LEFT.Transactionid = RIGHT.Transactionid,
													 xGetCompTable(LEFT, RIGHT));
RETURN IndividualTreeTest;
END;

SHARED DS := GetCompTable(Threshold_ScoreComp);

SHARED TableList := DATASET([
                                   {'Tree1', COUNT(DS(Score1_comp=1))/COUNT(DS), SET(DS(Score1_comp=1),  trim(TransactionID))},
                                   {'Tree2', COUNT(DS(Score2_comp=1))/COUNT(DS), SET(DS(Score2_comp=1),  trim(TransactionID))},
                                   {'Tree3', COUNT(DS(Score3_comp=1))/COUNT(DS), SET(DS(Score3_comp=1),  trim(TransactionID))},
                                   {'Tree4', COUNT(DS(Score4_comp=1))/COUNT(DS), SET(DS(Score4_comp=1),  trim(TransactionID))},
                                   {'Tree5', COUNT(DS(Score5_comp=1))/COUNT(DS), SET(DS(Score5_comp=1),  trim(TransactionID))},
                                   {'Tree6', COUNT(DS(Score6_comp=1))/COUNT(DS), SET(DS(Score6_comp=1),  trim(TransactionID))},
                                   {'Tree7', COUNT(DS(Score7_comp=1))/COUNT(DS), SET(DS(Score7_comp=1),  trim(TransactionID))},
                                   {'Tree8', COUNT(DS(Score8_comp=1))/COUNT(DS), SET(DS(Score8_comp=1),  trim(TransactionID))},
                                   {'Tree9', COUNT(DS(Score9_comp=1))/COUNT(DS), SET(DS(Score9_comp=1),  trim(TransactionID))},
                                   {'Tree10', COUNT(DS(Score10_comp=1))/COUNT(DS), SET(DS(Score10_comp=1),  trim(TransactionID))},
                                   {'Tree11', COUNT(DS(Score11_comp=1))/COUNT(DS), SET(DS(Score11_comp=1),  trim(TransactionID))},
                                   {'Tree12', COUNT(DS(Score12_comp=1))/COUNT(DS), SET(DS(Score12_comp=1),  trim(TransactionID))},
                                   {'Tree13', COUNT(DS(Score13_comp=1))/COUNT(DS), SET(DS(Score13_comp=1),  trim(TransactionID))},
                                   {'Tree14', COUNT(DS(Score14_comp=1))/COUNT(DS), SET(DS(Score14_comp=1),  trim(TransactionID))},
                                   {'Tree15', COUNT(DS(Score15_comp=1))/COUNT(DS), SET(DS(Score15_comp=1),  trim(TransactionID))},
                                   {'Tree16', COUNT(DS(Score16_comp=1))/COUNT(DS), SET(DS(Score16_comp=1),  trim(TransactionID))},
                                   {'Tree17', COUNT(DS(Score17_comp=1))/COUNT(DS), SET(DS(Score17_comp=1),  trim(TransactionID))},
                                   {'Tree18', COUNT(DS(Score18_comp=1))/COUNT(DS), SET(DS(Score18_comp=1),  trim(TransactionID))},
                                   {'Tree19', COUNT(DS(Score19_comp=1))/COUNT(DS), SET(DS(Score19_comp=1),  trim(TransactionID))},
                                   {'Tree20', COUNT(DS(Score20_comp=1))/COUNT(DS), SET(DS(Score20_comp=1),  trim(TransactionID))},
                                   {'Tree21', COUNT(DS(Score21_comp=1))/COUNT(DS), SET(DS(Score21_comp=1),  trim(TransactionID))},
                                   {'Tree22', COUNT(DS(Score22_comp=1))/COUNT(DS), SET(DS(Score22_comp=1),  trim(TransactionID))},
                                   {'Tree23', COUNT(DS(Score23_comp=1))/COUNT(DS), SET(DS(Score23_comp=1),  trim(TransactionID))},
                                   {'Tree24', COUNT(DS(Score24_comp=1))/COUNT(DS), SET(DS(Score24_comp=1),  trim(TransactionID))},
                                   {'Tree25', COUNT(DS(Score25_comp=1))/COUNT(DS), SET(DS(Score25_comp=1),  trim(TransactionID))},
                                   {'Tree26', COUNT(DS(Score26_comp=1))/COUNT(DS), SET(DS(Score26_comp=1),  trim(TransactionID))},
                                   {'Tree27', COUNT(DS(Score27_comp=1))/COUNT(DS), SET(DS(Score27_comp=1),  trim(TransactionID))},
                                   {'Tree28', COUNT(DS(Score28_comp=1))/COUNT(DS), SET(DS(Score28_comp=1),  trim(TransactionID))},
                                   {'Tree29', COUNT(DS(Score29_comp=1))/COUNT(DS), SET(DS(Score29_comp=1),  trim(TransactionID))},
                                   {'Tree30', COUNT(DS(Score30_comp=1))/COUNT(DS), SET(DS(Score30_comp=1),  trim(TransactionID))},
                                   {'Tree31', COUNT(DS(Score31_comp=1))/COUNT(DS), SET(DS(Score31_comp=1),  trim(TransactionID))},
                                   {'Tree32', COUNT(DS(Score32_comp=1))/COUNT(DS), SET(DS(Score32_comp=1),  trim(TransactionID))},
                                   {'Tree33', COUNT(DS(Score33_comp=1))/COUNT(DS), SET(DS(Score33_comp=1),  trim(TransactionID))},
                                   {'Tree34', COUNT(DS(Score34_comp=1))/COUNT(DS), SET(DS(Score34_comp=1),  trim(TransactionID))},
                                   {'Tree35', COUNT(DS(Score35_comp=1))/COUNT(DS), SET(DS(Score35_comp=1),  trim(TransactionID))},
                                   {'Tree36', COUNT(DS(Score36_comp=1))/COUNT(DS), SET(DS(Score36_comp=1),  trim(TransactionID))},
                                   {'Tree37', COUNT(DS(Score37_comp=1))/COUNT(DS), SET(DS(Score37_comp=1),  trim(TransactionID))},
                                   {'Tree38', COUNT(DS(Score38_comp=1))/COUNT(DS), SET(DS(Score38_comp=1),  trim(TransactionID))},
                                   {'Tree39', COUNT(DS(Score39_comp=1))/COUNT(DS), SET(DS(Score39_comp=1),  trim(TransactionID))},
                                   {'Tree40', COUNT(DS(Score40_comp=1))/COUNT(DS), SET(DS(Score40_comp=1),  trim(TransactionID))},
                                   {'Tree41', COUNT(DS(Score41_comp=1))/COUNT(DS), SET(DS(Score41_comp=1),  trim(TransactionID))},
                                   {'Tree42', COUNT(DS(Score42_comp=1))/COUNT(DS), SET(DS(Score42_comp=1),  trim(TransactionID))},
                                   {'Tree43', COUNT(DS(Score43_comp=1))/COUNT(DS), SET(DS(Score43_comp=1),  trim(TransactionID))},
                                   {'Tree44', COUNT(DS(Score44_comp=1))/COUNT(DS), SET(DS(Score44_comp=1),  trim(TransactionID))},
                                   {'Tree45', COUNT(DS(Score45_comp=1))/COUNT(DS), SET(DS(Score45_comp=1),  trim(TransactionID))},
                                   {'Tree46', COUNT(DS(Score46_comp=1))/COUNT(DS), SET(DS(Score46_comp=1),  trim(TransactionID))},
                                   {'Tree47', COUNT(DS(Score47_comp=1))/COUNT(DS), SET(DS(Score47_comp=1),  trim(TransactionID))},
                                   {'Tree48', COUNT(DS(Score48_comp=1))/COUNT(DS), SET(DS(Score48_comp=1),  trim(TransactionID))},
                                   {'Tree49', COUNT(DS(Score49_comp=1))/COUNT(DS), SET(DS(Score49_comp=1),  trim(TransactionID))},
                                   {'Tree50', COUNT(DS(Score50_comp=1))/COUNT(DS), SET(DS(Score50_comp=1),  trim(TransactionID))},
                                   {'Tree51', COUNT(DS(Score51_comp=1))/COUNT(DS), SET(DS(Score51_comp=1),  trim(TransactionID))},
                                   {'Tree52', COUNT(DS(Score52_comp=1))/COUNT(DS), SET(DS(Score52_comp=1),  trim(TransactionID))},
                                   {'Tree53', COUNT(DS(Score53_comp=1))/COUNT(DS), SET(DS(Score53_comp=1),  trim(TransactionID))},
                                   {'Tree54', COUNT(DS(Score54_comp=1))/COUNT(DS), SET(DS(Score54_comp=1),  trim(TransactionID))},
                                   {'Tree55', COUNT(DS(Score55_comp=1))/COUNT(DS), SET(DS(Score55_comp=1),  trim(TransactionID))},
                                   {'Tree56', COUNT(DS(Score56_comp=1))/COUNT(DS), SET(DS(Score56_comp=1),  trim(TransactionID))},
                                   {'Tree57', COUNT(DS(Score57_comp=1))/COUNT(DS), SET(DS(Score57_comp=1),  trim(TransactionID))},
                                   {'Tree58', COUNT(DS(Score58_comp=1))/COUNT(DS), SET(DS(Score58_comp=1),  trim(TransactionID))},
                                   {'Tree59', COUNT(DS(Score59_comp=1))/COUNT(DS), SET(DS(Score59_comp=1),  trim(TransactionID))},
                                   {'Tree60', COUNT(DS(Score60_comp=1))/COUNT(DS), SET(DS(Score60_comp=1),  trim(TransactionID))},
                                   {'Tree61', COUNT(DS(Score61_comp=1))/COUNT(DS), SET(DS(Score61_comp=1),  trim(TransactionID))},
                                   {'Tree62', COUNT(DS(Score62_comp=1))/COUNT(DS), SET(DS(Score62_comp=1),  trim(TransactionID))},
                                   {'Tree63', COUNT(DS(Score63_comp=1))/COUNT(DS), SET(DS(Score63_comp=1),  trim(TransactionID))},
                                   {'Tree64', COUNT(DS(Score64_comp=1))/COUNT(DS), SET(DS(Score64_comp=1),  trim(TransactionID))},
                                   {'Tree65', COUNT(DS(Score65_comp=1))/COUNT(DS), SET(DS(Score65_comp=1),  trim(TransactionID))},
                                   {'Tree66', COUNT(DS(Score66_comp=1))/COUNT(DS), SET(DS(Score66_comp=1),  trim(TransactionID))},
                                   {'Tree67', COUNT(DS(Score67_comp=1))/COUNT(DS), SET(DS(Score67_comp=1),  trim(TransactionID))},
                                   {'Tree68', COUNT(DS(Score68_comp=1))/COUNT(DS), SET(DS(Score68_comp=1),  trim(TransactionID))},
                                   {'Tree69', COUNT(DS(Score69_comp=1))/COUNT(DS), SET(DS(Score69_comp=1),  trim(TransactionID))},
                                   {'Tree70', COUNT(DS(Score70_comp=1))/COUNT(DS), SET(DS(Score70_comp=1),  trim(TransactionID))},
                                   {'Tree71', COUNT(DS(Score71_comp=1))/COUNT(DS), SET(DS(Score71_comp=1),  trim(TransactionID))},
                                   {'Tree72', COUNT(DS(Score72_comp=1))/COUNT(DS), SET(DS(Score72_comp=1),  trim(TransactionID))},
                                   {'Tree73', COUNT(DS(Score73_comp=1))/COUNT(DS), SET(DS(Score73_comp=1),  trim(TransactionID))},
                                   {'Tree74', COUNT(DS(Score74_comp=1))/COUNT(DS), SET(DS(Score74_comp=1),  trim(TransactionID))},
                                   {'Tree75', COUNT(DS(Score75_comp=1))/COUNT(DS), SET(DS(Score75_comp=1),  trim(TransactionID))},
                                   {'Tree76', COUNT(DS(Score76_comp=1))/COUNT(DS), SET(DS(Score76_comp=1),  trim(TransactionID))},
                                   {'Tree77', COUNT(DS(Score77_comp=1))/COUNT(DS), SET(DS(Score77_comp=1),  trim(TransactionID))},
                                   {'Tree78', COUNT(DS(Score78_comp=1))/COUNT(DS), SET(DS(Score78_comp=1),  trim(TransactionID))},
                                   {'Tree79', COUNT(DS(Score79_comp=1))/COUNT(DS), SET(DS(Score79_comp=1),  trim(TransactionID))},
                                   {'Tree80', COUNT(DS(Score80_comp=1))/COUNT(DS), SET(DS(Score80_comp=1),  trim(TransactionID))},
                                   {'Tree81', COUNT(DS(Score81_comp=1))/COUNT(DS), SET(DS(Score81_comp=1),  trim(TransactionID))},
                                   {'Tree82', COUNT(DS(Score82_comp=1))/COUNT(DS), SET(DS(Score82_comp=1),  trim(TransactionID))},
                                   {'Tree83', COUNT(DS(Score83_comp=1))/COUNT(DS), SET(DS(Score83_comp=1),  trim(TransactionID))},
                                   {'Tree84', COUNT(DS(Score84_comp=1))/COUNT(DS), SET(DS(Score84_comp=1),  trim(TransactionID))},
                                   {'Tree85', COUNT(DS(Score85_comp=1))/COUNT(DS), SET(DS(Score85_comp=1),  trim(TransactionID))},
                                   {'Tree86', COUNT(DS(Score86_comp=1))/COUNT(DS), SET(DS(Score86_comp=1),  trim(TransactionID))},
                                   {'Tree87', COUNT(DS(Score87_comp=1))/COUNT(DS), SET(DS(Score87_comp=1),  trim(TransactionID))},
                                   {'Tree88', COUNT(DS(Score88_comp=1))/COUNT(DS), SET(DS(Score88_comp=1),  trim(TransactionID))},
                                   {'Tree89', COUNT(DS(Score89_comp=1))/COUNT(DS), SET(DS(Score89_comp=1),  trim(TransactionID))},
                                   {'Tree90', COUNT(DS(Score90_comp=1))/COUNT(DS), SET(DS(Score90_comp=1),  trim(TransactionID))},
                                   {'Tree91', COUNT(DS(Score91_comp=1))/COUNT(DS), SET(DS(Score91_comp=1),  trim(TransactionID))},
                                   {'Tree92', COUNT(DS(Score92_comp=1))/COUNT(DS), SET(DS(Score92_comp=1),  trim(TransactionID))},
                                   {'Tree93', COUNT(DS(Score93_comp=1))/COUNT(DS), SET(DS(Score93_comp=1),  trim(TransactionID))},
                                   {'Tree94', COUNT(DS(Score94_comp=1))/COUNT(DS), SET(DS(Score94_comp=1),  trim(TransactionID))},
                                   {'Tree95', COUNT(DS(Score95_comp=1))/COUNT(DS), SET(DS(Score95_comp=1),  trim(TransactionID))},
                                   {'Tree96', COUNT(DS(Score96_comp=1))/COUNT(DS), SET(DS(Score96_comp=1),  trim(TransactionID))},
                                   {'Tree97', COUNT(DS(Score97_comp=1))/COUNT(DS), SET(DS(Score97_comp=1),  trim(TransactionID))},
                                   {'Tree98', COUNT(DS(Score98_comp=1))/COUNT(DS), SET(DS(Score98_comp=1),  trim(TransactionID))},
                                   {'Tree99', COUNT(DS(Score99_comp=1))/COUNT(DS), SET(DS(Score99_comp=1),  trim(TransactionID))},
                                   {'Tree100', COUNT(DS(Score100_comp=1))/COUNT(DS), SET(DS(Score100_comp=1),  trim(TransactionID))},
                                   {'Tree101', COUNT(DS(Score101_comp=1))/COUNT(DS), SET(DS(Score101_comp=1),  trim(TransactionID))},
                                   {'Tree102', COUNT(DS(Score102_comp=1))/COUNT(DS), SET(DS(Score102_comp=1),  trim(TransactionID))},
                                   {'Tree103', COUNT(DS(Score103_comp=1))/COUNT(DS), SET(DS(Score103_comp=1),  trim(TransactionID))},
                                   {'Tree104', COUNT(DS(Score104_comp=1))/COUNT(DS), SET(DS(Score104_comp=1),  trim(TransactionID))},
                                   {'Tree105', COUNT(DS(Score105_comp=1))/COUNT(DS), SET(DS(Score105_comp=1),  trim(TransactionID))},
                                   {'Tree106', COUNT(DS(Score106_comp=1))/COUNT(DS), SET(DS(Score106_comp=1),  trim(TransactionID))},
                                   {'Tree107', COUNT(DS(Score107_comp=1))/COUNT(DS), SET(DS(Score107_comp=1),  trim(TransactionID))},
                                   {'Tree108', COUNT(DS(Score108_comp=1))/COUNT(DS), SET(DS(Score108_comp=1),  trim(TransactionID))},
                                   {'Tree109', COUNT(DS(Score109_comp=1))/COUNT(DS), SET(DS(Score109_comp=1),  trim(TransactionID))},
                                   {'Tree110', COUNT(DS(Score110_comp=1))/COUNT(DS), SET(DS(Score110_comp=1),  trim(TransactionID))},
                                   {'Tree111', COUNT(DS(Score111_comp=1))/COUNT(DS), SET(DS(Score111_comp=1),  trim(TransactionID))},
                                   {'Tree112', COUNT(DS(Score112_comp=1))/COUNT(DS), SET(DS(Score112_comp=1),  trim(TransactionID))},
                                   {'Tree113', COUNT(DS(Score113_comp=1))/COUNT(DS), SET(DS(Score113_comp=1),  trim(TransactionID))},
                                   {'Tree114', COUNT(DS(Score114_comp=1))/COUNT(DS), SET(DS(Score114_comp=1),  trim(TransactionID))},
                                   {'Tree115', COUNT(DS(Score115_comp=1))/COUNT(DS), SET(DS(Score115_comp=1),  trim(TransactionID))},
                                   {'Tree116', COUNT(DS(Score116_comp=1))/COUNT(DS), SET(DS(Score116_comp=1),  trim(TransactionID))},
                                   {'Tree117', COUNT(DS(Score117_comp=1))/COUNT(DS), SET(DS(Score117_comp=1),  trim(TransactionID))},
                                   {'Tree118', COUNT(DS(Score118_comp=1))/COUNT(DS), SET(DS(Score118_comp=1),  trim(TransactionID))},
                                   {'Tree119', COUNT(DS(Score119_comp=1))/COUNT(DS), SET(DS(Score119_comp=1),  trim(TransactionID))},
                                   {'Tree120', COUNT(DS(Score120_comp=1))/COUNT(DS), SET(DS(Score120_comp=1),  trim(TransactionID))},
                                   {'Tree121', COUNT(DS(Score121_comp=1))/COUNT(DS), SET(DS(Score121_comp=1),  trim(TransactionID))},
                                   {'Tree122', COUNT(DS(Score122_comp=1))/COUNT(DS), SET(DS(Score122_comp=1),  trim(TransactionID))},
                                   {'Tree123', COUNT(DS(Score123_comp=1))/COUNT(DS), SET(DS(Score123_comp=1),  trim(TransactionID))},
                                   {'Tree124', COUNT(DS(Score124_comp=1))/COUNT(DS), SET(DS(Score124_comp=1),  trim(TransactionID))},
                                   {'Tree125', COUNT(DS(Score125_comp=1))/COUNT(DS), SET(DS(Score125_comp=1),  trim(TransactionID))},
                                   {'Tree126', COUNT(DS(Score126_comp=1))/COUNT(DS), SET(DS(Score126_comp=1),  trim(TransactionID))},
                                   {'Tree127', COUNT(DS(Score127_comp=1))/COUNT(DS), SET(DS(Score127_comp=1),  trim(TransactionID))},
                                   {'Tree128', COUNT(DS(Score128_comp=1))/COUNT(DS), SET(DS(Score128_comp=1),  trim(TransactionID))},
                                   {'Tree129', COUNT(DS(Score129_comp=1))/COUNT(DS), SET(DS(Score129_comp=1),  trim(TransactionID))},
                                   {'Tree130', COUNT(DS(Score130_comp=1))/COUNT(DS), SET(DS(Score130_comp=1),  trim(TransactionID))},
                                   {'Tree131', COUNT(DS(Score131_comp=1))/COUNT(DS), SET(DS(Score131_comp=1),  trim(TransactionID))},
                                   {'Tree132', COUNT(DS(Score132_comp=1))/COUNT(DS), SET(DS(Score132_comp=1),  trim(TransactionID))},
                                   {'Tree133', COUNT(DS(Score133_comp=1))/COUNT(DS), SET(DS(Score133_comp=1),  trim(TransactionID))},
                                   {'Tree134', COUNT(DS(Score134_comp=1))/COUNT(DS), SET(DS(Score134_comp=1),  trim(TransactionID))},
                                   {'Tree135', COUNT(DS(Score135_comp=1))/COUNT(DS), SET(DS(Score135_comp=1),  trim(TransactionID))},
                                   {'Tree136', COUNT(DS(Score136_comp=1))/COUNT(DS), SET(DS(Score136_comp=1),  trim(TransactionID))},
                                   {'Tree137', COUNT(DS(Score137_comp=1))/COUNT(DS), SET(DS(Score137_comp=1),  trim(TransactionID))},
                                   {'Tree138', COUNT(DS(Score138_comp=1))/COUNT(DS), SET(DS(Score138_comp=1),  trim(TransactionID))},
                                   {'Tree139', COUNT(DS(Score139_comp=1))/COUNT(DS), SET(DS(Score139_comp=1),  trim(TransactionID))},
                                   {'Tree140', COUNT(DS(Score140_comp=1))/COUNT(DS), SET(DS(Score140_comp=1),  trim(TransactionID))},
                                   {'Tree141', COUNT(DS(Score141_comp=1))/COUNT(DS), SET(DS(Score141_comp=1),  trim(TransactionID))},
                                   {'Tree142', COUNT(DS(Score142_comp=1))/COUNT(DS), SET(DS(Score142_comp=1),  trim(TransactionID))},
                                   {'Tree143', COUNT(DS(Score143_comp=1))/COUNT(DS), SET(DS(Score143_comp=1),  trim(TransactionID))},
                                   {'Tree144', COUNT(DS(Score144_comp=1))/COUNT(DS), SET(DS(Score144_comp=1),  trim(TransactionID))},
                                   {'Tree145', COUNT(DS(Score145_comp=1))/COUNT(DS), SET(DS(Score145_comp=1),  trim(TransactionID))},
                                   {'Tree146', COUNT(DS(Score146_comp=1))/COUNT(DS), SET(DS(Score146_comp=1),  trim(TransactionID))},
                                   {'Tree147', COUNT(DS(Score147_comp=1))/COUNT(DS), SET(DS(Score147_comp=1),  trim(TransactionID))},
                                   {'Tree148', COUNT(DS(Score148_comp=1))/COUNT(DS), SET(DS(Score148_comp=1),  trim(TransactionID))},
                                   {'Tree149', COUNT(DS(Score149_comp=1))/COUNT(DS), SET(DS(Score149_comp=1),  trim(TransactionID))},
                                   {'Tree150', COUNT(DS(Score150_comp=1))/COUNT(DS), SET(DS(Score150_comp=1),  trim(TransactionID))},
                                   {'Tree151', COUNT(DS(Score151_comp=1))/COUNT(DS), SET(DS(Score151_comp=1),  trim(TransactionID))},
                                   {'Tree152', COUNT(DS(Score152_comp=1))/COUNT(DS), SET(DS(Score152_comp=1),  trim(TransactionID))},
                                   {'Tree153', COUNT(DS(Score153_comp=1))/COUNT(DS), SET(DS(Score153_comp=1),  trim(TransactionID))},
                                   {'Tree154', COUNT(DS(Score154_comp=1))/COUNT(DS), SET(DS(Score154_comp=1),  trim(TransactionID))},
                                   {'Tree155', COUNT(DS(Score155_comp=1))/COUNT(DS), SET(DS(Score155_comp=1),  trim(TransactionID))},
                                   {'Tree156', COUNT(DS(Score156_comp=1))/COUNT(DS), SET(DS(Score156_comp=1),  trim(TransactionID))},
                                   {'Tree157', COUNT(DS(Score157_comp=1))/COUNT(DS), SET(DS(Score157_comp=1),  trim(TransactionID))},
                                   {'Tree158', COUNT(DS(Score158_comp=1))/COUNT(DS), SET(DS(Score158_comp=1),  trim(TransactionID))},
                                   {'Tree159', COUNT(DS(Score159_comp=1))/COUNT(DS), SET(DS(Score159_comp=1),  trim(TransactionID))},
                                   {'Tree160', COUNT(DS(Score160_comp=1))/COUNT(DS), SET(DS(Score160_comp=1),  trim(TransactionID))},
                                   {'Tree161', COUNT(DS(Score161_comp=1))/COUNT(DS), SET(DS(Score161_comp=1),  trim(TransactionID))},
                                   {'Tree162', COUNT(DS(Score162_comp=1))/COUNT(DS), SET(DS(Score162_comp=1),  trim(TransactionID))},
                                   {'Tree163', COUNT(DS(Score163_comp=1))/COUNT(DS), SET(DS(Score163_comp=1),  trim(TransactionID))},
                                   {'Tree164', COUNT(DS(Score164_comp=1))/COUNT(DS), SET(DS(Score164_comp=1),  trim(TransactionID))},
                                   {'Tree165', COUNT(DS(Score165_comp=1))/COUNT(DS), SET(DS(Score165_comp=1),  trim(TransactionID))},
                                   {'Tree166', COUNT(DS(Score166_comp=1))/COUNT(DS), SET(DS(Score166_comp=1),  trim(TransactionID))},
                                   {'Tree167', COUNT(DS(Score167_comp=1))/COUNT(DS), SET(DS(Score167_comp=1),  trim(TransactionID))},
                                   {'Tree168', COUNT(DS(Score168_comp=1))/COUNT(DS), SET(DS(Score168_comp=1),  trim(TransactionID))},
                                   {'Tree169', COUNT(DS(Score169_comp=1))/COUNT(DS), SET(DS(Score169_comp=1),  trim(TransactionID))},
                                   {'Tree170', COUNT(DS(Score170_comp=1))/COUNT(DS), SET(DS(Score170_comp=1),  trim(TransactionID))},
                                   {'Tree171', COUNT(DS(Score171_comp=1))/COUNT(DS), SET(DS(Score171_comp=1),  trim(TransactionID))},
                                   {'Tree172', COUNT(DS(Score172_comp=1))/COUNT(DS), SET(DS(Score172_comp=1),  trim(TransactionID))},
                                   {'Tree173', COUNT(DS(Score173_comp=1))/COUNT(DS), SET(DS(Score173_comp=1),  trim(TransactionID))},
                                   {'Tree174', COUNT(DS(Score174_comp=1))/COUNT(DS), SET(DS(Score174_comp=1),  trim(TransactionID))},
                                   {'Tree175', COUNT(DS(Score175_comp=1))/COUNT(DS), SET(DS(Score175_comp=1),  trim(TransactionID))},
                                   {'Tree176', COUNT(DS(Score176_comp=1))/COUNT(DS), SET(DS(Score176_comp=1),  trim(TransactionID))},
                                   {'Tree177', COUNT(DS(Score177_comp=1))/COUNT(DS), SET(DS(Score177_comp=1),  trim(TransactionID))},
                                   {'Tree178', COUNT(DS(Score178_comp=1))/COUNT(DS), SET(DS(Score178_comp=1),  trim(TransactionID))},
                                   {'Tree179', COUNT(DS(Score179_comp=1))/COUNT(DS), SET(DS(Score179_comp=1),  trim(TransactionID))},
                                   {'Tree180', COUNT(DS(Score180_comp=1))/COUNT(DS), SET(DS(Score180_comp=1),  trim(TransactionID))},
                                   {'Tree181', COUNT(DS(Score181_comp=1))/COUNT(DS), SET(DS(Score181_comp=1),  trim(TransactionID))},
                                   {'Tree182', COUNT(DS(Score182_comp=1))/COUNT(DS), SET(DS(Score182_comp=1),  trim(TransactionID))},
                                   {'Tree183', COUNT(DS(Score183_comp=1))/COUNT(DS), SET(DS(Score183_comp=1),  trim(TransactionID))},
                                   {'Tree184', COUNT(DS(Score184_comp=1))/COUNT(DS), SET(DS(Score184_comp=1),  trim(TransactionID))},
                                   {'Tree185', COUNT(DS(Score185_comp=1))/COUNT(DS), SET(DS(Score185_comp=1),  trim(TransactionID))},
                                   {'Tree186', COUNT(DS(Score186_comp=1))/COUNT(DS), SET(DS(Score186_comp=1),  trim(TransactionID))},
                                   {'Tree187', COUNT(DS(Score187_comp=1))/COUNT(DS), SET(DS(Score187_comp=1),  trim(TransactionID))},
                                   {'Tree188', COUNT(DS(Score188_comp=1))/COUNT(DS), SET(DS(Score188_comp=1),  trim(TransactionID))},
                                   {'Tree189', COUNT(DS(Score189_comp=1))/COUNT(DS), SET(DS(Score189_comp=1),  trim(TransactionID))},
                                   {'Tree190', COUNT(DS(Score190_comp=1))/COUNT(DS), SET(DS(Score190_comp=1),  trim(TransactionID))},
                                   {'Tree191', COUNT(DS(Score191_comp=1))/COUNT(DS), SET(DS(Score191_comp=1),  trim(TransactionID))},
                                   {'Tree192', COUNT(DS(Score192_comp=1))/COUNT(DS), SET(DS(Score192_comp=1),  trim(TransactionID))},
                                   {'Tree193', COUNT(DS(Score193_comp=1))/COUNT(DS), SET(DS(Score193_comp=1),  trim(TransactionID))},
                                   {'Tree194', COUNT(DS(Score194_comp=1))/COUNT(DS), SET(DS(Score194_comp=1),  trim(TransactionID))},
                                   {'Tree195', COUNT(DS(Score195_comp=1))/COUNT(DS), SET(DS(Score195_comp=1),  trim(TransactionID))},
                                   {'Tree196', COUNT(DS(Score196_comp=1))/COUNT(DS), SET(DS(Score196_comp=1),  trim(TransactionID))},
                                   {'Tree197', COUNT(DS(Score197_comp=1))/COUNT(DS), SET(DS(Score197_comp=1),  trim(TransactionID))},
                                   {'Tree198', COUNT(DS(Score198_comp=1))/COUNT(DS), SET(DS(Score198_comp=1),  trim(TransactionID))},
                                   {'Tree199', COUNT(DS(Score199_comp=1))/COUNT(DS), SET(DS(Score199_comp=1),  trim(TransactionID))},
                                   {'Tree200', COUNT(DS(Score200_comp=1))/COUNT(DS), SET(DS(Score200_comp=1),  trim(TransactionID))},
                                   {'Tree201', COUNT(DS(Score201_comp=1))/COUNT(DS), SET(DS(Score201_comp=1),  trim(TransactionID))},
                                   {'Tree202', COUNT(DS(Score202_comp=1))/COUNT(DS), SET(DS(Score202_comp=1),  trim(TransactionID))},
                                   {'Tree203', COUNT(DS(Score203_comp=1))/COUNT(DS), SET(DS(Score203_comp=1),  trim(TransactionID))},
                                   {'Tree204', COUNT(DS(Score204_comp=1))/COUNT(DS), SET(DS(Score204_comp=1),  trim(TransactionID))},
                                   {'Tree205', COUNT(DS(Score205_comp=1))/COUNT(DS), SET(DS(Score205_comp=1),  trim(TransactionID))},
                                   {'Tree206', COUNT(DS(Score206_comp=1))/COUNT(DS), SET(DS(Score206_comp=1),  trim(TransactionID))},
                                   {'Tree207', COUNT(DS(Score207_comp=1))/COUNT(DS), SET(DS(Score207_comp=1),  trim(TransactionID))},
                                   {'Tree208', COUNT(DS(Score208_comp=1))/COUNT(DS), SET(DS(Score208_comp=1),  trim(TransactionID))},
                                   {'Tree209', COUNT(DS(Score209_comp=1))/COUNT(DS), SET(DS(Score209_comp=1),  trim(TransactionID))},
                                   {'Tree210', COUNT(DS(Score210_comp=1))/COUNT(DS), SET(DS(Score210_comp=1),  trim(TransactionID))},
                                   {'Tree211', COUNT(DS(Score211_comp=1))/COUNT(DS), SET(DS(Score211_comp=1),  trim(TransactionID))},
                                   {'Tree212', COUNT(DS(Score212_comp=1))/COUNT(DS), SET(DS(Score212_comp=1),  trim(TransactionID))},
                                   {'Tree213', COUNT(DS(Score213_comp=1))/COUNT(DS), SET(DS(Score213_comp=1),  trim(TransactionID))},
                                   {'Tree214', COUNT(DS(Score214_comp=1))/COUNT(DS), SET(DS(Score214_comp=1),  trim(TransactionID))},
                                   {'Tree215', COUNT(DS(Score215_comp=1))/COUNT(DS), SET(DS(Score215_comp=1),  trim(TransactionID))},
                                   {'Tree216', COUNT(DS(Score216_comp=1))/COUNT(DS), SET(DS(Score216_comp=1),  trim(TransactionID))},
                                   {'Tree217', COUNT(DS(Score217_comp=1))/COUNT(DS), SET(DS(Score217_comp=1),  trim(TransactionID))},
                                   {'Tree218', COUNT(DS(Score218_comp=1))/COUNT(DS), SET(DS(Score218_comp=1),  trim(TransactionID))},
                                   {'Tree219', COUNT(DS(Score219_comp=1))/COUNT(DS), SET(DS(Score219_comp=1),  trim(TransactionID))},
                                   {'Tree220', COUNT(DS(Score220_comp=1))/COUNT(DS), SET(DS(Score220_comp=1),  trim(TransactionID))},
                                   {'Tree221', COUNT(DS(Score221_comp=1))/COUNT(DS), SET(DS(Score221_comp=1),  trim(TransactionID))},
                                   {'Tree222', COUNT(DS(Score222_comp=1))/COUNT(DS), SET(DS(Score222_comp=1),  trim(TransactionID))},
                                   {'Tree223', COUNT(DS(Score223_comp=1))/COUNT(DS), SET(DS(Score223_comp=1),  trim(TransactionID))},
                                   {'Tree224', COUNT(DS(Score224_comp=1))/COUNT(DS), SET(DS(Score224_comp=1),  trim(TransactionID))},
                                   {'Tree225', COUNT(DS(Score225_comp=1))/COUNT(DS), SET(DS(Score225_comp=1),  trim(TransactionID))},
                                   {'Tree226', COUNT(DS(Score226_comp=1))/COUNT(DS), SET(DS(Score226_comp=1),  trim(TransactionID))},
                                   {'Tree227', COUNT(DS(Score227_comp=1))/COUNT(DS), SET(DS(Score227_comp=1),  trim(TransactionID))},
                                   {'Tree228', COUNT(DS(Score228_comp=1))/COUNT(DS), SET(DS(Score228_comp=1),  trim(TransactionID))},
                                   {'Tree229', COUNT(DS(Score229_comp=1))/COUNT(DS), SET(DS(Score229_comp=1),  trim(TransactionID))},
                                   {'Tree230', COUNT(DS(Score230_comp=1))/COUNT(DS), SET(DS(Score230_comp=1),  trim(TransactionID))},
                                   {'Tree231', COUNT(DS(Score231_comp=1))/COUNT(DS), SET(DS(Score231_comp=1),  trim(TransactionID))},
                                   {'Tree232', COUNT(DS(Score232_comp=1))/COUNT(DS), SET(DS(Score232_comp=1),  trim(TransactionID))},
                                   {'Tree233', COUNT(DS(Score233_comp=1))/COUNT(DS), SET(DS(Score233_comp=1),  trim(TransactionID))},
                                   {'Tree234', COUNT(DS(Score234_comp=1))/COUNT(DS), SET(DS(Score234_comp=1),  trim(TransactionID))},
                                   {'Tree235', COUNT(DS(Score235_comp=1))/COUNT(DS), SET(DS(Score235_comp=1),  trim(TransactionID))},
                                   {'Tree236', COUNT(DS(Score236_comp=1))/COUNT(DS), SET(DS(Score236_comp=1),  trim(TransactionID))},
                                   {'Tree237', COUNT(DS(Score237_comp=1))/COUNT(DS), SET(DS(Score237_comp=1),  trim(TransactionID))},
                                   {'Tree238', COUNT(DS(Score238_comp=1))/COUNT(DS), SET(DS(Score238_comp=1),  trim(TransactionID))},
                                   {'Tree239', COUNT(DS(Score239_comp=1))/COUNT(DS), SET(DS(Score239_comp=1),  trim(TransactionID))},
                                   {'Tree240', COUNT(DS(Score240_comp=1))/COUNT(DS), SET(DS(Score240_comp=1),  trim(TransactionID))},
                                   {'Tree241', COUNT(DS(Score241_comp=1))/COUNT(DS), SET(DS(Score241_comp=1),  trim(TransactionID))},
                                   {'Tree242', COUNT(DS(Score242_comp=1))/COUNT(DS), SET(DS(Score242_comp=1),  trim(TransactionID))},
                                   {'Tree243', COUNT(DS(Score243_comp=1))/COUNT(DS), SET(DS(Score243_comp=1),  trim(TransactionID))},
                                   {'Tree244', COUNT(DS(Score244_comp=1))/COUNT(DS), SET(DS(Score244_comp=1),  trim(TransactionID))},
                                   {'Tree245', COUNT(DS(Score245_comp=1))/COUNT(DS), SET(DS(Score245_comp=1),  trim(TransactionID))},
                                   {'Tree246', COUNT(DS(Score246_comp=1))/COUNT(DS), SET(DS(Score246_comp=1),  trim(TransactionID))},
                                   {'Tree247', COUNT(DS(Score247_comp=1))/COUNT(DS), SET(DS(Score247_comp=1),  trim(TransactionID))},
                                   {'Tree248', COUNT(DS(Score248_comp=1))/COUNT(DS), SET(DS(Score248_comp=1),  trim(TransactionID))},
                                   {'Tree249', COUNT(DS(Score249_comp=1))/COUNT(DS), SET(DS(Score249_comp=1),  trim(TransactionID))},
                                   {'Tree250', COUNT(DS(Score250_comp=1))/COUNT(DS), SET(DS(Score250_comp=1),  trim(TransactionID))},
                                   {'Tree251', COUNT(DS(Score251_comp=1))/COUNT(DS), SET(DS(Score251_comp=1),  trim(TransactionID))},
                                   {'Tree252', COUNT(DS(Score252_comp=1))/COUNT(DS), SET(DS(Score252_comp=1),  trim(TransactionID))},
                                   {'Tree253', COUNT(DS(Score253_comp=1))/COUNT(DS), SET(DS(Score253_comp=1),  trim(TransactionID))},
                                   {'Tree254', COUNT(DS(Score254_comp=1))/COUNT(DS), SET(DS(Score254_comp=1),  trim(TransactionID))},
                                   {'Tree255', COUNT(DS(Score255_comp=1))/COUNT(DS), SET(DS(Score255_comp=1),  trim(TransactionID))},
                                   {'Tree256', COUNT(DS(Score256_comp=1))/COUNT(DS), SET(DS(Score256_comp=1),  trim(TransactionID))}],
                            { STRING20 IndividualTree, REAL MismatchPer, SET OF STRING MismatcheList :=[]});
SHARED mismatchList :=  TABLEList(MismatcheList <> []);

/******************************************************************************\
|*******************Step4 - Get Validation File for Auditing*******************|
\******************************************************************************/
  Layouts.AuditLayouts xGetLUCIAuditFile(LUCI_Points_Assignments_Pre L) := TRANSFORM
    SELF.Score1 := L.Score1_Tree1_score;
    SELF.Score2 := L.Score1_Tree2_score;
    SELF.Score3 := L.Score1_Tree3_score;
    SELF.Score4 := L.Score1_Tree4_score;
    SELF.Score5 := L.Score1_Tree5_score;
    SELF.Score6 := L.Score1_Tree6_score;
    SELF.Score7 := L.Score1_Tree7_score;
    SELF.Score8 := L.Score1_Tree8_score;
    SELF.Score9 := L.Score1_Tree9_score;
    SELF.Score10 := L.Score1_Tree10_score;
    SELF.Score11 := L.Score1_Tree11_score;
    SELF.Score12 := L.Score1_Tree12_score;
    SELF.Score13 := L.Score1_Tree13_score;
    SELF.Score14 := L.Score1_Tree14_score;
    SELF.Score15 := L.Score1_Tree15_score;
    SELF.Score16 := L.Score1_Tree16_score;
    SELF.Score17 := L.Score1_Tree17_score;
    SELF.Score18 := L.Score1_Tree18_score;
    SELF.Score19 := L.Score1_Tree19_score;
    SELF.Score20 := L.Score1_Tree20_score;
    SELF.Score21 := L.Score1_Tree21_score;
    SELF.Score22 := L.Score1_Tree22_score;
    SELF.Score23 := L.Score1_Tree23_score;
    SELF.Score24 := L.Score1_Tree24_score;
    SELF.Score25 := L.Score1_Tree25_score;
    SELF.Score26 := L.Score1_Tree26_score;
    SELF.Score27 := L.Score1_Tree27_score;
    SELF.Score28 := L.Score1_Tree28_score;
    SELF.Score29 := L.Score1_Tree29_score;
    SELF.Score30 := L.Score1_Tree30_score;
    SELF.Score31 := L.Score1_Tree31_score;
    SELF.Score32 := L.Score1_Tree32_score;
    SELF.Score33 := L.Score1_Tree33_score;
    SELF.Score34 := L.Score1_Tree34_score;
    SELF.Score35 := L.Score1_Tree35_score;
    SELF.Score36 := L.Score1_Tree36_score;
    SELF.Score37 := L.Score1_Tree37_score;
    SELF.Score38 := L.Score1_Tree38_score;
    SELF.Score39 := L.Score1_Tree39_score;
    SELF.Score40 := L.Score1_Tree40_score;
    SELF.Score41 := L.Score1_Tree41_score;
    SELF.Score42 := L.Score1_Tree42_score;
    SELF.Score43 := L.Score1_Tree43_score;
    SELF.Score44 := L.Score1_Tree44_score;
    SELF.Score45 := L.Score1_Tree45_score;
    SELF.Score46 := L.Score1_Tree46_score;
    SELF.Score47 := L.Score1_Tree47_score;
    SELF.Score48 := L.Score1_Tree48_score;
    SELF.Score49 := L.Score1_Tree49_score;
    SELF.Score50 := L.Score1_Tree50_score;
    SELF.Score51 := L.Score1_Tree51_score;
    SELF.Score52 := L.Score1_Tree52_score;
    SELF.Score53 := L.Score1_Tree53_score;
    SELF.Score54 := L.Score1_Tree54_score;
    SELF.Score55 := L.Score1_Tree55_score;
    SELF.Score56 := L.Score1_Tree56_score;
    SELF.Score57 := L.Score1_Tree57_score;
    SELF.Score58 := L.Score1_Tree58_score;
    SELF.Score59 := L.Score1_Tree59_score;
    SELF.Score60 := L.Score1_Tree60_score;
    SELF.Score61 := L.Score1_Tree61_score;
    SELF.Score62 := L.Score1_Tree62_score;
    SELF.Score63 := L.Score1_Tree63_score;
    SELF.Score64 := L.Score1_Tree64_score;
    SELF.Score65 := L.Score1_Tree65_score;
    SELF.Score66 := L.Score1_Tree66_score;
    SELF.Score67 := L.Score1_Tree67_score;
    SELF.Score68 := L.Score1_Tree68_score;
    SELF.Score69 := L.Score1_Tree69_score;
    SELF.Score70 := L.Score1_Tree70_score;
    SELF.Score71 := L.Score1_Tree71_score;
    SELF.Score72 := L.Score1_Tree72_score;
    SELF.Score73 := L.Score1_Tree73_score;
    SELF.Score74 := L.Score1_Tree74_score;
    SELF.Score75 := L.Score1_Tree75_score;
    SELF.Score76 := L.Score1_Tree76_score;
    SELF.Score77 := L.Score1_Tree77_score;
    SELF.Score78 := L.Score1_Tree78_score;
    SELF.Score79 := L.Score1_Tree79_score;
    SELF.Score80 := L.Score1_Tree80_score;
    SELF.Score81 := L.Score1_Tree81_score;
    SELF.Score82 := L.Score1_Tree82_score;
    SELF.Score83 := L.Score1_Tree83_score;
    SELF.Score84 := L.Score1_Tree84_score;
    SELF.Score85 := L.Score1_Tree85_score;
    SELF.Score86 := L.Score1_Tree86_score;
    SELF.Score87 := L.Score1_Tree87_score;
    SELF.Score88 := L.Score1_Tree88_score;
    SELF.Score89 := L.Score1_Tree89_score;
    SELF.Score90 := L.Score1_Tree90_score;
    SELF.Score91 := L.Score1_Tree91_score;
    SELF.Score92 := L.Score1_Tree92_score;
    SELF.Score93 := L.Score1_Tree93_score;
    SELF.Score94 := L.Score1_Tree94_score;
    SELF.Score95 := L.Score1_Tree95_score;
    SELF.Score96 := L.Score1_Tree96_score;
    SELF.Score97 := L.Score1_Tree97_score;
    SELF.Score98 := L.Score1_Tree98_score;
    SELF.Score99 := L.Score1_Tree99_score;
    SELF.Score100 := L.Score1_Tree100_score;
    SELF.Score101 := L.Score1_Tree101_score;
    SELF.Score102 := L.Score1_Tree102_score;
    SELF.Score103 := L.Score1_Tree103_score;
    SELF.Score104 := L.Score1_Tree104_score;
    SELF.Score105 := L.Score1_Tree105_score;
    SELF.Score106 := L.Score1_Tree106_score;
    SELF.Score107 := L.Score1_Tree107_score;
    SELF.Score108 := L.Score1_Tree108_score;
    SELF.Score109 := L.Score1_Tree109_score;
    SELF.Score110 := L.Score1_Tree110_score;
    SELF.Score111 := L.Score1_Tree111_score;
    SELF.Score112 := L.Score1_Tree112_score;
    SELF.Score113 := L.Score1_Tree113_score;
    SELF.Score114 := L.Score1_Tree114_score;
    SELF.Score115 := L.Score1_Tree115_score;
    SELF.Score116 := L.Score1_Tree116_score;
    SELF.Score117 := L.Score1_Tree117_score;
    SELF.Score118 := L.Score1_Tree118_score;
    SELF.Score119 := L.Score1_Tree119_score;
    SELF.Score120 := L.Score1_Tree120_score;
    SELF.Score121 := L.Score1_Tree121_score;
    SELF.Score122 := L.Score1_Tree122_score;
    SELF.Score123 := L.Score1_Tree123_score;
    SELF.Score124 := L.Score1_Tree124_score;
    SELF.Score125 := L.Score1_Tree125_score;
    SELF.Score126 := L.Score1_Tree126_score;
    SELF.Score127 := L.Score1_Tree127_score;
    SELF.Score128 := L.Score1_Tree128_score;
    SELF.Score129 := L.Score1_Tree129_score;
    SELF.Score130 := L.Score1_Tree130_score;
    SELF.Score131 := L.Score1_Tree131_score;
    SELF.Score132 := L.Score1_Tree132_score;
    SELF.Score133 := L.Score1_Tree133_score;
    SELF.Score134 := L.Score1_Tree134_score;
    SELF.Score135 := L.Score1_Tree135_score;
    SELF.Score136 := L.Score1_Tree136_score;
    SELF.Score137 := L.Score1_Tree137_score;
    SELF.Score138 := L.Score1_Tree138_score;
    SELF.Score139 := L.Score1_Tree139_score;
    SELF.Score140 := L.Score1_Tree140_score;
    SELF.Score141 := L.Score1_Tree141_score;
    SELF.Score142 := L.Score1_Tree142_score;
    SELF.Score143 := L.Score1_Tree143_score;
    SELF.Score144 := L.Score1_Tree144_score;
    SELF.Score145 := L.Score1_Tree145_score;
    SELF.Score146 := L.Score1_Tree146_score;
    SELF.Score147 := L.Score1_Tree147_score;
    SELF.Score148 := L.Score1_Tree148_score;
    SELF.Score149 := L.Score1_Tree149_score;
    SELF.Score150 := L.Score1_Tree150_score;
    SELF.Score151 := L.Score1_Tree151_score;
    SELF.Score152 := L.Score1_Tree152_score;
    SELF.Score153 := L.Score1_Tree153_score;
    SELF.Score154 := L.Score1_Tree154_score;
    SELF.Score155 := L.Score1_Tree155_score;
    SELF.Score156 := L.Score1_Tree156_score;
    SELF.Score157 := L.Score1_Tree157_score;
    SELF.Score158 := L.Score1_Tree158_score;
    SELF.Score159 := L.Score1_Tree159_score;
    SELF.Score160 := L.Score1_Tree160_score;
    SELF.Score161 := L.Score1_Tree161_score;
    SELF.Score162 := L.Score1_Tree162_score;
    SELF.Score163 := L.Score1_Tree163_score;
    SELF.Score164 := L.Score1_Tree164_score;
    SELF.Score165 := L.Score1_Tree165_score;
    SELF.Score166 := L.Score1_Tree166_score;
    SELF.Score167 := L.Score1_Tree167_score;
    SELF.Score168 := L.Score1_Tree168_score;
    SELF.Score169 := L.Score1_Tree169_score;
    SELF.Score170 := L.Score1_Tree170_score;
    SELF.Score171 := L.Score1_Tree171_score;
    SELF.Score172 := L.Score1_Tree172_score;
    SELF.Score173 := L.Score1_Tree173_score;
    SELF.Score174 := L.Score1_Tree174_score;
    SELF.Score175 := L.Score1_Tree175_score;
    SELF.Score176 := L.Score1_Tree176_score;
    SELF.Score177 := L.Score1_Tree177_score;
    SELF.Score178 := L.Score1_Tree178_score;
    SELF.Score179 := L.Score1_Tree179_score;
    SELF.Score180 := L.Score1_Tree180_score;
    SELF.Score181 := L.Score1_Tree181_score;
    SELF.Score182 := L.Score1_Tree182_score;
    SELF.Score183 := L.Score1_Tree183_score;
    SELF.Score184 := L.Score1_Tree184_score;
    SELF.Score185 := L.Score1_Tree185_score;
    SELF.Score186 := L.Score1_Tree186_score;
    SELF.Score187 := L.Score1_Tree187_score;
    SELF.Score188 := L.Score1_Tree188_score;
    SELF.Score189 := L.Score1_Tree189_score;
    SELF.Score190 := L.Score1_Tree190_score;
    SELF.Score191 := L.Score1_Tree191_score;
    SELF.Score192 := L.Score1_Tree192_score;
    SELF.Score193 := L.Score1_Tree193_score;
    SELF.Score194 := L.Score1_Tree194_score;
    SELF.Score195 := L.Score1_Tree195_score;
    SELF.Score196 := L.Score1_Tree196_score;
    SELF.Score197 := L.Score1_Tree197_score;
    SELF.Score198 := L.Score1_Tree198_score;
    SELF.Score199 := L.Score1_Tree199_score;
    SELF.Score200 := L.Score1_Tree200_score;
    SELF.Score201 := L.Score1_Tree201_score;
    SELF.Score202 := L.Score1_Tree202_score;
    SELF.Score203 := L.Score1_Tree203_score;
    SELF.Score204 := L.Score1_Tree204_score;
    SELF.Score205 := L.Score1_Tree205_score;
    SELF.Score206 := L.Score1_Tree206_score;
    SELF.Score207 := L.Score1_Tree207_score;
    SELF.Score208 := L.Score1_Tree208_score;
    SELF.Score209 := L.Score1_Tree209_score;
    SELF.Score210 := L.Score1_Tree210_score;
    SELF.Score211 := L.Score1_Tree211_score;
    SELF.Score212 := L.Score1_Tree212_score;
    SELF.Score213 := L.Score1_Tree213_score;
    SELF.Score214 := L.Score1_Tree214_score;
    SELF.Score215 := L.Score1_Tree215_score;
    SELF.Score216 := L.Score1_Tree216_score;
    SELF.Score217 := L.Score1_Tree217_score;
    SELF.Score218 := L.Score1_Tree218_score;
    SELF.Score219 := L.Score1_Tree219_score;
    SELF.Score220 := L.Score1_Tree220_score;
    SELF.Score221 := L.Score1_Tree221_score;
    SELF.Score222 := L.Score1_Tree222_score;
    SELF.Score223 := L.Score1_Tree223_score;
    SELF.Score224 := L.Score1_Tree224_score;
    SELF.Score225 := L.Score1_Tree225_score;
    SELF.Score226 := L.Score1_Tree226_score;
    SELF.Score227 := L.Score1_Tree227_score;
    SELF.Score228 := L.Score1_Tree228_score;
    SELF.Score229 := L.Score1_Tree229_score;
    SELF.Score230 := L.Score1_Tree230_score;
    SELF.Score231 := L.Score1_Tree231_score;
    SELF.Score232 := L.Score1_Tree232_score;
    SELF.Score233 := L.Score1_Tree233_score;
    SELF.Score234 := L.Score1_Tree234_score;
    SELF.Score235 := L.Score1_Tree235_score;
    SELF.Score236 := L.Score1_Tree236_score;
    SELF.Score237 := L.Score1_Tree237_score;
    SELF.Score238 := L.Score1_Tree238_score;
    SELF.Score239 := L.Score1_Tree239_score;
    SELF.Score240 := L.Score1_Tree240_score;
    SELF.Score241 := L.Score1_Tree241_score;
    SELF.Score242 := L.Score1_Tree242_score;
    SELF.Score243 := L.Score1_Tree243_score;
    SELF.Score244 := L.Score1_Tree244_score;
    SELF.Score245 := L.Score1_Tree245_score;
    SELF.Score246 := L.Score1_Tree246_score;
    SELF.Score247 := L.Score1_Tree247_score;
    SELF.Score248 := L.Score1_Tree248_score;
    SELF.Score249 := L.Score1_Tree249_score;
    SELF.Score250 := L.Score1_Tree250_score;
    SELF.Score251 := L.Score1_Tree251_score;
    SELF.Score252 := L.Score1_Tree252_score;
    SELF.Score253 := L.Score1_Tree253_score;
    SELF.Score254 := L.Score1_Tree254_score;
    SELF.Score255 := L.Score1_Tree255_score;
    SELF.Score256 := L.Score1_Tree256_score;

    //Scores
    SELF.rawscore:= L.Model1_Score1_Score0;
    SELF.predscr:= SELF.rawscore;
    SELF.finalscore := L.Model1_Score;
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
  desprayName(STRING desprayNamePre)     := desprayNamePre + dateString+'.csv';
  LandingZoneIP  := LUCI.Constants.LandingZoneIP;
  lzDesprayFilePath(STRING desprayNamePre)     := lzFilePathFolder + desprayName(desprayNamePre);
  DesprayAuditResult   := LUCI.FNDesprayCSV(LUCI_AuditResult, TempLogical('~LUCI::AuditFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_AuditFile'));
  DesprayComparision   := LUCI.FNDesprayCSV(DS_Comp, TempLogical('~LUCI::ComparisonFile:' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ComparisonFile'));
  DesprayMismatches_SC := LUCI.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_sc), TempLogical('~LUCI::Mismatches_SC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_SC'));
  DesprayMismatches_RC := LUCI.FNDesprayCSV(DS_Comp(TransactionID in mismatch_list_rc), TempLogical('~LUCI::Mismatches_RC::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_Mismatches_RC'));

SEQUENTIAL( DesprayAuditResult,
            DesprayComparision,
						DesprayMismatches_SC,
						DesprayMismatches_RC,
						DesprayADR
						);
