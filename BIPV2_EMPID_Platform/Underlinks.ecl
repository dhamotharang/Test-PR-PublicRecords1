// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT SALT30,ut,std;
EXPORT Underlinks(DATASET(layout_EmpID) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
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
    lname_skipped := COUNT(GROUP,RRF.lname_skipped);
    lname_skipped_pcnt := AVE(GROUP,IF(RRF.lname_skipped,100,0));
    contact_did_skipped := COUNT(GROUP,RRF.contact_did_skipped);
    contact_did_skipped_pcnt := AVE(GROUP,IF(RRF.contact_did_skipped,100,0));
    cname_devanitize_skipped := COUNT(GROUP,RRF.cname_devanitize_skipped);
    cname_devanitize_skipped_pcnt := AVE(GROUP,IF(RRF.cname_devanitize_skipped,100,0));
    fname_skipped := COUNT(GROUP,RRF.fname_skipped);
    fname_skipped_pcnt := AVE(GROUP,IF(RRF.fname_skipped,100,0));
    contact_ssn_skipped := COUNT(GROUP,RRF.contact_ssn_skipped);
    contact_ssn_skipped_pcnt := AVE(GROUP,IF(RRF.contact_ssn_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT30.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.lname_Score = 0,'','|'+IF(le.lname_Score < 0,'-','')+'lname')+IF(le.contact_phone_Score = 0,'','|'+IF(le.contact_phone_Score < 0,'-','')+'contact_phone')+IF(le.contact_did_Score = 0,'','|'+IF(le.contact_did_Score < 0,'-','')+'contact_did')+IF(le.cname_devanitize_Score = 0,'','|'+IF(le.cname_devanitize_Score < 0,'-','')+'cname_devanitize')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.fname_Score = 0,'','|'+IF(le.fname_Score < 0,'-','')+'fname')+IF(le.contact_ssn_Score = 0,'','|'+IF(le.contact_ssn_Score < 0,'-','')+'contact_ssn');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
