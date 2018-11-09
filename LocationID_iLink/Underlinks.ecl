// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT37,std;
EXPORT Underlinks(DATASET(layout_LocationId) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
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
    v_city_name_skipped := COUNT(GROUP,RRF.v_city_name_skipped);
    v_city_name_skipped_pcnt := AVE(GROUP,IF(RRF.v_city_name_skipped,100,0));
    st_skipped := COUNT(GROUP,RRF.st_skipped);
    st_skipped_pcnt := AVE(GROUP,IF(RRF.st_skipped,100,0));
    zip5_skipped := COUNT(GROUP,RRF.zip5_skipped);
    zip5_skipped_pcnt := AVE(GROUP,IF(RRF.zip5_skipped,100,0));
    cntprimname_skipped := COUNT(GROUP,RRF.cntprimname_skipped);
    cntprimname_skipped_pcnt := AVE(GROUP,IF(RRF.cntprimname_skipped,100,0));
    sec_range_skipped := COUNT(GROUP,RRF.sec_range_skipped);
    sec_range_skipped_pcnt := AVE(GROUP,IF(RRF.sec_range_skipped,100,0));
    postdir_skipped := COUNT(GROUP,RRF.postdir_skipped);
    postdir_skipped_pcnt := AVE(GROUP,IF(RRF.postdir_skipped,100,0));
    predir_skipped := COUNT(GROUP,RRF.predir_skipped);
    predir_skipped_pcnt := AVE(GROUP,IF(RRF.predir_skipped,100,0));
    err_stat_skipped := COUNT(GROUP,RRF.err_stat_skipped);
    err_stat_skipped_pcnt := AVE(GROUP,IF(RRF.err_stat_skipped,100,0));
    addr_suffix_skipped := COUNT(GROUP,RRF.addr_suffix_skipped);
    addr_suffix_skipped_pcnt := AVE(GROUP,IF(RRF.addr_suffix_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT37.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.zip5_Score = 0,'','|'+IF(le.zip5_Score < 0,'-','')+'zip5')+IF(le.cntprimname_Score = 0,'','|'+IF(le.cntprimname_Score < 0,'-','')+'cntprimname')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.postdir_Score = 0,'','|'+IF(le.postdir_Score < 0,'-','')+'postdir')+IF(le.predir_Score = 0,'','|'+IF(le.predir_Score < 0,'-','')+'predir')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.err_stat_Score = 0,'','|'+IF(le.err_stat_Score < 0,'-','')+'err_stat')+IF(le.addr_suffix_Score = 0,'','|'+IF(le.addr_suffix_Score < 0,'-','')+'addr_suffix');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
