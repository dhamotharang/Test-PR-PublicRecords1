EXPORT mac_AlertListBasic(CntFact1='', CntFact2='', CntFact3='', CntFact4='', CntFact5='', SumCol1='', 
															distance_threshold, OutGraph) := FUNCTIONMACRO 

IMPORT SNA;

rAlertList := RECORD
  OutGraph.cluster_id;
#IF(#TEXT(CntFact1)!='')
  INTEGER2 al_Fact1_Cnt := COUNT(GROUP, OutGraph.CntFact1);
  INTEGER3 al_Fact1_Cnt_0 := COUNT(GROUP, OutGraph.CntFact1 AND OutGraph.degree = 0);
  INTEGER3 al_Fact1_Cnt_1 := COUNT(GROUP, OutGraph.CntFact1 AND OutGraph.degree > 0 AND OutGraph.degree <= 1);
  INTEGER4 al_Fact1_Cnt_2 := COUNT(GROUP, OutGraph.CntFact1 AND OutGraph.degree > 1 AND OutGraph.degree <= 2);
#ELSE
  INTEGER2 al_Fact1_Cnt := 0;
  INTEGER3 al_Fact1_Cnt_0 := 0;
  INTEGER3 al_Fact1_Cnt_1 := 0;
  INTEGER4 al_Fact1_Cnt_2 := 0;
#END
#IF(#TEXT(CntFact2)!='')
  INTEGER2 al_Fact2_Cnt := COUNT(GROUP, OutGraph.CntFact2);
  INTEGER3 al_Fact2_Cnt_0 := COUNT(GROUP, OutGraph.CntFact2 AND OutGraph.degree = 0);
  INTEGER3 al_Fact2_Cnt_1 := COUNT(GROUP, OutGraph.CntFact2 AND OutGraph.degree > 0 AND OutGraph.degree <= 1);
  INTEGER4 al_Fact2_Cnt_2 := COUNT(GROUP, OutGraph.CntFact2 AND OutGraph.degree > 1 AND OutGraph.degree <= 2);
#ELSE
  INTEGER2 al_Fact2_Cnt := 0;
  INTEGER3 al_Fact2_Cnt_0 := 0;
  INTEGER3 al_Fact2_Cnt_1 := 0;
  INTEGER4 al_Fact2_Cnt_2 := 0;
#END
#IF(NOT #TEXT(CntFact3)='')
  INTEGER2 al_Fact3_Cnt := COUNT(GROUP, OutGraph.CntFact3);
  INTEGER3 al_Fact3_Cnt_0 := COUNT(GROUP, OutGraph.CntFact3 AND OutGraph.degree = 0);
  INTEGER3 al_Fact3_Cnt_1 := COUNT(GROUP, OutGraph.CntFact3 AND OutGraph.degree > 0 AND OutGraph.degree <= 1);
  INTEGER4 al_Fact3_Cnt_2 := COUNT(GROUP, OutGraph.CntFact3 AND OutGraph.degree > 1 AND OutGraph.degree <= 2);
#ELSE
  INTEGER2 al_Fact3_Cnt := 0;
  INTEGER3 al_Fact3_Cnt_0 := 0;
  INTEGER3 al_Fact3_Cnt_1 := 0;
  INTEGER4 al_Fact3_Cnt_2 := 0;
#END
#IF(#TEXT(CntFact4)!='')
  INTEGER2 al_Fact4_Cnt := COUNT(GROUP, OutGraph.CntFact4);
  INTEGER3 al_Fact4_Cnt_0 := COUNT(GROUP, OutGraph.CntFact4 AND OutGraph.degree = 0);
  INTEGER3 al_Fact4_Cnt_1 := COUNT(GROUP, OutGraph.CntFact4 AND OutGraph.degree > 0 AND OutGraph.degree <= 1);
  INTEGER4 al_Fact4_Cnt_2 := COUNT(GROUP, OutGraph.CntFact4 AND OutGraph.degree > 1 AND OutGraph.degree <= 2);
#ELSE
  INTEGER2 al_Fact4_Cnt := 0;
  INTEGER3 al_Fact4_Cnt_0 := 0;
  INTEGER3 al_Fact4_Cnt_1 := 0;
  INTEGER4 al_Fact4_Cnt_2 := 0;
#END
#IF(#TEXT(CntFact5)!='')
  INTEGER2 al_Fact5_Cnt := COUNT(GROUP, OutGraph.CntFact5);
  INTEGER3 al_Fact5_Cnt_0 := COUNT(GROUP, OutGraph.CntFact5 AND OutGraph.degree = 0);
  INTEGER3 al_Fact5_Cnt_1 := COUNT(GROUP, OutGraph.CntFact5 AND OutGraph.degree > 0 AND OutGraph.degree <= 1);
  INTEGER4 al_Fact5_Cnt_2 := COUNT(GROUP, OutGraph.CntFact5 AND OutGraph.degree > 1 AND OutGraph.degree <= 2);
#ELSE
  INTEGER2 al_Fact5_Cnt := 0;
  INTEGER3 al_Fact5_Cnt_0 := 0;
  INTEGER3 al_Fact5_Cnt_1 := 0;
  INTEGER4 al_Fact5_Cnt_2 := 0;
#END
#IF(#TEXT(SumCol1)!='')
  INTEGER4 al_Sum1 := SUM(GROUP, OutGraph.SumCol1);
#ELSE
  INTEGER4 al_Sum1 := 0;
#END
	INTEGER2 al_TotalCnt := COUNT(GROUP);
	INTEGER2 al_FirstDegrees := COUNT(GROUP,OutGraph.Degree > 0 AND OutGraph.Degree <= 1.0);
	INTEGER3 al_SecondDegrees := COUNT(GROUP,OutGraph.Degree > 1.0);
	REAL4 al_Cohesivity := AVE(GROUP,OutGraph.Degree);
END;

// compute cluster aggregate counts for all persons within threshold_distance of input people.
RETURN TABLE(OutGraph, rAlertList, cluster_id, MERGE);

ENDMACRO;
