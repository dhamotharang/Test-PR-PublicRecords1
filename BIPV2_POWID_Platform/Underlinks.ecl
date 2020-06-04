// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT32,ut,std;
EXPORT Underlinks(DATASET(layout_POWID) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
  dt := debug(ih,s,MatchThreshold).sample_match_join;
  RawResults := matches(ih,MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    prim_range_skipped := COUNT(GROUP,RRF.prim_range_skipped);
    prim_range_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_skipped,100,0));
    prim_name_skipped := COUNT(GROUP,RRF.prim_name_skipped);
    prim_name_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_skipped,100,0));
    RID_If_Big_Biz_skipped := COUNT(GROUP,RRF.RID_If_Big_Biz_skipped);
    RID_If_Big_Biz_skipped_pcnt := AVE(GROUP,IF(RRF.RID_If_Big_Biz_skipped,100,0));
    cnp_name_skipped := COUNT(GROUP,RRF.cnp_name_skipped);
    cnp_name_skipped_pcnt := AVE(GROUP,IF(RRF.cnp_name_skipped,100,0));
    company_name_skipped := COUNT(GROUP,RRF.company_name_skipped);
    company_name_skipped_pcnt := AVE(GROUP,IF(RRF.company_name_skipped,100,0));
    cnp_number_skipped := COUNT(GROUP,RRF.cnp_number_skipped);
    cnp_number_skipped_pcnt := AVE(GROUP,IF(RRF.cnp_number_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT32.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.RID_If_Big_Biz_Score = 0,'','|'+IF(le.RID_If_Big_Biz_Score < 0,'-','')+'RID_If_Big_Biz')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.company_name_Score = 0,'','|'+IF(le.company_name_Score < 0,'-','')+'company_name')+IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
