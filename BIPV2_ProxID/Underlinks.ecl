// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT37,std;
EXPORT Underlinks(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
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
    st_skipped := COUNT(GROUP,RRF.st_skipped);
    st_skipped_pcnt := AVE(GROUP,IF(RRF.st_skipped,100,0));
    prim_range_derived_skipped := COUNT(GROUP,RRF.prim_range_derived_skipped);
    prim_range_derived_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_derived_skipped,100,0));
    active_enterprise_number_skipped := COUNT(GROUP,RRF.active_enterprise_number_skipped);
    active_enterprise_number_skipped_pcnt := AVE(GROUP,IF(RRF.active_enterprise_number_skipped,100,0));
    active_domestic_corp_key_skipped := COUNT(GROUP,RRF.active_domestic_corp_key_skipped);
    active_domestic_corp_key_skipped_pcnt := AVE(GROUP,IF(RRF.active_domestic_corp_key_skipped,100,0));
    cnp_name_skipped := COUNT(GROUP,RRF.cnp_name_skipped);
    cnp_name_skipped_pcnt := AVE(GROUP,IF(RRF.cnp_name_skipped,100,0));
    company_csz_skipped := COUNT(GROUP,RRF.company_csz_skipped);
    company_csz_skipped_pcnt := AVE(GROUP,IF(RRF.company_csz_skipped,100,0));
    prim_name_derived_skipped := COUNT(GROUP,RRF.prim_name_derived_skipped);
    prim_name_derived_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_derived_skipped,100,0));
    company_address_skipped := COUNT(GROUP,RRF.company_address_skipped);
    company_address_skipped_pcnt := AVE(GROUP,IF(RRF.company_address_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT37.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.prim_range_derived_Score = 0,'','|'+IF(le.prim_range_derived_Score < 0,'-','')+'prim_range_derived')+IF(le.hist_duns_number_Score = 0,'','|'+IF(le.hist_duns_number_Score < 0,'-','')+'hist_duns_number')+IF(le.ebr_file_number_Score = 0,'','|'+IF(le.ebr_file_number_Score < 0,'-','')+'ebr_file_number')+IF(le.active_duns_number_Score = 0,'','|'+IF(le.active_duns_number_Score < 0,'-','')+'active_duns_number')+IF(le.hist_enterprise_number_Score = 0,'','|'+IF(le.hist_enterprise_number_Score < 0,'-','')+'hist_enterprise_number')+IF(le.hist_domestic_corp_key_Score = 0,'','|'+IF(le.hist_domestic_corp_key_Score < 0,'-','')+'hist_domestic_corp_key')+IF(le.foreign_corp_key_Score = 0,'','|'+IF(le.foreign_corp_key_Score < 0,'-','')+'foreign_corp_key')+IF(le.unk_corp_key_Score = 0,'','|'+IF(le.unk_corp_key_Score < 0,'-','')+'unk_corp_key')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.company_phone_Score = 0,'','|'+IF(le.company_phone_Score < 0,'-','')+'company_phone')+IF(le.active_enterprise_number_Score = 0,'','|'+IF(le.active_enterprise_number_Score < 0,'-','')+'active_enterprise_number')+IF(le.active_domestic_corp_key_Score = 0,'','|'+IF(le.active_domestic_corp_key_Score < 0,'-','')+'active_domestic_corp_key')+IF(le.company_addr1_Score = 0,'','|'+IF(le.company_addr1_Score < 0,'-','')+'company_addr1')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.company_csz_Score = 0,'','|'+IF(le.company_csz_Score < 0,'-','')+'company_csz')+IF(le.prim_name_derived_Score = 0,'','|'+IF(le.prim_name_derived_Score < 0,'-','')+'prim_name_derived')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.cnp_btype_Score = 0,'','|'+IF(le.cnp_btype_Score < 0,'-','')+'cnp_btype')+IF(le.company_name_type_derived_Score = 0,'','|'+IF(le.company_name_type_derived_Score < 0,'-','')+'company_name_type_derived')+IF(le.company_address_Score = 0,'','|'+IF(le.company_address_Score < 0,'-','')+'company_address');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
