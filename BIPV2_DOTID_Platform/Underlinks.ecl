// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT32,ut,std;
EXPORT Underlinks(DATASET(layout_DOT) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
  dt := debug(ih,s,MatchThreshold).sample_match_join;
  RawResults := matches(ih,MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    cnp_number_skipped := COUNT(GROUP,RRF.cnp_number_skipped);
    cnp_number_skipped_pcnt := AVE(GROUP,IF(RRF.cnp_number_skipped,100,0));
    prim_range_skipped := COUNT(GROUP,RRF.prim_range_skipped);
    prim_range_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_skipped,100,0));
    prim_name_skipped := COUNT(GROUP,RRF.prim_name_skipped);
    prim_name_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_skipped,100,0));
    st_skipped := COUNT(GROUP,RRF.st_skipped);
    st_skipped_pcnt := AVE(GROUP,IF(RRF.st_skipped,100,0));
    isContact_skipped := COUNT(GROUP,RRF.isContact_skipped);
    isContact_skipped_pcnt := AVE(GROUP,IF(RRF.isContact_skipped,100,0));
    company_fein_skipped := COUNT(GROUP,RRF.company_fein_skipped);
    company_fein_skipped_pcnt := AVE(GROUP,IF(RRF.company_fein_skipped,100,0));
    active_enterprise_number_skipped := COUNT(GROUP,RRF.active_enterprise_number_skipped);
    active_enterprise_number_skipped_pcnt := AVE(GROUP,IF(RRF.active_enterprise_number_skipped,100,0));
    active_domestic_corp_key_skipped := COUNT(GROUP,RRF.active_domestic_corp_key_skipped);
    active_domestic_corp_key_skipped_pcnt := AVE(GROUP,IF(RRF.active_domestic_corp_key_skipped,100,0));
    cnp_name_skipped := COUNT(GROUP,RRF.cnp_name_skipped);
    cnp_name_skipped_pcnt := AVE(GROUP,IF(RRF.cnp_name_skipped,100,0));
    corp_legal_name_skipped := COUNT(GROUP,RRF.corp_legal_name_skipped);
    corp_legal_name_skipped_pcnt := AVE(GROUP,IF(RRF.corp_legal_name_skipped,100,0));
    address_skipped := COUNT(GROUP,RRF.address_skipped);
    address_skipped_pcnt := AVE(GROUP,IF(RRF.address_skipped,100,0));
    csz_skipped := COUNT(GROUP,RRF.csz_skipped);
    csz_skipped_pcnt := AVE(GROUP,IF(RRF.csz_skipped,100,0));
    sec_range_skipped := COUNT(GROUP,RRF.sec_range_skipped);
    sec_range_skipped_pcnt := AVE(GROUP,IF(RRF.sec_range_skipped,100,0));
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
    SELF.Summary := IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.isContact_Score = 0,'','|'+IF(le.isContact_Score < 0,'-','')+'isContact')+IF(le.contact_ssn_Score = 0,'','|'+IF(le.contact_ssn_Score < 0,'-','')+'contact_ssn')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.active_enterprise_number_Score = 0,'','|'+IF(le.active_enterprise_number_Score < 0,'-','')+'active_enterprise_number')+IF(le.active_domestic_corp_key_Score = 0,'','|'+IF(le.active_domestic_corp_key_Score < 0,'-','')+'active_domestic_corp_key')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.corp_legal_name_Score = 0,'','|'+IF(le.corp_legal_name_Score < 0,'-','')+'corp_legal_name')+IF(le.address_Score = 0,'','|'+IF(le.address_Score < 0,'-','')+'address')+IF(le.active_duns_number_Score = 0,'','|'+IF(le.active_duns_number_Score < 0,'-','')+'active_duns_number')+IF(le.addr1_Score = 0,'','|'+IF(le.addr1_Score < 0,'-','')+'addr1')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.csz_Score = 0,'','|'+IF(le.csz_Score < 0,'-','')+'csz')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.lname_Score = 0,'','|'+IF(le.lname_Score < 0,'-','')+'lname')+IF(le.mname_Score = 0,'','|'+IF(le.mname_Score < 0,'-','')+'mname')+IF(le.fname_Score = 0,'','|'+IF(le.fname_Score < 0,'-','')+'fname')+IF(le.name_suffix_Score = 0,'','|'+IF(le.name_suffix_Score < 0,'-','')+'name_suffix')+IF(le.cnp_btype_Score = 0,'','|'+IF(le.cnp_btype_Score < 0,'-','')+'cnp_btype');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
