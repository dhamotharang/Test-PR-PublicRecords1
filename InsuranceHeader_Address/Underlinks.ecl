// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT311,std;
EXPORT Underlinks(DATASET(layout_Address_Link) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
  dt := Debug(ih, s, MatchThreshold).sample_match_join;
  RawResults := matches(ih, MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    DID_skipped := COUNT(GROUP,RRF.DID_skipped);
    DID_skipped_pcnt := AVE(GROUP,IF(RRF.DID_skipped,100,0));
    addr_skipped := COUNT(GROUP,RRF.addr_skipped);
    addr_skipped_pcnt := AVE(GROUP,IF(RRF.addr_skipped,100,0));
    prim_range_num_skipped := COUNT(GROUP,RRF.prim_range_num_skipped);
    prim_range_num_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_num_skipped,100,0));
    prim_name_num_skipped := COUNT(GROUP,RRF.prim_name_num_skipped);
    prim_name_num_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_num_skipped,100,0));
    prim_range_alpha_skipped := COUNT(GROUP,RRF.prim_range_alpha_skipped);
    prim_range_alpha_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_alpha_skipped,100,0));
    prim_name_alpha_skipped := COUNT(GROUP,RRF.prim_name_alpha_skipped);
    prim_name_alpha_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_alpha_skipped,100,0));
    prim_range_fract_skipped := COUNT(GROUP,RRF.prim_range_fract_skipped);
    prim_range_fract_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_fract_skipped,100,0));
    sec_range_alpha_skipped := COUNT(GROUP,RRF.sec_range_alpha_skipped);
    sec_range_alpha_skipped_pcnt := AVE(GROUP,IF(RRF.sec_range_alpha_skipped,100,0));
    sec_range_num_skipped := COUNT(GROUP,RRF.sec_range_num_skipped);
    sec_range_num_skipped_pcnt := AVE(GROUP,IF(RRF.sec_range_num_skipped,100,0));
    st_skipped := COUNT(GROUP,RRF.st_skipped);
    st_skipped_pcnt := AVE(GROUP,IF(RRF.st_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT311.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.DID_Score = 0,'','|'+IF(le.DID_Score < 0,'-','')+'DID')+IF(le.addr_Score = 0,'','|'+IF(le.addr_Score < 0,'-','')+'addr')+IF(le.locale_Score = 0,'','|'+IF(le.locale_Score < 0,'-','')+'locale')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.prim_range_num_Score = 0,'','|'+IF(le.prim_range_num_Score < 0,'-','')+'prim_range_num')+IF(le.prim_name_num_Score = 0,'','|'+IF(le.prim_name_num_Score < 0,'-','')+'prim_name_num')+IF(le.prim_range_alpha_Score = 0,'','|'+IF(le.prim_range_alpha_Score < 0,'-','')+'prim_range_alpha')+IF(le.prim_name_alpha_Score = 0,'','|'+IF(le.prim_name_alpha_Score < 0,'-','')+'prim_name_alpha')+IF(le.prim_range_fract_Score = 0,'','|'+IF(le.prim_range_fract_Score < 0,'-','')+'prim_range_fract')+IF(le.sec_range_alpha_Score = 0,'','|'+IF(le.sec_range_alpha_Score < 0,'-','')+'sec_range_alpha')+IF(le.sec_range_num_Score = 0,'','|'+IF(le.sec_range_num_Score < 0,'-','')+'sec_range_num')+IF(le.city_Score = 0,'','|'+IF(le.city_Score < 0,'-','')+'city')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
