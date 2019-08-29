// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT SALT32,ut,std;
EXPORT Underlinks(DATASET(layout_EmpID) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
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
    lname_skipped := COUNT(GROUP,RRF.lname_skipped);
    lname_skipped_pcnt := AVE(GROUP,IF(RRF.lname_skipped,100,0));
    mname_skipped := COUNT(GROUP,RRF.mname_skipped);
    mname_skipped_pcnt := AVE(GROUP,IF(RRF.mname_skipped,100,0));
    fname_skipped := COUNT(GROUP,RRF.fname_skipped);
    fname_skipped_pcnt := AVE(GROUP,IF(RRF.fname_skipped,100,0));
    name_suffix_skipped := COUNT(GROUP,RRF.name_suffix_skipped);
    name_suffix_skipped_pcnt := AVE(GROUP,IF(RRF.name_suffix_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT32.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.orgid_Score = 0,'','|'+IF(le.orgid_Score < 0,'-','')+'orgid')+IF(le.contact_ssn_Score = 0,'','|'+IF(le.contact_ssn_Score < 0,'-','')+'contact_ssn')+IF(le.contact_did_Score = 0,'','|'+IF(le.contact_did_Score < 0,'-','')+'contact_did')+IF(le.lname_Score = 0,'','|'+IF(le.lname_Score < 0,'-','')+'lname')+IF(le.mname_Score = 0,'','|'+IF(le.mname_Score < 0,'-','')+'mname')+IF(le.fname_Score = 0,'','|'+IF(le.fname_Score < 0,'-','')+'fname')+IF(le.name_suffix_Score = 0,'','|'+IF(le.name_suffix_Score < 0,'-','')+'name_suffix');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
