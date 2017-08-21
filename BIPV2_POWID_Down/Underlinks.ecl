// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT35,ut,std;
EXPORT Underlinks(DATASET(layout_POWID_Down) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
  dt := debug(ih,s,MatchThreshold).sample_match_join;
  RawResults := matches(ih,MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    orgid_skipped := COUNT(GROUP,RRF.orgid_skipped);
    orgid_skipped_pcnt := AVE(GROUP,IF(RRF.orgid_skipped,100,0));
    prim_range_skipped := COUNT(GROUP,RRF.prim_range_skipped);
    prim_range_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_skipped,100,0));
    prim_name_skipped := COUNT(GROUP,RRF.prim_name_skipped);
    prim_name_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_skipped,100,0));
    st_skipped := COUNT(GROUP,RRF.st_skipped);
    st_skipped_pcnt := AVE(GROUP,IF(RRF.st_skipped,100,0));
    csz_skipped := COUNT(GROUP,RRF.csz_skipped);
    csz_skipped_pcnt := AVE(GROUP,IF(RRF.csz_skipped,100,0));
    address_skipped := COUNT(GROUP,RRF.address_skipped);
    address_skipped_pcnt := AVE(GROUP,IF(RRF.address_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT35.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.orgid_Score = 0,'','|'+IF(le.orgid_Score < 0,'-','')+'orgid')+IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.csz_Score = 0,'','|'+IF(le.csz_Score < 0,'-','')+'csz')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.addr1_Score = 0,'','|'+IF(le.addr1_Score < 0,'-','')+'addr1')+IF(le.address_Score = 0,'','|'+IF(le.address_Score < 0,'-','')+'address');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
