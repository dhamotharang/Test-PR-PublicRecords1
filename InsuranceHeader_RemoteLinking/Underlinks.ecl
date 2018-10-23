// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT37,std;
EXPORT Underlinks(DATASET(layout_HEADER) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
  dt := debug(ih,s,MatchThreshold).sample_match_join;
  RawResults := matches(ih,MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    FULLNAME_skipped := COUNT(GROUP,RRF.FULLNAME_skipped);
    FULLNAME_skipped_pcnt := AVE(GROUP,IF(RRF.FULLNAME_skipped,100,0));
    DOB_skipped := COUNT(GROUP,RRF.DOB_skipped);
    DOB_skipped_pcnt := AVE(GROUP,IF(RRF.DOB_skipped,100,0));
    FNAME_skipped := COUNT(GROUP,RRF.FNAME_skipped);
    FNAME_skipped_pcnt := AVE(GROUP,IF(RRF.FNAME_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT37.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.ADDRESS_Score = 0,'','|'+IF(le.ADDRESS_Score < 0,'-','')+'ADDRESS')+IF(le.SSN_Score = 0,'','|'+IF(le.SSN_Score < 0,'-','')+'SSN')+IF(le.POLICY_NUMBER_Score = 0,'','|'+IF(le.POLICY_NUMBER_Score < 0,'-','')+'POLICY_NUMBER')+IF(le.CLAIM_NUMBER_Score = 0,'','|'+IF(le.CLAIM_NUMBER_Score < 0,'-','')+'CLAIM_NUMBER')+IF(le.DL_NBR_Score = 0,'','|'+IF(le.DL_NBR_Score < 0,'-','')+'DL_NBR')+IF(le.FULLNAME_Score = 0,'','|'+IF(le.FULLNAME_Score < 0,'-','')+'FULLNAME')+IF(le.MAINNAME_Score = 0,'','|'+IF(le.MAINNAME_Score < 0,'-','')+'MAINNAME')+IF(le.ADDR1_Score = 0,'','|'+IF(le.ADDR1_Score < 0,'-','')+'ADDR1')+IF(le.DOB_Score = 0,'','|'+IF(le.DOB_Score < 0,'-','')+'DOB')+IF(le.ZIP_Score = 0,'','|'+IF(le.ZIP_Score < 0,'-','')+'ZIP')+IF(le.LOCALE_Score = 0,'','|'+IF(le.LOCALE_Score < 0,'-','')+'LOCALE')+IF(le.PRIM_NAME_Score = 0,'','|'+IF(le.PRIM_NAME_Score < 0,'-','')+'PRIM_NAME')+IF(le.LNAME_Score = 0,'','|'+IF(le.LNAME_Score < 0,'-','')+'LNAME')+IF(le.PRIM_RANGE_Score = 0,'','|'+IF(le.PRIM_RANGE_Score < 0,'-','')+'PRIM_RANGE')+IF(le.CITY_Score = 0,'','|'+IF(le.CITY_Score < 0,'-','')+'CITY')+IF(le.FNAME_Score = 0,'','|'+IF(le.FNAME_Score < 0,'-','')+'FNAME')+IF(le.SEC_RANGE_Score = 0,'','|'+IF(le.SEC_RANGE_Score < 0,'-','')+'SEC_RANGE')+IF(le.MNAME_Score = 0,'','|'+IF(le.MNAME_Score < 0,'-','')+'MNAME')+IF(le.ST_Score = 0,'','|'+IF(le.ST_Score < 0,'-','')+'ST')+IF(le.SNAME_Score = 0,'','|'+IF(le.SNAME_Score < 0,'-','')+'SNAME')+IF(le.GENDER_Score = 0,'','|'+IF(le.GENDER_Score < 0,'-','')+'GENDER')+IF(le.DERIVED_GENDER_Score = 0,'','|'+IF(le.DERIVED_GENDER_Score < 0,'-','')+'DERIVED_GENDER');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
