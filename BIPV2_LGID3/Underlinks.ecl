// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT311,std;
EXPORT Underlinks(DATASET(layout_LGID3) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
  dt := Debug(ih, s, MatchThreshold).sample_match_join;
  RawResults := matches(ih, MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    company_inc_state_skipped := COUNT(GROUP,RRF.company_inc_state_skipped);
    company_inc_state_skipped_pcnt := AVE(GROUP,IF(RRF.company_inc_state_skipped,100,0));
    Lgid3IfHrchy_skipped := COUNT(GROUP,RRF.Lgid3IfHrchy_skipped);
    Lgid3IfHrchy_skipped_pcnt := AVE(GROUP,IF(RRF.Lgid3IfHrchy_skipped,100,0));
    cnp_number_skipped := COUNT(GROUP,RRF.cnp_number_skipped);
    cnp_number_skipped_pcnt := AVE(GROUP,IF(RRF.cnp_number_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT311.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.company_inc_state_Score = 0,'','|'+IF(le.company_inc_state_Score < 0,'-','')+'company_inc_state')+IF(le.Lgid3IfHrchy_Score = 0,'','|'+IF(le.Lgid3IfHrchy_Score < 0,'-','')+'Lgid3IfHrchy')+IF(le.active_duns_number_Score = 0,'','|'+IF(le.active_duns_number_Score < 0,'-','')+'active_duns_number')+IF(le.duns_number_Score = 0,'','|'+IF(le.duns_number_Score < 0,'-','')+'duns_number')+IF(le.duns_number_concept_Score = 0,'','|'+IF(le.duns_number_concept_Score < 0,'-','')+'duns_number_concept')+IF(le.sbfe_id_Score = 0,'','|'+IF(le.sbfe_id_Score < 0,'-','')+'sbfe_id')+IF(le.company_name_Score = 0,'','|'+IF(le.company_name_Score < 0,'-','')+'company_name')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.company_charter_number_Score = 0,'','|'+IF(le.company_charter_number_Score < 0,'-','')+'company_charter_number')+IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.cnp_btype_Score = 0,'','|'+IF(le.cnp_btype_Score < 0,'-','')+'cnp_btype');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
