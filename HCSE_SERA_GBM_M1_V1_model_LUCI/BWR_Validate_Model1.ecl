﻿IMPORT UT,STD,LUCI;
IMPORT LUCI.Constants AS Constants;
IMPORT HCSE_SERA_GBM_M1_V1_model_LUCI AS LUCI_Model;
IMPORT HCSE_SERA_GBM_M1_V1_model_LUCI.z_layouts AS Layouts;
IMPORT zz_cyu_LUCI_CF02_M6.z_FNValidationWithRC AS FNValidation; //DAB: How do I find this function 

SHARED SampleSize := 1000; // The number of mismatches provided for review

/******************************************************************************\
|**************************Step 0 - Spray Input File***************************|
\******************************************************************************/
SHARED ModelName := 'Model1';
SHARED lzFilePath        := '/data/model/' + ModelName+'.csv';
SHARED SprayCSVName      := '~HCSE_SERA_GBM_M1_V1_model_LUCI::' + ut.GetDate + '::' + ModelName +'_from_csv';
SHARED CSVSpraySeparator := '|';
SHARED HeaderLine := 1;
SHARED isCSVFile := TRUE;
  LUCI.FNSpray(lzFilePath, SprayCSVName, CSVSpraySeparator);

/******************************************************************************\
|**************************Step 1a - Load Input File***************************|
\******************************************************************************/
  LUCI.FNValidationWithRC.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, HeaderLine, isCSVFile, CSVSpraySeparator);
SHARED RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_Model1 := TRUE, SELF := LEFT));

/******************************************************************************\
|**********************Step 1b - Standardized Input File***********************|
\******************************************************************************/
  LUCI.FNValidationWithRC.MAC_STDInputFile(RawInputSet, Layouts.StandLayouts, rawscore, finalscore, StdFile);
SHARED pLUCIresults := LUCI_Model.AsResults(RawInputSet);
SHARED LUCIresults  := DISTRIBUTE(pLUCIresults.Validation(), hash32(TransactionID));
OUTPUT(LUCIresults, NAMED('LUCIresults'));

/******************************************************************************\
|****************Step 2 - Get Statistics of Final Scores and RC****************|
\******************************************************************************/
  LUCI.FNValidationWithRC.MAC_CompareScore(LUCIresults, StdFile, Check_Result, pOutputSet);
  rc_mismatches := Check_Result(score_match,~rc_match);
  sc_mismatches := Check_Result(~score_match);
OUTPUT(rc_mismatches,,NAMED('rc_mismatches'));
OUTPUT(sc_mismatches,,NAMED('sc_mismatches'));
  Check_Result_rc_mismatch := CHOOSEN(rc_mismatches, SampleSize);
  Check_Result_sc_mismatch := CHOOSEN(sc_mismatches, SampleSize);
  mismatch_list_rc := SET(Check_Result_rc_mismatch, TransactionId);
  mismatch_list_sc := SET(Check_Result_sc_mismatch, TransactionId);

/******************************************************************************\
|***Step3 - Check Points Assignments and Reason Code of Mismatches(Optional)***|
\******************************************************************************/
  LUCI_Points_Assignments_Pre := LUCI_Model.AsResults(RawInputSet).ValidationF;
  Layouts.StandLayouts xGetLUCIPointsAssignments(LUCI_Points_Assignments_Pre L) := TRANSFORM
// Forest parts Score1
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
    SELF.rawscore  := L.Model1_Score1_Score1;
    SELF.predscr  := L.Model1_Score1_Score0;
    SELF.stdrawscore  := L.Model1_Score1_Score1;
    SELF.finalscore := L.Model1_Score;
    SELF.SOURCE := 'HPCC';
    SELF.std_scr := (string)(unsigned)L.Model1_Score;
    SELF := L;
    SELF := [];
  END;
  LUCI_Points_Assignments :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIPointsAssignments(LEFT));
  DS_Comp_pre := SORT(LUCI_Points_Assignments + StdFile, TransactionID) ;
  DS_Comp := PROJECT(DS_Comp_pre, layouts.CompLayouts) ;
OUTPUT(DS_Comp( TransactionID in mismatch_list_rc),,NAMED('rc_mismatches_details'));
OUTPUT(DS_Comp( TransactionID in Mismatch_list_sc),,NAMED('sc_mismatches_details'));
OUTPUT(DS_Comp,,NAMED('AuditComparison'));

/******************************************************************************\
|*******************Step4 - Get Validation File for Auditing*******************|
\******************************************************************************/
  ValidationResult_Rec:= RECORD
    Layouts.Input_Layout;
  END;
  ValidationResult_Rec xGetLUCIAuditFile(LUCI_Points_Assignments_Pre L) := TRANSFORM
// Forest parts Score1
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
    SELF.rawscore  := L.Model1_Score1_Score1;
    SELF.predscr  := L.Model1_Score1_Score0;
    SELF.stdrawscore  := L.Model1_Score1_Score1;
    SELF := L;
    SELF := [];
  END;
  LUCI_AuditResult :=PROJECT(LUCI_Points_Assignments_Pre, xGetLUCIAuditFile(LEFT));
OUTPUT(LUCI_AuditResult,,NAMED('LUCIResults_Audit'));

/******************************************************************************\
|*************************Step5 - Despray the Results**************************|
\******************************************************************************/
  dateString	    := (STRING)STD.Date.Today();
  TempCSV(String LogicalName) := LogicalName +  WORKUNIT;
  desprayName(STRING desprayNamePre)     := desprayNamePre + dateString+'.csv';
  EXPORT_DS	:= SORT(LUCI_Points_Assignments, TransactionID);
  LandingZoneIP  := Constants.LandingZoneIP;
  lzDesprayFilePath(STRING desprayNamePre)     := '/data/models/'+ desprayName(desprayNamePre);
  DesprayComparision := LUCI.FNDesprayCSV(DS_Comp, TempCSV(??couldnotfigureoutthisname??), LandingZoneIP, lzDesprayFilePath('????'));
  DesprayAuditResult := LUCI.FNDesprayCSV(LUCI_AUditResult, TempCSV(???), LandingZoneIP, lzDesprayFilePath('????'));
SEQUENTIAL( DesprayComparision,DesprayAuditResult);
