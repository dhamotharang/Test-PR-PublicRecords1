// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT30,ut,std;
EXPORT Underlinks(DATASET(layout_Base) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
  dt := debug(ih,s,MatchThreshold).sample_match_join;
  RawResults := matches(ih,MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    active_duns_number_skipped := COUNT(GROUP,RRF.active_duns_number_skipped);
    active_duns_number_skipped_pcnt := AVE(GROUP,IF(RRF.active_duns_number_skipped,100,0));
    active_enterprise_number_skipped := COUNT(GROUP,RRF.active_enterprise_number_skipped);
    active_enterprise_number_skipped_pcnt := AVE(GROUP,IF(RRF.active_enterprise_number_skipped,100,0));
    prim_range_skipped := COUNT(GROUP,RRF.prim_range_skipped);
    prim_range_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_skipped,100,0));
    sec_range_skipped := COUNT(GROUP,RRF.sec_range_skipped);
    sec_range_skipped_pcnt := AVE(GROUP,IF(RRF.sec_range_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT30.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.active_duns_number_Score = 0,'','|'+IF(le.active_duns_number_Score < 0,'-','')+'active_duns_number')+IF(le.active_enterprise_number_Score = 0,'','|'+IF(le.active_enterprise_number_Score < 0,'-','')+'active_enterprise_number')+IF(le.company_charter_number_Score = 0,'','|'+IF(le.company_charter_number_Score < 0,'-','')+'company_charter_number')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.source_record_id_Score = 0,'','|'+IF(le.source_record_id_Score < 0,'-','')+'source_record_id')+IF(le.contact_ssn_Score = 0,'','|'+IF(le.contact_ssn_Score < 0,'-','')+'contact_ssn')+IF(le.contact_phone_Score = 0,'','|'+IF(le.contact_phone_Score < 0,'-','')+'contact_phone')+IF(le.contact_email_username_Score = 0,'','|'+IF(le.contact_email_username_Score < 0,'-','')+'contact_email_username')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.lname_Score = 0,'','|'+IF(le.lname_Score < 0,'-','')+'lname')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.fname_Score = 0,'','|'+IF(le.fname_Score < 0,'-','')+'fname')+IF(le.mname_Score = 0,'','|'+IF(le.mname_Score < 0,'-','')+'mname')+IF(le.company_inc_state_Score = 0,'','|'+IF(le.company_inc_state_Score < 0,'-','')+'company_inc_state')+IF(le.postdir_Score = 0,'','|'+IF(le.postdir_Score < 0,'-','')+'postdir')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.source_Score = 0,'','|'+IF(le.source_Score < 0,'-','')+'source');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
