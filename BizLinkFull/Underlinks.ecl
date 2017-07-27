// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT33,ut,std;
EXPORT Underlinks(DATASET(layout_BizHead) ih,UNSIGNED MatchThreshold = Config_BIP.MatchThreshold) := MODULE
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
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT33.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.parent_proxid_Score = 0,'','|'+IF(le.parent_proxid_Score < 0,'-','')+'parent_proxid')+IF(le.sele_proxid_Score = 0,'','|'+IF(le.sele_proxid_Score < 0,'-','')+'sele_proxid')+IF(le.org_proxid_Score = 0,'','|'+IF(le.org_proxid_Score < 0,'-','')+'org_proxid')+IF(le.ultimate_proxid_Score = 0,'','|'+IF(le.ultimate_proxid_Score < 0,'-','')+'ultimate_proxid')+IF(le.source_record_id_Score = 0,'','|'+IF(le.source_record_id_Score < 0,'-','')+'source_record_id')+IF(le.company_url_Score = 0,'','|'+IF(le.company_url_Score < 0,'-','')+'company_url')+IF(le.contact_ssn_Score = 0,'','|'+IF(le.contact_ssn_Score < 0,'-','')+'contact_ssn')+IF(le.contact_email_Score = 0,'','|'+IF(le.contact_email_Score < 0,'-','')+'contact_email')+IF(le.company_name_Score = 0,'','|'+IF(le.company_name_Score < 0,'-','')+'company_name')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.contact_did_Score = 0,'','|'+IF(le.contact_did_Score < 0,'-','')+'contact_did')+IF(le.company_phone_7_Score = 0,'','|'+IF(le.company_phone_7_Score < 0,'-','')+'company_phone_7')+IF(le.CONTACTNAME_Score = 0,'','|'+IF(le.CONTACTNAME_Score < 0,'-','')+'CONTACTNAME')+IF(le.STREETADDRESS_Score = 0,'','|'+IF(le.STREETADDRESS_Score < 0,'-','')+'STREETADDRESS')+IF(le.company_name_prefix_Score = 0,'','|'+IF(le.company_name_prefix_Score < 0,'-','')+'company_name_prefix')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.city_Score = 0,'','|'+IF(le.city_Score < 0,'-','')+'city')+IF(le.city_clean_Score = 0,'','|'+IF(le.city_clean_Score < 0,'-','')+'city_clean')+IF(le.company_sic_code1_Score = 0,'','|'+IF(le.company_sic_code1_Score < 0,'-','')+'company_sic_code1')+IF(le.lname_Score = 0,'','|'+IF(le.lname_Score < 0,'-','')+'lname')+IF(le.company_phone_3_Score = 0,'','|'+IF(le.company_phone_3_Score < 0,'-','')+'company_phone_3')+IF(le.company_phone_3_ex_Score = 0,'','|'+IF(le.company_phone_3_ex_Score < 0,'-','')+'company_phone_3_ex')+IF(le.fname_preferred_Score = 0,'','|'+IF(le.fname_preferred_Score < 0,'-','')+'fname_preferred')+IF(le.mname_Score = 0,'','|'+IF(le.mname_Score < 0,'-','')+'mname')+IF(le.fname_Score = 0,'','|'+IF(le.fname_Score < 0,'-','')+'fname')+IF(le.name_suffix_Score = 0,'','|'+IF(le.name_suffix_Score < 0,'-','')+'name_suffix')+IF(le.cnp_lowv_Score = 0,'','|'+IF(le.cnp_lowv_Score < 0,'-','')+'cnp_lowv')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.source_Score = 0,'','|'+IF(le.source_Score < 0,'-','')+'source')+IF(le.cnp_btype_Score = 0,'','|'+IF(le.cnp_btype_Score < 0,'-','')+'cnp_btype')+IF(le.isContact_Score = 0,'','|'+IF(le.isContact_Score < 0,'-','')+'isContact')+IF(le.title_Score = 0,'','|'+IF(le.title_Score < 0,'-','')+'title')+IF(le.sele_flag_Score = 0,'','|'+IF(le.sele_flag_Score < 0,'-','')+'sele_flag')+IF(le.org_flag_Score = 0,'','|'+IF(le.org_flag_Score < 0,'-','')+'org_flag')+IF(le.ult_flag_Score = 0,'','|'+IF(le.ult_flag_Score < 0,'-','')+'ult_flag')+IF(le.fallback_value_Score = 0,'','|'+IF(le.fallback_value_Score < 0,'-','')+'fallback_value');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
