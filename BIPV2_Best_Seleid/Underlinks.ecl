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
    SELF.Summary := IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.company_url_Score = 0,'','|'+IF(le.company_url_Score < 0,'-','')+'company_url')+IF(le.duns_number_Score = 0,'','|'+IF(le.duns_number_Score < 0,'-','')+'duns_number')+IF(le.company_name_Score = 0,'','|'+IF(le.company_name_Score < 0,'-','')+'company_name')+IF(le.company_phone_Score = 0,'','|'+IF(le.company_phone_Score < 0,'-','')+'company_phone')+IF(le.address_Score = 0,'','|'+IF(le.address_Score < 0,'-','')+'address')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.zip4_Score = 0,'','|'+IF(le.zip4_Score < 0,'-','')+'zip4')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.p_city_name_Score = 0,'','|'+IF(le.p_city_name_Score < 0,'-','')+'p_city_name')+IF(le.company_sic_code1_Score = 0,'','|'+IF(le.company_sic_code1_Score < 0,'-','')+'company_sic_code1')+IF(le.company_naics_code1_Score = 0,'','|'+IF(le.company_naics_code1_Score < 0,'-','')+'company_naics_code1')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.postdir_Score = 0,'','|'+IF(le.postdir_Score < 0,'-','')+'postdir')+IF(le.fips_county_Score = 0,'','|'+IF(le.fips_county_Score < 0,'-','')+'fips_county')+IF(le.unit_desig_Score = 0,'','|'+IF(le.unit_desig_Score < 0,'-','')+'unit_desig')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.fips_state_Score = 0,'','|'+IF(le.fips_state_Score < 0,'-','')+'fips_state')+IF(le.predir_Score = 0,'','|'+IF(le.predir_Score < 0,'-','')+'predir')+IF(le.addr_suffix_Score = 0,'','|'+IF(le.addr_suffix_Score < 0,'-','')+'addr_suffix');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
