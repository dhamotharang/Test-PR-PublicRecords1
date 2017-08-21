// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT SALT30,ut,std;
EXPORT Underlinks(DATASET(layout_HealthFacility) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
  dt := debug(ih,s,MatchThreshold).sample_match_join;
  RawResults := matches(ih,MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    ST_skipped := COUNT(GROUP,RRF.ST_skipped);
    ST_skipped_pcnt := AVE(GROUP,IF(RRF.ST_skipped,100,0));
    NPI_NUMBER_skipped := COUNT(GROUP,RRF.NPI_NUMBER_skipped);
    NPI_NUMBER_skipped_pcnt := AVE(GROUP,IF(RRF.NPI_NUMBER_skipped,100,0));
    CLIA_NUMBER_skipped := COUNT(GROUP,RRF.CLIA_NUMBER_skipped);
    CLIA_NUMBER_skipped_pcnt := AVE(GROUP,IF(RRF.CLIA_NUMBER_skipped,100,0));
    NCPDP_NUMBER_skipped := COUNT(GROUP,RRF.NCPDP_NUMBER_skipped);
    NCPDP_NUMBER_skipped_pcnt := AVE(GROUP,IF(RRF.NCPDP_NUMBER_skipped,100,0));
    DEA_NUMBER_skipped := COUNT(GROUP,RRF.DEA_NUMBER_skipped);
    DEA_NUMBER_skipped_pcnt := AVE(GROUP,IF(RRF.DEA_NUMBER_skipped,100,0));
    CNP_STORE_NUMBER_skipped := COUNT(GROUP,RRF.CNP_STORE_NUMBER_skipped);
    CNP_STORE_NUMBER_skipped_pcnt := AVE(GROUP,IF(RRF.CNP_STORE_NUMBER_skipped,100,0));
    ADDRESS_skipped := COUNT(GROUP,RRF.ADDRESS_skipped);
    ADDRESS_skipped_pcnt := AVE(GROUP,IF(RRF.ADDRESS_skipped,100,0));
    FEIN_skipped := COUNT(GROUP,RRF.FEIN_skipped);
    FEIN_skipped_pcnt := AVE(GROUP,IF(RRF.FEIN_skipped,100,0));
    CNP_NAME_skipped := COUNT(GROUP,RRF.CNP_NAME_skipped);
    CNP_NAME_skipped_pcnt := AVE(GROUP,IF(RRF.CNP_NAME_skipped,100,0));
    CNP_NUMBER_skipped := COUNT(GROUP,RRF.CNP_NUMBER_skipped);
    CNP_NUMBER_skipped_pcnt := AVE(GROUP,IF(RRF.CNP_NUMBER_skipped,100,0));
    PRIM_NAME_skipped := COUNT(GROUP,RRF.PRIM_NAME_skipped);
    PRIM_NAME_skipped_pcnt := AVE(GROUP,IF(RRF.PRIM_NAME_skipped,100,0));
    LOCALE_skipped := COUNT(GROUP,RRF.LOCALE_skipped);
    LOCALE_skipped_pcnt := AVE(GROUP,IF(RRF.LOCALE_skipped,100,0));
    PRIM_RANGE_skipped := COUNT(GROUP,RRF.PRIM_RANGE_skipped);
    PRIM_RANGE_skipped_pcnt := AVE(GROUP,IF(RRF.PRIM_RANGE_skipped,100,0));
    SEC_RANGE_skipped := COUNT(GROUP,RRF.SEC_RANGE_skipped);
    SEC_RANGE_skipped_pcnt := AVE(GROUP,IF(RRF.SEC_RANGE_skipped,100,0));
    CNP_BTYPE_skipped := COUNT(GROUP,RRF.CNP_BTYPE_skipped);
    CNP_BTYPE_skipped_pcnt := AVE(GROUP,IF(RRF.CNP_BTYPE_skipped,100,0));
    TAXONOMY_CODE_skipped := COUNT(GROUP,RRF.TAXONOMY_CODE_skipped);
    TAXONOMY_CODE_skipped_pcnt := AVE(GROUP,IF(RRF.TAXONOMY_CODE_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT30.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.ST_Score = 0,'','|'+IF(le.ST_Score < 0,'-','')+'ST')+IF(le.NPI_NUMBER_Score = 0,'','|'+IF(le.NPI_NUMBER_Score < 0,'-','')+'NPI_NUMBER')+IF(le.CLIA_NUMBER_Score = 0,'','|'+IF(le.CLIA_NUMBER_Score < 0,'-','')+'CLIA_NUMBER')+IF(le.NCPDP_NUMBER_Score = 0,'','|'+IF(le.NCPDP_NUMBER_Score < 0,'-','')+'NCPDP_NUMBER')+IF(le.MEDICAID_NUMBER_Score = 0,'','|'+IF(le.MEDICAID_NUMBER_Score < 0,'-','')+'MEDICAID_NUMBER')+IF(le.DEA_NUMBER_Score = 0,'','|'+IF(le.DEA_NUMBER_Score < 0,'-','')+'DEA_NUMBER')+IF(le.MEDICARE_FACILITY_NUMBER_Score = 0,'','|'+IF(le.MEDICARE_FACILITY_NUMBER_Score < 0,'-','')+'MEDICARE_FACILITY_NUMBER')+IF(le.TAX_ID_Score = 0,'','|'+IF(le.TAX_ID_Score < 0,'-','')+'TAX_ID')+IF(le.VENDOR_ID_Score = 0,'','|'+IF(le.VENDOR_ID_Score < 0,'-','')+'VENDOR_ID')+IF(le.CNP_STORE_NUMBER_Score = 0,'','|'+IF(le.CNP_STORE_NUMBER_Score < 0,'-','')+'CNP_STORE_NUMBER')+IF(le.PHONE_Score = 0,'','|'+IF(le.PHONE_Score < 0,'-','')+'PHONE')+IF(le.FAX_Score = 0,'','|'+IF(le.FAX_Score < 0,'-','')+'FAX')+IF(le.FAC_NAME_Score = 0,'','|'+IF(le.FAC_NAME_Score < 0,'-','')+'FAC_NAME')+IF(le.ADDR1_Score = 0,'','|'+IF(le.ADDR1_Score < 0,'-','')+'ADDR1')+IF(le.ADDRESS_Score = 0,'','|'+IF(le.ADDRESS_Score < 0,'-','')+'ADDRESS')+IF(le.C_LIC_NBR_Score = 0,'','|'+IF(le.C_LIC_NBR_Score < 0,'-','')+'C_LIC_NBR')+IF(le.FEIN_Score = 0,'','|'+IF(le.FEIN_Score < 0,'-','')+'FEIN')+IF(le.CNP_NAME_Score = 0,'','|'+IF(le.CNP_NAME_Score < 0,'-','')+'CNP_NAME')+IF(le.CNP_NUMBER_Score = 0,'','|'+IF(le.CNP_NUMBER_Score < 0,'-','')+'CNP_NUMBER')+IF(le.PRIM_NAME_Score = 0,'','|'+IF(le.PRIM_NAME_Score < 0,'-','')+'PRIM_NAME')+IF(le.ZIP_Score = 0,'','|'+IF(le.ZIP_Score < 0,'-','')+'ZIP')+IF(le.LOCALE_Score = 0,'','|'+IF(le.LOCALE_Score < 0,'-','')+'LOCALE')+IF(le.PRIM_RANGE_Score = 0,'','|'+IF(le.PRIM_RANGE_Score < 0,'-','')+'PRIM_RANGE')+IF(le.V_CITY_NAME_Score = 0,'','|'+IF(le.V_CITY_NAME_Score < 0,'-','')+'V_CITY_NAME')+IF(le.SEC_RANGE_Score = 0,'','|'+IF(le.SEC_RANGE_Score < 0,'-','')+'SEC_RANGE')+IF(le.TAXONOMY_Score = 0,'','|'+IF(le.TAXONOMY_Score < 0,'-','')+'TAXONOMY')+IF(le.CNP_BTYPE_Score = 0,'','|'+IF(le.CNP_BTYPE_Score < 0,'-','')+'CNP_BTYPE')+IF(le.TAXONOMY_CODE_Score = 0,'','|'+IF(le.TAXONOMY_CODE_Score < 0,'-','')+'TAXONOMY_CODE');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
